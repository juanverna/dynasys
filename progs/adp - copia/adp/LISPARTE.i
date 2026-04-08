/*------------------------------------------------------------------------------------*/
/*                    Listado General de Ficha de Novedades                           */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE INPUT PARAMETER que_registro AS ROWID.
DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.

DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE fecha_lis           AS DATE.
DEFINE VARIABLE hora_lis            AS CHARACTER.
DEFINE VARIABLE ultimo              AS LOGICAL.
DEFINE VARIABLE que_empresa         LIKE Empresa.nombre.


DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "{&TITULO-FRAME}" AT 23
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis
  det_titulo AT 23
  hora_lis AT 68
  SKIP
  des_fecha AT 23 NO-LABEL
  " - " has_fecha NO-LABEL
  SKIP(1)
  {&TITULO-COLUMNAS}
  WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  {&DEFINICION-LISTADO}
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR_PARTE.
RUN PRINFILE.P ( INPUT DIRE_TMP + "{&ARCHIVO-SALIDA}", INPUT port).

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_PARTE:

  {&ARMAR_DET}

  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").

  OUTPUT TO VALUE( DIRE_TMP + "{&ARCHIVO-SALIDA}" ) PAGED PAGE-SIZE 72.

  {&FOR-EACH-PARTE}

      VIEW FRAME frm-titulo.
      DISPLAY {&CAMPOS-LISTADO}
              WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.

  END.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  
END PROCEDURE.  

{CODIMPRE.I}
