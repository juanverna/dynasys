
DEFINE INPUT-OUTPUT PARAMETER que_registro AS ROWID.
DEFINE INPUT        PARAMETER modo         AS INTEGER.

{VPERSINM.I}

RUN TOCARSND.P (INPUT "SOUND\DING.WAV").
MESSAGE "No hay mas datos que los que se exhiben en pantalla"
         VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje del sistema".
 