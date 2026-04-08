/*=================================================================================*/
/*                         VALORES x FECHA DE DEPOSITO                             */
/*=================================================================================*/

&GLOBAL-DEFINE TITULO-LS    Valores por Fecha de Depósito
&GLOBAL-DEFINE ORDEN-POR    Valor.cdg_rubro

&GLOBAL-DEFINE CORTE-POR    Valor.fecha_deposito

&GLOBAL-DEFINE CAMPOS-LS    Valor.estado           ~
                            Valor.cdg_banco        ~
                            Banco.abrevia WHEN AVAILABLE banco ~
                            Valor.cdg_rubro        ~
                            Valor.numero_cheque    ~
                            Valor.cdg_caja         ~
                            Valor.fecha_recepcion  ~
                            Valor.fecha_emision    ~
                            Valor.fecha_acredita   ~
                            Valor.dias_clearing    ~
                            Valor.importe        
                           

                             


&GLOBAL-DEFINE CORTE-FR     Valor.fecha_deposito   COLUMN-LABEL "Fecha!Depós"
&GLOBAL-DEFINE CAMPOS-FR    Valor.estado           COLUMN-LABEL "Es-!tado"       ~
                            Valor.cdg_banco        COLUMN-LABEL "Cód.!Banco"   ~
                            Banco.abrevia          COLUMN-LABEL "Banco"   ~
                            Valor.cdg_rubro        COLUMN-LABEL "Rubro!Caja"     ~
                            Valor.numero_cheque    COLUMN-LABEL "Número!Cheque"  ~
                            Valor.cdg_caja         COLUMN-LABEL "Código!Caja"    ~
                            Valor.fecha_recepcion  COLUMN-LABEL "Fecha!Ingr"  ~
                            Valor.fecha_emision    COLUMN-LABEL "Fecha!Emisión"  ~
                            Valor.dias_clearing    COLUMN-LABEL "D!C" FORMAT ">9"    ~
                            Valor.fecha_acredita   COLUMN-LABEL "Fecha!Acred" ~
                            Valor.importe          COLUMN-LABEL "Importe!Cheque" FORMAT ">>>>>9.99"
                            

                            
{lsvaloresxcampo.i}
