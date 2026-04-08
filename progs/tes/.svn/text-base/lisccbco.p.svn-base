/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_cuenta  AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE FORMAT "99/99/9999" .
DEFINE INPUT PARAMETER has_fecha   AS DATE FORMAT "99/99/9999" .

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE dtl_movim      AS   CHARACTER FORMAT "X(35)" LABEL "Referencia".
DEFINE VARIABLE fecha_lis      AS   DATE FORMAT "99/99/9999" .
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
       Cta_cte_bco.fecha_movimto   COLUMN-LABEL "Fecha!Movimto."
       Cta_cte_bco.fecha_efectiva  COLUMN-LABEL "Fecha!Efectiva"
       Cta_cte_bco.tip_comprob
       Cta_cte_bco.nro_comprob
       Cta_cte_bco.credito 
       Cta_cte_bco.debito 
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

OUTPUT TO VALUE(DIRE_TMP + "lisccbco.txt") PAGED PAGE-SIZE 72.
RUN LISTAR_MOVIMIENTOS.
OUTPUT CLOSE.

RUN veresult.w ( INPUT dire_tmp + "lisccbco.txt", INPUT 8).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE CALCULAR_SALDO:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Cta_cte_bco OF Cuenta_bancaria 
       WHERE Cta_cte_bco.fecha_movimto < des_fecha
         AND NOT Cta_cte_bco.anulado:

       tot_debitogr  = tot_debitogr + Cta_cte_bco.debito.
       tot_creditogr = tot_creditogr + Cta_cte_bco.credito.

   END.

END PROCEDURE.

PROCEDURE LISTAR_MOVIMIENTOS:

   titulo-f = "Movimientos de Cuenta Corriente".

   RUN CALCULAR_SALDO ( OUTPUT debitos, OUTPUT creditos ).
   saldo = creditos - debitos.

   FOR EACH Cta_cte_bco OF Cuenta_bancaria NO-LOCK
       WHERE Cta_cte_bco.fecha_movimto >= des_fecha 
         AND Cta_cte_bco.fecha_movimto <= has_fecha
         AND NOT Cta_cte_bco.anulado
          BREAK BY Cta_cte_bco.fecha_movimto 
                BY Cta_cte_bco.tip_comprob
                BY Cta_cte_bco.nro_comprob
                WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       IF FIRST(Cta_cte_bco.fecha_movimto)
       THEN DO:
          dtl_movim = "Saldo Inicial".
          DISPLAY 
             des_fecha - 1 @ Cta_cte_bco.fecha_movimto
             saldo
             dtl_movim
             WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
       END.             

       debitos = debitos + Cta_cte_bco.debito.
       creditos = creditos + Cta_cte_bco.credito.
       saldo = creditos - debitos.

       dtl_movim = "".
       FIND Valor OF Cta_cte_bco NO-LOCK NO-ERROR.
       IF AVAILABLE Valor 
       THEN DO:
            dtl_movim = STRING(Valor.cdg_banco,"999") + " - " + 
                        STRING(Valor.numero_cheque,"99999999").
            FIND Cliente OF Valor NO-LOCK NO-ERROR.
            IF AVAILABLE Cliente 
               THEN dtl_movim = dtl_movim + " " + Cliente.cdg_cliente.
       END.        
       ELSE DO:
            FIND Cheque OF Cta_cte_bco NO-LOCK NO-ERROR.
            IF AVAILABLE Cheque 
            THEN DO:
                 FIND Proveedor OF Cheque NO-LOCK NO-ERROR.
                 IF AVAILABLE Proveedor 
                    THEN dtl_movim = Proveedor.cdg_proveedor + "-" + Proveedor.nombre.
                    ELSE dtl_movim = Cheque.observacion.
            END.             
            ELSE DO:
                 dtl_movim = Cta_cte_bco.leyenda.
            END.             
       END.

       DISPLAY   
           Cta_cte_bco.fecha_movimto    
           Cta_cte_bco.fecha_efectiva   
           Cta_cte_bco.tip_comprob      WHEN FIRST-OF(Cta_cte_bco.nro_comprob)
           Cta_cte_bco.nro_comprob      WHEN FIRST-OF(Cta_cte_bco.nro_comprob)
           Cta_cte_bco.debito           WHEN Cta_cte_bco.debito <> 0
           Cta_cte_bco.credito          WHEN Cta_cte_bco.debito = 0
           saldo
           dtl_movim
           WITH FRAME frm-listado.
           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte_bco.tip_comprob
           Cta_cte_bco.nro_comprob
           Cta_cte_bco.fecha_movimto
           Cta_cte_bco.fecha_efectiva
           Cta_cte_bco.debito
           Cta_cte_bco.credito
           saldo
           dtl_movim
           WITH FRAME frm-listado.
           
   saldo = creditos - debitos.
   DISPLAY debitos  @ Cta_cte_bco.debito
           creditos @ Cta_cte_bco.credito
           saldo
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   UNDERLINE 
           Cta_cte_bco.tip_comprob
           Cta_cte_bco.nro_comprob
           Cta_cte_bco.fecha_movimto
           Cta_cte_bco.fecha_efectiva
           Cta_cte_bco.debito
           Cta_cte_bco.credito
           saldo
           dtl_movim
           WITH FRAME frm-listado.
   
END PROCEDURE.   

{CODIMPRE.I}
 
