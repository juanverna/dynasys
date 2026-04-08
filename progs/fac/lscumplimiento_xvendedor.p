/*==========================================================================================================*/
/*              LISTADO DE TOTAL DE VENTAS POR ARTICULO. PUEDE INCLUIR CLIENTES O NO                        */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER  des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER  has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER  que_cicloventas  LIKE Ciclo_ventas.cdg_cicloventas.
DEFINE INPUT PARAMETER  p-lista_empresas AS CHARACTER.

/*==========================================================================================================*/
/*                                          VARIABLES                                                       */
/*==========================================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE dire_tmp                AS CHARACTER.
DEFINE VARIABLE det_titulo              AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE titulo_f                AS CHARACTER FORMAT "X(45)".

DEFINE VARIABLE tv-cantidad             LIKE  Vendedor_objetivo.cantidad.          
DEFINE VARIABLE tv-granel               LIKE  Vendedor_objetivo.granel.            
DEFINE VARIABLE tv-subtotal             LIKE  Vendedor_objetivo.subtotal.
DEFINE VARIABLE tv-cantidad_cum         LIKE  Vendedor_objetivo.cantidad.          
DEFINE VARIABLE tv-granel_cum           LIKE  Vendedor_objetivo.granel.            
DEFINE VARIABLE tv-subtotal_cum         LIKE  Vendedor_objetivo.subtotal.
DEFINE VARIABLE tv-cantidad_prc         AS DECIMAL FORMAT ">>>9.99".         
DEFINE VARIABLE tv-granel_prc           AS DECIMAL FORMAT ">>>9.99".         
DEFINE VARIABLE tv-subtotal_prc         AS DECIMAL FORMAT ">>>9.99".

DEFINE STREAM Seguimiento.

/*==========================================================================================================*/
/*                                             FRAMES                                                       */
/*==========================================================================================================*/

DEFINE TEMP-TABLE T-Cumplimiento NO-UNDO
     FIELD nro_vendedor         LIKE  Vendedor.nro_vendedor
     FIELD cdg_subclaseart      LIKE  Clase_de_Articulo.cdg_subclaseart   
     FIELD nombre_subclaseart   LIKE  Clase_de_Articulo.nombre_subclaseart
     FIELD cdg_empresa          LIKE  Empresa.cdg_empresa
     FIELD cantidad             LIKE  Vendedor_objetivo.cantidad          
     FIELD granel               LIKE  Vendedor_objetivo.granel            
     FIELD subtotal             LIKE  Vendedor_objetivo.subtotal
     FIELD cantidad_cum         LIKE  Vendedor_objetivo.cantidad          
     FIELD granel_cum           LIKE  Vendedor_objetivo.granel            
     FIELD subtotal_cum         LIKE  Vendedor_objetivo.subtotal
     FIELD cantidad_prc         AS DECIMAL FORMAT ">>>9.99-"         
     FIELD granel_prc           AS DECIMAL FORMAT ">>>9.99-"         
     FIELD subtotal_prc         AS DECIMAL FORMAT ">>>9.99-"
     INDEX por_clase IS UNIQUE nro_vendedor cdg_subclaseart cdg_empresa.

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Cumplimiento de Objetivos de Venta" AT 40
    "Página:" AT 89 PAGE-NUMBER FORMAT ">>9" AT 97 SKIP 
    fecha_lis               
    titulo_f AT 40 
    hora_lis AT 89  
    SKIP
    det_titulo AT 40 
    SKIP(1)
    "---------------------------------------------------------------------------------------------------" SKIP   
    "Codigo   Nombre                                                                                    " SKIP   
    "Vendedor Vendedor                                                                                  " SKIP   
    "       Còdigo                  Descripción                                                         " SKIP   
    "       Lìnea                   Línea                                                               " SKIP   
    "            Código          Objetivo      Objetivo    Cumplimiento  Cumplimiento    %         %    " SKIP   
    "            Empresa         Unidades     Monetario        Unidades     Monetario Unidades Monetario" SKIP   
    "---------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-vendedor
    Vendedor.cdg_vendedor
    Vendedor.nombre
    WITH WIDTH 196 DOWN CENTERED FRAME frm-vendedor USE-TEXT STREAM-IO NO-LABEL.
    
DEFINE FRAME frm-subclase
    SPACE(6)
    T-Cumplimiento.cdg_subclaseart        
    T-Cumplimiento.nombre_subclaseart   
    WITH WIDTH 196 DOWN CENTERED FRAME frm-subclase USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-listado
    SPACE(12)
    T-Cumplimiento.cdg_empresa          
    T-Cumplimiento.cantidad             
    /*T-Cumplimiento.granel               */
    T-Cumplimiento.subtotal             
    T-Cumplimiento.cantidad_cum         
    /*T-Cumplimiento.granel_cum           */
    T-Cumplimiento.subtotal_cum         
    T-Cumplimiento.cantidad_prc         
    /*T-Cumplimiento.granel_prc           */
    T-Cumplimiento.subtotal_prc         
    WITH WIDTH 196 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

PROCEDURE listar:

    OUTPUT STREAM Seguimiento TO "c:\sic-temp\cumplimiento.txt" PAGE-SIZE 0.

    EMPTY TEMP-TABLE T-Cumplimiento.

    FIND Ciclo_ventas WHERE Ciclo_ventas.cdg_cicloventas = que_cicloventas NO-LOCK.

    FOR EACH Vendedor WHERE Vendedor.cdg_vendedor <= has_vendedor
                        AND Vendedor.cdg_vendedor >= des_vendedor
                        AND CAN-FIND(FIRST Vendedor_objetivo OF Vendedor 
                                           WHERE Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas
                                             AND LOOKUP(Vendedor_objetivo.cdg_empresa,p-lista_empresas) <> 0)
                            NO-LOCK:
    
        /* ----------------------------------------- */
        /*  Crea cumplimiento de objetivos en blanco */
        /* ----------------------------------------- */

        FOR EACH Vendedor_objetivo OF Vendedor 
                WHERE Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas
                  AND LOOKUP(Vendedor_objetivo.cdg_empresa,p-lista_empresas) <> 0 NO-LOCK,
                      FIRST Clase_de_Articulo WHERE Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart NO-LOCK:

                CREATE T-Cumplimiento.
                BUFFER-COPY Vendedor_objetivo TO T-Cumplimiento
                    ASSIGN T-Cumplimiento.nombre_subclaseart = Clase_de_Articulo.nombre_subclaseart.

        END.


        /* ------------------------------------*/
        /*  Sumariza cumplimiento de objetivos */
        /* ----------------------------------- */
    
        FOR EACH Fac_header OF Vendedor
            WHERE Fac_header.fecha <= Ciclo_ventas.rige_hasta 
              AND Fac_header.fecha >= Ciclo_ventas.rige_desde
              AND Fac_header.anulado = NO
              AND LOOKUP(Fac_header.cdg_empresa,p-lista_empresas) <> 0 NO-LOCK,
            FIRST Imputacion OF Fac_header WHERE Imputacion.afecta_estadisticas NO-LOCK,
                  FIRST Tipocomprobante OF Fac_header NO-LOCK,
            EACH Fac_detalle OF Fac_header NO-LOCK, FIRST Articulo OF Fac_detalle NO-LOCK, 
                 FIRST Vendedor_objetivo OF Vendedor
                       WHERE Vendedor_objetivo.cdg_subclaseart = Articulo.cdg_subclase
                          AND Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas 
                          AND Vendedor_objetivo.cdg_empresa = Fac_header.cdg_empresa NO-LOCK: 

                   PUT STREAM Seguimiento
                       Vendedor.cdg_vendedor              ";"
                       Vendedor_objetivo.cdg_empresa      ";"
                       Articulo.cdg_subclase              ";"
                       Articulo.cdg_articulo              ";"
                       Fac_header.tip_comprob             ";"
                       Fac_header.prf_comprob             ";"
                       Fac_header.nro_comprob             ";"
                       Fac_detalle.cantidad SKIP.
    
            FIND FIRST T-Cumplimiento OF  Vendedor_objetivo
                WHERE T-Cumplimiento.cdg_empresa = Vendedor_objetivo.cdg_empresa NO-ERROR.

            IF NOT AVAILABLE T-Cumplimiento
                 THEN MESSAGE Vendedor.cdg_vendedor Vendedor_objetivo.cdg_subclaseart
                    VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "no encontro cumplimiento".

            IF Tipocomprobante.debita
                THEN ASSIGN T-Cumplimiento.cantidad_cum = T-Cumplimiento.cantidad_cum  + Fac_detalle.cantidad
                            T-Cumplimiento.granel_cum   = T-Cumplimiento.granel_cum    + Fac_detalle.granel                 
                            T-Cumplimiento.subtotal_cum = T-Cumplimiento.subtotal_cum  + Fac_detalle.subtotal_neto.
                ELSE ASSIGN T-Cumplimiento.cantidad_cum = T-Cumplimiento.cantidad_cum  - Fac_detalle.cantidad
                            T-Cumplimiento.granel_cum   = T-Cumplimiento.granel_cum    - Fac_detalle.granel                 
                            T-Cumplimiento.subtotal_cum = T-Cumplimiento.subtotal_cum  - Fac_detalle.subtotal_neto.
    
        END.

    END.

    OUTPUT STREAM Seguimiento CLOSE.

    titulo_f = "Vendedores: " + des_vendedor + " - " + has_vendedor + " " + "Empresas:" + p-lista_empresas.
    det_titulo = "Ciclo: " + STRING(Ciclo_ventas.rige_desde,"99/99/99") + " - " +  
                  STRING(Ciclo_ventas.rige_hasta,"99/99/99") + " " + Ciclo_ventas.dsc_cicloventas.

    {findempresa.i}
    que_empresa = Empresa.nombre.

    {dirprinfile.i}

    DO WITH FRAME frm-listado:

        ASSIGN  tv-cantidad       = 0      
                tv-granel         = 0      
                tv-subtotal       = 0      
                tv-cantidad_cum   = 0      
                tv-granel_cum     = 0      
                tv-subtotal_cum   = 0      
                tv-cantidad_prc   = 0      
                tv-granel_prc     = 0      
                tv-subtotal_prc   = 0.      

        FOR EACH Vendedor NO-LOCK
            WHERE Vendedor.cdg_vendedor <= has_vendedor
              AND Vendedor.cdg_vendedor >= des_vendedor
              AND CAN-FIND(FIRST T-Cumplimiento OF Vendedor)
                  BY Vendedor.cdg_vendedor:

            VIEW FRAME frm-titulo.

            DISPLAY Vendedor.cdg_vendedor
                    Vendedor.nombre
                    WITH FRAME frm-vendedor.
            DOWN WITH FRAME frm-vendedor.

            FOR EACH T-Cumplimiento OF Vendedor BREAK BY T-Cumplimiento.cdg_subclaseart BY T-Cumplimiento.cdg_empresa:

                IF FIRST-OF(T-Cumplimiento.cdg_subclaseart)
                THEN DO:
                    DISPLAY 
                        T-Cumplimiento.cdg_subclaseart      WHEN FIRST-OF(T-Cumplimiento.cdg_subclaseart)
                        T-Cumplimiento.nombre_subclaseart   WHEN FIRST-OF(T-Cumplimiento.cdg_subclaseart)
                        WITH FRAME frm-subclase.
                    DOWN WITH FRAME frm-subclase.
                END.
    
                IF T-Cumplimiento.cantidad <> 0
                    THEN T-Cumplimiento.cantidad_prc = T-Cumplimiento.cantidad_cum / T-Cumplimiento.cantidad * 100.
                IF T-Cumplimiento.granel <> 0
                    THEN T-Cumplimiento.granel_prc = T-Cumplimiento.granel_cum / T-Cumplimiento.granel * 100.
                IF T-Cumplimiento.subtotal <> 0
                    THEN T-Cumplimiento.subtotal_prc = T-Cumplimiento.subtotal_cum / T-Cumplimiento.subtotal * 100.
    
                DISPLAY 
                    T-Cumplimiento.cdg_empresa
                    T-Cumplimiento.cantidad            
                    T-Cumplimiento.subtotal            
                    T-Cumplimiento.cantidad_cum            
                    T-Cumplimiento.subtotal_cum            
                    T-Cumplimiento.cantidad_prc        
                    T-Cumplimiento.subtotal_prc        
                    WITH FRAME frm-listado.
                DOWN WITH FRAME frm-listado.
    
                ASSIGN
                    tv-cantidad      = tv-cantidad       + T-Cumplimiento.cantidad
                    tv-granel        = tv-granel         + T-Cumplimiento.granel  
                    tv-subtotal      = tv-subtotal       + T-Cumplimiento.subtotal
                    tv-cantidad_cum  = tv-cantidad_cum   + T-Cumplimiento.cantidad_cum
                    tv-granel_cum    = tv-granel_cum     + T-Cumplimiento.granel_cum  
                    tv-subtotal_cum  = tv-subtotal_cum   + T-Cumplimiento.subtotal_cum.
    
                IF LAST-OF(T-Cumplimiento.cdg_subclaseart)
                THEN DO:
    
                    IF tv-cantidad <> 0
                        THEN tv-cantidad_prc = tv-cantidad_cum / tv-cantidad * 100.
                    IF tv-granel <> 0
                        THEN tv-granel_prc = tv-granel_cum / tv-granel * 100.
                    IF tv-subtotal <> 0
                        THEN tv-subtotal_prc = tv-subtotal_cum / tv-subtotal * 100.
    
                    UNDERLINE 
                        T-Cumplimiento.cdg_empresa
                        T-Cumplimiento.cantidad            
                        T-Cumplimiento.subtotal            
                        T-Cumplimiento.cantidad_cum            
                        T-Cumplimiento.subtotal_cum            
                        T-Cumplimiento.cantidad_prc        
                        T-Cumplimiento.subtotal_prc        
                        WITH FRAME frm-listado.
                    
                    DOWN WITH FRAME frm-listado.
    
                    DISPLAY  tv-cantidad       @ T-Cumplimiento.cantidad         
                             tv-subtotal       @ T-Cumplimiento.subtotal         
                             tv-cantidad_cum   @ T-Cumplimiento.cantidad_cum         
                             tv-subtotal_cum   @ T-Cumplimiento.subtotal_cum         
                             tv-cantidad_prc   @ T-Cumplimiento.cantidad_prc     
                             tv-subtotal_prc   @ T-Cumplimiento.subtotal_prc     
                             WITH FRAME frm-listado.
                    
                    DOWN WITH FRAME frm-listado.
    
                    ASSIGN  tv-cantidad       = 0      
                            tv-granel         = 0      
                            tv-subtotal       = 0      
                            tv-cantidad_cum   = 0      
                            tv-granel_cum     = 0      
                            tv-subtotal_cum   = 0      
                            tv-cantidad_prc   = 0      
                            tv-granel_prc     = 0      
                            tv-subtotal_prc   = 0.      
    
                    DOWN 1 WITH FRAME frm-listado.

                END.
            END.
        END.  
    
        UNDERLINE 
            T-Cumplimiento.cantidad            
            T-Cumplimiento.subtotal            
            T-Cumplimiento.cantidad_cum            
            T-Cumplimiento.subtotal_cum            
            T-Cumplimiento.cantidad_prc        
            T-Cumplimiento.subtotal_prc        
            WITH FRAME frm-listado.

    END.
    
    OUTPUT CLOSE.

    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).

END PROCEDURE.


