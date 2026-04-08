
/*------------------------------------------------------------------------------------*/
/* Exportacion de movimientos de Cta.Cte.                                             */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE des_fecha   AS DATE LABEL "Desde Fecha".
DEFINE VARIABLE has_fecha   AS DATE LABEL "Hasta Fecha" INITIAL TODAY.
DEFINE VARIABLE mensaje     AS CHARACTER FORMAT "X(40)".

DEFINE BUTTON btn_proceso
     LABEL "&Procesar":L
     SIZE 10 BY 1 FONT 10.

DEFINE BUTTON btn_salir
     LABEL "&Salir":L
     SIZE 10 BY 1 FONT 10.

DEFINE BUTTON btn_copiar
     LABEL "&Copiar":L
     SIZE 10 BY 1 FONT 10.

FORM
   SKIP(0.5)
   SPACE(2) des_fecha   FGCOLOR fe_c BGCOLOR be_c
   SKIP
   SPACE(2) has_fecha   FGCOLOR fe_c BGCOLOR be_c
   SKIP(1)
   SPACE(1) BTN_PROCESO SPACE(1)
            SPACE(1) BTN_SALIR SPACE(1) BTN_COPIAR
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Exportacion de movimientos" FONT 8 THREE-D.


FORM
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" FONT 8
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 1.


/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

ON CHOOSE OF btn_copiar
DO:
  MESSAGE "Por favor, coloque el disco en la disquetera A:."
          "A continuacion oprima ENTER"
          VIEW-AS ALERT-BOX MESSAGE TITLE "Solicitud de disco".
  DOS SILENT "COPY CTA_CTE.TXT A:".
END.


ON CHOOSE OF btn_proceso
DO:

  ASSIGN
    des_fecha
    has_fecha.

  mensaje = "    Exportando...".
  DISPLAY mensaje WITH FRAME frm-espere.

  OUTPUT TO "CTA_CTE.TXT".
  FOR EACH Cta_cte WHERE Cta_cte.fecha_emision <= has_fecha
                     AND Cta_cte.fecha_emision >= des_fecha:

      EXPORT Cta_cte.

  END.
  OUTPUT CLOSE.
  HIDE FRAME frm-espere NO-PAUSE.

END.
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Movimientos/Saldos".
nom_menu = "CUENTAS CORRIENTES".

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.

des_fecha = TODAY.
has_fecha = TODAY.

RUN PONER_SESION.

DISPLAY
    des_fecha
    has_fecha
    WITH FRAME frm-rango.

ENABLE ALL WITH FRAME frm-rango.
WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.


PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.



