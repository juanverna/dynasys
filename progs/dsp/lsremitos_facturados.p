/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(17)".
DEFINE VARIABLE que_factura     AS CHARACTER FORMAT "X(17)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Remitos Facturados" AT 40
    "Página:" AT 110 PAGE-NUMBER FORMAT "9999" AT 117
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 110
    SKIP (1) 
    "--------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Fecha    Identificación     Código   Razón                                   Identificación    Fecha                            " SKIP
    "Remito   del comprobante    Cliente  Social                                  de la factura     Factura                          " SKIP
    "                          Código     Descripción                              Código           Cantidad  Unidad    Kilaje       " SKIP
    "                          Artículo   Artículo                                 Partida          Remitida  Medida  Remitido       " SKIP
    "--------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Rem_header.fecha
    que_comprobante
    Cliente.cdg_cliente
    Cliente.nom_cliente
    que_factura
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Rem_detalle.cantidad
    Unidad.abrevia 
    Rem_detalle.granel
    WITH WIDTH 220 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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

  FOR EACH Rem_header NO-LOCK
        WHERE Rem_header.cdg_empresa = Empresa.cdg_empresa
          AND Rem_header.fecha <= has_fecha
          AND Rem_header.fecha >= des_fecha
          AND NOT Rem_header.anulado
          AND Rem_header.estado = "P",
              FIRST Cliente OF Rem_header
              WHERE Cliente.cdg_cliente <= has_codigo
                AND Cliente.cdg_cliente >= des_codigo NO-LOCK,
          EACH Rem_detalle OF Rem_header NO-LOCK,
          FIRST Articulo OF Rem_detalle NO-LOCK,
          FIRST Unidad OF Articulo NO-LOCK,
          FIRST Partida  OF Rem_detalle
          BREAK BY Rem_header.fecha
                BY Cliente.cdg_cliente
                BY Rem_header.tip_comprob
                BY Rem_header.prf_comprob
                BY Rem_header.nro_comprob
                BY Articulo.cdg_articulo
                BY Partida.cdg_partida:
      FIND Fac_header WHERE Fac_header.nro_remito = Rem_header.nro_remito NO-LOCK NO-ERROR.

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Rem_header.nro_comprob)
       THEN DO:
            que_comprobante = fncomprobante(Rem_header.tip_comprob,Rem_header.prf_comprob,Rem_header.nro_comprob).            
            que_factura = fncomprobante(Fac_header.tip_comprob,Fac_header.prf_comprob,Fac_header.nro_comprob).
            DISPLAY Rem_header.fecha             WHEN FIRST-OF(Rem_header.fecha)
                    que_comprobante  
                    Cliente.cdg_cliente          
                    Cliente.nom_cliente          
                    que_factura WHEN AVAILABLE Fac_header
                    Fac_header.fecha WHEN AVAILABLE Fac_header
                    WITH FRAME frm-listado.
         /* DOWN WITH FRAME frm-listado. */

       END.

       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               Partida.cdg_partida
               Rem_detalle.cantidad
               Unidad.abrevia
               Rem_detalle.granel
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

