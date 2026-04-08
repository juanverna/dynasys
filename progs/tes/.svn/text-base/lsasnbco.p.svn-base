/*=================================================================================*/
/*    LISTA ASIENTOS DE BANCO Y GENERA EL ASIENTO RESUMEN PARA CONTABILIDAD        */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        LIKE Cta_cte_bco.fecha_movimto.
DEFINE INPUT PARAMETER has_fecha        LIKE Cta_cte_bco.fecha_movimto.
DEFINE INPUT PARAMETER tipo_movm        AS CHARACTER.
DEFINE INPUT PARAMETER gen_asiento      AS LOGICAL.
DEFINE INPUT PARAMETER fecha_contable   LIKE Asn_header.fecha.

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i }

DEFINE VARIABLE que_asiento             AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE titulo_det              AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE chr_caja                AS CHARACTER.
DEFINE VARIABLE que_leyenda             AS CHARACTER.
DEFINE VARIABLE tgn_debitos_tot         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_tot        AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tgn_debitos_pen         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_pen        AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE lst_c_tot               AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_tot               AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Debitos".
DEFINE VARIABLE lst_c_pen               AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_pen               AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Debitos".

{WGLISTAR.I}

DEFINE BUFFER B-Cuenta FOR Cuenta.

DEFINE WORK-TABLE Acumulado
   FIELD nro_cuenta_deposito   LIKE Cuenta.nro_cuenta
   FIELD codigo_dbcr  AS INTEGER
   FIELD debitos      AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD creditos     AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD debitos_pen  AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD creditos_pen AS DECIMAL FORMAT "->,>>>,>>9.99".
   
DEFINE FRAME frm-titulo-res HEADER
  que_empresa
  "Asiento Resumen de Banco:" AT 39 
  que_asiento
  "Pagina:" AT 92 PAGE-NUMBER FORMAT ">9" AT 99
  SKIP  
  fecha_lis   
  titulo_det AT 39
  hora_lis AT 92
  SKIP
  "Fecha Contable:" AT 39
  fecha_contable
  " Gen.:" gen_asiento
  SKIP(1)
  "----------------------------------------------------------------------------------------------------" SKIP
  "                                                         Totales                    Pendiente       " SKIP
  "  Imputación contable                              Débitos      Créditos       Débitos      Créditos" SKIP
  "----------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo-res TOP-ONLY PAGE-TOP STREAM-IO.
  
DEFINE FRAME frm-movimiento-res
  Cuenta.cdg_cuenta
  Cuenta.nombre
  lst_d_tot
  lst_c_tot
  lst_d_pen
  lst_c_pen
  WITH WIDTH 132 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

   titulo_det = "Movimientos del " + STRING(des_fecha) + " al " + STRING(has_fecha).
   
   {dirprinfile.i &LIN-PAG=40}
 
   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.

   FIND FIRST Acumulado NO-ERROR.
   IF AVAILABLE Acumulado
   THEN DO:
      FOR EACH Acumulado:
          DELETE Acumulado.
      END.    
   END.

   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.
   tgn_debitos_pen = 0.
   tgn_creditos_pen = 0.

   FOR EACH  Cta_cte_bco
       WHERE Cta_cte_bco.fecha_movimto >= des_fecha 
         AND Cta_cte_bco.fecha_movimto <= has_fecha
         AND Cta_cte_bco.nro_cuenta <> 0 EXCLUSIVE-LOCK,
             FIRST Cuenta_bancaria OF Cta_cte_bco WHERE Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa NO-LOCK
             BREAK BY Cta_cte_bco.fecha_movimto WITH FRAME frm-listado:
         
       RUN ACUMULAR_MOVIMIENTO.
            
   END. /* De los movimientos de caja */

   /* Listamos los acumulados y gneramos el asiento */

   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.
   tgn_debitos_pen = 0.
   tgn_creditos_pen = 0.
   
   FOR EACH Acumulado:

       IF Acumulado.debitos > Acumulado.creditos
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos = Acumulado.debitos - Acumulado.creditos
                 Acumulado.creditos = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos = Acumulado.creditos - Acumulado.debitos
                 Acumulado.debitos = 0.
       END.

       IF Acumulado.debitos_pen > Acumulado.creditos_pen
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos_pen = Acumulado.debitos_pen - Acumulado.creditos_pen
                 Acumulado.creditos_pen = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos_pen = Acumulado.creditos_pen - Acumulado.debitos_pen
                 Acumulado.debitos_pen = 0.
       END.


       tgn_debitos_tot   = tgn_debitos_tot + Acumulado.debitos.
       tgn_creditos_tot  = tgn_creditos_tot  + Acumulado.creditos.

       tgn_debitos_pen   = tgn_debitos_pen   + Acumulado.debitos_pen.
       tgn_creditos_pen  = tgn_creditos_pen  + Acumulado.creditos_pen.

   END.

   CLEAR FRAME frm-movimiento-res ALL NO-PAUSE.
   
   IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
   THEN DO:       
      que_leyenda = "Resumen " + titulo_det.
      RUN CREASNHD.P ( INPUT fecha_contable, INPUT que_leyenda, INPUT "A" ).
      FIND Asn_header WHERE ROWID(Asn_header) = act_asn_head EXCLUSIVE-LOCK.
      que_asiento = Asn_header.tip_comprob + " " + STRING(Asn_header.nro_comprob,"999999").
   END.   
   ELSE DO:
      que_asiento = "No Generado".
   END.   

   FOR EACH Acumulado , Cuenta OF Acumulado BY Acumulado.codigo_dbcr:

       lst_d_tot = Acumulado.debitos.
       lst_c_tot = Acumulado.creditos.
       lst_d_pen = Acumulado.debitos_pen.
       lst_c_pen = Acumulado.creditos_pen.
              
       VIEW FRAME frm-titulo-res.
       DISPLAY
             Cuenta.cdg_cuenta
             Cuenta.nombre
             lst_d_tot  WHEN lst_d_tot <> 0
             lst_c_tot  WHEN lst_c_tot <> 0
             lst_d_pen  WHEN lst_d_pen <> 0
             lst_c_pen  WHEN lst_c_pen <> 0

             WITH FRAME frm-movimiento-res.
       DOWN WITH FRAME frm-movimiento-res.

       IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
          THEN IF Acumulado.codigo_dbcr = 1 
                  THEN RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                        INPUT entidad_logon,
                                        INPUT 0 /*Obra.nro_obra*/,
                                        INPUT lst_d_pen, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0,                                         
                                        INPUT que_leyenda ).
                  ELSE RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                        INPUT entidad_logon,
                                        INPUT 0 /*Obra.nro_obra*/,
                                        INPUT 0, 
                                        INPUT lst_c_pen, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0,                                         
                                        INPUT que_leyenda ).

   END.

   UNDERLINE lst_d_tot 
                lst_c_tot 
                lst_d_pen 
                lst_c_pen 
                WITH FRAME frm-movimiento-res.
   DISPLAY tgn_debitos_tot   @ lst_d_tot
           tgn_creditos_tot  @ lst_c_tot
           tgn_debitos_pen   @ lst_d_pen
           tgn_creditos_pen  @ lst_c_pen
           WITH FRAME frm-movimiento-res.


   IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
   THEN DO:       
      RUN EMIASIEN.P.
   END.   

   OUTPUT CLOSE.
   RUN veresult.w ( INPUT arch_salida,
                    INPUT 22 ).
     
END PROCEDURE.  

PROCEDURE ACUMULAR_MOVIMIENTO:

          /* Acumulamos el movimiento en si */

   FIND FIRST Acumulado 
        WHERE Acumulado.nro_cuenta_deposito = Cta_cte_bco.nro_cuenta NO-ERROR.
   IF NOT AVAILABLE Acumulado
   THEN DO:
      CREATE Acumulado.
      ASSIGN Acumulado.nro_cuenta_deposito = Cta_cte_bco.nro_cuenta.
   END.

   IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
      THEN Acumulado.debitos  = Acumulado.debitos  + Cta_cte_bco.debito.
      ELSE Acumulado.creditos = Acumulado.creditos + Cta_cte_bco.credito.

   IF NOT Cta_cte_bco.contable 
   THEN DO:

      IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
         THEN Acumulado.debitos_pen  = Acumulado.debitos_pen  + Cta_cte_bco.debito.
         ELSE Acumulado.creditos_pen = Acumulado.creditos_pen + Cta_cte_bco.credito.

   END.
        /* Acumulamos el total para esta cuenta bancaria */
 
   FIND FIRST Acumulado 
        WHERE Acumulado.nro_cuenta_deposito = Cuenta_bancaria.nro_cuenta_deposito NO-ERROR.
   IF NOT AVAILABLE Acumulado
   THEN DO:
      CREATE Acumulado.
      ASSIGN Acumulado.nro_cuenta_deposito = Cuenta_bancaria.nro_cuenta_deposito.
   END.

   IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
      THEN Acumulado.creditos = Acumulado.creditos  + Cta_cte_bco.debito.
      ELSE Acumulado.debitos  = Acumulado.debitos   + Cta_cte_bco.credito.

   IF NOT Cta_cte_bco.contable 
   THEN DO:

      IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
         THEN Acumulado.creditos_pen  = Acumulado.creditos_pen + Cta_cte_bco.debito.
         ELSE Acumulado.debitos_pen   = Acumulado.debitos_pen  + Cta_cte_bco.credito.

   END.   
 
       
END PROCEDURE.
