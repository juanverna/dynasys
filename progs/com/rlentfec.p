/*====================================================================================*/
/*       Toma datos para el listado de movimientos por articulo                       */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

/*{RANGOART.I "NEW"}*/

DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".
DEFINE VARIABLE que_estados    AS   CHARACTER FORMAT "X(30)" INITIAL "IN,AL" LABEL "Estados".
DEFINE VARIABLE des_fecha      AS   DATE LABEL "Del".
DEFINE VARIABLE has_fecha      AS   DATE INITIAL TODAY LABEL "Al".
DEFINE VARIABLE ficha          AS   INTEGER INITIAL 0 LABEL "Ficha"
       VIEW-AS RADIO-SET
               RADIO-BUTTONS "&Todos",0,"&Dep.",1,"&Partida",2.

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

/*{ESTADRQS.I}*/
{WGLISTAR.I}

FORM
   SKIP(1)
/*   {SCRNGART.I}
   SKIP (0.2)*/
   des_fecha   COLON 17  FGCOLOR fe_c BGCOLOR be_c
   has_fecha             FGCOLOR fe_c BGCOLOR be_c
   SKIP(1)
   disp_out    COLON 17  FGCOLOR fg_c procesar FGCOLOR fg_c
   SKIP(1)
   SPACE(5) BTN_PROCESO SPACE(3) BTN_VERDATOS SPACE(3) BTN_IMPRIMIR
            SPACE(3) BTN_SALIR SPACE(5)
   SKIP(1)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Entregas por fecha" FONT 8 THREE-D KEEP-TAB-ORDER.

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "lsentfec.txt" "port" }
/*{VERANART.I }*/

ON CHOOSE OF btn_proceso
DO:

  ASSIGN
       /*ver_por*/
       des_fecha   has_fecha
       /*des_codigo  des_nombre
       has_codigo  has_nombre*/
       disp_out.  

  RUN LSENTFEC.P ( INPUT des_fecha, 
                   INPUT has_fecha,
                   INPUT disp_out).
                   
END.

{TGPROBAT.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Reportes de Entregas por Fecha".
nom_menu = "COMPRAS".

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

RUN PONER_SESION.

ENABLE ALL WITH FRAME frm-rango.

ASSIGN
   des_fecha = DATE(MONTH(TODAY),1,YEAR(TODAY)).
   has_fecha = TODAY.

      
/*APPLY "U8" TO des_codigo IN FRAME frm-rango.
APPLY "U9" TO has_codigo IN FRAME frm-rango.
ver_por = 1.
APPLY "VALUE-CHANGED" TO ver_por IN FRAME frm-rango.*/

DISPLAY /*ver_por
        des_codigo
        has_codigo
        des_nombre
        has_nombre*/
        disp_out
        procesar
        des_fecha
        has_fecha
        WITH FRAME frm-rango.

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

{CODIMPRE.I}
