/*====================================================================================*/
/*                 EJECUTA REPORTE DE TODOS LOS PROBLEMAS PENDIENTES                  */
/*====================================================================================*/


DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE quien_pide AS CHARACTER LABEL "Reportante".
DEFINE VARIABLE des_tema AS CHARACTER LABEL "Desde Tema".
DEFINE VARIABLE has_tema AS CHARACTER LABEL "Hasta Tema".
DEFINE VARIABLE todos_sino AS CHARACTER LABEL "Listar" initial "R"
       VIEW-AS RADIO-SET HORIZONTAL RADIO-BUTTONS "Resueltos","R", 
                                             "Pendientes","P",
                                             "A Presupuestar","A".


DEFINE VARIABLE v-params AS CHARACTER.

UPDATE des_tema has_tema SKIP
       quien_pide todos_sino
       WITH FRAME a VIEW-AS DIALOG-BOX THREE-D 
            SIDE-LABELS 2 COLUMNS TITLE "Indique Solicitante" .

v-filtro =  "Tema.cdg_tema <= '" +
            has_tema +
            "' AND Tema.cdg_tema >= '" +
            des_tema + "' AND ( Problema.tipo = 'D' OR Problema.tipo = 'C' ) " +  
            " AND Problema.reportado_por = '" + quien_pide + "'".

v-params = "p-titulo="    + "Desde " + des_tema + " hasta " + has_tema.
CASE todos_sino:
     WHEN "R" 
        THEN DO:
            v-filtro = v-filtro + " AND ( Problema.estado <> '' AND Problema.estado <> '$' )".
            v-params = v-params + " - Resueltos".
        END.
     WHEN "P" 
        THEN DO:
            v-filtro = v-filtro + " AND Problema.estado = ''".
            v-params = v-params + " - Pendientes".
        END.
     WHEN "A" 
        THEN DO:
            v-filtro = v-filtro + " AND Problema.estado = 'P'".
            v-params = v-params + " - A Presupuestar".
        END.
END.

v-params = v-params + "~n" + "p-reportado=" + "Reportado:" + quien_pide.
            
RUN exreport.p (  INPUT  ".\imagenes\problemas.prl",                /* Librería desde la que se ejecuta */
                  INPUT  "Modificaciones Solicitadas",   /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                       /* Filtro de registros a imponer    */
                  INPUT  "D",                            /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                             /* Impresora de destino del listado */
                  INPUT  v-params                        /* Parametros del listado */
               )   
