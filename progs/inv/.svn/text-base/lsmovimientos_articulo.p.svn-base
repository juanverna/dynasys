/*====================================================================================*/
/*                   GENERA EL LISTADO DE MOVIMIENTOS X ARTICULO                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart     LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart     LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart     LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart     LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por        AS   INTEGER.
DEFINE INPUT PARAMETER des_coddep     LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep     LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER des_fecha      AS   DATE.
DEFINE INPUT PARAMETER has_fecha      AS   DATE.
DEFINE INPUT PARAMETER modo_movs      AS CHARACTER.

/*====================================================================================*/
/*                                  VARIABLES                                         */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}
{dfmodoexist.i}
{dfmodomovs.i}

DEFINE VARIABLE ry                  AS   CHARACTER FORMAT "X(131)".
DEFINE VARIABLE ing_cantidad        LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad        LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad        LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE v-real_cantidad     LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE v-pres_cantidad     LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE v-real_granel       LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE v-pres_granel       LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE ing_granel          LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel          LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel          LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE list_i_un           LIKE Cct_stock.cantidad.
DEFINE VARIABLE list_e_un           LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_i_un            LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_e_un            LIKE Cct_stock.cantidad.
                                    
DEFINE VARIABLE list_i_gr           LIKE Cct_stock.granel.
DEFINE VARIABLE list_e_gr           LIKE Cct_stock.granel.
DEFINE VARIABLE tot_i_gr            LIKE Cct_stock.granel.
DEFINE VARIABLE tot_e_gr            LIKE Cct_stock.granel.
                                    
DEFINE VARIABLE todos               AS LOGICAL.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE titulo_lst          AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE titulo_det          AS CHARACTER FORMAT "X(50)".

DEFINE QUERY qry_movimiento         FOR Cct_stock, Deposito.
DEFINE QUERY qry_articulos          FOR Articulo.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       titulo_lst AT 50
       "Pagina:" AT  113 PAGE-NUMBER FORMAT ">>9" AT 120
       SKIP
       fecha_lis
       titulo_det AT 50
       hora_lis AT 113
       SKIP(1)
       "--------------------------------------------------------------------------------------------------------------------------" SKIP
       "Código       Descripción                                        Unidad                                                    " SKIP
       "Artículo     Articulo                                           Stock                                                     " SKIP
       "     Código     Fecha    Identifiación                                                                                    " SKIP
       "     Depósito   Movimto  Comprobante       #         Ingreso        Egreso         Saldo Observaciones                    " SKIP
       "--------------------------------------------------------------------------------------------------------------------------" SKIP(1)
       WITH WIDTH 231 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.


DEFINE FRAME frm-articulo
       Articulo.cdg_articulo
       Articulo.descripcion
       Articulo.cdg_umed
       /*
       SKIP
       SPACE(9)
       des_fecha
       SPACE(49)
       sal_cantidad
       SPACE(23)
       sal_granel
       */
       WITH WIDTH 280 DOWN FRAME frm-articulo USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-movimiento
       SPACE(5)
       Deposito.cdg_deposito
       Cct_stock.fecha
       Cct_stock.tip_comprob
       Cct_stock.prf_comprob
       Cct_stock.nro_comprob FORMAT "ZZZZZ9"
       Cct_stock.nro_linea FORMAT "ZZ9"
       Cct_stock.presupuestado
       list_i_un
       list_e_un
       sal_cantidad
       /*
       list_i_gr
       list_e_gr
       sal_granel
       */
       Cct_stock.observacion FORMAT "X(40)"
       WITH WIDTH 231 FRAME frm-movimiento USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

DEFINE FRAME frm-raya
       ry
       SKIP
       WITH WIDTH 231 FRAME frm-raya USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  titulo_det = "Del " + STRING(des_fecha) + " al " + STRING(has_fecha).

  CASE modo_movs:
      WHEN C-TODOS  THEN titulo_lst = "Movimientos por Artículo".
      WHEN C-PRESUP THEN titulo_lst = "Movimientos Presupuestados por Artículo".
      WHEN C-REALES THEN titulo_lst = "Movimientos Reales por Artículo".
  END CASE.

  ry = FILL("-",131).
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


  GET FIRST qry_articulos.
  DO WHILE AVAILABLE Articulo:

     VIEW FRAME frm-titulo.

     tot_i_un = 0.
     tot_e_un = 0.
     tot_i_gr = 0.
     tot_e_gr = 0.

     ASSIGN sal_cantidad = 0
            sal_granel   = 0.

     FOR EACH Deposito 
         WHERE Deposito.cdg_deposito <= has_coddep 
           AND Deposito.cdg_deposito >= des_coddep:


         RUN calcular_stock.p (INPUT ROWID(Articulo),
                               INPUT ROWID(Deposito),
                               INPUT ?,
                               INPUT des_fecha - 1 ,
                               INPUT dep,
                               OUTPUT v-real_cantidad,
                               OUTPUT v-real_granel,
                               OUTPUT v-pres_cantidad,
                               OUTPUT v-pres_granel).

         CASE modo_movs:
             WHEN C-TODOS   THEN ASSIGN sal_cantidad = sal_cantidad + v-pres_cantidad - v-real_cantidad
                                        sal_granel = sal_granel + v-pres_granel - v-real_granel.
             WHEN C-PRESUP  THEN ASSIGN sal_cantidad = sal_cantidad + v-pres_cantidad
                                        sal_granel = sal_granel + v-pres_granel.
             WHEN C-REALES  THEN ASSIGN sal_cantidad = sal_cantidad + v-real_cantidad
                                               sal_granel = sal_granel + v-real_granel.
         END CASE.

     END.

     DISPLAY
            Articulo.cdg_articulo
            Articulo.descripcion
            Articulo.cdg_umed
            WITH FRAME frm-articulo.

     DOWN WITH FRAME frm-articulo.

     DISPLAY
         des_fecha @ Cct_stock.fecha
         sal_cantidad
         /*
         list_i_gr WHEN Cct_stock.tipo_mov = "I"
         list_e_gr WHEN Cct_stock.tipo_mov = "E"
         sal_granel
         */
         "Saldo Inicial" @ Cct_stock.observacion
         WITH FRAME frm-movimiento.

     DOWN WITH FRAME frm-movimiento.

     CASE modo_movs:

         WHEN C-TODOS   
             THEN DO:
                 OPEN QUERY qry_movimiento
                     FOR EACH Cct_stock OF Articulo
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha
                                AND Cct_stock.fecha <= has_fecha NO-LOCK,
                              FIRST Deposito OF Cct_stock
                                   WHERE Deposito.cdg_deposito >= des_coddep
                                     AND Deposito.cdg_deposito <= has_coddep NO-LOCK
                                         BY Cct_stock.fecha.
             END.

         WHEN C-PRESUP
             THEN DO:
                 OPEN QUERY qry_movimiento
                     FOR EACH Cct_stock OF Articulo
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha
                                AND Cct_stock.fecha <= has_fecha 
                                AND Cct_stock.presupuestado <> "" NO-LOCK,
                              FIRST Deposito OF Cct_stock
                                   WHERE Deposito.cdg_deposito >= des_coddep
                                     AND Deposito.cdg_deposito <= has_coddep NO-LOCK
                                         BY Cct_stock.fecha.
             END.

         WHEN C-REALES
             THEN DO:
                 OPEN QUERY qry_movimiento
                     FOR EACH Cct_stock OF Articulo
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha
                                AND Cct_stock.fecha <= has_fecha
                                AND Cct_stock.presupuestado = "" NO-LOCK,
                              FIRST Deposito OF Cct_stock
                                   WHERE Deposito.cdg_deposito >= des_coddep
                                     AND Deposito.cdg_deposito <= has_coddep NO-LOCK
                                         BY Cct_stock.fecha.
             END.

     END CASE.

     GET FIRST qry_movimiento NO-LOCK.
     DO WHILE AVAILABLE Cct_stock:

         IF Cct_stock.tipo_mov = "I"
         THEN DO:
              ASSIGN  tot_i_gr = tot_i_gr + Cct_stock.granel
                      tot_i_un = tot_i_un + Cct_stock.cantidad

                      list_i_gr = Cct_stock.granel
                      list_i_un = Cct_stock.cantidad

                      sal_cantidad = sal_cantidad + Cct_stock.cantidad
                      sal_granel = sal_granel + Cct_stock.granel.
         END.
         ELSE DO:
              ASSIGN  tot_e_gr = tot_e_gr + Cct_stock.granel
                      tot_e_un = tot_e_un + Cct_stock.cantidad

                      list_e_gr = Cct_stock.granel
                      list_e_un = Cct_stock.cantidad

                      sal_cantidad = sal_cantidad - Cct_stock.cantidad
                      sal_granel = sal_granel - Cct_stock.granel.
         END.

         DISPLAY
             Deposito.cdg_deposito
             Cct_stock.fecha
             Cct_stock.tip_comprob
             Cct_stock.prf_comprob
             Cct_stock.nro_comprob FORMAT "ZZZZZ9"
             Cct_stock.nro_linea FORMAT "ZZ9"
             Cct_stock.presupuestado
             list_i_un WHEN Cct_stock.tipo_mov = "I"
             list_e_un WHEN Cct_stock.tipo_mov = "E"
             sal_cantidad
             /*
             list_i_gr WHEN Cct_stock.tipo_mov = "I"
             list_e_gr WHEN Cct_stock.tipo_mov = "E"
             sal_granel
             */
             Cct_stock.observacion
             WITH FRAME frm-movimiento.

         DOWN WITH FRAME frm-movimiento.

         GET NEXT qry_movimiento.

     END. /* De los movimientos de una partida */

     UNDERLINE
             list_i_un
             list_e_un
             sal_cantidad
             /*
             list_i_gr
             list_e_gr
             sal_granel
             */
             WITH FRAME frm-movimiento.

     DISPLAY
             tot_i_un @ list_i_un
             tot_e_un @ list_e_un
             sal_cantidad
             /*
             tot_i_gr @ list_i_gr
             tot_e_gr @ list_e_gr
             sal_granel
             */
             WITH FRAME frm-movimiento.

      DOWN 1 WITH FRAME frm-movimiento.


     GET NEXT qry_Articulos.

  END. /* De los articulos */


  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).


END PROCEDURE.

