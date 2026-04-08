/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_articulo AS ROWID.
DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.
DEFINE INPUT PARAMETER ficha         AS INTEGER.

{VRSHARED.I }

DEFINE VARIABLE tod            AS   INTEGER INITIAL 0.
DEFINE VARIABLE dep            AS   INTEGER INITIAL 1.
DEFINE VARIABLE par            AS   INTEGER INITIAL 2.
DEFINE VARIABLE ing_cantidad   LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad   LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE ing_granel     LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel     LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE ry             AS   CHARACTER FORMAT "X(131)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE list_i_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE list_e_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_i_un       LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_e_un       LIKE Cct_stock.cantidad.

DEFINE VARIABLE list_i_gr      LIKE Cct_stock.granel.
DEFINE VARIABLE list_e_gr      LIKE Cct_stock.granel.
DEFINE VARIABLE tot_i_gr       LIKE Cct_stock.granel.
DEFINE VARIABLE tot_e_gr       LIKE Cct_stock.granel.


DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_articulo   LIKE Articulo.cdg_articulo.
DEFINE VARIABLE que_nombre     LIKE Articulo.descripcion.
DEFINE VARIABLE que_archivo    AS CHARACTER.

DEFINE VARIABLE hubo_inicio    AS LOGICAL INITIAL NO.

DEFINE BUFFER B-Partida FOR Partida.
DEFINE QUERY qry_movimiento   FOR Cct_stock, B-Partida.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 38
       "Pagina:" AT  102 PAGE-NUMBER FORMAT ">9" AT 110 
       SKIP
       fecha_lis 
       titulo-2 AT 38 
       hora_lis AT 102
       SKIP(1)
       que_articulo  AT 38
       que_nombre
       SKIP(1)                                                                  
       "--------------------------------------------------------------------------------------------------------------------" SKIP
       "                                                             Unidades                            A Granel           " SKIP
       " Partida Dep Fecha    Id. Documento     #       Ingreso        Egreso         Saldo    Ingreso     Egreso      Saldo" SKIP
       "--------------------------------------------------------------------------------------------------------------------" SKIP
       WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
  
DEFINE FRAME frm-listado
       B-Partida.cdg_partida
       Deposito.cdg_deposito
       Cct_stock.fecha 
       Cct_stock.tip_comprob
       Cct_stock.prf_comprob
       Cct_stock.nro_comprob FORMAT "ZZZZZ9"
       Cct_stock.nro_linea FORMAT "ZZ9"
       list_i_un
       list_e_un
       sal_cantidad
       list_i_gr
       list_e_gr         
       sal_granel
       WITH WIDTH 131 FRAME frm-listado PAGE-TOP USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

DEFINE FRAME frm-raya
       ry
       SKIP
       WITH WIDTH 131 FRAME frm-raya USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.


/*=================================================================================*/
/*                        B L O Q U E   P R I N C I P A L                          */
/*=================================================================================*/


{findempresa.i}
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Articulo WHERE ROWID(Articulo) = rid_articulo.
IF ficha = dep THEN FIND Deposito WHERE ROWID(Deposito) = act_deposito NO-LOCK.
IF ficha = par THEN FIND Partida WHERE ROWID(Partida) = act_partida NO-LOCK.

que_articulo = Articulo.cdg_articulo.
que_nombre =  Articulo.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").
titulo-f = "Detalle de movimientos por articulo".
titulo-2 =  STRING(des_fecha) + "-" + STRING(has_fecha) + " - ".
CASE ficha:
       WHEN tod THEN titulo-2 =  titulo-2 + "Todos".
       WHEN dep THEN titulo-2 =  titulo-2 + "Por deposito".     
       WHEN par THEN titulo-2 =  titulo-2 + "Por partida".     
END CASE.

ry = "---------------------------------------------------------------------------------------------------------------".

que_archivo = dire_tmp + "lisccart.txt".
OUTPUT TO VALUE(que_archivo) PAGED.

RUN PONE_CODIGO ( INPUT "CARTA,SET17CPI").

hubo_inicio = NO.

tot_i_un = 0.
tot_e_un = 0.
tot_i_gr = 0.
tot_e_gr = 0.

RUN ABRE_INICIAL.

GET FIRST qry_movimiento NO-LOCK.
DO WHILE AVAILABLE Cct_stock:

   IF Cct_stock.tipo_mov = "I"
   THEN DO:
      tot_i_gr = tot_i_gr + Cct_stock.granel.
      list_i_gr = Cct_stock.granel.      
      tot_i_un = tot_i_un + Cct_stock.cantidad.
      list_i_un = Cct_stock.cantidad.      
   END.
   ELSE DO:
      tot_e_gr = tot_e_gr + Cct_stock.granel.
      list_e_gr = Cct_stock.granel.      
      tot_e_un = tot_e_un + Cct_stock.cantidad.
      list_e_un = Cct_stock.cantidad.      
   END.
   
   GET NEXT qry_movimiento.    

END.

ASSIGN   
   sal_cantidad = tot_i_un - tot_e_un
   sal_granel = tot_i_gr - tot_e_gr.

RUN ABRE_QUERY.

GET FIRST qry_movimiento NO-LOCK.
DO WHILE AVAILABLE Cct_stock:

   VIEW FRAME frm-titulo.

   IF NOT hubo_inicio
   THEN DO:
        DISPLAY
                 ( des_fecha - 1 ) @ Cct_stock.fecha 
                 "Si" @ Cct_stock.tip_comprob
                 sal_cantidad @ list_i_un
                 sal_cantidad
                 sal_granel   @ list_i_gr
                 sal_granel
                 WITH FRAME frm-listado.       
       
        DOWN WITH FRAME frm-listado.
        hubo_inicio = YES.
   END.

   IF Cct_stock.tipo_mov = "I"
   THEN DO:
      tot_i_gr = tot_i_gr + Cct_stock.granel.
      list_i_gr = Cct_stock.granel.      
      tot_i_un = tot_i_un + Cct_stock.cantidad.
      list_i_un = Cct_stock.cantidad.      
   END.
   ELSE DO:
      tot_e_gr = tot_e_gr + Cct_stock.granel.
      list_e_gr = Cct_stock.granel.      
      tot_e_un = tot_e_un + Cct_stock.cantidad.
      list_e_un = Cct_stock.cantidad.      
   END.
   
   sal_cantidad = tot_i_un - tot_e_un.
   sal_granel = tot_i_gr - tot_e_gr.

   DISPLAY
       B-Partida.cdg_partida
       Deposito.cdg_deposito
       Cct_stock.fecha 
       Cct_stock.tip_comprob
       Cct_stock.prf_comprob
       Cct_stock.nro_comprob FORMAT "ZZZZZ9"
       Cct_stock.nro_linea FORMAT "ZZ9"
       list_i_un WHEN Cct_stock.tipo_mov = "I"
       list_e_un WHEN Cct_stock.tipo_mov = "E"
       sal_cantidad
       list_i_gr WHEN Cct_stock.tipo_mov = "I"
       list_e_gr WHEN Cct_stock.tipo_mov = "E"
       sal_granel
       WITH FRAME frm-listado.       
       
   DOWN WITH FRAME frm-listado.    

   GET NEXT qry_movimiento.    

END.     

/*
   UNDERLINE
       B-Partida.cdg_partida
       Deposito.cdg_deposito
       Cct_stock.fecha 
       Cct_stock.tip_comprob
       Cct_stock.nro_comprob
       Cct_stock.nro_linea
       list_i_un
       list_e_un
       sal_cantidad
       list_i_gr
       list_e_gr
       sal_granel
       WITH FRAME frm-listado.       
*/
   DISPLAY ry WITH FRAME frm-raya.
   DOWN WITH frame frm-listado.       
   DISPLAY
       tot_i_un @ list_i_un
       tot_e_un @ list_e_un
       sal_cantidad
       tot_i_gr @ list_i_gr
       tot_e_gr @ list_e_gr
       sal_granel
       WITH FRAME frm-listado.     
   DOWN WITH FRAME frm-listado.             
   DISPLAY ry WITH FRAME frm-raya.
/*
   UNDERLINE
       B-Partida.cdg_partida
       Deposito.cdg_deposito
       Cct_stock.fecha 
       Cct_stock.tip_comprob
       Cct_stock.nro_comprob
       Cct_stock.nro_linea
       list_i_un
       list_e_un
       sal_cantidad
       list_i_gr
       list_e_gr
       sal_granel
       WITH FRAME frm-listado.                     
*/

   DOWN WITH FRAME frm-listado.    


OUTPUT CLOSE.

RUN veresult.w ( INPUT que_archivo, INPUT 9 ).

/*================================================================================*/

PROCEDURE ABRE_QUERY:

    CASE ficha:

       WHEN tod THEN  

                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha 
                                AND Cct_stock.fecha <= has_fecha,
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha BY B-Partida.cdg_partida . 

       WHEN dep THEN     
                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha 
                                AND Cct_stock.fecha <= has_fecha
                                AND Cct_stock.nro_deposito = Deposito.nro_deposito,
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha BY B-Partida.cdg_partida . 

       WHEN par THEN     
                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha >= des_fecha 
                                AND Cct_stock.fecha <= has_fecha
                                AND Cct_stock.nro_partida = Partida.nro_partida,
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha. 


  END CASE.

END PROCEDURE.

PROCEDURE ABRE_INICIAL:

    CASE ficha:

       WHEN tod THEN  

                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha < des_fecha, 
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha BY B-Partida.cdg_partida . 



       WHEN dep THEN     
                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha < des_fecha 
                                AND Cct_stock.nro_deposito = Deposito.nro_deposito,
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha BY B-Partida.cdg_partida . 

       WHEN par THEN     
                         OPEN QUERY qry_movimiento       
                           FOR EACH Cct_stock OF Articulo 
                              WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                                AND Cct_stock.fecha < des_fecha 
                                AND Cct_stock.nro_partida = Partida.nro_partida,
                               EACH B-Partida OF Cct_stock
                                 BY Cct_stock.fecha. 


  END CASE.

END PROCEDURE.

{CODIMPRE.I}
