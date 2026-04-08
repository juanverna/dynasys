/*=================================================================================*/
/*                    LIBRO DEL VIAJANTE FORMATO CHARACTER                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo      LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.
DEFINE INPUT PARAMETER v-lista_estados AS CHARACTER.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante        AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Pedido".
DEFINE VARIABLE que_factura            AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!de la Factura".

DEFINE VARIABLE tit_vendedor           AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE i-vencido              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE i-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE i-comiscobrado         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE i-comisvendido         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".

DEFINE VARIABLE x-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".

DEFINE VARIABLE t-vencido              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE t-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE t-vendido              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE t-comiscobrado         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE t-comisvendido         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".

DEFINE VARIABLE signo                  AS DECIMAL.
DEFINE VARIABLE signo_pedido           AS DECIMAL.

DEFINE VARIABLE que_cuit               LIKE Empresa.cuit.
DEFINE VARIABLE que_domicilio          LIKE Empresa.direccion.

DEFINE VARIABLE v-nom_vendedor         LIKE Vendedor.nombre.
DEFINE VARIABLE v-cuil_vendedor        AS CHARACTER FORMAT "X(13)".
DEFINE VARIABLE v-legajo_vendedor      AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-fchingreso_vendedor  AS DATE.
DEFINE VARIABLE v-sueldo_vendedor      LIKE Vendedor.imp_minimo. 
DEFINE VARIABLE v-comision_ventas      LIKE Vendedor.prc_ventas.
DEFINE VARIABLE v-comision_cobranzas   LIKE Vendedor.prc_cobranzas.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Libro del Viajante" AT 59
    "Página:" AT 134 PAGE-NUMBER FORMAT "9999" AT 141
    SKIP  
    que_cuit
    "Ley 14546 Art. 10" AT 59
    "Fecha:" AT 134 fecha_lis
    SKIP
    que_domicilio
    "Operaciones del" AT 59
    des_fecha
    "al"
    has_fecha
    "Hora: " AT 134 hora_lis
    SKIP(1) 
    "Viajante:" AT 59 v-nom_vendedor
    SKIP(1)
    "Nro. de CUIL:" AT 15 v-cuil_vendedor
    "Nro. de Legajo:" AT 65 v-legajo_vendedor
    "Fecha de Ingreso:" At 95 v-fchingreso_vendedor 
    SKIP
    "Sueldo Garantido:" AT 15 v-sueldo_vendedor    
    "Comisión x ventas:" AT 65 v-comision_ventas FORMAT "%>>9.99"
    "Comisión x cobranzas:" AT 95 v-comision_cobranzas FORMAT "%>>9.99"
    SKIP
    "Viáticos: 0.00" AT 15
    "Otros:0.00" AT 65    
    SKIP (1) 
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-listado
    Ped_header.fecha           COLUMN-LABEL "Fecha!Pedido"  
    que_comprobante              
    Ped_header.imp_neto        COLUMN-LABEL "Importe!Pedido"
    Estado_pedido.descripcion  COLUMN-LABEL "Estado del!Pedido" FORMAT "X(20)"
    que_factura                  
    Fac_header.imp_neto        COLUMN-LABEL "Importe!Vendido"
    i-comisvendido             COLUMN-LABEL "Comisión!S/Vendido"
    i-cobrado                  COLUMN-LABEL "Importe!Cobrado"
    i-comiscobrado             COLUMN-LABEL "Comisión!S/Cobrado"
    i-vencido                  COLUMN-LABEL "Cobranzas!Vencidas"
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  que_empresa    = Empresa.nombre.
  que_cuit       = Empresa.cuit.
  que_domicilio  = Empresa.direccion.
   
  {dirprinfile.i}

  FOR EACH Vendedor
     WHERE Vendedor.cdg_vendedor <= has_codigo
       AND Vendedor.cdg_vendedor >= des_codigo,
        EACH Ped_header OF Vendedor
              WHERE Ped_header.cdg_empresa = Empresa.cdg_empresa
                AND Ped_header.fecha <= has_fecha
                AND Ped_header.fecha >= des_fecha,
                      FIRST Estado_pedido OF Ped_header
                BREAK BY Vendedor.cdg_vendedor
                      BY Ped_header.cdg_empresa
                      BY Ped_header.fecha
                      BY Ped_header.tip_comprob
                      BY Ped_header.prf_comprob
                      BY Ped_header.nro_comprob:

       IF FIRST-OF(Vendedor.cdg_vendedor)
       THEN DO:
            ASSIGN
                v-nom_vendedor        = Vendedor.nombre
                v-cuil_vendedor       = Vendedor.nro_cuil
                v-legajo_vendedor     = STRING(Vendedor.nro_legajo)
                v-fchingreso_vendedor = Vendedor.fecha_ingreso
                v-sueldo_vendedor     = Vendedor.imp_minimo 
                v-comision_ventas     = Vendedor.prc_ventas
                v-comision_cobranzas  = Vendedor.prc_cobranzas.
       END.

       VIEW FRAME frm-titulo.

       que_comprobante = Ped_header.tip_comprob + " " + 
                         STRING(Ped_header.prf_comprob,"9999") + " " +
                         STRING(Ped_header.nro_comprob,"99999999").

       i-cobrado = 0.
       i-vencido = 0.
       x-cobrado = 0.
       que_factura = "".

       IF Ped_header.cdg_estado = "CC"
       THEN DO:

            FIND Rem_header WHERE Rem_header.nro_pedido = Ped_header.nro_pedido NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header
            THEN DO: 

                FIND Fac_header WHERE Fac_header.nro_factura = Rem_header.nro_factura NO-LOCK NO-ERROR.
                IF AVAILABLE Fac_header
                THEN DO:

                    que_factura = Fac_header.tip_comprob + " " + 
                                  STRING(Fac_header.prf_comprob,"9999") + " " +
                                  STRING(Fac_header.nro_comprob,"99999999").

                    FOR EACH Cta_cte 
                        WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa 
                          AND Cta_cte.tip_comprob = Fac_header.tip_comprob 
                          AND Cta_cte.prf_comprob = Fac_header.prf_comprob 
                          AND Cta_cte.nro_comprob = Fac_header.nro_comprob:
                          
                            FOR EACH Rec_detalle 
                                WHERE Rec_detalle.cdg_emprecancela = Cta_cte.cdg_empresa 
                                  AND Rec_detalle.tip_cancela      = Cta_cte.tip_comprob 
                                  AND Rec_detalle.prf_cancela      = Cta_cte.prf_comprob 
                                  AND Rec_detalle.nro_cancela      = Cta_cte.nro_comprob
                                  AND Rec_detalle.nro_vencimiento  = Cta_cte.nro_vencimiento,
                                  FIRST Rec_header OF Rec_detalle:
                                  
                                  IF Rec_header.tip_comprob BEGINS "R" 
                                  THEN DO:
                                       IF Rec_header.fecha <= Cta_cte.fecha_vencimiento
                                          THEN i-cobrado = i-cobrado + Rec_detalle.importe.
                                          ELSE i-vencido = i-vencido + Rec_detalle.importe.
                                  END.        
                            END. 
                    END.        
                    x-cobrado = i-cobrado + i-vencido.
                    IF x-cobrado = Fac_header.imp_total /* Se cobro todo */
                    THEN DO:
                         IF i-vencido = 0
                         THEN DO:
                              i-cobrado = Fac_header.imp_neto .  /* NO hay vencido */
                         END.
                         ELSE DO:
                              i-cobrado = i-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                              x-cobrado = x-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                              i-vencido = x-cobrado - i-cobrado.
                              
                         END.
                    END.     
                    ELSE DO:
                         i-cobrado = i-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                         x-cobrado = x-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                         i-vencido = x-cobrado - i-cobrado.
                    END.

                    signo = IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0 THEN 1 ELSE -1. /* Cambiamos signo de NC */
                    i-comisvendido = Fac_header.imp_neto * Vendedor.prc_ventas / 100.
                    i-comiscobrado = i-cobrado * Vendedor.prc_cobranzas / 100.

                    Ped_header.imp_neto = Fac_header.imp_neto.
                END.

            END.

            t-vencido = t-vencido + i-vencido.
            t-cobrado = t-cobrado + i-cobrado.
            t-comiscobrado = t-comiscobrado + i-comiscobrado.
     
            IF AVAILABLE Fac_header
            THEN DO:
                 t-vendido = t-vendido + Fac_header.imp_neto.        
                 t-comisvendido = t-comisvendido + i-comisvendido.        
            END.

       END.

       DISPLAY Ped_header.fecha             WHEN FIRST-OF(Ped_header.fecha)
               que_comprobante              
               Estado_pedido.descripcion    
               Ped_header.imp_neto
               que_factura                  WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC"             
               Fac_header.imp_neto          WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC"
               i-comisvendido               WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC"
               i-cobrado                    WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC" AND i-cobrado <> 0             
               i-comiscobrado               WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC" AND i-cobrado <> 0
               i-vencido                    WHEN AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC" AND i-vencido <> 0
               WITH FRAME frm-listado.
               
       DOWN WITH FRAME frm-listado.

       IF LAST-OF(Vendedor.cdg_vendedor)
       THEN DO:

            UNDERLINE
               Ped_header.fecha
               que_comprobante              
               Ped_header.imp_neto
               Estado_pedido.descripcion    
               que_factura            
               Fac_header.imp_neto
               i-comisvendido
               i-cobrado
               i-comiscobrado
               i-vencido
               WITH FRAME frm-listado.

            DISPLAY
               "           Total"  @ que_comprobante
               Vendedor.nombre     @ Estado_pedido.descripcion
               t-vendido           @ Fac_header.imp_neto
               t-comisvendido      @ i-comisvendido
               t-cobrado           @ i-cobrado 
               t-comiscobrado      @ i-comiscobrado
               t-vencido           @ i-vencido
               WITH FRAME frm-listado.

            DOWN WITH FRAME frm-listado.

            t-cobrado = 0.
            t-vendido = 0.        
            t-comiscobrado = 0.
            t-comisvendido = 0.        

            IF NOT LAST(Vendedor.cdg_vendedor) THEN PAGE.

       END.


  END.   

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).
  
END PROCEDURE.  

