/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_cuenta  AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha   AS DATE FORMAT "99/99/9999".

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE dtl_movim      AS   CHARACTER FORMAT "X(35)" LABEL "Referencia".
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_cuenta     LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE VARIABLE que_nombre     LIKE Cuenta_bancaria.denominacion_cta.


DEFINE FRAME frm-titulo HEADER
       que_empresa 
       titulo-f AT 40
       "Pagina:" AT 87 PAGE-NUMBER FORMAT ">9" AT 94 
       SKIP
       fecha_lis 
       que_cuenta  AT 40
       que_nombre
       hora_lis AT 87
       SKIP(1)
       WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Extracto.fecha_movimto   COLUMN-LABEL "Fecha!Movimto."
       Extracto.tip_comprob
       Extracto.nro_comprob
       Extracto.credito 
       Extracto.debito 
       saldo
       dtl_movim
       WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Cuenta_bancaria WHERE ROWID(Cuenta_bancaria) = rid_cuenta.

que_cuenta = Cuenta_bancaria.cdg_cuenta_ban.
que_nombre =  Cuenta_bancaria.denominacion_cta.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(DIRE_TMP + "lisexbco.txt") PAGED PAGE-SIZE 72.
RUN LISTAR_MOVIMIENTOS.
OUTPUT CLOSE.

RUN veresult.w ( INPUT dire_tmp + "lisexbco.txt", INPUT 8).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE CALCULAR_SALDO:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Extracto OF Cuenta_bancaria 
       WHERE Extracto.fecha_movimto < des_fecha:

       IF LOOKUP(Extracto.tip_comprob,str_debitan_bco) <> 0
       THEN DO:
            tot_debitogr  = tot_debitogr + Extracto.debito.
       END.     
       ELSE DO:
            tot_creditogr = tot_creditogr + Extracto.credito.
       END.     

   END.

END PROCEDURE.

PROCEDURE LISTAR_MOVIMIENTOS:

   titulo-f = "Extracto Bancario".

   RUN CALCULAR_SALDO ( OUTPUT debitos, OUTPUT creditos ).
   saldo = creditos - debitos.

   FOR EACH Extracto OF Cuenta_bancaria 
       WHERE Extracto.fecha_movimto >= des_fecha 
         AND Extracto.fecha_movimto <= has_fecha
          BREAK BY Extracto.fecha_movimto 
                BY Extracto.tip_comprob
                BY Extracto.nro_comprob
                WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       IF FIRST(Extracto.fecha_movimto)
       THEN DO:
          dtl_movim = "Saldo Inicial".
          DISPLAY 
             des_fecha - 1 @ Extracto.fecha_movimto
             saldo
             dtl_movim
             WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
       END.             

       IF LOOKUP(Extracto.tip_comprob,str_debitan_bco) <> 0
          THEN debitos = debitos + Extracto.debito.
          ELSE creditos = creditos + Extracto.credito.

       saldo = creditos - debitos.
       dtl_movim = Extracto.leyenda.
       DISPLAY   
           Extracto.fecha_movimto    WHEN FIRST-OF(Extracto.fecha_movimto)
           Extracto.tip_comprob      WHEN FIRST-OF(Extracto.nro_comprob)
           Extracto.nro_comprob      WHEN FIRST-OF(Extracto.nro_comprob)
           Extracto.debito  WHEN LOOKUP(Extracto.tip_comprob,str_debitan_bco) <> 0
           Extracto.credito WHEN LOOKUP(Extracto.tip_comprob,str_debitan_bco) = 0
           saldo
           dtl_movim
           WITH FRAME frm-listado.
           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Extracto.tip_comprob
           Extracto.nro_comprob
           Extracto.fecha_movimto
           Extracto.debito
           Extracto.credito
           saldo
           dtl_movim
           WITH FRAME frm-listado.
           
   saldo = creditos - debitos.
   DISPLAY debitos  @ Extracto.debito
           creditos @ Extracto.credito
           saldo
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   UNDERLINE 
           Extracto.tip_comprob
           Extracto.nro_comprob
           Extracto.fecha_movimto
           Extracto.debito
           Extracto.credito
           saldo
           dtl_movim
           WITH FRAME frm-listado.
   
END PROCEDURE.   

{CODIMPRE.I}
 
