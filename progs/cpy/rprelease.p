/*====================================================================================*/
/*                 EJECUTA REPORTE DE TODOS LOS PROBLEMAS REPORTADOS                  */
/*====================================================================================*/

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE que_release AS CHARACTER LABEL "Release".

DEFINE VARIABLE v-params AS CHARACTER.

UPDATE que_release 
       WITH FRAME a VIEW-AS DIALOG-BOX THREE-D TITLE "Rango de Todos" .

v-filtro =  "Problema.version-arreglo = '" +
            que_release + "'".
v-params = "p-titulo=Cambios del release " + que_release.
            
RUN exreport.p (  INPUT  ".\imagenes\problemas.prl",           /* Librería desde la que se ejecuta */
                  INPUT  "Problemas reportados",     /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                         /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros del listado */
               )   
