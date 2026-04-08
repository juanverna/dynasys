/*=================================================================================*/
/*                     LISTADO DE SALDOS ANALITICOS X COBRADOR                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_cobrador    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_cobrador    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER des_codigo      LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo      LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_nombre      LIKE Cliente.nom_cliente. 
DEFINE INPUT PARAMETER has_nombre      LIKE Cliente.nom_cliente. 
DEFINE INPUT PARAMETER ver_por         AS INTEGER.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.

/*=================================================================================*/
/*                                       VARIABLES                                 */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE QUERY qry_cliente               FOR Cliente.

DEFINE VARIABLE creditos               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Débitos".
DEFINE VARIABLE debitos                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Créditos".
DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".

DEFINE VARIABLE acum_debitos           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_creditos          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_saldo             AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE nom-vend               AS CHARACTER.
DEFINE VARIABLE hubo_cliente           AS LOGICAL.
DEFINE VARIABLE ver_cliente            AS LOGICAL.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa FORMAT "X(32)"
  "Documentos Pendientes por Cobrador" AT 35
  "Página:" AT 83 PAGE-NUMBER FORMAT ">>9" AT 91
  SKIP
  fecha_lis
  det_titulo AT 35 NO-LABEL
  hora_lis AT 83
  SKIP
  "Importes en" AT 35
  desc_moneda NO-LABEL
  SKIP(1)
  "---------------------------------------------------------------------------------------------" SKIP
  "Cliente Razón Social                                                                         " SKIP
  "   Identificación del      Fecha de    Fecha de         Importe        Importe        Importe" SKIP
  "      Comprobante          Emisión     Vencimiento      Débitos       Créditos          Saldo" SKIP
  "---------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
  Cliente.cdg_cliente
  SPACE(2)
  Cliente.nom_cliente FORMAT "X(35)"
  SPACE(3)
  nom-vend FORMAT "X(31)"
  SPACE(2)
  saldo 
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-titulo-mov HEADER
  que_empresa 
  "Cuentas Corrientes - Movimientos" AT 40
  "Pagina:" AT 122 PAGE-NUMBER FORMAT ">>9" AT 129
  SKIP  
  fecha_lis
  det_titulo AT 40 NO-LABEL
  hora_lis AT 122
  SKIP
  "Importes en" AT 40
  desc_moneda NO-LABEL
  SKIP(0.5)
  WITH WIDTH 140 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  SPACE(3)
  Cta_cte.tip_comprob
  Cta_cte.prf_comprob
  Cta_cte.nro_comprob FORMAT "ZZZZZ9"
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
  SPACE(1)
  Imputacion.abrevia
  SPACE(1)
  Cta_cte.fecha_emision
  SPACE(1)
  Cta_cte.fecha_vencimiento
  SPACE(2)
  Cta_cte.debito
  SPACE(2)
  Cta_cte.credito
  SPACE(2)
  saldo
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.
         
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

/*{SETIMPRE.I}*/

que_empresa = Empresa.nombre.

RUN getparametro.p (  INPUT  "DFMONEDA",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
act_moneda = ROWID(Moneda).

RUN LISTAR.


/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

    desc_moneda = Moneda.descripcion.

    {DIRPRINFILE.I}

    FOR EACH Cobrador WHERE Cobrador.cdg_cobrador <= has_cobrador
                        AND Cobrador.cdg_cobrador >= des_cobrador
                            BREAK BY Cobrador.cdg_cobrador:
      
        det_titulo = "Cobrador:" + Cobrador.cdg_cobrador + " - " +  Cobrador.nom_cobrador.
    
        {OPQRYCLICOB.I}
        
        acum_debitos = 0.
        acum_creditos = 0.
        acum_saldo = 0.
        GET FIRST qry_cliente.
        DO WHILE AVAILABLE Cliente:
           RUN PROCESAR_CLIENTE.
           GET NEXT qry_cliente.
        END.
      
      
        UNDERLINE Cta_cte.debito Cta_cte.credito saldo
                  WITH FRAME frm-listado-mov.
        DISPLAY 
          acum_debitos @ Cta_cte.debito
          acum_creditos @ Cta_cte.credito
          acum_saldo @ saldo
          WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.
      
        UNDERLINE Cta_cte.debito Cta_cte.credito saldo
                  WITH FRAME frm-listado-mov.
      
        DISPLAY " " @ Cliente.cdg_cliente WITH FRAME frm-listado-mov.
        
        IF NOT LAST(Cobrador.cdg_cobrador) THEN PAGE.
    
    END.
    
    OUTPUT CLOSE.
    
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CLIENTE.

       ASSIGN debitos   = 0
              creditos  = 0
              saldo     = 0.
        
       hubo_cliente = NO.

       VIEW FRAME frm-titulo-sdo.
                   
                       /* Recorremos los movimientos acumulando saldo */

       FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                     AND Cta_cte.credito <> Cta_cte.debito
                                     AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                                    EACH Imputacion OF Cta_cte BY fecha_emision:
     
            debitos = debitos + Cta_cte.debito.
            creditos = creditos + Cta_cte.credito.
            saldo = Cta_cte.debito - Cta_cte.credito.
     
            IF NOT hubo_cliente
            THEN DO:

                 FIND Vendedor OF Cliente.
                 nom-vend = "(" + STRING(Vendedor.cdg_vendedor)+ "  " + SUBSTRING(Vendedor.nombre,1,25) + ")".
                 DISPLAY Cliente.cdg_cliente
                         Cliente.nom_cliente
                         nom-vend
                         WITH FRAME frm-listado-sdo.
                 DOWN WITH FRAME frm-listado-sdo.
                 hubo_cliente = YES.  

            END.
            
            RUN LISTAR_MOVIMIENTO.
      
       END.

       IF hubo_cliente
       THEN DO:
            saldo = debitos - creditos.
            UNDERLINE saldo WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.
            DISPLAY saldo WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.

            acum_debitos = acum_debitos + debitos.
            acum_creditos = acum_creditos + creditos.
            acum_saldo = acum_saldo + (debitos - creditos).
       END.   

       acum_debitos = acum_debitos + debitos.
       acum_creditos = acum_creditos + creditos.
       acum_saldo = acum_saldo + saldo.
 
END PROCEDURE.

PROCEDURE LISTAR_MOVIMIENTO:

    DISPLAY Cta_cte.tip_comprob
            Cta_cte.prf_comprob
            Cta_cte.nro_comprob
            Imputacion.abrevia
            Cta_cte.nro_vencimiento
            Cta_cte.fecha_emision
            Cta_cte.fecha_vencimiento
            Cta_cte.debito
            Cta_cte.credito
            saldo
            WITH FRAME frm-listado-mov.
     
    DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE PONER_MONEDA:

END PROCEDURE.


PROCEDURE CALCULAR_SALDO:

   DEFINE INPUT  PARAMETER a_que_fecha   AS DATE.
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Cta_cte OF Cliente 
       WHERE Cta_cte.fecha_emision < a_que_fecha
         AND Cta_cte.nro_moneda = Moneda.nro_moneda
         AND Cta_cte.cdg_empresa = Empresa.cdg_empresa:

      IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
         THEN tot_debitogr  = tot_debitogr + Cta_cte.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte.credito.

   END.

END PROCEDURE.


