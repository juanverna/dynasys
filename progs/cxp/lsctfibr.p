
/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      AS   DATE.
DEFINE INPUT PARAMETER has_fecha      AS   DATE.
DEFINE INPUT PARAMETER ver_pagos      AS   INTEGER.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE imp_ant        AS   DECIMAL.
DEFINE VARIABLE ie_ant         AS   CHARACTER.
DEFINE VARIABLE que_mes        AS   INTEGER.
DEFINE VARIABLE que_dia        AS   INTEGER.
DEFINE VARIABLE ant_ano        AS   INTEGER.
DEFINE VARIABLE ant_mes        AS   INTEGER.

DEFINE VARIABLE mensaje        AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE ya_emi          AS   INTEGER INITIAL 1.
DEFINE VARIABLE no_emi          AS   INTEGER INITIAL 2.

DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.

DEFINE QUERY qry_certificados   FOR Certificado_ibr, Tipo_retibr, Proveedor.

/*---------------------------------------------------------------------------------*/
/*                                   F R A M E S                                   */
/*---------------------------------------------------------------------------------*/

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP
       fecha_lis hora_lis AT 70
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.

FORM
  Certificado_ibr.nro_certifibr FORMAT "ZZZZZ9"
  Proveedor.cdg_proveedor
  Proveedor.nombre FORMAT "X(20)"
  Tipo_retibr.abrevia
  Certificado_ibr.fecha_emision
  Certificado_ibr.imp_retenido
  Certificado_ibr.imp_pagado
  Certificado_ibr.emitido
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FORM
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE FGCOLOR 14 BGCOLOR 4 "Aguarde un momento por favor"
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.

/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O     */
/*=================================================================================*/

{findempresa.i}
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

CASE ver_pagos:
    WHEN todos
    THEN DO:
         titulo-f = "Certificados emitidos o no".
    END.
    WHEN ya_emi
    THEN DO:
         titulo-f = "Certificados ya emitidos".
    END.
    WHEN no_emi
    THEN DO:
         titulo-f = "Certificados pendientes de emision".
    END.
END CASE.
RUN ABRE_QUERY.

OUTPUT TO VALUE(DIRE_TMP + "lsctfibr.txt") PAGED PAGE-SIZE 72.

GET FIRST qry_certificados.
DO WHILE AVAILABLE Certificado_ibr:

   VIEW FRAME frm-titulo.
   DISPLAY Certificado_ibr.nro_certifibr FORMAT "ZZZZZ9"
           Proveedor.cdg_proveedor
           Proveedor.nombre FORMAT "X(20)"
           Tipo_retibr.abrevia
           Certificado_ibr.fecha_emision
           Certificado_ibr.imp_retenido
           Certificado_ibr.imp_pagado
           Certificado_ibr.emitido
           WITH FRAME frm-listado.

    DOWN WITH FRAME frm-listado.
          
    GET NEXT qry_certificados.
    
END.           

UNDERLINE  Certificado_ibr.nro_certifibr
           Proveedor.cdg_proveedor
           Proveedor.nombre
           Tipo_retibr.abrevia
           Certificado_ibr.fecha_emision
           Certificado_ibr.imp_retenido
           Certificado_ibr.imp_pagado
           Certificado_ibr.emitido
           WITH FRAME frm-listado.

OUTPUT CLOSE.

RUN PRINFILE.P ( INPUT DIRE_TMP + "lsctfibr.txt", INPUT port).

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

{OPQYRIBR.I}

END PROCEDURE.
