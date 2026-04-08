/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo      LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.
DEFINE INPUT PARAMETER v-lista_estados AS CHARACTER.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE BUFFER Ugranel FOR Unidad.

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Pedidos por Fecha" AT 55
    "Página:" AT 131 PAGE-NUMBER FORMAT "9999" AT 138
    SKIP  
    fecha_lis
    "del" AT 55
    des_fecha
    "al"
    has_fecha
    hora_lis AT 131
    SKIP (1) 
    "---------------------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Fecha    Identificación   Código   Razón                                                                                                     " SKIP
    "Remito   del comprobante  Cliente  Social                                                                                                    " SKIP
    "                          Código     Descripción                                  Código        Cantidad                Granel         Estado" SKIP
    "                          Artículo   Artículo                                     Partida       Pedida                  Pedido               " SKIP
    "---------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)

  /*"----------------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Fecha    Identificación   Código   Razón                                                                                                " SKIP
    "Remito   del comprobante  Cliente  Social                                                                                               " SKIP
    "                          Código     Descripción                                  Código      Cantidad            Granel        Estado  " SKIP
    "                          Artículo   Artículo                                     Partida     Pedida              Pedido                " SKIP
    "----------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)*/
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Ped_header.fecha
    que_comprobante
    Cliente.cdg_cliente
    Cliente.nom_cliente
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Ped_detalle.cantidad
    Unidad.abrevia
    Ped_detalle.granel
    Ugranel.abrevia
    Estado_pedido.descripcion 
   
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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

  FOR EACH Ped_header, 
          EACH Estado_pedido
          WHERE Ped_header.cdg_estado = Estado_pedido.cdg_estado 
          AND Ped_header.cdg_empresa = Empresa.cdg_empresa
          AND Ped_header.fecha <= has_fecha
          AND Ped_header.fecha >= des_fecha
          AND NOT Ped_header.anulado,
              FIRST Cliente OF Ped_header
              WHERE Cliente.cdg_cliente <= has_codigo
                AND Cliente.cdg_cliente >= des_codigo,
          EACH Ped_detalle OF Ped_header
               WHERE LOOKUP(Ped_detalle.cdg_estado,v-lista_estados) <> 0,
          FIRST Articulo OF Ped_detalle,
          FIRST Partida  OF Ped_detalle
          BREAK BY Ped_header.fecha
                BY Cliente.cdg_cliente
                BY Ped_header.tip_comprob
                BY Ped_header.prf_comprob
                BY Ped_header.nro_comprob
                BY Articulo.cdg_articulo
                BY Partida.cdg_partida:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Ped_header.nro_comprob)
       THEN DO:
            que_comprobante = Ped_header.tip_comprob + " " + 
                              STRING(Ped_header.prf_comprob,"9999") + " " +
                              STRING(Ped_header.nro_comprob,"99999999").
            DISPLAY Ped_header.fecha             WHEN FIRST-OF(Ped_header.fecha)
                    que_comprobante              
                    Cliente.cdg_cliente          
                    Cliente.nom_cliente          
                    WITH FRAME frm-listado.
         /* DOWN WITH FRAME frm-listado. */

       END.

       FIND Unidad OF Articulo NO-LOCK.
       FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.

       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               Partida.cdg_partida
               Ped_detalle.cantidad
               Unidad.abrevia
               Ped_detalle.granel
               Ugranel.abrevia
               Estado_pedido.descripcion         
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

