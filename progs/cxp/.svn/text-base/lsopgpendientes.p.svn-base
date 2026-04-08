/*=================================================================================*/
/*            LISTADO DE ORDENES DE PAGO PENDIENTES DE ENTREGA                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.
DEFINE INPUT PARAMETER p-entregada  AS LOGICAL.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE que_empresa         LIKE Empresa.nombre.
DEFINE VARIABLE titulo              AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE importe_total       LIKE Opg_header.imp_total.

DEFINE VARIABLE fecha_lis           AS CHARACTER.
DEFINE VARIABLE hora_lis            AS CHARACTER.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  titulo AT 40
  "Página:" AT 116 PAGE-NUMBER FORMAT "Z9" AT 123
  SKIP
  fecha_lis
  "del" AT 40
  des_fecha
  "al"
  has_fecha
  hora_lis AT 116
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Proveedor.cdg_proveedor COLUMN-LABEL "Código!Proveedor"
  Proveedor.nombre        COLUMN-LABEL "Razón!Social"
  Opg_header.fecha        COLUMN-LABEL "Fecha!Emisión"
  Opg_header.nro_comprob  COLUMN-LABEL "Número!Comprobte"
  Opg_header.imp_total    COLUMN-LABEL "Importe!Total"
  Opg_header.leyenda FORMAT "X(40)"
  WITH WIDTH 132 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/


RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

   fecha_lis = STRING(TODAY).
   hora_lis  = STRING(TIME,"HH:MM:SS").
   IF p-entregada 
      THEN titulo = "Ordenes de pago entregadas a proveedores".
      ELSE titulo = "Ordenes de pago pendientes de entrega".

   PAUSE 0.
   mensaje = "    Procesando ...".
   DISPLAY mensaje WITH FRAME frm-espere.

   OUTPUT TO VALUE(dire_tmp + "lsopgpendientes.txt") PAGED.

   FOR EACH  Opg_header
       WHERE Opg_header.tip_comprob = "OP"
         AND Opg_header.fecha >= des_fecha
         AND Opg_header.fecha <= has_fecha
         AND Opg_header.entregada = p-entregada
         AND Opg_header.cdg_empresa = Empresa.cdg_empresa
         AND NOT Opg_header.anulado,
         FIRST Proveedor OF Opg_header
       BREAK BY Proveedor.cdg_proveedor BY Opg_header.fecha WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.

       DISPLAY 
            Proveedor.cdg_proveedor  WHEN FIRST-OF(Proveedor.cdg_proveedor)
            Proveedor.nombre         WHEN FIRST-OF(Proveedor.cdg_proveedor)
            Opg_header.fecha
            Opg_header.nro_comprob 
            Opg_header.imp_total 
            Opg_header.leyenda 
            WITH FRAME frm-listado.

       DOWN WITH FRAME frm-listado.

       importe_total = importe_total + Opg_header.imp_total.
 
   END. 

   UNDERLINE  Opg_header.imp_total 
                WITH FRAME frm-listado.
   DISPLAY importe_total @ Opg_header.imp_total
                WITH FRAME frm-listado.

   OUTPUT CLOSE.
   PAUSE 0.
   HIDE FRAME frm-espere.

   RUN veresult.w ( INPUT dire_tmp + "lsopgpendientes.txt",
                    INPUT 2 ).


END PROCEDURE.

