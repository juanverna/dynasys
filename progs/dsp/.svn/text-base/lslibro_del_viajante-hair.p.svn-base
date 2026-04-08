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
DEFINE VARIABLE i-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE i-comiscobrado         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE i-comisvendido         AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".

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
    "Libro del Viajante" AT 54
    "Página:" AT 117 PAGE-NUMBER FORMAT "9999" AT 124
    SKIP  
    que_cuit
    "Ley 14546 Art. 10" AT 54
    "Fecha:" AT 117 fecha_lis
    SKIP
    que_domicilio
    "Operaciones del" AT 54
    des_fecha
    "al"
    has_fecha
    "Hora: " AT 117 hora_lis
    SKIP(1) 
    "Viajante:" AT 54 v-nom_vendedor
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

  FOR EACH Ped_header 
        WHERE Ped_header.cdg_empresa = Empresa.cdg_empresa
          AND Ped_header.fecha <= has_fecha
          AND Ped_header.fecha >= des_fecha,
              FIRST Vendedor OF Ped_header
              WHERE Vendedor.cdg_vendedor <= has_codigo
                AND Vendedor.cdg_vendedor >= des_codigo,
                FIRST Estado_pedido OF Ped_header
          BREAK BY Vendedor.cdg_vendedor
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
       que_factura = "".

       IF Ped_header.cdg_estado = "CC"
       THEN DO:

            FIND Rem_header WHERE Rem_header.nro_remito = Ped_header.nro_remito NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header
            THEN DO: 

                FIND Fac_header WHERE Fac_header.nro_factura = Rem_header.nro_factura NO-LOCK NO-ERROR.
                IF AVAILABLE Fac_header
                THEN DO:

                    que_factura = Fac_header.tip_comprob + " " + 
                                  STRING(Fac_header.prf_comprob,"9999") + " " +
                                  STRING(Fac_header.nro_comprob,"99999999").

                    FOR EACH Rec_detalle 
                        WHERE Rec_detalle.cdg_emprecancela = Fac_header.cdg_empresa 
                          AND Rec_detalle.tip_cancela      = Fac_header.tip_comprob 
                          AND Rec_detalle.prf_cancela      = Fac_header.prf_comprob 
                          AND Rec_detalle.nro_cancela      = Fac_header.nro_comprob,
                          FIRST Rec_header OF Rec_detalle:
                          
                          IF Rec_header.tip_comprob BEGINS "R" THEN i-cobrado = i-cobrado + Rec_detalle.importe.
             
                    END. 
                    i-cobrado = IF i-cobrado = Fac_header.imp_total 
                                   THEN Fac_header.imp_neto 
                                   ELSE i-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                    signo = IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0 THEN 1 ELSE -1. /* Cambiamos signo de NC */
                    i-comisvendido = Fac_header.imp_neto * Vendedor.prc_ventas / 100.
                    i-comiscobrado = i-cobrado * Vendedor.prc_cobranzas / 100.

                END.

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
               WITH FRAME frm-listado.
               
       t-cobrado = t-cobrado + i-cobrado.
       t-comiscobrado = t-comiscobrado + i-comiscobrado.

       IF AVAILABLE Fac_header
       THEN DO:
            t-vendido = t-vendido + Fac_header.imp_neto.        
            t-comisvendido = t-comisvendido + i-comisvendido.        
       END.
               
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
               WITH FRAME frm-listado.

            DISPLAY
               "           Total"  @ que_comprobante
               Vendedor.nombre     @ Estado_pedido.descripcion
               t-vendido           @ Fac_header.imp_neto
               t-comisvendido      @ i-comisvendido
               t-cobrado           @ i-cobrado 
               t-comiscobrado      @ i-comiscobrado
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

