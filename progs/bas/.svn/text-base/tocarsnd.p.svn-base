/*=================================================================================*/
/*                        EJECUTA UN ARCHIVO DE SONIDO                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER wave-name AS CHARACTER.

/*{VPERSINM.I}*/
/*{VRSHARED.I}*/

DEFINE VARIABLE play-status AS INTEGER.
DEFINE VARIABLE sonido      AS LOGICAL INITIAL NO.

FIND Parametro "CSSONIDO" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN sonido = Parametro.valor_l.

IF sonido THEN RUN sndPlaySound (INPUT wave-name, INPUT 2,
                                 OUTPUT play-status).

PROCEDURE sndPlaySound EXTERNAL "mmsystem.dll":
   DEFINE INPUT PARAMETER ic AS CHARACTER.
   DEFINE INPUT PARAMETER ish AS SHORT.
   DEFINE RETURN PARAMETER osh AS SHORT.
END PROCEDURE.

