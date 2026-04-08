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

DEFINE BUFFER Ugranel FOR Unidad.

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(17)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Remitos por Cliente" AT 40
    "Página:" AT 119 PAGE-NUMBER FORMAT "9999" AT 126
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 119
    SKIP (1) 

    "---------------------------------------------------------------------------------------------------------------------------------" SKIP
    " Código   Razón                                    Fecha    Identificación                                                       " SKIP
    " Cliente  Social                                   Remito   del comprobante                                                      " SKIP
    "                          Código     Descripción                              Código            Cantidad                   Kilaje" SKIP
    "                          Artículo   Artículo                                 Partida           Remitida                 Remitido" SKIP
    "---------------------------------------------------------------------------------------------------------------------------------" SKIP(1)

  /*"----------------------------------------------------------------------------------------------------------------------------" SKIP
    " Código   Razón                                    Fecha    Identificación                                                  " SKIP
    " Cliente  Social                                   Remito   del comprobante                                                 " SKIP
    "                          Código     Descripción                              Código          Cantidad            Kilaje    " SKIP
    "                          Artículo   Artículo                                 Partida         Remitida          Remitido    " SKIP
    "----------------------------------------------------------------------------------------------------------------------------" SKIP(1)*/
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Cliente.cdg_cliente
    Cliente.nom_cliente
    Rem_header.fecha
    que_comprobante
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Rem_detalle.cantidad
    Unidad.abrevia
    Rem_detalle.granel
    Ugranel.abrevia
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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
          AND NOT Rem_header.anulado,
              FIRST Cliente OF Rem_header
              WHERE Cliente.cdg_cliente <= has_codigo
                AND Cliente.cdg_cliente >= des_codigo,
          EACH Rem_detalle OF Rem_header,
          FIRST Articulo OF Rem_detalle,
          FIRST Partida  OF Rem_detalle
          BREAK BY Cliente.cdg_cliente
                BY Rem_header.fecha
                BY Rem_header.tip_comprob
                BY Rem_header.prf_comprob
                BY Rem_header.nro_comprob
                BY Articulo.cdg_articulo
                BY Partida.cdg_partida:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Rem_header.nro_comprob)
       THEN DO:
            que_comprobante = fncomprobante(Rem_header.tip_comprob,Rem_header.prf_comprob,Rem_header.nro_comprob).            
            DISPLAY Rem_header.fecha             WHEN FIRST-OF(Rem_header.fecha)
                    que_comprobante              
                    Cliente.cdg_cliente   WHEN FIRST-OF(Cliente.cdg_cliente)
                    Cliente.nom_cliente   WHEN FIRST-OF(Cliente.cdg_cliente)       
                    WITH FRAME frm-listado.
         /* DOWN WITH FRAME frm-listado. */

       END.

       FIND Unidad OF Articulo NO-LOCK.
       FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.

       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               Partida.cdg_partida
               Rem_detalle.cantidad
               Unidad.abrevia
               Rem_detalle.granel
               Ugranel.abrevia
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

