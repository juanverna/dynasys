DEFINE VARIABLE cantidad AS INTEGER.
DEFINE VARIABLE nro AS INTEGER.
DEFINE VARIABLE X AS INTEGER.
nro = 0.

cantidad = 10.

FOR EACH caj_header WHERE Caj_header.fecha       = 10/27/04
                       AND Caj_header.tip_comprob = "CJ"
                       AND Caj_header.prf_comprob = 0000
                       AND Caj_header.nro_comprob = 987:

FIND FIRST Valor OF caj_header NO-ERROR.
IF AVAILABLE Valor THEN
 MESSAGE "Ya existe un valor" VIEW-AS ALERT-BOX. 
        ELSE DO:
            DO X=1 TO cantidad:
            nro = nro + 1.
             CREATE Valor.
             ASSIGN 
                 Valor.cdg_banco            = 01.
                 Valor.cdg_caja             = Caj_header.cdg_caja.
                 Valor.cdg_empresa          = "F".
                 Valor.cdg_sucurbanco       = 0.
                 Valor.dias_clearing        = 2.
                 Valor.estado               = "00".
                 Valor.fecha_deposito       = Caj_header.fecha.
                 Valor.fecha_acredita       = Caj_header.fecha.
                 Valor.fecha_emision        = Caj_header.fecha.
                 Valor.fecha_recepcion      = Caj_header.fecha.
                 Valor.importe              = 1.
                 Valor.nro_cliente          = Caj_header.nro_cliente.
                 Valor.nro_cuenta           = Caj_header.nro_cuenta.
                 Valor.nro_proveedor        = Caj_header.nro_proveedor.
                 Valor.nro_transaccion      = Caj_header.nro_transaccion.
                 Valor.nro_valor            = NEXT-VALUE(proximo_valor).
                 Valor.numero_cheque        = nro.
                 Valor.num_sucursal         = "0000".
        
            UPDATE 
                Valor.cdg_empresa 
                Valor.cdg_banco 
                Valor.cdg_sucurbanco 
                Valor.numero_cheque 
                Valor.importe
                Valor.fecha_deposito 
                Valor.fecha_acredita
                Valor.fecha_emision
                WITH 1 COL.
          END.
         END.
END.

