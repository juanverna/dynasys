
/*------------------------------------------------------------------------------------*/
/* Listado Cta.Cte. Movimientos/Saldos  Historicos/Analiticos                         */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE des_cliente   LIKE Cliente.cdg_cliente LABEL "Desde Cliente".
DEFINE VARIABLE has_cliente   LIKE Cliente.cdg_cliente LABEL "Hasta Cliente".
DEFINE VARIABLE mensaje       AS CHARACTER FORMAT "X(40)".

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
   SPACE(2) des_cliente   FGCOLOR fg_c
   SKIP
   SPACE(2) has_cliente   FGCOLOR fg_c
   SKIP(1)
   SPACE(1) BTN_PROCESO SPACE(1)
            SPACE(1) BTN_SALIR SPACE(1) BTN_COPIAR
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Exportacion de movimientos" FONT 8.


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
    des_cliente
    has_cliente.

  mensaje = "    Exportando...".
  DISPLAY mensaje WITH FRAME frm-espere.

  OUTPUT TO "CTA_CTE.TXT".
  FOR EACH Cliente WHERE Cliente.cdg_cliente <= has_cliente
                     AND Cliente.cdg_cliente >= des_cliente:

      EXPORT Cliente.

  END.
  OUTPUT CLOSE.
  HIDE FRAME frm-espere NO-PAUSE.

END.
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Exportacion de datos".
nom_menu = "CLIENTES".

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.

RUN PONER_SESION.

DISPLAY
    des_cliente
    has_cliente
    WITH FRAME frm-rango.

ENABLE ALL WITH FRAME frm-rango.
WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.


PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.



