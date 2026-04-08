/*====================================================================================*/
/*      GENERA EL LISTADO DE ARTICULOS CON PARTIDAS - DEPOSITOS CON REMANENTE         */
/*                        DE STOCK                                                    */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.
DEFINE INPUT PARAMETER des_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep LIKE Deposito.cdg_deposito.

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE Sal_un      LIKE Partida-Deposito.remanente_cantidad.
DEFINE VARIABLE Sal_gr      LIKE Partida-Deposito.remanente_granel.
DEFINE VARIABLE Ver         AS LOGICAL.
DEFINE VARIABLE Pri         AS LOGICAL.
DEFINE VARIABLE kilteor     AS DECIMAL.
DEFINE VARIABLE tkilteor    AS DECIMAL.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Artículos con Remanentes por Partidas por Depósitos" AT 40
  "Página:" AT 125 PAGE-NUMBER FORMAT ">>9" AT 133
  SKIP
  fecha_lis
  titulo_det AT 40
  hora_lis AT 125
  SKIP(1)
  WITH WIDTH 140 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       Articulo.cdg_articulo COLUMN-LABEL "Código!Artículo"
       Articulo.descripcion  COLUMN-LABEL "Descripción!Artículo"
       Articulo.cdg_umed     COLUMN-LABEL "Uni!dad" 
       Articulo.a_granel     COLUMN-LABEL "Gra!nel" FORMAT "Si/"
       Partida.cdg_partida   COLUMN-LABEL "Código!Partida"
       Deposito.cdg_deposito COLUMN-LABEL "Código!Depósito"
       Partida-Deposito.remanente_cantidad COLUMN-LABEL "Existencia!Unidades" FORMAT "->,>>>,>>9.99"
       Partida-Deposito.remanente_granel COLUMN-LABEL "Existencia!a Granel" FORMAT "->,>>>,>>>,>>9.99"
       kilteor COLUMN-LABEL "Conversión!a Kilogramos" FORMAT "->,>>>,>>>,>>9.99"
       WITH WIDTH 140 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.
  titulo_det = "Depósitos: " + STRING(des_coddep) + " - " + STRING(has_coddep).

  tkilteor = 0.
  PAUSE 0.
  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i}

  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart
                         AND Articulo.stock_sino
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.descripcion >= des_nomart
                         AND Articulo.descripcion <= has_nomart
                         AND Articulo.stock_sino
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_Articulos.
  DO WHILE AVAILABLE Articulo:
     Sal_un = 0.
     Sal_gr = 0.
     kilteor = 0.
     Ver = NO.    
     Pri = YES.       
     VIEW FRAME frm-titulo.

     FOR EACH Partida-deposito OF Articulo 
        WHERE Partida-Deposito.cdg_empresa = Empresa.cdg_empresa
          AND ( Partida-deposito.remanente_cantidad <> 0 OR 
                Partida-deposito.remanente_granel <> 0 ) NO-LOCK,
         FIRST Deposito OF Partida-deposito
               WHERE Deposito.cdg_deposito >= des_coddep
                 AND Deposito.cdg_deposito <= has_coddep NO-LOCK:
                
            FIND Partida OF Partida-deposito.
            Sal_un = Sal_un + Partida-Deposito.remanente_cantidad.
            Sal_gr = Sal_gr + Partida-Deposito.remanente_granel.
            kilteor = kilteor + (Partida-Deposito.remanente_cantidad * kgxun_neto).
            DISPLAY
                Articulo.cdg_articulo  WHEN pri
                Articulo.descripcion   WHEN pri
                Articulo.cdg_umed      WHEN pri
                Articulo.a_granel      WHEN pri
                Partida.cdg_partida    
                Deposito.cdg_deposito
                Partida-Deposito.remanente_cantidad
                Partida-Deposito.remanente_granel
                (Partida-Deposito.remanente_cantidad * kgxun_neto) @ kilteor 
                WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
            Pri = NO.
     END.

     GET NEXT qry_Articulos.

     IF Ver 
     THEN DO:
            tkilteor = tkilteor + kilteor.
            UNDERLINE
                   Articulo.cdg_articulo
                   Articulo.descripcion
                   Articulo.cdg_umed
                   Articulo.a_granel
                   Partida.cdg_partida
                   Deposito.cdg_deposito                   
                   Partida-Deposito.remanente_cantidad
                   Partida-Deposito.remanente_granel
                   kilteor
                   WITH FRAME frm-listado.
                   DOWN 1 WITH FRAME frm-listado.
             DISPLAY
                   Sal_un @ Partida-Deposito.remanente_cantidad
                   Sal_gr @ Partida-Deposito.remanente_granel
                   kilteor
                   WITH FRAME frm-listado.
                   DOWN 2 WITH FRAME frm-listado.
     END.
  END.

  UNDERLINE
        Articulo.cdg_articulo
        Articulo.descripcion
        Articulo.cdg_umed
        Articulo.a_granel
        Partida.cdg_partida
        Deposito.cdg_deposito                   
        Partida-Deposito.remanente_cantidad
        Partida-Deposito.remanente_granel
        kilteor
        WITH FRAME frm-listado.
        DOWN 1 WITH FRAME frm-listado.
  DISPLAY
        "Total Teórico de Kg" @ Partida-Deposito.remanente_cantidad
        tkilteor @ kilteor
        WITH FRAME frm-listado.
        DOWN 2 WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).

END PROCEDURE.

