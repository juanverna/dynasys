DEF VAR v-destino AS CHARACTER.
DEF VAR retcode AS INTEGER.

    FOR EACH Area:
        v-destino = v-destino + "," + Area.reporte.
    END.
    v-destino = SUBSTRING(v-destino,2).

    MESSAGE v-destino VIEW-AS ALERT-BOX MESSAGE.
    
   RUN mail(    v-destino,
                "hola mundo!!",
                "Testing was the shee goose",
                "",   /* files to send 	           */           
                0,						/* show dialog window */
                OUTPUT retCode).

    IF retCode <> 0 THEN MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".


    PROCEDURE mail EXTERNAL "xpMail.dll":
        DEFINE INPUT  PARAMETER mailto		    AS CHAR.
        DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
        DEFINE INPUT  PARAMETER mailText		AS CHAR.
        DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
        DEFINE INPUT  PARAMETER mailDialog		AS LONG.
        DEFINE OUTPUT PARAMETER retCode		    AS LONG.
    END.
    
