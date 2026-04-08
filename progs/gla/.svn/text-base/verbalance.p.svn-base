/*=================================================================================*/
/*    MUESTRA EL BALANCE GENERADO EN LA TABLA LST_SUMYSAL                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER  p-titulo_window  AS CHARACTER FORMAT "X(60)".

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}

/*{SHTSUMYS.I "NEW"}*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  p-titulo_window AT 52 
  "Pagina:" AT 166 PAGE-NUMBER FORMAT "ZZZ9" AT 173
  SKIP  
  fecha_lis   
  "del" AT 52
  p-des_fecha
  "al" 
  p-has_fecha 
  hora_lis AT 166
  SKIP(1)
  WITH WIDTH 195 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.


DEFINE FRAME frm-listado
  Lst_sumysal.que_codigo       
  Lst_sumysal.que_nombre       
  Lst_sumysal.saldo_per            FORMAT "->>>,>>>,>>>,>>9.99"
  Lst_sumysal.acm_debitos_per      FORMAT "->>>,>>>,>>>,>>9.99"
  Lst_sumysal.acm_creditos_per     FORMAT "->>>,>>>,>>>,>>9.99"
  Lst_sumysal.saldo_tot            FORMAT "->>>,>>>,>>>,>>9.99"
  Lst_sumysal.acm_debitos_tot      FORMAT "->>>,>>>,>>>,>>9.99"
  Lst_sumysal.acm_creditos_tot     FORMAT "->>>,>>>,>>>,>>9.99"
  WITH WIDTH 195 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX
       FRAME frm-listado FONT 2.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.

/*=================================================================================*/
/*           INVOCA LA REPRESENTACION VISUAL DEL BALANCE                           */
/*=================================================================================*/

{dirprinfile.i}

FOR EACH Lst_sumysal NO-LOCK:
    
    VIEW FRAME frm-titulo.

    IF Lst_sumysal.que_codigo = FILL("-",10) AND Lst_sumysal.que_nombre = FILL("-",35)
        THEN UNDERLINE Lst_sumysal.que_codigo        
                     Lst_sumysal.que_nombre        
                     Lst_sumysal.acm_debitos_per   
                     Lst_sumysal.acm_creditos_per  
                     Lst_sumysal.saldo_per         
                     Lst_sumysal.acm_creditos_tot  
                     Lst_sumysal.acm_debitos_tot   
                     Lst_sumysal.saldo_tot         
                     WITH FRAME frm-listado.
        ELSE DISPLAY Lst_sumysal.que_codigo        
                     Lst_sumysal.que_nombre        
                     Lst_sumysal.acm_debitos_per   
                     Lst_sumysal.acm_creditos_per  
                     Lst_sumysal.saldo_per         
                     Lst_sumysal.acm_creditos_tot  
                     Lst_sumysal.acm_debitos_tot   
                     Lst_sumysal.saldo_tot         
                     WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT (arch_salida),
                 INPUT 22 ).
