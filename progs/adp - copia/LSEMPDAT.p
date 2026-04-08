/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER que-empleado AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE det_titulo  AS CHARACTER FORMAT "X(30)".
DEFINE QUERY qry_datosliq   FOR Datos_liq, Tit_dat_liquid.

/*---------------------------------------------------------------------------------*/
/*                                   F R A M E S                                   */
/*---------------------------------------------------------------------------------*/

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "Datos de Liquidacion por Dato" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  det_titulo AT 30
  hora_lis AT 68
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "Legajo           Nombre                                         Valor" SKIP
  "------------------------------------------------------------------------------"
  WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM
    Empleado.nro_legajo
    SPACE(10)
    Empleado.nombre
    SPACE(5)
    Datos_liq.valor
    WITH WIDTH 80 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O     */
/*=================================================================================*/

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").
FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

FIND Tit_dat_liquid WHERE ROWID(Tit_dat_liquid) = act_datliq NO-LOCK.    
det_titulo = STRING(Tit_dat_liquid.cdg_datliq) + " - " + Tit_dat_liquid.descripcion.

OUTPUT TO VALUE(dire_tmp + "lsempdat.txt") PAGED.

FOR EACH Datos_liq OF Tit_dat_liquid NO-LOCK, Empleado OF Datos_liq NO-LOCK:
    VIEW FRAME frm-titulo.
    DISPLAY Empleado.nro_legajo
            Empleado.nombre
            Datos_liq.valor
            WITH FRAME frm-listado.       
    DOWN WITH FRAME frm-listado.        
END.

OUTPUT CLOSE.

RUN PRINFILE.P (INPUT "lsempdat.txt").