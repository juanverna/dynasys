/*====================================================================================*/
/*                 EJECUTA REPORTE DE TODOS LOS PROBLEMAS PENDIENTES                  */
/*====================================================================================*/


DEFINE VARIABLE des_tema AS CHARACTER LABEL "Desde Tema".
DEFINE VARIABLE has_tema AS CHARACTER LABEL "Hasta Tema".

DEFINE VARIABLE des_fecha AS DATE LABEL "Desde Fecha".
DEFINE VARIABLE has_fecha AS DATE LABEL "Hasta Fecha".

DEFINE VARIABLE ch_des_fecha AS CHARACTER LABEL "Desde Fecha".
DEFINE VARIABLE ch_has_fecha AS CHARACTER LABEL "Hasta Fecha".

DEFINE VARIABLE ver_arreglos    AS LOGICAL LABEL "Arreglos" VIEW-AS TOGGLE-BOX INITIAL YES. 
DEFINE VARIABLE ver_cambios     AS LOGICAL LABEL "Cambios" VIEW-AS TOGGLE-BOX INITIAL YES. 
DEFINE VARIABLE ver_desarrollos AS LOGICAL LABEL "Desarrollos" VIEW-AS TOGGLE-BOX INITIAL YES. 
DEFINE VARIABLE ver_tareas      AS LOGICAL LABEL "Tareas" VIEW-AS TOGGLE-BOX INITIAL YES. 

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

UPDATE des_tema COLON 15 has_tema COLON 50 SKIP
       des_fecha COLON 15 has_fecha COLON 50 SKIP
       /*
       ver_arreglos COLON 15 ver_cambios COLON 50 SKIP
       ver_desarrollos COLON 15 ver_tareas COLON 50 SKIP
       */
       WITH FRAME a VIEW-AS DIALOG-BOX SIDE-LABELS THREE-D 
            TITLE "Indique Rango de Temas y fechas de entrega" .

RUN RBFECHA.P ( INPUT des_fecha, OUTPUT ch_des_fecha ).
RUN RBFECHA.P ( INPUT has_fecha, OUTPUT ch_has_fecha ).

v-filtro =  "Tema.cdg_tema <= '" +
            has_tema +
            "' AND Tema.cdg_tema >= '" +
            des_tema +
            "' AND Problema.fecha_prevista <= " + ch_has_fecha + 
            "  AND Problema.fecha_prevista >= " + ch_des_fecha.

/*            
IF ver_arreglos OR ver_cambios OR ver_desarrollos OR ver_tareas
THEN DO: 
v-filtro = v-filtro + " AND ( "
IF ver_arreglos THEN v-filtro = v-filtro + "Problema.tipo = 'A' ".
IF ver_cambios 
   THEN IF ver_arreglos 
           THEN v-filtro = v-filtro + " OR Problema.tipo = 'C' ".
           ELSE v-filtro = v-filtro + " Problema.tipo = 'C' ".


END.
*/               

v-params = "p-titulo=Rango:" + des_tema + " - " + has_tema + 
                " Período: " + STRING(des_fecha) + " al " + STRING(has_fecha) + "~n" +
           "p-tipos=:Arreglos,Cambios,Desarrollos,Tareas" .
            
RUN exreport.p (  INPUT  ".\imagenes\problemas.prl",          /* Librería desde la que se ejecuta */
                  INPUT  "Entregas por Fecha",     /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                 /* Filtro de registros a imponer    */
                  INPUT  "D",                      /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                       /* Impresora de destino del listado */
                  INPUT  v-params                  /* Parametros del listado           */
               )   
