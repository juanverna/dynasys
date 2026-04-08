  FORM HEADER
  que_empresa
  "Sumas y Saldos Presupuestados" AT 52 
  "Pagina:" AT 122 PAGE-NUMBER FORMAT "ZZZ9" AT 129
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 122
  SKIP(1)
  "             Totales  del  periodo                       Totales  del  ejercicio" AT 44 SKIP
  "Codigo Descripcion" 
  "       Debitos       Creditos          Saldo        Debitos       Creditos          Saldo" AT 44 SKIP
  "------ -----------------------------------" 
  "-------------- -------------- -------------- -------------- -------------- --------------" AT 44 SKIP
  WITH FRAME frm-titulo
       WIDTH 136 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX USE-TEXT.
