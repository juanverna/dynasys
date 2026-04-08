/*==========================================================================================*/
/*   EMITE UN LISTADO DE TODAS LAS ORDENES DE COMPRA QUE SE HALLAN EN EL SISTEMA            */
/*==========================================================================================*/

DEFINE VARIABLE v-filtro AS CHARACTER INITIAL "".
DEFINE VARIABLE que_estado AS CHARACTER.

/*
UPDATE que_estado LABEL "Estado"
       WITH FRAME f-estado VIEW-AS DIALOG-BOX THREE-D SIDE-LABEL 
            TITLE "Indique estado" FONT 4.

v-filtro = "Ocm_header.cdg_estado = '" + 
            que_estado + "'".
*/
            
RUN exreport.p (  INPUT  ".\prl\sic.prl",  /* Librería desde la que se ejecuta */
                  INPUT  "ORDENES DE COMPRA",    /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,               /* Filtro de registros a imponer    */
                  INPUT  "D",                    /* Salida de datos    (ver cPrinter)*/
                  INPUT  "" ,                    /* Impresora de destino del listado */
                  INPUT  ""                      /* Parametros del reporte           */
               )   

