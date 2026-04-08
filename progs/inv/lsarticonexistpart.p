/*====================================================================================*/
/*      GENERA EL LISTADO DE ARTICULOS CON EXISTENCIA EN UN RANGO DE DEPÓSITOS        */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_articulo   LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_articulo   LIKE Articulo.cdg_articulo.

DEFINE INPUT PARAMETER des_deposito   LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_deposito   LIKE Deposito.cdg_deposito.

{VRSHARED.I}
{VPERSINM.I}
{DFVRBUIL.I}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Remanentes por Partidas - Depósitos" AT 30
  "Página:" AT 73 PAGE-NUMBER FORMAT ">9" AT 80
  SKIP
  fecha_lis
  titulo_det AT 30
  hora_lis AT 73
  SKIP(1)
  "----------------------------------------------------------------------------------" SKIP
  "   Codigo        Descripcion                              Unidades      Granel    " SKIP
  "----------------------------------------------------------------------------------" SKIP
  WITH WIDTH 120 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       Articulo.cdg_articulo
       Articulo.descripcion
       Partida.cdg_partida
       Partida-Deposito.remanente_cantidad
       Partida-Deposito.remanente_granel
       WITH WIDTH 120 DOWN FRAME frm-listado USE-TEXT STREAM-IO NO-LABEL.


/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/
RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  titulo_det = " Al ".

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
/*  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.*/

  OUTPUT TO VALUE(dire_tmp + "lsexsten.txt") PAGED.

  RUN PONE_CODIGO ( INPUT "CARTA").

  
  FOR EACH Articulo NO-LOCK:
     VIEW FRAME frm-titulo.
     DISPLAY
         Articulo.cdg_articulo
         Articulo.descripcion
         WITH FRAME frm-listado.
  
         FOR EACH Partida-deposito NO-LOCK 
                 OF Articulo, Deposito OF Partida-deposito
                            WHERE Deposito.cdg_deposito >= des_deposito
                              AND Deposito.cdg_deposito <= has_deposito:
                              
            IF Partida-deposito.remanente_cantidad <> 0 or Partida-deposito.remanente_granel <> 0
                THEN DO:
                     FIND Partida of Partida-Deposito.
                     DISPLAY
                              Partida.cdg_partida
                              Partida-Deposito.remanente_cantidad
                              Partida-Deposito.remanente_granel
                              WITH FRAME frm-listado.
                              DOWN WITH FRAME frm-listado.

                END.
          END.

  END.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT dire_tmp + "lsexsdeppart.txt",
                   INPUT 8 ).

END PROCEDURE.

{CODIMPRE.I}

/*     RUN CALCSTCK.P (INPUT ROWID(Articulo),
                     INPUT has_fecha,
                     INPUT ficha,
                     OUTPUT sal_cantidad,
                     OUTPUT sal_granel ).
     GET NEXT qry_Articulos.
  END.

  UNDERLINE
       Articulo.cdg_articulo
       Articulo.descripcion
       sal_cantidad
       sal_granel
       WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.*/
