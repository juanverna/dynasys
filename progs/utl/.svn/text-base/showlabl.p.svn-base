/*=================================================================================*/
/*                    MUESTRA EL LABEL DE LA BASE DE DATOS                         */
/*=================================================================================*/

DEFINE FRAME frm-a
        SKIP(0.1)
        Base-ID.label_base LABEL "R¢tulo de la Base" FGCOLOR 0 BGCOLOR 15
        SKIP(0.1)
        WITH THREE-D VIEW-AS DIALOG-BOX SIDE-LABELS
             TITLE "Identificaci¢n de la Base de Datos. Oprima ESC para finalizar".

FIND FIRST Base-ID.
DISPLAY Base-ID.label_base
        WITH FRAME frm-a.
ENABLE Base-ID.label_base
       WITH FRAME frm-a.

WAIT-FOR RETURN OF Base-ID.label_base IN FRAME frm-a.