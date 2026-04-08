/*====================================================================================*/
/*                   GENERA EL FORMULARIO DE RECUENTO DE MERCADERIA                   */
/*====================================================================================*/

DEFINE INPUT PARAMETER que_deposito   LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER que_hoja       LIKE Articulo-deposito.hoja_numero.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE titulo_lst     AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det     AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE espacio_un     AS CHARACTER INITIAL "________" COLUMN-LABEL "Recuento!Manual".
DEFINE VARIABLE espacio_gr     AS CHARACTER INITIAL "________" COLUMN-LABEL "Recuento!Manual".

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Hoja de recuento de artículos " AT 40 que_hoja
  "Página:" AT 118 PAGE-NUMBER FORMAT ">>>9" AT 125
  SKIP
  fecha_lis
  titulo_det AT 40
  hora_lis AT 118
  SKIP(1)
  WITH WIDTH 155 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo COLUMN-LABEL "Código!Artículo"
    Articulo.descripcion COLUMN-LABEL "Descripción!Artículo"
    Partida.cdg_partida COLUMN-LABEL "Código!Partida"
    Partida-deposito.cdg_ubicacion COLUMN-LABEL "Ubicación!Física"
    Partida-deposito.recuento_cantidad
    espacio_un
    Partida-deposito.recuento_granel
    espacio_gr
    WITH WIDTH 155 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  FIND Deposito WHERE Deposito.cdg_deposito = que_deposito NO-LOCK.

  titulo_det = "Depósito: " + STRING(Deposito.cdg_deposito) + " - " + Deposito.nombre.

  {dirprinfile.i}

  FOR EACH Articulo-deposito OF Deposito
      WHERE Articulo-deposito.cdg_empresa = Empresa.cdg_empresa
        AND Articulo-deposito.hoja_numero = que_hoja
        AND Articulo-deposito.st_recuento = "P" NO-LOCK,
      EACH Partida-deposito OF Articulo-deposito 
      WHERE Partida-deposito.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
      FIRST Articulo OF Articulo-deposito NO-LOCK,
      FIRST Partida WHERE Partida.cdg_empresa = Empresa.cdg_empresa OF Partida-deposito NO-LOCK
           BREAK BY Articulo.cdg_articulo
                 BY Partida.cdg_partida:

          VIEW FRAME frm-titulo.

          DISPLAY Articulo.cdg_articulo WHEN FIRST-OF(Articulo.cdg_articulo)
                  Articulo.descripcion  WHEN FIRST-OF(Articulo.cdg_articulo)
                  Partida.cdg_partida
                  Partida-deposito.cdg_ubicacion
                  Partida-deposito.recuento_cantidad
                  espacio_un
                  Partida-deposito.recuento_granel
                  espacio_gr
                  Partida-deposito.cdg_empresa
                  Partida.cdg_empresa
                  WITH CENTERED USE-TEXT FONT 2 FRAME frm-listado.
         DOWN WITH FRAME frm-listado.

  END.

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 2 ).

END PROCEDURE.

  
