
/*------------------------------------------------------------------------------------*/
/*             IMPORTACION DE MOVIMIENTOS DE CUENTA CORRIENTE                         */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}

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
   SKIP(2)
   SPACE(1) BTN_PROCESO SPACE(1)
            SPACE(1) BTN_SALIR SPACE(1) BTN_COPIAR
   SKIP(2)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Importacion de movimientos" FONT 8.


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
  DOS SILENT "COPY A:CTA_CTE.TXT".
END.

ON CHOOSE OF btn_proceso
DO:

  mensaje = "    Imortando...".
  DISPLAY mensaje WITH FRAME frm-espere.

  INPUT FROM  "CTA_CTE.TXT".
  REPEAT:
      CREATE Cta_cte.
      IMPORT Cta_cte.
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

RUN PONER_SESION.

VIEW FRAME frm-rango.
ENABLE ALL WITH FRAME frm-rango.
WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.


PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.



