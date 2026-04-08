/*=================================================================================*/
/*                TOMA EL RANGO DE FECHAS PARA LISTADOS DE CHEQUES                 */
/*=================================================================================*/

{VRSHARED.I }

DEFINE VARIABLE des_fecha LIKE Caj_header.fecha    LABEL "Desde fecha".
DEFINE VARIABLE has_fecha LIKE Caj_header.fecha    LABEL "Hasta fecha" INITIAL TODAY.

{WGLISTAR.I}

FORM 
   SKIP(1)
   des_fecha  COLON 15 FGCOLOR fe_c BGCOLOR be_c
              HELP "Primer día del rango a considerar"
   SKIP
   has_fecha  COLON 15 FGCOLOR fe_c BGCOLOR be_c
              HELP "Ultimo día del rango a considerar"
   SKIP(1)
   SPACE(3) BTN_PROCESO SPACE(1) BTN_VERDATOS SPACE(1) BTN_IMPRIMIR 
            SPACE(1) BTN_SALIR SPACE(3)
   SKIP(1)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c FONT 4
        TITLE "Indique rango de fechas" THREE-D.
        
/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "ls{&ID-PROG}.txt" port }

ON CHOOSE OF btn_proceso
DO:

  ASSIGN 
    des_fecha
    has_fecha.

  RUN LSCUADRORES.P ( INPUT des_fecha,
                      INPUT has_fecha ).

  ENABLE ALL WITH FRAME frm-rango.

END.  

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Cuadro de Resultados".
nom_menu = "CONTROL PRESUPUESTARIO".

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.

ASSIGN des_fecha = TODAY - (DAY(TODAY) - 1).
RUN PONER_SESION.

DISPLAY 
    des_fecha
    has_fecha
    WITH FRAME frm-rango.   
    
ENABLE ALL EXCEPT btn_verdatos btn_imprimir WITH FRAME frm-rango.

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

{CODIMPRE.I}
