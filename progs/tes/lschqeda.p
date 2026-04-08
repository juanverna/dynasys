/*====================================================================================*/
/*                          Listado de Cheque por Proveedor                           */
/*====================================================================================*/

DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_nombre  LIKE Proveedor.nombre.
DEFINE INPUT PARAMETER has_codigo  LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_nombre  LIKE Proveedor.nombre.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

DEFINE SHARED VARIABLE ndias       AS INTEGER EXTENT 7.

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

/* Campos para el Listado */

DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "Tot.Cheques".
DEFINE VARIABLE vencida     AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "Vencidos".
DEFINE VARIABLE avencer     AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "A Vencer".
DEFINE VARIABLE aper_1      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "  <  -060".
DEFINE VARIABLE aper_2      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "-060 a -030".
DEFINE VARIABLE aper_3      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "-030 a  000".
DEFINE VARIABLE aper_4      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL " 000 a  015".
DEFINE VARIABLE aper_5      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL " 015 a  030".
DEFINE VARIABLE aper_6      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL " 030 a  045".
DEFINE VARIABLE aper_7      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL " 045 a  060".
DEFINE VARIABLE aper_8      AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "  >   060".


/* Acumuladores para totales */

DEFINE VARIABLE acu_saldo   AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_vencida AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_avencer AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_1       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_2       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_3       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_4       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_5       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_6       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_7       AS DECIMAL FORMAT "-ZZZZZZ9.99".
DEFINE VARIABLE acu_8       AS DECIMAL FORMAT "-ZZZZZZ9.99".

DEFINE VARIABLE deuda     AS DECIMAL.
DEFINE VARIABLE dias      AS INTEGER.
DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Cheques emitidos por fecha, al" AT 58
  has_fecha
  "Pagina:" AT 161 PAGE-NUMBER FORMAT ">>9" AT 168
  SKIP
  fecha_lis
  hora_lis AT 161
  SKIP(1)
  WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Proveedor.cdg_proveedor COLUMN-LABEL "Codigo"
  SPACE(1)
  Proveedor.nombre FORMAT "X(30)"
  SPACE(2)
  saldo
  vencida
  avencer
  aper_1
  aper_2
  aper_3
  aper_4
  aper_5
  aper_6
  aper_7
  aper_8
  WITH WIDTH 180 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR_TODO.
RETURN.


/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  ASSIGN
     acu_saldo   = 0 
     acu_vencida = 0 
     acu_avencer = 0
     acu_1       = 0
     acu_2       = 0
     acu_3       = 0
     acu_4       = 0
     acu_5       = 0
     acu_6       = 0
     acu_7       = 0
     acu_8       = 0.

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i &LIN-PAG=72}

  /*  
  OUTPUT TO VALUE (dire_tmp + "lschqeda.txt") PAGE-SIZE 72.
  */
  
  RUN PONE_CODIGO ( INPUT "CARTA,HORIZONT" ).

  DO WITH FRAME frm-listado:
     aper_1:LABEL = "  < " + STRING(ndias [ 1 ] ).
     aper_2:LABEL = STRING(ndias [ 1 ] ) + " a " + STRING(ndias [ 2 ] ).
     aper_3:LABEL = STRING(ndias [ 2 ] ) + " a " + STRING(ndias [ 3 ] ).
     aper_4:LABEL = STRING(ndias [ 3 ] ) + " a " + STRING(ndias [ 4 ] ).   
     aper_5:LABEL = STRING(ndias [ 4 ] ) + " a " + STRING(ndias [ 5 ] ).
     aper_6:LABEL = STRING(ndias [ 5 ] ) + " a " + STRING(ndias [ 6 ] ).
     aper_7:LABEL = STRING(ndias [ 6 ] ) + " a " + STRING(ndias [ 7 ] ).
     aper_8:LABEL = "  > " + STRING(ndias [ 7 ] ).
  END.

  {OPQRYPRV.I}
  
  GET FIRST qry_proveedor.
  DO WHILE AVAILABLE Proveedor:
     VIEW FRAME frm-titulo.
     RUN LISTAR.
     GET NEXT qry_proveedor.
  END.   

  UNDERLINE Proveedor.cdg_proveedor Proveedor.nombre
            saldo vencida avencer
            aper_1 aper_2 aper_3 aper_4
            aper_5 aper_6 aper_7 aper_8
            WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.

  DISPLAY "TOTALES:"  @ Proveedor.nombre
          acu_saldo   @ saldo
          acu_vencida @ vencida
          acu_avencer @ avencer
          acu_1       @ aper_1
          acu_2       @ aper_2
          acu_3       @ aper_3
          acu_4       @ aper_4
          acu_5       @ aper_5
          acu_6       @ aper_6
          acu_7       @ aper_7
          acu_8       @ aper_8
     WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.

  UNDERLINE Proveedor.cdg_proveedor Proveedor.nombre
            saldo vencida avencer
            aper_1 aper_2 aper_3 aper_4
            aper_5 aper_6 aper_7 aper_8
            WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

RUN PONER_SESION.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

PROCEDURE LISTAR:

  IF NOT CAN-FIND (FIRST Cheque OF Proveedor WHERE Cheque.estado = "00")
     THEN RETURN.

  ASSIGN saldo   = 0
         vencida = 0
         avencer = 0
         aper_1  = 0
         aper_2  = 0
         aper_3  = 0
         aper_4  = 0
         aper_5  = 0
         aper_6  = 0
         aper_7  = 0
         aper_8  = 0.

  FOR EACH Cheque OF Proveedor WHERE Cheque.estado = "00":

     deuda = Cheque.importe.
     saldo = saldo + deuda.
     dias = Cheque.fecha_emision - has_fecha.

     IF dias > 0 THEN avencer = avencer + deuda.
                 ELSE vencida = vencida + deuda.

     IF dias <  ndias [ 1 ] THEN  aper_1 = aper_1 + deuda.
     IF dias >= ndias [ 1 ] AND dias < ndias [ 2 ] THEN aper_2 = aper_2 + deuda.
     IF dias >= ndias [ 2 ] AND dias < ndias [ 3 ] THEN aper_3 = aper_3 + deuda.
     IF dias >= ndias [ 3 ] AND dias < ndias [ 4 ] THEN aper_4 = aper_4 + deuda.
     IF dias >= ndias [ 4 ] AND dias < ndias [ 5 ] THEN aper_5 = aper_5 + deuda.
     IF dias >= ndias [ 5 ] AND dias < ndias [ 6 ] THEN aper_6 = aper_6 + deuda.
     IF dias >= ndias [ 6 ] AND dias <= ndias [ 7 ] THEN aper_7 = aper_7 + deuda.
     IF dias >  ndias [ 7 ] THEN                aper_8 = aper_8 + deuda.

  END.

  acu_saldo   = acu_saldo   + saldo.
  acu_vencida = acu_vencida + vencida.
  acu_avencer = acu_avencer + avencer.
  acu_1       = acu_1       + aper_1.
  acu_2       = acu_2       + aper_2.
  acu_3       = acu_3       + aper_3.
  acu_4       = acu_4       + aper_4.
  acu_5       = acu_5       + aper_5.
  acu_6       = acu_6       + aper_6.
  acu_7       = acu_7       + aper_7.
  acu_8       = acu_8       + aper_8.

  VIEW FRAME frm-titulo.
        
  DISPLAY Proveedor.cdg_proveedor
          Proveedor.nombre
          saldo
          vencida
          avencer
          aper_1
          aper_2
          aper_3
          aper_4
          aper_5
          aper_6
          aper_7
          aper_8
          WITH FRAME frm-listado.

  DOWN WITH FRAME frm-listado.

END PROCEDURE.


PROCEDURE PONER_MONEDA:

END PROCEDURE.

{CODIMPRE.I}
 
