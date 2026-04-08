/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha        LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_empleado     LIKE Empleado.nro_legajo.
DEFINE INPUT PARAMETER has_empleado     LIKE Empleado.nro_legajo.
DEFINE INPUT PARAMETER p-cdg_monedapago LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-cambio_pago    LIKE Moneda.cambio.
DEFINE INPUT PARAMETER p-generar        AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

DEFINE VARIABLE x-equiv_adelto LIKE Fac_detalle_prv.subtotal_neto. /* Equivalente adelanto en moneda de pago al cambio factura */
DEFINE VARIABLE x-emple_descto LIKE Fac_detalle_prv.subtotal_neto. /* Equivalente adelanto en moneda de pago al cambio de pago */
DEFINE VARIABLE t-emple_descto  LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE t-total_descto  LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE t-total_difca  LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE t-emple_difca  LIKE Fac_detalle_prv.subtotal_neto.
DEFINE VARIABLE x-cambio       LIKE Fac_header_prv.cambio.
DEFINE VARIABLE x-fechcambio   AS DATE.

DEFINE VARIABLE tit_moneda AS CHARACTER FORMAT "X(70)".

DEFINE BUFFER Monedapago FOR Moneda.

{parlocales.i}
{DFVARIMP.I}
{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Detalle de gastos de empleados a descontar de nomina" AT 87 
    "Pagina:" AT 191 PAGE-NUMBER FORMAT "ZZZ9" AT 198
    SKIP  
    fecha_lis   
    "del" AT 87
    des_fecha
    "al" 
    has_fecha 
    hora_lis AT 191 
    SKIP
    tit_moneda AT 87
    SKIP(1)
    WITH WIDTH 296 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-listado
    Empleado.nro_legajo              COLUMN-LABEL "Legajo!Empleado"
    Empleado.nombre                  COLUMN-LABEL "Nombre!Empleado"
    Proveedor.cdg_proveedor          COLUMN-LABEL "Codigo!Proveedor"
    Proveedor.nombre                 COLUMN-LABEL "Nombre!Proveedor"
    Fac_header_prv.fecha             COLUMN-LABEL "Fecha!Factura"
    Moneda.abrevia                   COLUMN-LABEL "Ident!Moneda"
    Fac_detalle_prv.subtotal_neto    COLUMN-LABEL "Importe!Original"
    x-cambio                         COLUMN-LABEL "Cambio!Adelanto"
    x-equiv_adelto                   COLUMN-LABEL "Equivale!Adelanto"
    x-emple_descto                   COLUMN-LABEL "Equivale!Descuento"
    t-emple_descto                    COLUMN-LABEL "Total!Empleado"
    t-emple_difca                    COLUMN-LABEL "Total!Difcambio"
    WITH WIDTH 296 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.
 
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND Monedapago WHERE Monedapago.cdg_moneda = p-cdg_monedapago NO-LOCK.
tit_moneda = "Moneda de Pago:" + Monedapago.descripcion + STRING(p-cambio_pago," Cambio: >>>,>>9.9999").

{findempresa.i}
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE listar:

   {dirprinfile.i}

    FOR EACH Fac_detalle_prv, 
        FIRST Empleado OF Fac_detalle_prv
              WHERE Empleado.nro_legajo >= des_empleado
                AND Empleado.nro_legajo <= has_empleado, 
        FIRST Fac_header_prv OF Fac_detalle_prv
              WHERE Fac_header_prv.fecha <= has_fecha
                AND Fac_header_prv.fecha >= des_fecha, 
        Proveedor OF Fac_header_prv, Moneda OF Fac_header_prv 
                     BREAK BY Empleado.nro_legajo BY Proveedor.cdg_proveedor:

        VIEW FRAME frm-titulo.
        
        IF Moneda.cdg_moneda = Monedapago.cdg_moneda 
        THEN DO: 
            x-equiv_adelto = Fac_detalle_prv.subtotal_neto.
            x-cambio = 1.
            x-emple_descto = Fac_detalle_prv.subtotal_neto.
        END.
        ELSE DO: 

            RUN cotizar_moneda.p ( INPUT Monedapago.cdg_moneda,
                                   INPUT Fac_header_prv.cdg_empresa,
                                   INPUT Fac_header_prv.fecha,
                                   OUTPUT x-cambio,
                                   OUTPUT x-fechcambio).

            x-equiv_adelto = Fac_detalle_prv.subtotal_neto * x-cambio / Fac_header_prv.cambio.
            x-emple_descto = Fac_detalle_prv.subtotal_neto * p-cambio_pago / Fac_header_prv.cambio.

        END.        

        t-emple_descto = t-emple_descto + x-emple_descto.
        t-total_descto = t-total_descto + x-emple_descto.
    
        t-emple_difca = t-emple_difca + x-equiv_adelto - x-emple_descto.
        

        DISPLAY Empleado.nro_legajo     WHEN FIRST-OF(Empleado.nro_legajo)
                Empleado.nombre         WHEN FIRST-OF(Empleado.nro_legajo)
                Proveedor.cdg_proveedor WHEN FIRST-OF(Proveedor.cdg_proveedor)
                Proveedor.nombre        WHEN FIRST-OF(Proveedor.cdg_proveedor)
                Fac_header_prv.fecha 
                Moneda.abrevia 
                Fac_detalle_prv.subtotal_neto 
                x-cambio
                x-equiv_adelto
                x-emple_descto
                t-emple_descto WHEN LAST-OF(Empleado.nro_legajo)
                t-emple_difca WHEN LAST-OF(Empleado.nro_legajo)
            WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.
        IF LAST-OF(Empleado.nro_legajo) 
            THEN ASSIGN t-emple_descto = 0
                        t-total_difca = t-total_difca + t-emple_difca
                        t-emple_difca = 0.
    
    END.

    UNDERLINE Empleado.nro_legajo 
              Empleado.nombre 
              Proveedor.cdg_proveedor 
              Proveedor.nombre 
              Fac_header_prv.fecha 
              Moneda.abrevia 
              Fac_detalle_prv.subtotal_neto 
              x-cambio
              x-emple_descto
              x-equiv_adelto
              t-emple_descto
              t-emple_difca
              WITH FRAME frm-listado.

    DISPLAY t-total_descto @ t-emple_descto
            WITH FRAME frm-listado.

    OUTPUT CLOSE.

    RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.
