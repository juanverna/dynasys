/*=================================================================================*/
/*                       DESPACHO DE MAILS                                         */
/*=================================================================================*/
DEFINE INPUT  PARAMETER i_e_mail  LIKE Proveedor.e-mail.
DEFINE INPUT  PARAMETER i_subject AS CHARACTER.
DEFINE INPUT  PARAMETER i_mensaje AS CHARACTER.
DEFINE INPUT  PARAMETER i_direccion_archivo_adjunto AS CHARACTER.
DEFINE INPUT  PARAMETER i_muestra_dialogo_mail      AS INTEGER.
DEFINE OUTPUT PARAMETER codigo_error AS INTEGER.

{xprint.i}
                                                         
/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
RUN despachar_mails.
RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE despachar_mails:

    DEFINE VARIABLE retCode    AS INT NO-UNDO.


    RUN mail( STRING(i_e_mail),
              STRING(i_subject),
              STRING(i_mensaje),
              STRING(i_direccion_archivo_adjunto), /* files to send 	           */           
              i_muestra_dialogo_mail,	/* Mostrar el dialogo de mail, con 1 no lo muestra */
              OUTPUT retCode).
    
    IF retCode <> 0 THEN 
    DO:
        codigo_error = retcode.
        MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".
    END.


END PROCEDURE.

PROCEDURE mail EXTERNAL "xpMail.dll":
    DEFINE INPUT  PARAMETER mailto		    AS CHAR.
    DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
    DEFINE INPUT  PARAMETER mailText		AS CHAR.
    DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
    DEFINE INPUT  PARAMETER mailDialog		AS LONG.
    DEFINE OUTPUT PARAMETER retCode		    AS LONG.
END.
