/*=================================================================================*/
/*                                                                                 */
/*                   SECCIONES DE INCLUDE                                          */
/*                   --------------------                                          */
/*                                                                                 */
/*  DEFINICIONES          - Definiciones locales de variables                      */
/*  FRAMES                - Frames de los listados                                 */
/*  INICIAR-PROCESO       - Inicializacion del proceso                             */
/*  INICIAR-EMPLEADO      - Inicializacion de cada empleado, antes de OPEN QUERY   */
/*  INICIAR-RECIBO        - Inicializacion de cada empleado, despues de OPEN QUERY */
/*  PROCESAR-RECIBO       - Proceso de cada recibo, antes de los conceptos         */
/*  PROCESAR-CONCEPTO     - Proceso de cada concepto                               */
/*  FIN-CONCEPTOS         - Proceso luego de los conceptos de un recibo            */
/*  FIN-RECIBOS           - Proceso luego de los recibos de un empleado            */
/*  FIN-EMPLEADOS         - Proceso luego de todos los empleados                   */
/*  PROCEDIMIENTOS        - Procedimientos particulares de cada caso               */
/*                                                                                 */
/*                                                                                 */
/*                   PARAMETROS DE PRECOMPILACION                                  */
/*                   ----------------------------                                  */
/*                                                                                 */
/* ID-PROG              Identificacion del archivo de include                      */
/* CONDICION-EMPLEADO   Condicion adicional sobre los empleados                    */
/* CAMPOS-EXTRA-FRAME   Campos agregados a la frame de rango para el caso          */
/* CAMPOS-EXTRA-DISPLAY Variables adicionales a mostrar al inciar el programa      */
/* TITULO-FRAME         Titulo de la frame                                         */
/* TITULO-WINDOW        Titulo de la window                                        */
/* ARCHIVO-SALIDA       Nombre del archivo de salida para los listados             */
/* PROCESAR-CONCEPTOS   Indica si se accede al detalle de los recibos o no         */
/* SETEAR-IMPRESORA     Comandos de seteo a enviar a la impresora                  */
/*                                                                                 */
/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}

DEFINE VARIABLE por_fecha AS LOGICAL LABEL "Rango de" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Fechas",  YES, "Liquidaciones", NO INITIAL NO.
DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".
DEFINE VARIABLE des_fecha AS DATE LABEL "Desde Fecha".
DEFINE VARIABLE has_fecha AS DATE LABEL "Hasta Fecha" INITIAL TODAY.

{DFVRNEMP.I "NEW"}
{DFVRNLIQ.I}

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE det_titulo  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE que_domicilio LIKE Empresa.direccion.
DEFINE VARIABLE que_actividad LIKE Empresa.actividad.
DEFINE VARIABLE n_lineas    AS INTEGER FORMAT "ZZ9" LABEL "Lin/Pag" INITIAL 56.

DEFINE QUERY qry_recibos FOR Rcb_header, Liquidacion.

{WGLISTAR.I}

/*------------------------------------------------------------------------------------*/

              /* Definicion de variables locales al programa */
                   &SCOPED-DEFINE SECCION "DEFINICIONES" 
                             {LS{&ID-PROG}.I}

/*------------------------------------------------------------------------------------*/

FORM 
   SKIP(0.5)
   des_fecha   COLON 15 
    VIEW-AS FILL-IN 
    SIZE 9 BY .75
    BGCOLOR be_c FGCOLOR fe_c 
   por_fecha    COLON 35  FGCOLOR fg_c 
   SKIP(0.2)
   has_fecha   COLON 15 
    VIEW-AS FILL-IN 
    SIZE 9 BY .75
    BGCOLOR be_c FGCOLOR fe_c 
   procesar     COLON 35  FGCOLOR fg_c 
   /*
   SKIP(0.2)
   des_fecha    COLON 15  FGCOLOR fe_c BGCOLOR be_c     
   */
   SKIP(0.2)
   {SCRRNLIQ.I}
   SKIP(0.2)
   {SCRRNEMP.I}
   SKIP(0.2)
   {&CAMPOS-EXTRA-FRAME}
   SKIP(0.2)                           
   disp_out     COLON 15  FGCOLOR fg_c 
   n_lineas               FGCOLOR fe_c BGCOLOR be_c 
   SKIP(0.5)  
   BTN_PROCESO AT 10 SPACE(1) BTN_VERDATOS SPACE(1) BTN_IMPRIMIR 
            SPACE(1) BTN_SALIR SPACE(1)
   SKIP(0.5)         
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "{&TITULO-FRAME}" FONT 8 THREE-D KEEP-TAB-ORDER.
        
    /* Definicion de frames de listado de cada programa. Pueden incluirse triggers  */
                   &SCOPED-DEFINE SECCION "FRAMES" 
                             {LS{&ID-PROG}.I}
       
/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "{&ARCHIVO-SALIDA}" "port" }

ON CHOOSE OF btn_proceso
DO:

              /* Inicializacion de proceso y consistencia del mismo */
                   &SCOPED-DEFINE SECCION "INICIAR-PROCESO" 
                             {LS{&ID-PROG}.I}


  ASSIGN
    des_legajo
    has_legajo
    des_fecha
    has_fecha
    des_liquid
    has_liquid
    por_fecha
    disp_out
    procesar
    n_lineas.

  det_titulo = ( IF por_fecha THEN STRING(des_fecha) + "-" + STRING(has_fecha)
                              ELSE STRING(des_liquid,"999") + "-" + 
                                   SUBSTRING(des_liq_nom,1,8) +
                                   "/" +
                                   STRING(has_liquid,"999") + "-" + 
                                   SUBSTRING(has_liq_nom,1,8)).
  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  IF disp_out = "A" 
     THEN OUTPUT TO VALUE(dire_tmp + "{&ARCHIVO-SALIDA}") PAGE-SIZE VALUE(n_lineas).
     ELSE OUTPUT TO VALUE(port) PAGE-SIZE VALUE(n_lineas).

  {&SETEAR-IMPRESORA}

  FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                      AND Empleado.nro_legajo <= has_legajo
                      {&CONDICION-EMPLEADO}
                      AND ( ( CAN-FIND(FIRST Rcb_header OF Empleado 
                                       WHERE Rcb_header.fecha >= des_fecha
                                         AND Rcb_header.fecha <= has_fecha )
                              AND por_fecha )
                            OR 
                            ( CAN-FIND(FIRST Rcb_header OF Empleado 
                                   WHERE Rcb_header.sec_liquidacion >= des_liquid                                                                    AND Rcb_header.sec_liquidacion <= has_liquid ) )
                              AND NOT por_fecha ) 
                   BREAK BY Empleado.nro_legajo:

              /* Inicializacion del proceso de cada empleado */
                   &SCOPED-DEFINE SECCION "INICIAR-EMPLEADO" 
                             {LS{&ID-PROG}.I}

      IF por_fecha 
         THEN OPEN QUERY qry_recibos FOR EACH Rcb_header OF Empleado 
                                        WHERE Rcb_header.fecha >= des_fecha
                                          AND Rcb_header.fecha <= has_fecha, 
                                        FIRST Liquidacion OF Rcb_header.
         ELSE OPEN QUERY qry_recibos FOR EACH Rcb_header OF Empleado 
                                        WHERE Rcb_header.sec_liquidacion >= des_liquid                                                      AND Rcb_header.sec_liquidacion <= has_liquid,
                                        FIRST Liquidacion OF Rcb_header.


          /* Inicializacion del proceso de cada recibo de cada empleado */
                   &SCOPED-DEFINE SECCION "INICIAR-RECIBO" 
                             {LS{&ID-PROG}.I}

      GET FIRST qry_recibos.

      DO WHILE AVAILABLE Rcb_header:

                 /* Proceso de cada recibo de cada empleado */
                   &SCOPED-DEFINE SECCION "PROCESAR-RECIBO" 
                             {LS{&ID-PROG}.I}

          &IF {&PROCESAR-CONCEPTOS}
          &THEN
          FOR EACH Rcb_detalle OF Rcb_header NO-LOCK, 
               Concepto OF Rcb_detalle NO-LOCK BREAK BY Concepto.cdg_concepto:           
          
           /* Proceso de cada concepto de cada recibo de cada empleado */
                   &SCOPED-DEFINE SECCION "PROCESAR-CONCEPTO" 
                             {LS{&ID-PROG}.I}
          END.    
         
                 /* Finalizacion de los conceptos de este recibo */
                   &SCOPED-DEFINE SECCION "FIN-CONCEPTOS" 
                             {LS{&ID-PROG}.I}
          
          &ENDIF

          GET NEXT qry_recibos.

      END.      

                 /* Finalizacion de los recibos de este empleado */
                   &SCOPED-DEFINE SECCION "FIN-RECIBOS" 
                             {LS{&ID-PROG}.I}


  END.

                     /* Finalizacion de los empleados */
                   &SCOPED-DEFINE SECCION "FIN-EMPLEADOS" 
                             {LS{&ID-PROG}.I}

  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  VIEW FRAME frm-rango.   
     
  IF disp_out = "A" THEN ENABLE btn_verdatos btn_imprimir
                                WITH FRAME frm-rango.

END.         

ON VALUE-CHANGED OF por_fecha IN FRAME frm-rango
DO:

   ASSIGN por_fecha.
   IF por_fecha
   THEN DO:
      DISABLE des_liquid
              has_liquid
              WITH FRAME frm-rango.
      DISPLAY " " @ des_liquid
              " " @ des_liq_nom
              " " @ has_liquid
              " " @ has_liq_nom
              WITH FRAME frm-rango.
      ENABLE des_fecha
             has_fecha
             WITH FRAME frm-rango.        
                            
   END.
   ELSE DO:                                     
      DISABLE des_fecha
              has_fecha
              WITH FRAME frm-rango.
      DISPLAY " " @ des_fecha
              " " @ has_fecha
              WITH FRAME frm-rango.
      ENABLE des_liquid
             has_liquid
             WITH FRAME frm-rango.
   END.

END.

{TGPROBAT.I}

{HLPRNGEM.I}
{HLPRNLIQ.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "{&TITULO-WINDOW}".
nom_menu = "REPORTES DE LIQUIDACION".

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.
que_actividad = Empresa.actividad.
que_domicilio = Empresa.direccion + "," + Empresa.localidad.

                /* Procedimientos de iniciaci¢n del proceso */
                   &SCOPED-DEFINE SECCION "INICIAR-PROGRAMA" 
                             {LS{&ID-PROG}.I}

RUN PONER_SESION.

ENABLE ALL EXCEPT   des_nombre has_nombre 
                    des_liq_nom has_liq_nom
                    /*btn_imprimir btn_verdatos */
                    {&NO-HABILITAR}
                    WITH FRAME frm-rango.

APPLY "U8" TO des_legajo IN FRAME frm-rango.
APPLY "U9" TO has_legajo IN FRAME frm-rango.

DISPLAY
    des_legajo
    des_nombre
    has_legajo
    has_nombre
    des_liquid
    has_liquid
    por_fecha
    disp_out
    procesar
    n_lineas
   {&CAMPOS-EXTRA-DISPLAY}
    WITH FRAME frm-rango.   

APPLY "VALUE-CHANGED" TO por_fecha IN FRAME frm-rango.

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

                /* Procedimientos particulares de cada caso */
                   &SCOPED-DEFINE SECCION "PROCEDIMIENTOS" 
                             {LS{&ID-PROG}.I}

{CODIMPRE.I}











