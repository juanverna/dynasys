/*=================================================================================*/
/*           RESUMEN DE LIQUIDACION DE LIQUIDO PRODUCTO POR PROVEEDOR              */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_fecha     LIKE Fac_header.fecha.
DEFINE INPUT PARAMETER has_fecha     LIKE Fac_header.fecha.
DEFINE INPUT PARAMETER que_liquido   LIKE Fac_detalle.liquido_sino.

/*=================================================================================*/
/*                              TABLA TEMPORAL                                     */
/*=================================================================================*/

{tblliquidoproducto.i} /* Definicion de la tabla temporal de liquido producto */

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE t-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE p-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE g-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE t-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE p-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE g-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".

DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE comprobantes AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas   AS CHARACTER FORMAT "X(124)".

DEFINE VARIABLE a-cdg_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE VARIABLE a-cdg_articulo  LIKE Articulo.cdg_articulo.

/*=================================================================================*/
/*                                FRAMES                                           */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Resumen de Liquido Producto por Proveedor/Fecha" AT 55
   "Página:" AT 139 PAGE-NUMBER FORMAT "9999" AT 147
   SKIP
   fecha_lis
   "Período" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 139
   SKIP
   comprobantes AT 55
   SKIP(1)
   WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sry 
   WITH FRAME f-subraya WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Proveedor.cdg_proveedor   
   Articulo.cdg_articulo
   t-cantidad [ 1 ] COLUMN-LABEL "Unidades!Vta.Bruta"
   t-cantidad [ 2 ] COLUMN-LABEL "Unidades!Devolucion"
   t-cantidad [ 3 ] COLUMN-LABEL "Unidades!Vta.Neta"
   t-pesos [ 1 ] COLUMN-LABEL "Pesos!Vta.Neta"
   t-pesos [ 2 ] COLUMN-LABEL "Pesos!Devolución"
   t-pesos [ 3 ] COLUMN-LABEL "Pesos!Bonificación"
   t-pesos [ 4 ] COLUMN-LABEL "Pesos!Promoción"
   t-pesos [ 5 ] COLUMN-LABEL "Neto!Líquido"
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
    RUN calcular_liquidoproducto.p ( INPUT des_proveedor,
                                     INPUT has_proveedor,
                                     INPUT des_fecha,
                                     INPUT has_fecha,
                                     INPUT que_liquido,
                                     INPUT NO, /* No marcamos los comprobantes */
                                     OUTPUT TABLE T-Fac_header_prv_impuesto,
                                     OUTPUT TABLE T-Liquido_producto ).

    que_empresa = Empresa.nombre.
    
    {dirprinfile.i}
    
    fecha_lis = STRING(TODAY,"99/99/99").
    hora_lis = STRING(TIME,"HH:MM:SS").

    CASE que_liquido:
        WHEN TRUE  THEN comprobantes = "Comprobantes Ya Procesados".
        WHEN FALSE THEN comprobantes = "Comprobantes Pendientes de Procesar".
        WHEN ?     THEN comprobantes = "Todos los Comprobantes".
    END CASE.

    p-cantidad = 0.
    p-pesos = 0.
             
    FOR EACH T-Liquido_producto, Proveedor OF T-Liquido_producto, Articulo OF T-Liquido_producto, Imputacion OF T-Liquido_producto
                   BREAK BY Proveedor.cdg_proveedor BY Articulo.cdg_articulo:
        
        VIEW FRAME frm-titulo.

        t-cantidad [ 1 ] = t-cantidad [ 1 ] + T-Liquido_producto.cantidad.
        t-cantidad [ 2 ] = t-cantidad [ 2 ] + T-Liquido_producto.cantidad_dev.
        t-pesos [ Imputacion.num_columna ] = t-pesos [ Imputacion.num_columna ] + T-Liquido_producto.subtotal.
             
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:

            t-pesos [ 5 ] = t-pesos [ 1 ].
            DO j = 2 TO 4:
               t-pesos [ 5 ] = t-pesos [ 5 ] + t-pesos [ j ].
            END.

            t-cantidad [ 3 ] = t-cantidad [ 1 ] + t-cantidad [ 2 ].
            DISPLAY Proveedor.cdg_proveedor WHEN Proveedor.cdg_proveedor <> a-cdg_proveedor
                    Articulo.cdg_articulo   /*WHEN FIRST-OF(Articulo.cdg_articulo)*/
                    t-cantidad [ 1 ] 
                    t-cantidad [ 2 ] 
                    t-cantidad [ 3 ] 
                    t-pesos [ 1 ] 
                    t-pesos [ 2 ] 
                    t-pesos [ 3 ] 
                    t-pesos [ 4 ] 
                    t-pesos [ 5 ] 
                    /*
                    T-Liquido_producto.proc_estad 
                    Imputacion.cdg_imputacion  
                    T-Liquido_producto.cantidad 
                    T-Liquido_producto.granel 
                    T-Liquido_producto.subtotal
                    */
                    WITH FRAME frm-listado STREAM-IO.
            DOWN WITH FRAME frm-listado.

            a-cdg_proveedor = Proveedor.cdg_proveedor.

            DO j = 1 TO 5:
               p-pesos [ j ] = p-pesos [ j ] + t-pesos [ j ].
            END.

            DO j = 1 TO 4:
               p-cantidad [ j ] = p-cantidad [ j ] + t-cantidad [ j ].
            END.

            t-cantidad = 0.
            t-pesos = 0.

        END.

        IF LAST-OF(Proveedor.cdg_proveedor)
        THEN DO:

            /*
            p-pesos [ 5 ] = 0.
            DO j = 1 TO 4:
               p-pesos [ 5 ] = p-pesos [ 5 ] + p-pesos [ j ].
            END.
            */
            
            DO j = 1 TO 5:
               t-pesos [ j ] = p-pesos [ j ].
            END.

            DO j = 1 TO 4:
               t-cantidad [ j ] = p-cantidad [ j ].
            END.

            UNDERLINE
                    t-cantidad [ 1 ] 
                    t-cantidad [ 2 ] 
                    t-cantidad [ 3 ] 
                    t-pesos [ 1 ] 
                    t-pesos [ 2 ] 
                    t-pesos [ 3 ] 
                    t-pesos [ 4 ] 
                    t-pesos [ 5 ] 
                    WITH FRAME frm-listado STREAM-IO.


            DISPLAY 
                    t-cantidad [ 1 ] 
                    t-cantidad [ 2 ] 
                    t-cantidad [ 3 ] 
                    t-pesos [ 1 ] 
                    t-pesos [ 2 ] 
                    t-pesos [ 3 ] 
                    t-pesos [ 4 ] 
                    t-pesos [ 5 ] 
                    WITH FRAME frm-listado STREAM-IO.
            DOWN 2 WITH FRAME frm-listado.

            DO j = 1 TO 5:
               g-pesos [ j ] = g-pesos [ j ] + p-pesos [ j ].
            END.

            DO j = 1 TO 4:
               g-cantidad [ j ] = g-cantidad [ j ] + p-cantidad [ j ].
            END.

            t-cantidad = 0.
            t-pesos = 0.

            p-cantidad = 0.
            p-pesos = 0.

        END.

    END.

    /*
    g-pesos [ 5 ] = 0.
    DO j = 1 TO 4:
       g-pesos [ 5 ] = g-pesos [ 5 ] + g-pesos [ j ].
    END.
    */

    DO j = 1 TO 5:
       t-pesos [ j ] = g-pesos [ j ].
    END.

    DO j = 1 TO 4:
       t-cantidad [ j ] = g-cantidad [ j ].
    END.

    UNDERLINE
            t-cantidad [ 1 ] 
            t-cantidad [ 2 ] 
            t-cantidad [ 3 ] 
            t-pesos [ 1 ] 
            t-pesos [ 2 ] 
            t-pesos [ 3 ] 
            t-pesos [ 4 ] 
            t-pesos [ 5 ] 
            WITH FRAME frm-listado STREAM-IO.


    DISPLAY 
            t-cantidad [ 1 ] 
            t-cantidad [ 2 ] 
            t-cantidad [ 3 ] 
            t-pesos [ 1 ] 
            t-pesos [ 2 ] 
            t-pesos [ 3 ] 
            t-pesos [ 4 ] 
            t-pesos [ 5 ] 
            WITH FRAME frm-listado STREAM-IO.

    UNDERLINE
            t-cantidad [ 1 ] 
            t-cantidad [ 2 ] 
            t-cantidad [ 3 ] 
            t-pesos [ 1 ] 
            t-pesos [ 2 ] 
            t-pesos [ 3 ] 
            t-pesos [ 4 ] 
            t-pesos [ 5 ] 
            WITH FRAME frm-listado STREAM-IO.

    OUTPUT CLOSE.

    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).

END PROCEDURE.

