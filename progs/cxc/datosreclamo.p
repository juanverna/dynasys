/*==========================================================================================*/
/*                EDICION DE LOS DATOS FIJOS DE LAS CARTAS DE RECLAMO                       */
/*==========================================================================================*/

DEFINE VARIABLE v-carta             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-piecarta          AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-lugar-y-fecha     AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-firma             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cargo             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-por-empresa       AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE v-cliente-nombre    AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cliente-domicilio AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cliente-localidad AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cliente-provincia AS CHARACTER FORMAT "X(60)".


{VRSHARED.I }

DEFINE BUTTON BTN_GRABAR
     LABEL "&Grabar":L 
     SIZE 10 BY 0.9 FONT 4.
     
DEFINE BUTTON BTN_SALIR
     LABEL "&Salir":L 
     SIZE 10 BY 0.9 FONT 4.

FORM 
    /*
    v-carta  AT ROW 2.00 COL 10 COLON-ALIGNED
          LABEL "Carta:"
          VIEW-AS EDITOR SIZE 65 BY 3 
          FGCOLOR fe_c BGCOLOR be_c
    v-piecarta  AT ROW 5.00 COL 10 COLON-ALIGNED
          LABEL "Pie:"
          VIEW-AS EDITOR SIZE 65 BY 3 
          FGCOLOR fe_c BGCOLOR be_c
    */      
    v-lugar-y-fecha AT ROW 3.00 COL 20 COLON-ALIGNED
          LABEL "Lugar y Fecha"
          VIEW-AS FILL-IN SIZE 65 BY 0.8
          FGCOLOR fe_c BGCOLOR be_c
    v-firma AT ROW 4.00 COL 20 COLON-ALIGNED
          LABEL "Firmante"
          VIEW-AS FILL-IN SIZE 65 BY 0.8
          FGCOLOR fe_c BGCOLOR be_c
    v-cargo  AT ROW 5.00 COL 20 COLON-ALIGNED
          LABEL "Cargo"
          VIEW-AS FILL-IN SIZE 65 BY 0.8
          FGCOLOR fe_c BGCOLOR be_c
    v-por-empresa AT ROW 6.00 COL 20 COLON-ALIGNED
          LABEL "Por Empresa"
          VIEW-AS FILL-IN SIZE 65 BY 0.8
          FGCOLOR fe_c BGCOLOR be_c
   SKIP(1)
   BTN_GRABAR SPACE(20) BTN_SALIR
   WITH FRAME frm-datos-fijos FONT 4  THREE-D
        SIDE-LABELS FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Datos Fijos de las Cartas de Reclamo" ROW 5 CENTERED VIEW-AS DIALOG-BOX
              WIDTH 90.

ON CHOOSE OF BTN_GRABAR IN FRAME frm-datos-fijos
DO:

  ASSIGN FRAME frm-datos-fijos
    /*
    v-carta  
    v-piecarta
    */
    v-lugar-y-fecha
    v-firma 
    v-cargo 
    v-por-empresa.

  DO TRANSACTION:
        /* 
        {GRABATEXTOS.I "RECLTCAR" "v-carta" "Primer parrafo de texto de la carta"}
        {GRABATEXTOS.I "RECLPIEC" "v-piecarta" "Segundo parrafo de texto de la carta"}
        */
        {GRABATEXTOS.I "RECLLYFE" "v-lugar-y-fecha" "Lugar y Fecha de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLFIRM" "v-firma" "Firmante de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLCARG" "v-cargo" "Cargo del firmante de las cartas de reclamo"}
        {GRABATEXTOS.I "RECLPEMP" "v-por-empresa" "Por Empresa de las cartas de reclamo"}
        /*
        OUTPUT TO ".\prl\modelo-reclamo.txt" PAGE-SIZE 0.

                {FILETEXTOS.I "carta"}
                {FILETEXTOS.I "lugar-y-fecha"}
                {FILETEXTOS.I "cliente-nombre"}
                {FILETEXTOS.I "cliente-domicilio"}
                {FILETEXTOS.I "cliente-localidad"}
                {FILETEXTOS.I "cliente-provincia"}
                {FILETEXTOS.I "piecarta"}
                {FILETEXTOS.I "firma"}
                {FILETEXTOS.I "cargo"}
                {FILETEXTOS.I "por-empresa"}
             
        OUTPUT CLOSE. 
        */
  END.

   RUN TOCARSND.P ( INPUT "SOUND\COMIENZO.WAV").
   APPLY "U1" TO FRAME frm-datos-fijos.

END.   

ON CHOOSE OF BTN_SALIR IN FRAME frm-datos-fijos
DO:

   RUN TOCARSND.P ( INPUT "SOUND\ELIMINAR.WAV").
   APPLY "U1" TO FRAME frm-datos-fijos.

END.   

/*==========================================================================================*/
/*                                 B L O Q U E   P R I N C I P A L                          */
/*==========================================================================================*/

{CARGATEXTOS.I "'RECLLYFE'" "v-lugar-y-fecha"}
{CARGATEXTOS.I "'RECLFIRM'" "v-firma"}
{CARGATEXTOS.I "'RECLCARG'" "v-cargo"}
{CARGATEXTOS.I "'RECLPEMP'" "v-por-empresa"}

BTN_SALIR:COLUMN IN FRAME frm-datos-fijos = FRAME frm-datos-fijos:WIDTH - BTN_SALIR:WIDTH - 0.5.

RUN TOCARSND.P ( INPUT "SOUND\ABREVENT.WAV").

FIND Empresa WHERE ROWID(Empresa) = act_empresa EXCLUSIVE-LOCK NO-ERROR.

DISPLAY
    v-lugar-y-fecha
    v-firma 
    v-cargo 
    v-por-empresa
   WITH FRAME frm-datos-fijos.

ENABLE
    v-lugar-y-fecha
    v-firma 
    v-cargo 
    v-por-empresa
    BTN_GRABAR BTN_SALIR
    WITH FRAME frm-datos-fijos.
   
WAIT-FOR U1 OF FRAME frm-datos-fijos.

