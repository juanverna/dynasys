/*===========================================================================================*/
/*     GENERA UNA NOTA DE DEBITO EN CUENTA CORRIENTE DEL CLIENTE POR CHEQUE RECHAZADO        */
/*===========================================================================================*/

DEFINE INPUT PARAMETER que_cheque AS ROWID.

{VRSHARED.I}

DEFINE VARIABLE credebfc         AS LOGICAL.
DEFINE VARIABLE v-tip_comprob    LIKE Rec_header.tip_comprob.
DEFINE VARIABLE v-prx_comprob    LIKE Parametro.cdg_parametro.

/*===========================================================================================*/
/*                                    BLOQUE PRINCIPAL                                       */
/*===========================================================================================*/

FIND Valor WHERE ROWID(Valor) = que_cheque NO-LOCK.
FIND Cuenta_bancaria OF Valor NO-LOCK.

RUN GENERAR_DEBITO.
   
/*===========================================================================================*/
/*                                     PROCEDIMIENTOS                                        */
/*===========================================================================================*/

PROCEDURE GENERAR_DEBITO:

   DO TRANSACTION:

        CREATE Cta_cte_bco.
        ASSIGN Cta_cte_bco.tip_comprob     = "RCH"
               Cta_cte_bco.prf_comprob     = 0
               Cta_cte_bco.nro_comprob     = Valor.numero_cheque
               Cta_cte_bco.fecha_efectiva  = Valor.fecha_acredita
               Cta_cte_bco.fecha_movimto   = Valor.fecha_acredita
               Cta_cte_bco.credito         = 0
               Cta_cte_bco.debito          = Valor.importe
               Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
               Cta_cte_bco.nro_valor       = Valor.nro_valor.


        FIND Cliente OF Valor NO-LOCK NO-ERROR.
        FIND Banco   OF Valor NO-LOCK.

        IF AVAILABLE Cliente
        THEN DO:

                act_cliente = ROWID(Cliente).
                FIND FIRST Domicilio OF Cliente NO-LOCK.

                FIND Condicion_impos   OF Cliente NO-LOCK.
                act_condiva = ROWID(Condicion_impos).

                RUN getparametro.p (  INPUT  "CDGPESOS",
                                      OUTPUT v-valor_c,
                                      OUTPUT v-valor_d,
                                      OUTPUT v-valor_l,
                                      OUTPUT v-valor_n,
                                      OUTPUT v-observacion ).

                FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
                act_moneda = ROWID(Moneda).

                RUN getparametro.p (  INPUT  "DFCNCHRC",
                                      OUTPUT v-valor_c,
                                      OUTPUT v-valor_d,
                                      OUTPUT v-valor_l,
                                      OUTPUT v-valor_n,
                                      OUTPUT v-observacion ).

                FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
                FIND Cuenta OF Imputacion NO-LOCK.
                act_concepto = ROWID(Imputacion).
                act_cuenta = ROWID(Cuenta).
             
                RUN getparametro.p (  INPUT  "DFCNCONT",
                                      OUTPUT v-valor_c,
                                      OUTPUT v-valor_d,
                                      OUTPUT v-valor_l,
                                      OUTPUT v-valor_n,
                                      OUTPUT v-observacion ).

                FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = v-valor_c NO-LOCK.
                act_cndventa = ROWID(Condicion_venta).
             

                RUN getparametro.p (  INPUT  "CREDEBFC",
                                      OUTPUT v-valor_c,
                                      OUTPUT v-valor_d,
                                      OUTPUT v-valor_l,
                                      OUTPUT v-valor_n,
                                      OUTPUT v-observacion ).

                credebfc = v-valor_l.
             
                FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.

                CREATE Rec_header.
                ASSIGN Rec_header.nro_usuario      = Usuario.nro_usuario 
                       Rec_header.fecha            = Valor.fecha_acredita
                       Rec_header.cdg_empresa      = Valor.cdg_empresa 
                       Rec_header.tip_comprob      = "D" + Condicion_impos.tipo_factura 
                       Rec_header.prf_comprob      = pto_venta
                       Rec_header.nro_recibo       = NEXT-VALUE(proxima_transaccion) 
                       Rec_header.nro_moneda       = Moneda.nro_moneda 
                       Rec_header.cambio           = Moneda.cambio  
                       Rec_header.cdg_imputacion   = Imputacion.cdg_imputacion  
                       Rec_header.cdg_provincia    = Domicilio.cdg_provincia
                       Rec_header.origen           = "M"            
                       Rec_header.leyenda          = "Por rechazo CHEQUE:" + 
                                                     STRING(Valor.numero_cheque,"99999999") + 
                                                     " Banco:" + Banco.nombre
                       Rec_header.cdg_imputacion   = Imputacion.cdg_imputacion
                       Rec_header.tipo_pago        = 2
                       Rec_header.imp_neto         = Valor.importe
                       Rec_header.imp_bruto        = Rec_header.imp_neto
                       Rec_header.nro_cndventa     = Condicion_venta.nro_cndventa
                       Rec_header.nro_cliente      = Cliente.nro_cliente
                       Rec_header.cdg_condiva      = Cliente.cdg_condiva
                       Rec_header.nro_domicilio    = Domicilio.nro_domicilio
                       Rec_header.nombre           = Cliente.nom_cliente
                       Rec_header.direccion        = Domicilio.direccion
                       Rec_header.cdg_postal       = Domicilio.cdg_postal
                       Rec_header.localidad        = Domicilio.localidad
                       Rec_header.cuit             = Cliente.cuit.

                v-prx_comprob = "PDB" + 
                                 Condicion_impos.tipo_factura + 
                                 STRING(Rec_header.prf_comprob,"9999").
          
                FIND Parametro 
                     WHERE Parametro.cdg_parametro = v-prx_comprob 
                       AND Parametro.cdg_empresa   = Valor.cdg_empresa
                           EXCLUSIVE-LOCK NO-ERROR.
                IF NOT AVAILABLE Parametro
                THEN DO:
                     CREATE Parametro.
                     ASSIGN 
                            Parametro.cdg_parametro = v-prx_comprob
                            Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                            Parametro.observacion   = ""
                            Parametro.tipo          = "N"
                            Parametro.valor_n       = 1.
                END.        
               
                Rec_header.nro_comprob = Parametro.valor_n.
                Parametro.valor_n = Parametro.valor_n + 1.

                ASSIGN Cta_cte_bco.leyenda         = Rec_header.tip_comprob + " " +
                                                     STRING(Rec_header.prf_comprob,"9999") + " " +
                                                     STRING(Rec_header.nro_comprob,"99999999").

                Rec_header.estado = "E".
                act_rec_head =  ROWID(Rec_header).
          
                RUN EMIDBCHR.P.
                
                RELEASE Parametro. /* Liberamos el contador para emitir 
                                   desde otros puestos              */

        END.                   
        RUN TOCARSND.P ( INPUT "SOUND\COMIENZO.WAV").   

   END. /* De la transaccion */

END PROCEDURE.
