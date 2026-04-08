/*=================================================================================*/
/*                    VENCIMIENTOS PENDIENTES POR COBRADOR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo       LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_codigo       LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER des_zonag        LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER has_zonag        LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE ant_zonag   LIKE Zona_geografica.cdg_zonag.

DEFINE VARIABLE tot_vendr            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_saldo            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE t-credito            AS DECIMAL.
DEFINE VARIABLE t-debito             AS DECIMAL.

DEFINE VARIABLE hubo                 AS LOGICAL.
DEFINE VARIABLE tit_cobrador         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.
DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{findsector.i}
{WGLISTAR.I}
que_sector = Area.cdg_area.
DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Documentosa Pendientes por Cobrador/Zona" AT 44
  "Página:" AT 111 PAGE-NUMBER FORMAT ">>9" AT 120
  SKIP  
  fecha_lis
  "Vencimientos del " AT 44
  des_fecha
  " al "
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 113
  SKIP (1) 
  tit_cobrador AT 44
  SKIP(1)
  "--------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código   Razón                                   Dirección                            Localidad       Número de           " SKIP
  "Cliente  Social                                  de cobranza                          de cobranza     Teléfono            " SKIP
  "--------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  Cliente.nom_cliente
  Domicilio.direccion FORMAT "X(35)"
  Domicilio.localidad FORMAT "X(15)"
  Domicilio.telefono  FORMAT "X(15)"
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.
         
DEFINE FRAME frm-listado-zona
  SKIP(1)
  SPACE(30)
  "----------<"
  Zona_geografica.cdg_zonag 
  SPACE(4)
  Zona_geografica.nombre 
  ">----------"  
  SKIP(1)
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
  desc_moneda = "en " + Moneda.descripcion + " - " + v-lista_empresas.

  que_empresa = Empresa.nombre.

  {dirprinfile.i &LIN-PAG=72} 

  OPEN QUERY qry_cobrador 
       FOR EACH Cobrador NO-LOCK WHERE Cobrador.cdg_cobrador >= des_codigo
            AND Cobrador.cdg_cobrador <= has_codigo
             BY Cobrador.cdg_cobrador.
  
  GET FIRST qry_cobrador.
  DO WHILE AVAILABLE Cobrador:
     RUN LISTAR.
     GET NEXT qry_cobrador.
  END.   

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).


END PROCEDURE.  

PROCEDURE LISTAR:

  tit_cobrador = STRING(Cobrador.cdg_cobrador) + "-" + Cobrador.nom_cobrador +
                 " " + des_zonag + " <-> " + has_zonag.

  ASSIGN t-debito  = 0
         t-credito = 0
         tot_saldo = 0.

  ant_zonag = "".
  
  OPEN QUERY q_clientes 
       FOR EACH Cliente OF Cobrador 
           WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK,
           FIRST Domicilio NO-LOCK OF Cliente 
                 WHERE Domicilio.cdg_zonag <= has_zonag
                   AND Domicilio.cdg_zonag >= des_zonag
                       BY Domicilio.cdg_zonag 
                       BY Cliente.nom_cliente.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

        VIEW FRAME frm-titulo.

        IF AVAILABLE Domicilio
        THEN DO:

            saldo   = 0.
            hubo = no.
            
            FOR EACH Cta_cte OF Cliente NO-LOCK
               WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                 AND Cta_cte.credito <> Cta_cte.debito
                 AND Cta_cte.fecha_vencimiento >= des_fecha
                 AND Cta_cte.fecha_vencimiento <= has_fecha
                 AND CAN-DO(v-lista_empresas,Cta_cte.cdg_empresa)
                AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa):

                IF NOT hubo
                THEN DO:
    
                    hubo = YES.
                    
                    IF LINE-COUNTER >= 69 THEN PAGE.
     
                    IF Domicilio.cdg_zonag <> ant_zonag
                    THEN DO:
                         FIND Zona_geografica OF Domicilio NO-LOCK.
                         DISPLAY Zona_geografica.cdg_zonag 
                                 Zona_geografica.nombre
                                 WITH FRAME frm-listado-zona.
                         DOWN 1 WITH FRAME frm-listado-zona.
                    END.
     
                    DISPLAY Cliente.cdg_cliente
                            Cliente.nom_cliente
                            Domicilio.direccion 
                            Domicilio.localidad 
                            Domicilio.telefono
                            WITH FRAME frm-listado-cli.
                    DOWN 1 WITH FRAME frm-listado-cli.
   
                 END.

                 ant_zonag = Domicilio.cdg_zonag.
                 
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
                 DOWN WITH FRAME frm-listado-mov.        
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

        END.

        GET NEXT q_clientes.

  END.   
  PAGE.

END PROCEDURE.
