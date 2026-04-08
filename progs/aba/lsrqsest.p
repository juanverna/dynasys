/*=================================================================================*/
/*          EMITE EL LISTADO DE REQUISICIONES POR ESTADO                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha  AS DATE.
DEFINE INPUT PARAMETER has_fecha  AS DATE.
DEFINE INPUT PARAMETER que_estado AS CHARACTER FORMAT "X(20)".

{VRSHARED.I}
{VPERSINM.I}
{WGLISTAR.I}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.

FORM HEADER
   que_empresa FORMAT "X(25)"
   "Requisiciones por Estado:" AT 50
   que_estado
   "Pagina:" AT 113 PAGE-NUMBER FORMAT ">9" AT 120
   SKIP
   fecha_lis
   "Periodo" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 113
   SKIP(1) 
   "-------------------------------------------------------------------------------------------------------------------------" SKIP
   "Pr. Requisicion Vr Fecha      Sector                                       Fecha                        Fecha de         " SKIP
   "    Codigo Artic.      Descripcion                             Solicitado  Entrega         Aprobado     Entrega    Estado" SKIP
   "-------------------------------------------------------------------------------------------------------------------------" SKIP(1)
   WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
   Rqs_header.prioridad 
   Rqs_header.tip_comprob 
   Rqs_header.nro_comprob
   Rqs_header.version 
   Rqs_header.fecha 
   Area.cdg_area 
   WITH WIDTH 80 DOWN FRAME frm-head USE-TEXT STREAM-IO NO-LABEL.

FORM
   SPACE(8)
   Articulo.cdg_articulo
   Articulo.descripcion  /*FORMAT "X(35)"*/
   Rqs_detalle.cantidad_sol
   Rqs_detalle.fecha_temprana
   Rqs_detalle_ent.cantidad
   Articulo.cdg_umed COLUMN-LABEL "Un."
   Rqs_detalle_ent.fecha_temprana
   Rqs_detalle.cdg_estado
   WITH WIDTH 131 FRAME frm-detl USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.
  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  OUTPUT TO VALUE(DIRE_TMP + "lsrqsest.txt") PAGED PAGE-SIZE 72.

  RUN PONE_CODIGO ( INPUT "HORIZONT,SET17CPI,CARTA").
 

  FOR EACH Rqs_detalle WHERE LOOKUP(Rqs_detalle.cdg_estado,que_estado) <> 0, 
      EACH Rqs_header OF Rqs_detalle
           WHERE Rqs_header.tip_comprob = "PI"
           AND Rqs_header.fecha >= des_fecha
           AND Rqs_header.fecha <= has_fecha,
           Area OF Rqs_header,
           Articulo OF Rqs_detalle, 
           EACH Rqs_detalle_ent OF Rqs_detalle
           BREAK BY Rqs_header.nro_comprob BY Rqs_header.prioridad 
                 BY Rqs_header.fecha BY Rqs_detalle.nro_linea:
                 
      VIEW FRAME frm-titulo.

      IF FIRST-OF(Rqs_header.nro_comprob)
         THEN DISPLAY Rqs_header.prioridad 
                      Rqs_header.tip_comprob 
                      Rqs_header.nro_comprob
                      Rqs_header.version 
                      Rqs_header.fecha 
                      Area.cdg_area
                      WITH CENTERED FRAME frm-head STREAM-IO USE-TEXT.
            
      DISPLAY Articulo.cdg_articulo    WHEN FIRST-OF(Rqs_detalle.nro_linea) 
              Articulo.descripcion     WHEN FIRST-OF(Rqs_detalle.nro_linea) 
              Rqs_detalle.cantidad_sol WHEN FIRST-OF(Rqs_detalle.nro_linea) 
              Rqs_detalle.fecha_temprana WHEN FIRST-OF(Rqs_detalle.nro_linea)
              Rqs_detalle_ent.cantidad
              Articulo.cdg_umed COLUMN-LABEL "Un."
              Rqs_detalle_ent.fecha_temprana
              Rqs_detalle.cdg_estado
              WITH CENTERED FONT 10 FRAME frm-detl DOWN USE-TEXT STREAM-IO.
      DOWN WITH FRAME frm-detl.
  
      IF LAST-OF(Rqs_detalle.nro_linea)
      THEN DO:
           UNDERLINE Rqs_detalle_ent.cantidad WITH FRAME frm-detl.
           DISPLAY Rqs_detalle.cantidad @ Rqs_detalle_ent.cantidad
                   Articulo.cdg_umed
                   WITH CENTERED FRAME frm-detl DOWN USE-TEXT STREAM-IO.
           DOWN 2 WITH FRAME frm-detl.
      END.            
      
  END.                

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.

{CODIMPRE.I}
