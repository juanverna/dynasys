/*=================================================================================================*/
/*             GENERA UN ARCHIVO EXCEL CON LAS VENTAS DE UN PERIODO DETERMINADO                    */
/*=================================================================================================*/

DEFINE VARIABLE des_fecha       AS DATE.
DEFINE VARIABLE has_fecha       AS DATE.
DEFINE VARIABLE que_salida     AS CHARACTER FORMAT "X(75)".

/*=================================================================================================*/
/*                                          VARIABLES                                              */
/*=================================================================================================*/

{vrshared.i "new"}

DEFINE STREAM Ventas.

DEFINE VARIABLE tiempo AS INTEGER.
/*=================================================================================================*/
/*                                       BLOQUE PRINCIPAL                                          */
/*=================================================================================================*/

que_salida  = "c:\reporte.csv".

UPDATE 
       que_salida  LABEL "Salida" COLON 15       
       des_fecha  LABEL "Desde" COLON 15
       has_fecha  LABEL "Hasta" COLON 15
       WITH FRAME f-par VIEW-AS DIALOG-BOX THREE-D SIDE-LABELS TITLE "Parametros del listado"
            WIDTH 100.
       
SESSION:NUMERIC-FORMAT = "AMERICAN".

 tiempo = ETIME(YES).  

OUTPUT STREAM Ventas TO VALUE(que_salida).
EXPORT STREAM Ventas DELIMITER ";" "Codigo Articulo" "Codigo Cliente" "Nombre Cliente" "Mes" "Año" "Sub-total Neto" "Cantidad".

FOR EACH Fac_header WHERE Fac_header.fecha <= has_fecha
                      AND Fac_header.fecha >= des_fecha
                      AND NOT Fac_header.anulado,
                          FIRST Cliente OF Fac_header NO-LOCK,
                                EACH Fac_detalle OF Fac_header,
                                     FIRST Articulo OF Fac_detalle.

        EXPORT STREAM Ventas DELIMITER ";" 
               Articulo.cdg_articulo
               Cliente.cdg_cliente 
               Cliente.nom_cliente
               MONTH(Fac_header.fecha)
               YEAR(Fac_header.fecha)
               Fac_detalle.subtotal_neto
               Fac_detalle.cantidad.

    

END.                          

OUTPUT STREAM Ventas CLOSE.
tiempo = ETIME(NO).
MESSAGE "Termino en " tiempo / 1000 " segundos." VIEW-AS ALERT-BOX MESSAGE.
