/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER v-lista_estados  AS CHARACTER.
DEFINE INPUT PARAMETER v-lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER v-archivo        AS CHARACTER.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

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

  OUTPUT TO VALUE(v-archivo).
  EXPORT DELIMITER ";"
        "Empresa"
        "Provincia"
        "Vendedor"
        "Tiporticulo"
        "Articulo"
        "Color"
        "Cantidad"
        "Precio"
        "Subtotal".
        
  FOR EACH Ped_header 
        WHERE LOOKUP(Ped_header.cdg_empresa,v-lista_empresas) <> 0
          AND Ped_header.fecha <= has_fecha
          AND Ped_header.fecha >= des_fecha
          AND NOT Ped_header.anulado,
              FIRST Cliente OF Ped_header,
          FIRST Provincia OF Ped_header,    
          FIRST Vendedor OF Ped_header,    
          EACH Ped_detalle OF Ped_header
               WHERE LOOKUP(Ped_detalle.cdg_estado,v-lista_estados) <> 0,
          FIRST Articulo OF Ped_detalle,
          FIRST Partida  OF Ped_detalle:

        EXPORT DELIMITER ";"
               Ped_header.cdg_empresa
               Provincia.nombre
               Vendedor.cdg_vendedor
               Articulo.cdg_tipoart
               Articulo.cdg_articulo
               Partida.cdg_partida
               Ped_detalle.cantidad
               Ped_detalle.precio
               Ped_detalle.subtotal_neto.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

