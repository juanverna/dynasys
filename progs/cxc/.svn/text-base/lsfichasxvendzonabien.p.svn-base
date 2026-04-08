/*=================================================================================*/
/*                    VENCIMIENTOS PENDIENTES POR vendedor                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo       LIKE Vendedor.cdg_vendedor.
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
DEFINE VARIABLE saldo_consolidado    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".

DEFINE VARIABLE t-credito            AS DECIMAL.
DEFINE VARIABLE t-debito             AS DECIMAL.
DEFINE VARIABLE creditos             AS DECIMAL.
DEFINE VARIABLE debitos              AS DECIMAL.

DEFINE VARIABLE hubo                 AS LOGICAL.
DEFINE VARIABLE tit_vendedor         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE VARIABLE v-empresa_ccte AS CHARACTER.

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Saldos Pendientes por Vendedor/Zona" AT 44
  "Página:" AT 111 PAGE-NUMBER FORMAT ">>9" AT 120
  SKIP  
  fecha_lis
  "del" AT 44
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 113
  SKIP (1) 
  tit_vendedor AT 44
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

  OPEN QUERY qry_vendedor 
       FOR EACH vendedor NO-LOCK WHERE vendedor.cdg_vendedor >= des_codigo
            AND vendedor.cdg_vendedor <= has_codigo
             BY vendedor.cdg_vendedor.
  
  GET FIRST qry_vendedor.
  DO WHILE AVAILABLE vendedor:
     RUN LISTAR.
     GET NEXT qry_vendedor.
  END.   

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).


END PROCEDURE.  

PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre +
                 " " + des_zonag + " <-> " + has_zonag.

  ASSIGN t-debito  = 0
         t-credito = 0
         tot_saldo = 0.

  ant_zonag = "".
  
  OPEN QUERY q_clientes 
       FOR EACH Cliente NO-LOCK OF vendedor,
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

            hubo = NO.

            FOR EACH Cta_cte OF Cliente 
                WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
/*                   AND Cta_cte.fecha_emision >= des_fecha */
/*                   AND Cta_cte.fecha_emision <= has_fecha */
                  AND CAN-DO(v-lista_empresas,Cta_cte.cdg_empresa)
                  AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa),
                      EACH Imputacion OF Cta_cte
                   BREAK BY Cta_cte.cdg_empresa BY Cta_cte.fecha_emision WITH FRAME frm-listado:
                
                VIEW FRAME frm-titulo.

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
                
                 IF FIRST-OF(Cta_cte.cdg_empresa)
                 THEN DO:

                    
                    RUN CALCULAR_EI ( INPUT Cta_cte.cdg_empresa, OUTPUT debitos, OUTPUT creditos ).
                    saldo = debitos - creditos.
                    DISPLAY "S.In." @ Imputacion.abrevia
                          des_fecha @ Cta_cte.fecha_emision
                          debitos   @ Cta_cte.debito
                          creditos  @ Cta_cte.credito
                          saldo
                    WITH FRAME frm-listado-mov.
                    DOWN WITH FRAME frm-listado-mov.
                 END.
                 
                  IF Cta_cte.fecha_emision >= des_fecha 
                  AND Cta_cte.fecha_emision <= has_fecha THEN DO: 

                                 ant_zonag = Domicilio.cdg_zonag.
                                 
                         
                
                                 IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
                                    THEN debitos = debitos + Cta_cte.debito.
                                    ELSE creditos = creditos + Cta_cte.credito.
                         
                                 saldo = debitos - creditos.
                
                                 
                                 
                                    DISPLAY   
                                    Cta_cte.cdg_empresa
                                    Cta_cte.tip_comprob
                                    Cta_cte.prf_comprob
                                    Cta_cte.nro_comprob
                                    Cta_cte.nro_vencimiento
                                    Imputacion.abrevia           
                                    Cta_cte.fecha_emision
                                    Cta_cte.fecha_vencimiento
                                    Cta_cte.debito  WHEN CAN-DO(str_debitan,Cta_cte.tip_comprob)
                                    Cta_cte.credito WHEN NOT CAN-DO(str_debitan,Cta_cte.tip_comprob)
                                    saldo
                                    Cta_cte.leyenda
                                    WITH FRAME frm-listado-mov.
                                       
                                 DOWN WITH FRAME frm-listado-mov.
                                                  
                                 IF LAST-OF(Cta_cte.cdg_empresa)
                                 THEN DO:
                                    UNDERLINE Cta_cte.fecha_vencimiento
                                              Cta_cte.debito
                                              Cta_cte.credito
                                              saldo
                                              WITH FRAME frm-listado-mov.
                                 
                                 
                                    DISPLAY "Saldo " + Cta_cte.cdg_empresa  @ Cta_cte.fecha_vencimiento
                                            debitos  @ Cta_cte.debito
                                            creditos @ Cta_cte.credito
                                            saldo
                                            WITH FRAME frm-listado-mov.
                                    DOWN 2 WITH FRAME frm-listado-mov.        
                                 END.
                
                                    saldo_consolidado = saldo_consolidado + saldo.
                                    saldo = 0.
                  END. 
                                           
            END.
            IF hubo
            THEN DO:
                UNDERLINE Cta_cte.fecha_vencimiento
                          Cta_cte.debito
                          Cta_cte.credito
                          saldo
                          WITH FRAME frm-listado-mov.

                DISPLAY "Total"  @ Cta_cte.fecha_vencimiento
                        debitos  @ Cta_cte.debito
                        creditos @ Cta_cte.credito
                        saldo_consolidado @ saldo
                        WITH FRAME frm-listado-mov.
                DOWN 2 WITH FRAME frm-listado-mov.  

                          tot_saldo = tot_saldo + saldo_consolidado.
                          saldo_consolidado = 0.
                
            END.

        END.

        GET NEXT q_clientes.

  END.   
  PAGE.

END PROCEDURE.

PROCEDURE CALCULAR_EI:

   DEFINE INPUT  PARAMETER p-que_empresa LIKE Empresa.cdg_empresa.
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento desde principio de mes a la fecha */

   FOR EACH B-Cta_cte OF Cliente 
       WHERE B-Cta_cte.fecha_emision < des_fecha
         AND B-Cta_cte.nro_moneda = Moneda.nro_moneda
         AND B-Cta_cte.cdg_empresa = p-que_empresa 
             NO-LOCK:

      IF CAN-DO(str_debitan,B-Cta_cte.tip_comprob)
         THEN tot_debitogr  = tot_debitogr + B-Cta_cte.debito.
         ELSE tot_creditogr = tot_creditogr + B-Cta_cte.credito.
      
   END.

END PROCEDURE.

