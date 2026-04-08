/*====================================================================================*/
/*                 EJECUTA REPORTE DE TODOS LOS PROBLEMAS REPORTADOS                  */
/*====================================================================================*/

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE des_tema AS CHARACTER LABEL "Desde Tema".
DEFINE VARIABLE has_tema AS CHARACTER LABEL "Hasta Tema".

DEFINE VARIABLE v-params AS CHARACTER.
DEFINE VARIABLE que_fecha AS DATE.

UPDATE des_tema has_tema
       WITH FRAME a VIEW-AS DIALOG-BOX THREE-D TITLE "Rango de Todos" .

v-filtro =  "Tema.cdg_tema <= '" +
            has_tema +
            "' AND Tema.cdg_tema >= '" +
            des_tema +
            "'".
v-params = "p-titulo=Todos desde " + des_tema + " hasta " + has_tema.
            
RUN exreport.p (  INPUT  ".\imagenes\problemas.prl",           /* Librería desde la que se ejecuta */
                  INPUT  "Problemas reportados",     /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                         /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros del listado */
               )   
