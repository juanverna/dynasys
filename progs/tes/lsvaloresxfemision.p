/*=================================================================================*/
/*                         VALORES x FECHA DE EMISION                               */
/*=================================================================================*/

&GLOBAL-DEFINE TITULO-LS    Valores por Fecha de Emision
&GLOBAL-DEFINE ORDEN-POR    Valor.cdg_rubro
&GLOBAL-DEFINE CORTE-POR    Valor.fecha_emision
&GLOBAL-DEFINE CAMPOS-LS    Valor.estado           ~
                            Valor.cdg_banco        ~
                            Valor.cdg_rubro        ~
                            Valor.numero_cheque    ~
                            Valor.cdg_caja         ~
                            Valor.fecha_recepcion  ~
                            Valor.fecha_deposito   ~
                            Valor.fecha_deposito   ~
                            Valor.dias_clearing    ~
                            Valor.importe 

&GLOBAL-DEFINE CORTE-FR     Valor.fecha_emision    COLUMN-LABEL "Fecha!Emisión"
&GLOBAL-DEFINE CAMPOS-FR    Valor.estado           COLUMN-LABEL "Es-!tado"       ~
                            Valor.cdg_banco        COLUMN-LABEL "Código!Banco"   ~
                            Valor.cdg_rubro        COLUMN-LABEL "Rubro!Caja"     ~
                            Valor.numero_cheque    COLUMN-LABEL "Número!Cheque"  ~
                            Valor.cdg_caja         COLUMN-LABEL "Ca-!ja"         ~
                            Valor.fecha_recepcion  COLUMN-LABEL "Fecha!Ingreso"  ~
                            Valor.fecha_salida     COLUMN-LABEL "Fecha!Egreso"   ~
                            Valor.fecha_deposito   COLUMN-LABEL "Fecha!Depósito" ~
                            Valor.dias_clearing    COLUMN-LABEL "Dí-!as"         ~
                            Valor.importe          COLUMN-LABEL "Importe!Cheque"

{lsvaloresxcampo.i}
