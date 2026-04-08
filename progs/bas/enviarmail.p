/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-destino       AS CHARACTER.
DEFINE INPUT  PARAMETER p-subject       AS CHARACTER.
DEFINE INPUT  PARAMETER p-mensaje       AS CHARACTER.
DEFINE INPUT  PARAMETER p-attachments   AS CHARACTER.
DEFINE INPUT  PARAMETER p-showdialog    AS INTEGER.
DEFINE OUTPUT PARAMETER p-retCode       AS INTEGER NO-UNDO.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{xprint.i}

DEFINE VARIABLE codigo_salida          AS LOGICAL NO-UNDO.
DEFINE VARIABLE v-que_correo           AS CHARACTER NO-UNDO.

/*=================================================================================*/
/*                                 PROCESO                                         */
/*=================================================================================*/

v-que_correo = "".
codigo_salida = YES.


REPEAT WHILE v-que_correo = "" AND codigo_salida = YES:

    RUN verificarcorreoabierto.p ( OUTPUT v-que_correo ).
    IF v-que_correo <> "" /* Correo arrancado */
    THEN DO:
        RUN mail( p-destino,
                  p-subject,
                  p-mensaje,
                  p-attachments,  		    /* files to send 	           */           
                  p-showdialog,						/* show dialog window */
                  OUTPUT p-retCode).
        /*
        IF p-retCode <> 0 
            THEN MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".
        */    
    END.
    ELSE DO:
        MESSAGE "DYNASYS no detecta un cliente de correo activo. Indique la acción de su preferencia" SKIP(1)
                "     (1) Arranque su cliente de correo y LUEGO seleccione el botón ACEPTAR para enviar el mail." SKIP(1)
                "     (2) Seleccione CANCELAR para no enviar el correo." SKIP
                VIEW-AS ALERT-BOX MESSAGE BUTTONS OK-CANCEL TITLE "CORREO NO DETECTADO" SET codigo_salida.    END.
    

END.
/*=================================================================================*/
/*                               PROCEDIMIENTOS                                    */
/*=================================================================================*/

PROCEDURE mail EXTERNAL "xpMail.dll":
    DEFINE INPUT  PARAMETER mailto		    AS CHAR.
    DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
    DEFINE INPUT  PARAMETER mailText		AS CHAR.
    DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
    DEFINE INPUT  PARAMETER mailDialog		AS LONG.
    DEFINE OUTPUT PARAMETER retCode		    AS LONG.
END.
