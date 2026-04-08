/*=================================================================================*/
/*                       LISTADO DE PEDIDOS SEGUN ESTADO                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha         AS DATE.
DEFINE INPUT PARAMETER has_fecha         AS DATE.
DEFINE INPUT PARAMETER v-lista_estados   AS CHARACTER.
DEFINE INPUT PARAMETER v-lista_empresas  AS CHARACTER.

/*=================================================================================*/
/*                                  VARIABLES Y FRAMES                             */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Pedidos entre fechas según estado" AT 45
  "Página:" AT 111 PAGE-NUMBER FORMAT ">>9" AT 119
  SKIP
  fecha_lis
  det_titulo AT 35 NO-LABEL
  hora_lis AT 111
  SKIP(1)
  WITH WIDTH 140 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Ped_header.fecha                            COLUMN-LABEL "Fecha!Entrega"   
    Ped_header.cdg_empresa                      COLUMN-LABEL "Em-!presa"
    Ped_header.fecha_alta                       COLUMN-LABEL "Fecha!Alta"
    Ped_header.nro_comprob                      COLUMN-LABEL "Número!Pedido"
    Deposito.cdg_deposito                       COLUMN-LABEL "Depó-!sito"
    Estado_pedido.descripcion   FORMAT "X(10)"  COLUMN-LABEL "Es-!tado" 
    Ped_header.cdg_lista                        COLUMN-LABEL "Código!Lista"
    Ped_header.cdg_recorrido                    COLUMN-LABEL "Reco-!rrido"
    Vendedor.cdg_vendedor                       COLUMN-LABEL "Código!Vendedor"
    Cliente.cdg_cliente                         COLUMN-LABEL "Código!Cliente"
    Cliente.nom_cliente                         COLUMN-LABEL "Razón!Social"
    WITH WIDTH 140 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
         
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR.

/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  {DIRPRINFILE.I}

  FOR EACH Ped_header NO-LOCK, 
        EACH Estado_pedido
             WHERE Ped_header.cdg_estado = Estado_pedido.cdg_estado
               AND Ped_header.fecha <= has_fecha
               AND Ped_header.fecha >= des_fecha
               AND LOOKUP(Ped_header.cdg_estado,v-lista_estados) <> 0
               AND LOOKUP(Ped_header.cdg_empresa,v-lista_empresas) <> 0 NO-LOCK,
        FIRST Cliente OF Ped_header
              WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK,
        FIRST Vendedor OF Cliente NO-LOCK
              BREAK BY Ped_header.fecha BY Ped_header.cdg_empresa:
        
      VIEW FRAME frm-titulo.
      
      DISPLAY
            
            Ped_header.fecha 
            Ped_header.cdg_empresa 
            Ped_header.fecha_alta 
            Ped_header.nro_comprob 
            Deposito.cdg_deposito 
            Estado_pedido.descripcion
            Ped_header.cdg_lista 
            Ped_header.cdg_recorrido 
            Vendedor.cdg_vendedor
            Cliente.cdg_cliente
            Cliente.nom_cliente
            WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.  


  END.
  UNDERLINE 
            Ped_header.fecha
            Ped_header.cdg_empresa 
            Ped_header.fecha_alta 
            Ped_header.nro_comprob 
            Deposito.cdg_deposito 
            Estado_pedido.descripcion 
            Ped_header.cdg_lista 
            Ped_header.cdg_recorrido 
            Vendedor.cdg_vendedor
            Cliente.cdg_cliente
            Cliente.nom_cliente
            WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.  
  
  OUTPUT CLOSE.
  
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

