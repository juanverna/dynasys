DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE des_tema AS CHARACTER LABEL "Desde Tema".
DEFINE VARIABLE has_tema AS CHARACTER LABEL "Hasta Tema".

DEFINE VARIABLE que_fecha AS DATE.

UPDATE des_tema has_tema
       WITH FRAME a VIEW-AS DIALOG-BOX THREE-D TITLE "Indique Rango" .

v-filtro =  "Tema.cdg_tema <= '" +
            has_tema +
            "' AND Tema.cdg_tema >= '" +
            des_tema +
            "'AND Problema.fecha_resuelto = ?".
            
RUN exreport.p (  INPUT  ".\prl\sic.prl",           /* Librería desde la que se ejecuta */
                  INPUT  "Problemas reportados",     /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                         /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  ""                          /* Parametros del listado */
               )   
