/*=================================================================================*/
/*          EMITE EL LISTADO DE ENTREGAS DE O/COMPRA POR FECHA                     */ 
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo     LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codigo     LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_fecha      AS   DATE.
DEFINE INPUT PARAMETER has_fecha      AS   DATE.

/*=================================================================================*/
/*                               VARIABLES Y FRAMES                                */ 
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE nom_sector  LIKE Area.denominacion.
DEFINE VARIABLE tot_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_gr      LIKE Cct_stock.granel.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Entregas previstas por Artículo/Fecha" AT 40
   "Página:" AT  112 PAGE-NUMBER FORMAT ">>9" AT 120
   SKIP
   fecha_lis
   "Período" AT 40
   des_fecha " - " has_fecha
   hora_lis AT 112
   SKIP(1) 
   WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
   Articulo.cdg_articulo                      COLUMN-LABEL "Código!Artículo"
   Articulo.descripcion                       COLUMN-LABEL "Descripción!Artículo"
   Ocm_detalle.fecha_temprana                 COLUMN-LABEL "Fecha!Entrega"
   Ocm_header.nro_comprob                     COLUMN-LABEL "Número!Ocompra"
   Ocm_detalle.granel                         COLUMN-LABEL "Granel!Comprado"
   Ocm_detalle.cantidad                       COLUMN-LABEL "Cantidad!Comprada"
   Articulo.cdg_umed     FORMAT "X(5)"        COLUMN-LABEL "Unidad!Medida"
   Ocm_detalle.precio                         COLUMN-LABEL "Precio!Unitario"
   WITH WIDTH 131 FRAME frm-listado USE-TEXT STREAM-IO DOWN.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

    {findempresa.i} 
    que_empresa = Empresa.nombre.

    tot_un = 0.
    tot_gr = 0.

    {dirprinfile.i}
    
    FOR EACH Ocm_detalle NO-LOCK
         WHERE Ocm_detalle.fecha_temprana >= des_fecha
           AND Ocm_detalle.fecha_temprana <= has_fecha,
           EACH Ocm_header OF Ocm_detalle, 
                FIRST Articulo OF Ocm_detalle 
                      WHERE Articulo.cdg_articulo <= has_codigo
                        AND Articulo.cdg_articulo >= des_codigo
                            NO-LOCK 
                BREAK BY Articulo.cdg_articulo
                      BY Ocm_detalle.fecha_temprana 
                       WITH FRAME frm-listado:
    
          VIEW FRAME frm-titulo.

          DISPLAY Articulo.cdg_articulo WHEN FIRST-OF(Articulo.cdg_articulo)
                  Articulo.descripcion  WHEN FIRST-OF(Articulo.cdg_articulo)
                  Ocm_detalle.fecha_temprana  WHEN FIRST-OF(Ocm_detalle.fecha_temprana)
                  Ocm_header.nro_comprob
                  Ocm_detalle.granel
                  Ocm_detalle.cantidad
                  Articulo.cdg_umed 
                  Ocm_detalle.precio
                  WITH FRAME frm-listado.
    
          ASSIGN tot_un = tot_un + Ocm_detalle.cantidad  
                 tot_gr = tot_gr + Ocm_detalle.granel.

          DOWN WITH FRAME frm-listado.
                         
          IF LAST-OF(Articulo.cdg_articulo) 
          THEN DO:
              UNDERLINE Ocm_detalle.granel    
                        Ocm_detalle.cantidad  
                        WITH FRAME frm-listado.  

              DISPLAY 
                  tot_gr @ Ocm_detalle.granel    
                  tot_un @ Ocm_detalle.cantidad  
                         WITH FRAME frm-listado.  

              tot_un = 0.
              tot_gr = 0.

              DOWN 2 WITH FRAME frm-listado.  
          END.
              
   
    END.

    OUTPUT CLOSE.

    RUN veresult.w ( INPUT arch_salida, INPUT 22).

END PROCEDURE.

