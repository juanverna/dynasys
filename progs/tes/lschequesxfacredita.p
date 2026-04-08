/*=================================================================================*/
/*                         CHEQUES x FECHA DE ACREDITACION                         */
/*=================================================================================*/

&GLOBAL-DEFINE TITULO-LS    Cheques por Fecha de Acreditacion
&GLOBAL-DEFINE CORTE-POR    Cheque.fecha_acredita
&GLOBAL-DEFINE CAMPOS-LS    Cheque.estado           ~
                            Cuenta_bancaria.cdg_cuenta_ban        ~
                            Cheque.numero_cheque    ~
                            Cheque.cdg_caja         ~
                            Cheque.fecha_deposito  ~
                            Cheque.fecha_emision    ~
                            Cheque.fecha_salida   ~
                            Cheque.dias_clearing    ~
                            Cheque.importe 

&GLOBAL-DEFINE CORTE-FR     Cheque.fecha_acredita   COLUMN-LABEL "Fecha!Acredita"
&GLOBAL-DEFINE CAMPOS-FR    Cheque.estado           COLUMN-LABEL "Es-!tado"       ~
                            Cuenta_bancaria.cdg_cuenta_ban        COLUMN-LABEL "Código!Cuenta"   ~
                            Cheque.numero_cheque    COLUMN-LABEL "Número!Cheque"  ~
                            Cheque.cdg_caja         COLUMN-LABEL "Código!Caja"    ~
                            Cheque.fecha_deposito   COLUMN-LABEL "Fecha!Depósito"  ~
                            Cheque.fecha_emision    COLUMN-LABEL "Fecha!Emisión"  ~
                            Cheque.dias_clearing    COLUMN-LABEL "Días!Clear."    ~
                            Cheque.fecha_salida     COLUMN-LABEL "Fecha!Salida" ~
                            Cheque.importe          COLUMN-LABEL "Importe!Cheque"

{lschequesxcampo.i}
