/*============================================================================================*/
/*                          LANZA LA EJECUCION DE JARVIUS                                     */
/*============================================================================================*/

DEFINE VARIABLE fec-desde                   AS DATE.
DEFINE VARIABLE fec-hasta                   AS DATE.
DEFINE VARIABLE hms-desde                   AS CHARACTER.
DEFINE VARIABLE hms-hasta                   AS CHARACTER.

                        /*-------------------------------------------*/
                        /*  VARIABLES CON LOS DEFAULTS DE EJECUCION  */
                        /*-------------------------------------------*/


DEFINE VARIABLE v-cdg_depsalida             LIKE Deposito.cdg_deposito INITIAL 1.
DEFINE VARIABLE v-intervalo                 AS INTEGER INITIAL 1440.
DEFINE VARIABLE v-debug                     AS LOGICAL INITIAL NO.

                     /*-------------------------------------------------*/
                     /*  AJUSTA EL PATH PARA CADA CASO. UNIX O WINDOWS  */
                     /*-------------------------------------------------*/

IF OPSYS = "WIN32"
THEN DO:
     PROPATH=".\chui,.\sah,.\bas,.\aba,.\adp,.\com,.\exp,.\cxc,.\cxp,.\dsp," +
             ".\fac,.\gla,.\cps,.\imp,.\inv,.\seg,.\tes,.\utl," + 
             "u:\desa\sah\objetos,u:\desa\sah\fuentes,u:\desa\sah\includes," + 
             "u:\desa\sah\imagenes," +
             "C:\DLC83A\PROBUILD\EUCAPP\EUC.PL,C:\DLC83A\PROBUILD\EUCAPP," + 
             "C:\DLC83A\gui,C:\DLC83A,C:\DLC83A\bin".
END.
ELSE DO:
     PROPATH="/pgm/desa/sic/r2.5/chui,/pgm/desa/sic/r2.5/sah,/pgm/desa/sic/r2.5/bas,/pgm/desa/sic/r2.5/aba,/pgm/desa/sic/r2.5/adp,/pgm/desa/sic/r2.5/com,/pgm/desa/sic/r2.5/exp,/pgm/desa/sic/r2.5/cxc,/pgm/desa/sic/r2.5/cxp,/pgm/desa/sic/r2.5/dsp," +
             "/pgm/desa/sic/r2.5/fac,/pgm/desa/sic/r2.5/gla,/pgm/desa/sic/r2.5/cps,/pgm/desa/sic/r2.5/imp,/pgm/desa/sic/r2.5/inv,/pgm/desa/sic/r2.5/seg,/pgm/desa/sic/r2.5/tes,/pgm/desa/sic/r2.5/utl," + 
             "/pgm/desa/sah/objetos,/pgm/desa/sah/fuentes,/pgm/desa/sah/includes," + 
             "/pgm/desa/sah/imagenes," +
             "/usr/dlc/probuild/eucapp/euc.pl,/usr/dlc/probuild/eucapp," + 
             "/usr/dlc/gui,/usr/dlc,/usr/dlc/bin".
END.

                   /*----------------------------------------------------*/
                   /* LEVANTA PARAMETROS. SI NO ESTAN, DEJA LOS DEFAULTS */
                   /*----------------------------------------------------*/


FIND Parametro "JRVINTER" NO-LOCK NO-ERROR. 
IF AVAILABLE Parametro THEN v-intervalo = Parametro.valor_n.

FIND Parametro "JRVDEBUG" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN v-debug = Parametro.valor_l.

                            /*-----------------------------*/
                            /* CALCULA INTERVALO Y EJECUTA */
                            /*-----------------------------*/

fec-desde = TODAY.
hms-desde = STRING(TIME,"HH:MM:SS").
  
RUN sumahora.p ( INPUT  fec-desde,
                 INPUT  hms-desde,
                 OUTPUT fec-hasta,
                 OUTPUT hms-hasta,
                 INPUT  v-intervalo * 60).

RUN reqpresc.p ( INPUT  fec-desde,
                 INPUT  fec-hasta,
                 INPUT  hms-desde,
                 INPUT  hms-hasta,
                 INPUT  v-cdg_depsalida,
                 INPUT  v-debug) .
