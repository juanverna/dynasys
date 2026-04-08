/*
FOR EACH caj_header WHERE NOT CAN-FIND(FIRST Caja-imputacion WHERE Caja-imputacion.nro_transaccion = 
                       Caj_header.nro_transaccion) AND tip_comprob BEGINS "R":
  
  FIND FIRST Caja-imputacion WHERE Caja-imputacion.nro_transaccion = 
                       Caj_header.nro_transaccion.
  

  DISPLAY cdg_empresa tip_comprob prf_comprob nro_comprob caj_header.fecha
      Caja-imputacion.nro_cuenta
      WITH STREAM-IO.
  
END.
*/

FOR EACH caj_header NO-LOCK
    WHERE tip_comprob = "DP" AND cambio = 0:
     
    FIND FIRST Caja-imputacion WHERE Caja-imputacion.nro_transaccion = 
                       Caj_header.nro_transaccion.

    DISPLAY caj_header.fecha Caj_header.importe caja-imputacion.valor caj_header.cdg_empresa caj_header.nro_comprob
        caj_header.cambio
        WITH STREAM-IO.
    /*

  FIND caja OF caj_header.
  CREATE Caja-imputacion.
  ASSIGN Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion
         Caja-imputacion.nro_cuenta = 10625
         Caja-imputacion.valor = Caj_header.importe
         caja-imputacion.nro_entidad = caja.nro_entidad.
      */
  
END.

