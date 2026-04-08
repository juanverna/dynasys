/*=================================================================================*/
/*        Conecta los distintos ambientes de SIC                                   */
/*=================================================================================*/

DEFINE OUTPUT PARAMETER hubo_conexion AS LOGICAL INITIAL NO.

DEFINE VARIABLE ok             AS LOGICAL.
DEFINE VARIABLE entorno_tit    AS CHARACTER VIEW-AS SELECTION-LIST INNER-CHARS 50 INNER-LINES 15.
DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE conexion       AS CHARACTER INITIAL "-pf c:\sic8\arranque.pf".
DEFINE VARIABLE opciones       AS CHARACTER INITIAL " ". 
DEFINE VARIABLE conectando     AS CHARACTER FORMAT "X(30)" INITIAL "Conectando bases de datos ...".
DEFINE VARIABLE lista_entornos AS CHARACTER.
DEFINE VARIABLE entorno        AS CHARACTER FORMAT "X(50)".

DEFINE WORK-TABLE T-Conexiones
       FIELD que_entorno     AS CHARACTER
       FIELD que_descripcion AS CHARACTER
       FIELD que_conexion    AS CHARACTER.       

DEFINE BUTTON btn_salir  
       SIZE 10 BY 1 LABEL "&Salir" FONT 6.

DEFINE BUTTON btn_conectar  
       SIZE 10 BY 1 LABEL "&Conectar" FONT 6.

FORM 
    SKIP(0.5)
    conectando 
    SKIP(0.5)             
    WITH FRAME f-conect NO-LABELS THREE-D VIEW-AS DIALOG-BOX FGCOLOR 0 BGCOLOR 8
         TITLE "Aguarde un momento, por favor".

FORM
 entorno_tit FGCOLOR 1 BGCOLOR 14 NO-LABEL FONT 4
 SKIP(0.5)             
 btn_conectar AT 8 SPACE(4) btn_salir 
 SKIP(0.5)
 WITH FRAME frm-conexion NO-LABEL THREE-D TITLE "Lista de entornos disponibles"
 VIEW-AS DIALOG-BOX.

ON CHOOSE OF btn_conectar IN FRAME frm-conexion
DO:

   FIND FIRST T-Conexiones WHERE T-Conexiones.que_descripcion = entorno_tit:SCREEN-VALUE.
   
   RUN DSCONSIC.P.

   DISPLAY conectando
           WITH FRAME f-conect.

   CONNECT VALUE(T-Conexiones.que_conexion) NO-ERROR.
   HIDE FRAME f-conect NO-PAUSE.

   IF CONNECTED("SIC")
   THEN DO:
        hubo_conexion = YES.
        APPLY "U1" TO FRAME frm-conexion.
   END.     
   ELSE MESSAGE "No fue posible conectar la base SIC"
                 VIEW-AS ALERT-BOX ERROR.     

END.

ON CHOOSE OF btn_salir IN FRAME frm-conexion
DO:

   APPLY "U1" TO FRAME frm-conexion.

END.

/*=================================================================================*/
/*                                  BLOQUE PRINCIPAL                               */
/*=================================================================================*/

{levantarini.i}

GET-KEY-VALUE SECTION "Entornos" KEY ? VALUE lista_entornos.
DO j = 1 TO NUM-ENTRIES(lista_entornos):
   GET-KEY-VALUE SECTION "Entornos" KEY ENTRY(j,lista_entornos) VALUE entorno.
   ok = entorno_tit:ADD-LAST(ENTRY(1,entorno,",")).
   CREATE T-Conexiones.
   ASSIGN T-Conexiones.que_entorno     = ENTRY(j,lista_entornos)
          T-Conexiones.que_descripcion = ENTRY(1,entorno,",")
          T-Conexiones.que_conexion    = ENTRY(2,entorno,",").
END.

CASE NUM-ENTRIES(lista_entornos): 

     WHEN 0 
     THEN DO:
          MESSAGE "No existen entornos definidos"
                   VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE CONFIGURACION".
     END.
     WHEN 1 
     THEN DO:
          FIND FIRST T-Conexiones.
          RUN DSCONSIC.P.
          CONNECT VALUE(T-Conexiones.que_conexion) NO-ERROR.
          IF CONNECTED("SIC")
             THEN hubo_conexion = YES.
             ELSE MESSAGE "No fue posible conectar la base SIC"
                           VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE CONFIGURACION".     
     END.
     OTHERWISE 
     DO:
          DISPLAY entorno_tit WITH FRAME frm-conexion.
          ENABLE ALL WITH FRAME frm-conexion. 
          WAIT-FOR U1 OF FRAME frm-conexion.
          HIDE FRAME frm-conexion NO-PAUSE. 
     END.     

END CASE.          

