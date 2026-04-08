/*=================================================================================*/
/*                      EMISION DE UN MOVIMIENTO DE CAJA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_movimiento AS ROWID.

{VPERSINM.I}
{VRSHARED.I}

FIND Caj_header  WHERE ROWID(Caj_header) = que_movimiento.

              /* Generacion de movimientos bancarios */

FOR EACH Caj_detalle OF Caj_header: 

       FIND Rubro OF Caj_detalle NO-LOCK NO-ERROR. 
       
       IF AVAILABLE Rubro 
       THEN DO:
            CASE Rubro.tipo:
     
                 WHEN "A" 
                 THEN DO:
     
                      CREATE Cta_cte_bco.
                      ASSIGN Cta_cte_bco.tip_comprob     = Caj_header.tip_comprob
                             Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                             Cta_cte_bco.nro_comprob     = Caj_header.nro_comprob
                             Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                             Cta_cte_bco.fecha_efectiva  = Caj_header.fecha
                             Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                             Cta_cte_bco.credito         = Caj_detalle.importe
                             Cta_cte_bco.debito          = 0
                             Cta_cte_bco.cdg_cuenta_ban  = Caj_detalle.cdg_cuenta_ban
                             Cta_cte_bco.nro_cuenta      = 0
                             Cta_cte_bco.leyenda         = Caj_detalle.observacion.
     
     
                 END.
     
                 WHEN "B" 
                 THEN DO:
     
                      CREATE Cta_cte_bco.
                      ASSIGN Cta_cte_bco.tip_comprob     = Caj_header.tip_comprob
                             Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                             Cta_cte_bco.nro_comprob     = Caj_header.nro_comprob
                             Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                             Cta_cte_bco.fecha_efectiva  = Caj_header.fecha
                             Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                             Cta_cte_bco.credito         = 0
                             Cta_cte_bco.debito          = Caj_detalle.importe
                             Cta_cte_bco.cdg_cuenta_ban  = Caj_detalle.cdg_cuenta_ban
                             Cta_cte_bco.nro_cuenta      = 0
                             Cta_cte_bco.leyenda         = Caj_detalle.observacion.
     
                 END.
     
                WHEN "P" 
                THEN DO:
        
                     FIND Cheque OF Caj_detalle NO-LOCK NO-ERROR.
                     IF AVAILABLE Cheque
                     THEN DO:
                           FIND Cuenta_bancaria OF Cheque NO-LOCK.
                           IF NOT Cuenta_bancaria.ficticia
                           THEN DO:
              
                                CREATE Cta_cte_bco.
                                ASSIGN Cta_cte_bco.tip_comprob     = "CH"
                                       Cta_cte_bco.prf_comprob     = Caj_header.prf_comprob
                                       Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
                                       Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                                       Cta_cte_bco.fecha_efectiva  = Cheque.fecha_deposito
                                       Cta_cte_bco.fecha_movimto   = Caj_header.fecha
                                       Cta_cte_bco.credito         = 0
                                       Cta_cte_bco.debito          = Caj_detalle.importe
                                       Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
                                       Cta_cte_bco.nro_cheque      = Cheque.nro_cheque
                                       Cta_cte_bco.leyenda         = Cheque.observacion.
                           END.            
                     END.            
       
                END.
        
                WHEN "V" 
                THEN DO:
        
                     FIND Valor OF Caj_detalle NO-LOCK NO-ERROR.
                     IF AVAILABLE Valor
                     THEN DO:
                           IF Valor.estado = "**"
                           THEN DO:
                                FIND CURRENT Valor EXCLUSIVE-LOCK.
                                Valor.estado = "00".
                                RELEASE Valor.
                           END.    
                     END. 
                END.
     
            END CASE.    
       END.    
       ELSE DO:
            MESSAGE "Rubro " STRING(Caj_detalle.cdg_rubro) " NO EXISTE" VIEW-AS ALERT-BOX.
       END.            
END.

