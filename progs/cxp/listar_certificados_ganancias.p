/*=================================================================================*/
/*          LISTA TODOS LOS CERTIFICADOS DE GANANCIAS DE UN PERIODO                */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      AS   DATE.
DEFINE INPUT PARAMETER has_fecha      AS   DATE.
DEFINE INPUT PARAMETER ver_pagos      AS   INTEGER.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE t-retenido            LIKE Certificado_gan.imp_retenido.

DEFINE VARIABLE mensaje               AS   CHARACTER FORMAT "X(40)".
DEFINE VARIABLE todos                 AS   INTEGER INITIAL 0.
DEFINE VARIABLE ya_emi                AS   INTEGER INITIAL 1.
DEFINE VARIABLE no_emi                AS   INTEGER INITIAL 2.
DEFINE VARIABLE nulos                 AS   INTEGER INITIAL 3.

DEFINE VARIABLE titulo-f              AS   CHARACTER FORMAT "X(55)".

DEFINE QUERY qry_certificados   FOR Certificado_gan, Tipo_actividad, Proveedor.

/*=================================================================================*/
/*                                  FRAMES                                         */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
       que_empresa
       titulo-f AT 40
       "Página:" AT 116 PAGE-NUMBER FORMAT ">9" AT 123 
       SKIP
       fecha_lis 
       hora_lis AT 116
       SKIP(1)
       WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.

FORM
  Certificado_gan.nro_certifgan FORMAT "ZZZZZ9"
  Proveedor.cdg_proveedor
  Proveedor.nombre
  Certificado_gan.cdg_tiporetgan
  Tipo_actividad.abrevia
  Certificado_gan.fecha_emision
  Certificado_gan.imp_retenido
  Certificado_gan.imp_pagado
  Certificado_gan.emitido
  WITH WIDTH 196 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FORM
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE FGCOLOR 14 BGCOLOR 4 "Aguarde un momento por favor"
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.

/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O     */
/*=================================================================================*/


titulo_w = "Listado de Certificados de Retención de Ganancias".
que_empresa = Empresa.nombre.

CASE ver_pagos:
    WHEN todos
    THEN DO:
         titulo-f = "Certificados de retención de ganancias emitidos o no".
    END.
    WHEN ya_emi
    THEN DO:
         titulo-f = "Certificados de retención de ganancias ya emitidos".
    END.
    WHEN no_emi
    THEN DO:
         titulo-f = "Certificados de retención de ganancias pendientes de emisión".
    END.
    WHEN nulos
    THEN DO:
         titulo-f = "Certificados de retención de ganancias anulados".
    END.
END CASE.
RUN ABRE_QUERY.

{dirprinfile.i}
/*
OUTPUT TO VALUE(DIRE_TMP + "lsctfgan.txt") PAGED PAGE-SIZE 72.
*/

t-retenido = 0.
GET FIRST qry_certificados.
DO WHILE AVAILABLE Certificado_gan:

   VIEW FRAME frm-titulo.
   DISPLAY Certificado_gan.nro_certifgan
           Proveedor.cdg_proveedor
           Proveedor.nombre
           Certificado_gan.cdg_tiporetgan
           Tipo_actividad.abrevia
           Certificado_gan.fecha_emision
           Certificado_gan.imp_retenido
           Certificado_gan.imp_pagado
           Certificado_gan.emitido
           WITH FRAME frm-listado.

    DOWN WITH FRAME frm-listado.

    t-retenido = t-retenido + Certificado_gan.imp_retenido.
          
    GET NEXT qry_certificados.
    
END.           

UNDERLINE  Certificado_gan.nro_certifgan
           Proveedor.cdg_proveedor
           Proveedor.nombre
           Certificado_gan.cdg_tiporetgan
           Tipo_actividad.abrevia
           Certificado_gan.fecha_emision
           Certificado_gan.imp_retenido
           Certificado_gan.imp_pagado
           Certificado_gan.emitido
           WITH FRAME frm-listado.

DISPLAY "Total Certificados" @ Proveedor.nombre
        t-retenido           @ Certificado_gan.imp_retenido
        WITH FRAME frm-listado.


OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida, 
                 INPUT 22).

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

{OPQYRGAN.I}

END PROCEDURE.

