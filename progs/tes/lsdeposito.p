/*=================================================================================*/
/*       PRODUCE LA SALIDA IMPRESA CON EL DETALLE DE UNA BOLETA DE DEPOSITO        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_boleta  AS ROWID.

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE que_cuenta     LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE VARIABLE que_nombre     LIKE Cuenta_bancaria.denominacion_cta.
DEFINE VARIABLE tot_valors     AS INTEGER LABEL "Valores".
DEFINE VARIABLE tot_importes   LIKE Valor.importe LABEL "Importes".
DEFINE VARIABLE det_titulo     AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE det_titulo2    AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE titulo_f       AS CHARACTER FORMAT "X(45)".


DEFINE FRAME frm-titulo HEADER
  /*que_empresa */
  titulo_f AT 40
  "Página:" AT 87 PAGE-NUMBER FORMAT ">9" AT 94 SKIP
  fecha_lis               
  det_titulo AT 40
  hora_lis AT 87  
  det_titulo2 AT 40
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.
            
DEFINE FRAME frm-listado
  Valor.cdg_banco      COLUMN-LABEL "Código!Banco"
  Banco.nombre         COLUMN-LABEL "Razón!Social"
  Valor.numero_cheque  COLUMN-LABEL "Número!Cheque"
  Valor.estado         COLUMN-LABEL "Es-!tado"
  Valor.fecha_emision  COLUMN-LABEL "Fecha!Emisión" 
  Valor.fecha_acredita COLUMN-LABEL "Fecha!Acredita" 
  Valor.importe        COLUMN-LABEL "Importe!Cheque" 
  /*
  Cliente.cdg_cliente
  Cliente.nom_cliente FORMAT "X(25)"
  */
  WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

RUN LISTAR.
OUTPUT CLOSE.
RUN veresult.w ( INPUT arch_salida,
                 INPUT 22 ).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE LISTAR:

    {findempresa.i}
    que_empresa = Empresa.nombre.

    FIND Boleta_deposito_hd WHERE ROWID(Boleta_deposito_hd) = rid_boleta NO-LOCK.
    FIND Cuenta_bancaria OF Boleta_deposito_hd NO-LOCK.     

    det_titulo  = "Fecha:" +  STRING(Boleta_deposito_hd.fecha,"99/99/99") +
                  " Nro:" + STRING(Boleta_deposito_hd.nro_comprob,">>>>9") + 
                  " Ref:" + Boleta_deposito_hd.referencia.
    det_titulo2 = "Cuenta:" + Cuenta_bancaria.numero_cuenta + " - " + Cuenta_bancaria.denominacion_cta.
    titulo_f = "Valores Depositados en Cuenta Corriente".

    {dirprinfile.i &LIN-PAG=72}
     
    FOR EACH Boleta_deposito_dt OF Boleta_deposito_hd NO-LOCK,
        FIRST Valor OF Boleta_deposito_dt BY Valor.fecha_emision WITH FRAME frm-listado:
 
          VIEW FRAME frm-titulo.
            
/*        FIND Cliente OF Valor NO-LOCK NO-ERROR.*/
          FIND Banco   OF Valor NO-LOCK NO-ERROR.
 
          DISPLAY Valor.cdg_banco
                  Banco.nombre
                  Valor.numero_cheque
                  Valor.estado
                  Valor.fecha_emision
                  Valor.importe
                  /*
                  Cliente.cdg_cliente WHEN AVAILABLE Cliente
                  Cliente.nom_cliente WHEN AVAILABLE Cliente 
                  */
                  WITH FRAME frm-listado.
 
          DOWN WITH FRAME frm-listado.
          
          tot_importes = tot_importes + Valor.importe.
          tot_valors = tot_valors + 1.
 
    END.

    UNDERLINE Valor.cdg_banco
              Banco.nombre
              Valor.numero_cheque
              Valor.estado
              Valor.fecha_emision
              Valor.importe
              WITH FRAME frm-listado.
     
    DISPLAY   tot_valors   @ Valor.numero_cheque
              tot_importes @ Valor.importe 
              WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.
     
    DISPLAY   "Efvo."      @ Banco.nombre
              Boleta_deposito_hd.efectivo     @ Valor.importe 
              WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.
     
    DISPLAY   "Total"      @ Banco.nombre
              (Boleta_deposito_hd.efectivo + tot_importes ) @ Valor.importe 
              WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.
   
END PROCEDURE.   

{CODIMPRE.I}
 
