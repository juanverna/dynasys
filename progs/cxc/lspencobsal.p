/*=================================================================================*/
/*                    VENCIMIENTOS PENDIENTES POR COBRADOR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-consolidado AS LOGICAL.
DEFINE INPUT PARAMETER des_codigo    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_codigo    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER des_fecha     AS DATE.
DEFINE INPUT PARAMETER has_fecha     AS DATE.
DEFINE INPUT PARAMETER que_moneda    LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-estado_cliente AS INTEGER.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE tot_vendr            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_saldo            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE t-credito            AS DECIMAL.
DEFINE VARIABLE t-debito             AS DECIMAL.

DEFINE VARIABLE hubo                 AS LOGICAL.
DEFINE VARIABLE v-estado             AS CHARACTER.
DEFINE VARIABLE ultimo               AS LOGICAL.
DEFINE VARIABLE tit_cobrador         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda          LIKE Moneda.descripcion.
DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{WGLISTAR.I}
{findsector.i}
que_sector = Area.cdg_area.
/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Saldos Pendientes por Cobrador" AT 44
  "Página:" AT 105 PAGE-NUMBER FORMAT ">>9" AT 114
  SKIP  
  fecha_lis
  "del" AT 44
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 107
  SKIP (1) 
  tit_cobrador AT 44
  SKIP(1)
  "--------------------------------------------------------------------------------------------------------------------" SKIP
  "Código   Razón                                   Dirección                            Localidad       Número de     " SKIP
  "Cliente  Social                                  de cobranza                          de cobranza     Teléfono      " SKIP
  "--------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 240 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente AT 02
  Cliente.nom_cliente
  Domicilio.direccion FORMAT "X(35)"
  Domicilio.localidad FORMAT "X(15)"
  Domicilio.telefono  FORMAT "X(15)"
  SKIP(1)
  Rec_header.cdg_empresa 
  Rec_header.fecha
  Rec_header.tip_comprob 
  Rec_header.prf_comprob 
  Rec_header.nro_comprob    
  Rec_header.imp_total
  WITH WIDTH 240 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-mov
  SPACE(17)
  Cta_cte.cdg_empresa FORMAT "X(3)"
  Cta_cte.tip_comprob
  Cta_cte.prf_comprob
  Cta_cte.nro_comprob 
  Cta_cte.nro_vencimiento
  Imputacion.abrevia
  Cta_cte.fecha_emision
  Cta_cte.fecha_vencimiento
  Cta_cte.debito
  Cta_cte.credito
  saldo
  WITH WIDTH 240 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = "en " + Moneda.descripcion.
  IF v-consolidado THEN desc_moneda = desc_moneda + "- Consolidados".

  que_empresa = Empresa.nombre.

  {dirprinfile.i &LIN-PAG=100} 

  OPEN QUERY qry_cobrador 
       FOR EACH Cobrador NO-LOCK WHERE Cobrador.cdg_cobrador >= des_codigo
            AND Cobrador.cdg_cobrador <= has_codigo
             BY Cobrador.cdg_cobrador.
  
  GET FIRST qry_cobrador.
  DO WHILE AVAILABLE Cobrador:
     RUN LISTAR.
     GET NEXT qry_cobrador.
  END.   

  DISPLAY "=============" @ saldo WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  DISPLAY "TOTAL GRAL." @ Cta_cte.credito
          tot_saldo     @ saldo 
     WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  DISPLAY "=============" @ saldo WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 16).

END PROCEDURE.  

PROCEDURE LISTAR:

  tit_cobrador = STRING(Cobrador.cdg_cobrador) + "-" + Cobrador.nom_cobrador.

  ASSIGN t-debito  = 0
         t-credito = 0
         tot_saldo = 0.


  IF p-estado_cliente = 1 THEN v-estado = "A".
  IF p-estado_cliente = 2 THEN v-estado = "I".

  OPEN QUERY q_clientes 
       FOR EACH Cliente OF Cobrador WHERE cdg_estado = v-estado 
           AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK,
           FIRST Domicilio NO-LOCK OF Cliente 
              BY Cliente.cdg_cliente.

  IF p-estado_cliente = 3 THEN DO:
      OPEN QUERY q_clientes 
           FOR EACH Cliente NO-LOCK OF Cobrador
                    WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0,
               FIRST Domicilio NO-LOCK OF Cliente 
                  BY Cliente.cdg_cliente.
  
      END.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

      FIND LAST Rec_header OF cliente 
              WHERE rec_header.cdg_empresa = "F"
      NO-LOCK NO-ERROR.

        
VIEW FRAME frm-titulo.

            saldo   = 0.
            hubo = no.
            
                        FOR EACH Cta_cte OF Cliente NO-LOCK
               WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                 AND Cta_cte.credito <> Cta_cte.debito
                 AND Cta_cte.fecha_emision >= des_fecha
                 AND Cta_cte.fecha_emision <= has_fecha
                 AND ( Cta_cte.cdg_empresa = Empresa.cdg_empresa OR v-consolidado)
                AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa):


                IF NOT hubo
                THEN DO:
    
                    hubo = YES.
                    
                    IF LINE-COUNTER >= 82 THEN PAGE.
                

                    DISPLAY Cliente.cdg_cliente
                            Cliente.nom_cliente
                            Domicilio.direccion 
                            Domicilio.localidad 
                            Domicilio.telefono
                            WITH FRAME frm-listado-cli.
                    IF AVAILABLE Rec_header THEN DO:
                            DISPLAY 
                            Rec_header.cdg_empresa 
                            Rec_header.fecha
                            Rec_header.tip_comprob 
                            Rec_header.prf_comprob 
                            Rec_header.nro_comprob    
                            Rec_header.imp_total
                
                            WITH FRAME frm-listado-cli.
                    END.
                    DOWN 1 WITH FRAME frm-listado-cli.
   
                 END.
                 
                 FIND Imputacion OF Cta_cte NO-LOCK.
                 saldo = saldo + Cta_cte.debito - Cta_cte.credito.
                 DISPLAY
                    Cta_cte.cdg_empresa
                    Cta_cte.tip_comprob
                    Cta_cte.prf_comprob
                    Cta_cte.nro_comprob
                    Cta_cte.nro_vencimiento
                    Imputacion.abrevia
                    Cta_cte.fecha_emision
                    Cta_cte.fecha_vencimiento
                    Cta_cte.debito
                    Cta_cte.credito
                    Cta_cte.debito - Cta_cte.credito @ saldo
                    WITH FRAME frm-listado-mov.
                 DOWN 2 WITH FRAME frm-listado-mov.        
            END.

            IF hubo
            THEN DO:
                UNDERLINE
                     saldo
                     WITH FRAME frm-listado-mov.
                DOWN WITH FRAME frm-listado-mov.        
                DISPLAY 
                     saldo
                     WITH FRAME frm-listado-mov.
                DOWN 2 WITH FRAME frm-listado-mov.        

                tot_saldo = tot_saldo + saldo.

            END.

     GET NEXT q_clientes.

  END.   
  
END PROCEDURE.
