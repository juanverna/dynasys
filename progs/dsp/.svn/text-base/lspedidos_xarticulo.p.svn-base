/*=================================================================================*/
/*                    LIQUIDACION DE PEDIDOS X AARTICULO                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo    LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codigo    LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_fecha     AS DATE.
DEFINE INPUT PARAMETER has_fecha     AS DATE.
DEFINE INPUT PARAMETER lista_estados AS CHARACTER.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante      AS CHARACTER FORMAT "X(17)" COLUMN-LABEL "Identificación!del Comprobante".

DEFINE VARIABLE t-a-cantidad         LIKE Ped_detalle.cantidad.
DEFINE VARIABLE t-a-granel           LIKE Ped_detalle.granel.
DEFINE VARIABLE t-p-cantidad         LIKE Ped_detalle.cantidad.
DEFINE VARIABLE t-p-granel           LIKE Ped_detalle.granel.

DEFINE VARIABLE g-a-cantidad         LIKE Ped_detalle.cantidad.
DEFINE VARIABLE g-a-granel           LIKE Ped_detalle.granel.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Pedidos por Artículo" AT 62
    "Página:" AT 182 PAGE-NUMBER FORMAT "9999" AT 189
    SKIP  
    fecha_lis
    "del" AT 62
    des_fecha
    "al"
    has_fecha
    hora_lis AT 182
    SKIP (1) 
    WITH WIDTH 280 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Ped_header.fecha  COLUMN-LABEL "Fecha!Pedido"
    que_comprobante              
    Cliente.cdg_cliente          
    Cliente.nom_cliente          
    Ped_detalle.cantidad_sol  COLUMN-LABEL "Cantidad!Pedida"
    Ped_detalle.cantidad      COLUMN-LABEL "Cantidad!Aceptada"
    Ped_detalle.granel_sol    COLUMN-LABEL "Granel!Pedido"
    Ped_detalle.granel        COLUMN-LABEL "Granel!Aceptado"
    Estado_pedido.descripcion  COLUMN-LABEL "Estado"
    WITH WIDTH 290 DOWN CENTERED USE-TEXT STREAM-IO.

{fncomprobante.i}

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

  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  FOR EACH Ped_header,  /*NO-LOCK*/
          EACH Estado_pedido
          WHERE Ped_header.cdg_estado = Estado_pedido.cdg_estado 
          AND Ped_header.cdg_empresa = Empresa.cdg_empresa
          AND Ped_header.fecha <= has_fecha
          AND Ped_header.fecha >= des_fecha
          AND NOT Ped_header.anulado,
              FIRST Cliente OF Ped_header,
              EACH Ped_detalle OF Ped_header
                   WHERE LOOKUP(Ped_header.cdg_estado,lista_estados) <> 0,
          FIRST Articulo OF Ped_detalle
                WHERE Articulo.cdg_articulo <= has_codigo
                  AND Articulo.cdg_articulo >= des_codigo,
          FIRST Partida  OF Ped_detalle
          BREAK BY Articulo.cdg_articulo
                BY Partida.cdg_partida
                BY Ped_header.fecha
                BY Ped_header.tip_comprob
                BY Ped_header.prf_comprob
                BY Ped_header.nro_comprob:

       VIEW FRAME frm-titulo.

       que_comprobante = fncomprobante(Ped_header.tip_comprob,Ped_header.prf_comprob,Ped_header.nro_comprob).
       DISPLAY 
            Articulo.cdg_articulo WHEN FIRST-OF(Articulo.cdg_articulo)
            Articulo.descripcion  WHEN FIRST-OF(Articulo.cdg_articulo)
            Partida.cdg_partida   WHEN FIRST-OF(Partida.cdg_partida) 
            Ped_header.fecha      WHEN FIRST-OF(Ped_header.fecha)
            que_comprobante              
            Cliente.cdg_cliente          
            Cliente.nom_cliente          
            Ped_detalle.cantidad_sol
            Ped_detalle.cantidad
            Ped_detalle.granel_sol
            Ped_detalle.granel
            Estado_pedido.descripcion 
            WITH FRAME frm-listado.
       DOWN WITH FRAME frm-listado.

       ASSIGN
            t-p-cantidad = t-p-cantidad + Ped_detalle.cantidad
            t-p-granel   = t-p-granel   + Ped_detalle.granel.


       IF LAST-OF(Partida.cdg_partida)
       THEN DO:

            UNDERLINE 
                 Ped_detalle.cantidad_sol
                 Ped_detalle.granel_sol
                 Ped_detalle.cantidad
                 Ped_detalle.granel
                 Estado_pedido.descripcion
                 WITH FRAME frm-listado.
            DISPLAY
                 t-p-cantidad @ Ped_detalle.cantidad
                 t-p-granel   @ Ped_detalle.granel
                 WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

            ASSIGN
                 t-a-cantidad = t-a-cantidad + t-p-cantidad
                 t-a-granel   = t-a-granel   + t-p-granel
                 t-p-cantidad = 0
                 t-p-granel   = 0.

       END.
       
       IF LAST-OF(Articulo.cdg_articulo)
       THEN DO:

            UNDERLINE 
                 Ped_detalle.cantidad_sol
                 Ped_detalle.granel_sol
                 Ped_detalle.cantidad
                 Ped_detalle.granel
                 Estado_pedido.descripcion                
                 WITH FRAME frm-listado.
            DISPLAY
                 "Total " + Articulo.descripcion @ Cliente.nom_cliente
                 t-a-cantidad @ Ped_detalle.cantidad
                 t-a-granel   @ Ped_detalle.granel
                 WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

            ASSIGN
                 g-a-cantidad = g-a-cantidad + t-a-cantidad
                 g-a-granel   = g-a-granel   + t-a-granel
                 t-a-cantidad = 0
                 t-a-granel   = 0.

       END.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

