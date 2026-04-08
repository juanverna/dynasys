/*=================================================================================*/
/*                    VENTAS POR VENDEDOR/ZONA                                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas    AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha           AS DATE.
DEFINE INPUT PARAMETER has_fecha           AS DATE.
DEFINE INPUT PARAMETER des_zonag           LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER has_zonag           LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER que_moneda          LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ver_detalle         AS  LOGICAL.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

DEFINE VARIABLE ant_zonag                  LIKE Zona_geografica.cdg_zonag.

DEFINE VARIABLE tot_vendr                  AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_v-total-cli            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE v-total-cli                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE v-total-zon                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE v-total-ven                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.
DEFINE VARIABLE det_comprob LIKE Cliente.nom_cliente.

{WGLISTAR.I}
{VPERSINM.I}
{VRSHARED.I}
{DFVARIMP.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Ventas por Cliente por Vendedor/Zona" AT 38
  "Página:" AT 102 PAGE-NUMBER FORMAT ">>9" AT 110
  SKIP  
  fecha_lis
  "del" AT 38
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 102
  SKIP (1) 
  tit_vendedor AT 38
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------" SKIP
  "Código Denominacion            Código     Razón                                       Total Neto                " SKIP
  "Zona   Zona                   Cliente     Social                                       de Ventas                " SKIP
  "----------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Zona_geografica.cdg_zonag 
  Zona_geografica.nombre 
  Cliente.cdg_cliente
  Cliente.nom_cliente
  v-total-cli COLUMN-LABEL "v-total-cli" FORMAT "->,>>>,>>9.99"
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

  FIND FIRST Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = "en " + Moneda.descripcion.

  que_empresa = "Empresas:" + v-lista_empresas.

  {dirprinfile.i}
 
  OPEN QUERY qry_vendedor
    FOR EACH Vendedor NO-LOCK 
       WHERE Vendedor.cdg_vendedor >= des_codigo
         AND Vendedor.cdg_vendedor <= has_codigo
          BY Vendedor.cdg_vendedor.
  
  GET FIRST qry_vendedor.
  DO WHILE AVAILABLE Vendedor:
     RUN LISTAR.
     GET NEXT qry_vendedor.
  END.   

  /*
  DISPLAY "=============" @ v-total-cli WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  DISPLAY "TOTAL GRAL." @ Fac_header.credito
          tot_v-total-cli     @ v-total-cli 
     WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  DISPLAY "=============" @ v-total-cli WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  */
    
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).

END PROCEDURE.  

PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre +
                 " " + des_zonag + " <-> " + has_zonag.

  ASSIGN v-total-ven = 0
         v-total-zon = 0
         v-total-cli = 0.

  ant_zonag = "".
  
  OPEN QUERY q_clientes 
       FOR EACH Cliente NO-LOCK OF Vendedor,
           FIRST Domicilio NO-LOCK OF Cliente 
                 WHERE Domicilio.cdg_zonag <= has_zonag
                   AND Domicilio.cdg_zonag >= des_zonag
                       BY Domicilio.cdg_zonag 
                       BY Cliente.nom_cliente.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

        VIEW FRAME frm-titulo.

        IF Domicilio.cdg_zonag <> ant_zonag
        THEN DO:

             IF v-total-zon <> 0
             THEN DO:

                UNDERLINE
                           v-total-cli 
                           WITH FRAME frm-listado-cli.
                DOWN 1 WITH FRAME frm-listado-cli.
                DISPLAY "Total Zona" @ Cliente.nom_cliente
                         v-total-zon @ v-total-cli
                           WITH FRAME frm-listado-cli.
                DOWN 2 WITH FRAME frm-listado-cli.
   
                v-total-ven = v-total-ven + v-total-zon.
                v-total-zon = 0.

             END.
                        
        END.

        v-total-cli   = 0.
    
        FOR EACH Fac_header OF Cliente NO-LOCK
           WHERE Fac_header.nro_moneda = Moneda.nro_moneda
             AND Fac_header.fecha >= des_fecha
             AND Fac_header.fecha <= has_fecha
             AND LOOKUP(Fac_header.cdg_empresa,v-lista_empresas) <> 0
             AND CAN-DO (Usuario.lista_empresas, Fac_header.cdg_empresa)
             AND NOT Fac_header.anulado:
            
            IF Fac_header.tip_comprob BEGINS "F"
            THEN DO:
                 v-total-cli = v-total-cli + Fac_header.imp_neto.
            END.                 
            ELSE DO:
                 IF Fac_header.tip_comprob BEGINS "C"
                 THEN DO:
                      v-total-cli = v-total-cli - Fac_header.imp_neto.
                 END.                 
            END.                 
      
        END.

        IF v-total-cli <> 0
        THEN DO:

            FIND Zona_geografica OF Domicilio NO-LOCK.

            DISPLAY
                Zona_geografica.cdg_zonag 
                Zona_geografica.nombre 
                Cliente.cdg_cliente
                Cliente.nom_cliente
                v-total-cli WHEN NOT ver_detalle
                WITH FRAME frm-listado-cli.
    
            DOWN WITH FRAME frm-listado-cli.

            ant_zonag = Domicilio.cdg_zonag.
            v-total-zon = v-total-zon + v-total-cli.

            IF ver_detalle
            THEN DO:
                FOR EACH Fac_header OF Cliente NO-LOCK
                   WHERE Fac_header.nro_moneda = Moneda.nro_moneda
                     AND Fac_header.fecha >= des_fecha
                     AND Fac_header.fecha <= has_fecha
                     AND LOOKUP(Fac_header.cdg_empresa,v-lista_empresas) <> 0
                     AND CAN-DO (Usuario.lista_empresas, Fac_header.cdg_empresa)
                     AND NOT Fac_header.anulado:
                    
                    IF Fac_header.tip_comprob BEGINS "F"
                    THEN DO:
                        det_comprob =   "  " +
                                        SUBSTRING(Fac_header.cdg_empresa,1,1)  + " " +
                                        Fac_header.tip_comprob +
                                        STRING(Fac_header.prf_comprob,"9999") + "-" + 
                                        STRING(Fac_header.nro_comprob,"99999999") + " " + 
                                        STRING(Fac_header.fecha,"99/99/99"). 

                        DISPLAY
                            det_comprob @ Cliente.nom_cliente
                            Fac_header.imp_neto @ v-total-cli
                            WITH FRAME frm-listado-cli.
                
                        DOWN WITH FRAME frm-listado-cli.

                    END.                 
                    ELSE DO:
                         IF Fac_header.tip_comprob BEGINS "C"
                         THEN DO:
                            det_comprob =   "  " +
                                            SUBSTRING(Fac_header.cdg_empresa,1,1)  + " " +
                                            Fac_header.tip_comprob +
                                            STRING(Fac_header.prf_comprob,"9999") + "-" + 
                                            STRING(Fac_header.nro_comprob,"99999999") + " " + 
                                            STRING(Fac_header.fecha,"99/99/99"). 
    
                            DISPLAY
                                det_comprob @ Cliente.nom_cliente
                                Fac_header.imp_neto @ v-total-cli
                                WITH FRAME frm-listado-cli.
                
                            DOWN WITH FRAME frm-listado-cli.
                         END.                 
                    END.                 
              
                END.
                UNDERLINE v-total-cli
                          WITH FRAME frm-listado-cli.
                          
                DISPLAY v-total-cli
                        WITH FRAME frm-listado-cli.

                DOWN 1 WITH FRAME frm-listado-cli.

            END.    

        END.

        GET NEXT q_clientes.

  END.   

  v-total-ven = v-total-ven + v-total-zon.

  UNDERLINE
               v-total-cli 
               WITH FRAME frm-listado-cli.
  DOWN 1 WITH FRAME frm-listado-cli.
  DISPLAY "Total Zona" @ Cliente.nom_cliente
           v-total-zon @ v-total-cli
               WITH FRAME frm-listado-cli.
  DOWN 1 WITH FRAME frm-listado-cli.
    
  UNDERLINE
               v-total-cli 
               WITH FRAME frm-listado-cli.
  DOWN 1 WITH FRAME frm-listado-cli.
  DISPLAY "Total " + STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre
                @ Cliente.nom_cliente
               v-total-ven @ v-total-cli
               WITH FRAME frm-listado-cli.
  DOWN 1 WITH FRAME frm-listado-cli.

  PAGE.

END PROCEDURE.

 
