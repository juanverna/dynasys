/*=================================================================================*/
/*                      ACUMULA UN MOVIMIENTO DE CAJA                              */
/*=================================================================================*/
/*siempre acumula sobre un registro no cerrado sino crea uno nuevo*/
DEFINE INPUT PARAMETER ope AS CHARACTER.
DEFINE INPUT PARAMETER act_caj_head        AS ROWID.
/*{VRSHARED.I}*/

FIND Caj_header WHERE ROWID(Caj_header) = act_caj_head.

FOR EACH Caj_detalle OF Caj_header:

    FIND Acumulado_caja 
         WHERE
               acumulado_caja.cdg_caja     = caj_header.cdg_caja
           AND Acumulado_caja.ano          = YEAR(Caj_header.fecha)
           AND Acumulado_caja.mes          = MONTH(Caj_header.fecha) 
           AND Acumulado_caja.cdg_rubro    = Caj_detalle.cdg_rubro
           AND NOT cerrado
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Acumulado_caja
    THEN DO:
       CREATE Acumulado_caja.
       ASSIGN Acumulado_caja.cdg_caja     = caj_header.cdg_caja
              Acumulado_caja.ano          = YEAR(Caj_header.fecha)
              Acumulado_caja.mes          = MONTH(Caj_header.fecha)
              Acumulado_caja.cdg_rubro    = Caj_detalle.cdg_rubro
              Acumulado_caja.fechaA       = NOW.
    END.

    IF ope = "A"
    THEN DO:
       IF Caj_detalle.tipo_mov = "E" 
          THEN Acumulado_caja.tot_egreso  = Acumulado_caja.tot_egreso + 
                                            Caj_detalle.importe.
          ELSE Acumulado_caja.tot_ingreso = Acumulado_caja.tot_ingreso + 
                                            Caj_detalle.importe.
    END.                            
    ELSE DO:                               
       IF Caj_detalle.tipo_mov = "E" 
          THEN Acumulado_caja.tot_egreso  = Acumulado_caja.tot_egreso - 
                                            Caj_detalle.importe.
          ELSE Acumulado_caja.tot_ingreso = Acumulado_caja.tot_ingreso - 
                                            Caj_detalle.importe.
    END.
    Acumulado_caja.fechaA       = NOW.

END.

FIND Acumulado_caja 
     WHERE
           acumulado_caja.cdg_caja     = caj_header.cdg_caja
       AND Acumulado_caja.ano          = YEAR(Caj_header.fecha)
       AND Acumulado_caja.mes          = MONTH(Caj_header.fecha) 
       AND Acumulado_caja.cdg_rubro    = 0
       AND NOT acumulado_caja.cerrado
           EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Acumulado_caja
THEN DO:
   CREATE Acumulado_caja.
   ASSIGN Acumulado_caja.cdg_caja     = Caj_header.cdg_caja
          Acumulado_caja.ano          = YEAR(Caj_header.fecha)
          Acumulado_caja.mes          = MONTH(Caj_header.fecha)
          Acumulado_caja.cdg_rubro    = 0
          Acumulado_caja.fechaA       = NOW.
   
END.

IF ope = "A"
THEN DO:
   IF Caj_header.tipo_mov = "E" 
      THEN Acumulado_caja.tot_egreso  = Acumulado_caja.tot_egreso + 
                                        Caj_header.importe.
      ELSE Acumulado_caja.tot_ingreso = Acumulado_caja.tot_ingreso + 
                                        Caj_header.importe.
END.                            
ELSE DO:                               
   IF Caj_header.tipo_mov = "E" 
      THEN Acumulado_caja.tot_egreso  = Acumulado_caja.tot_egreso - 
                                        Caj_header.importe.
      ELSE Acumulado_caja.tot_ingreso = Acumulado_caja.tot_ingreso - 
                                        Caj_header.importe.
END.
Acumulado_caja.fechaA       = NOW.
RELEASE Acumulado_caja.

   
