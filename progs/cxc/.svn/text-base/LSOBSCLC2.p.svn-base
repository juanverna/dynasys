/*=================================================================================*/
/*                    VENTAS POR VENDEDOR/ZONA                                     */
/*=================================================================================*/
DEFINE INPUT PARAMETER v-lista_empresas    AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha           AS DATE.
DEFINE INPUT PARAMETER has_fecha           AS DATE.
DEFINE INPUT PARAMETER ver_detalle         AS  LOGICAL.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/
DEFINE VARIABLE ant_cliente AS CHARACTER.
DEFINE VARIABLE ant_zonag                  LIKE Zona_geografica.cdg_zonag.
DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".

{WGLISTAR.I}
{VPERSINM.I}
{VRSHARED.I}
{DFVARIMP.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Observaciones de Clientes" AT 55
  "Página:" AT 141 PAGE-NUMBER FORMAT ">>9" AT 149
  SKIP  
  fecha_lis
  "del" AT 55
  des_fecha
  "al"
  has_fecha
  hora_lis AT 141
  SKIP (1) 
  "Vendedor => "  
  tit_vendedor AT 13
  SKIP(1)


/*  "--------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP    */
/*  "Código   Razón                          Fecha    Número          Cn  Nro      Dirección                 Localidad            Número de                  " SKIP    */
/*  "Cliente  Social                         Alta     C.U.I.T.        IVA Cob      de cobranza               de cobranza          Teléfono                   " SKIP    */
/*  "--------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1) */
WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado-cli
    Cliente.cdg_cliente                         COLUMN-LABEL "Código"
    Cliente.nom_cliente         FORMAT "X(30)"  COLUMN-LABEL "Razón!Social"
     SKIP (1)
            Cliente-observacion.fecha_observacion       COLUMN-LABEL "Fecha"
            Cliente-observacion.hora_observacion        COLUMN-LABEL "Hora"
            Cliente-observacion.titulo                  COLUMN-LABEL "Titulo"
            Cliente-observacion.descripcion

       WITH WIDTH 200 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

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
    
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).
END PROCEDURE.  


PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre. 
  ant_zonag = "".
  OPEN QUERY q_clientes 
       FOR EACH Cliente OF Vendedor NO-LOCK,
      EACH Cliente-observacion      
              WHERE Cliente-observacion.fecha_observacion >= des_fecha
              AND Cliente-observacion.fecha_observacion <= has_fecha
              AND Cliente-observacion.descripcion <> "",
                 FIRST Domicilio OF Cliente NO-LOCK
                 WHERE Domicilio.cdg_subclasezng >= des_codigo
                   AND Domicilio.cdg_subclasezng <= has_codigo
                       BY Domicilio.cdg_subclasezng 
                       BY Cliente.cdg_cliente
                        BY Cliente-observacion.fecha_observacion
                        BY Cliente-observacion.hora_observacion.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

         VIEW FRAME frm-titulo. 
         IF Cliente.cdg_cliente = ant_cliente THEN DO:
             DISPLAY
                 Cliente-observacion.fecha_observacion
                 Cliente-observacion.hora_observacion
                 Cliente-observacion.titulo            
                 Cliente-observacion.descripcion 
             WITH FRAME frm-listado-cli.
            DOWN WITH FRAME frm-listado-cli.
         END.

        ELSE DO:
            PUT SKIP (1).
            DISPLAY
                Cliente.cdg_cliente   
                Cliente.nom_cliente
                Cliente-observacion.fecha_observacion 
                Cliente-observacion.hora_observacion
                Cliente-observacion.titulo            
                Cliente-observacion.descripcion 
                WITH FRAME frm-listado-cli.
            DOWN WITH FRAME frm-listado-cli.
        END.
            ant_zonag = Domicilio.cdg_subclasezng.
            ant_cliente = Cliente.cdg_cliente.
        GET NEXT q_clientes.

  END.

/*     DOWN 1 WITH FRAME frm-listado-cli. */

/*    PAGE. */

END PROCEDURE.

 

