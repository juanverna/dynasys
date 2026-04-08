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
DEFINE VARIABLE tot_art_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_art_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE rec_art_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE rec_art_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE tot_par_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_par_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE rec_par_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE rec_par_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE poc_par_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE poc_par_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE pto_par_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE pto_par_grl      LIKE Cct_stock.granel.
DEFINE VARIABLE pto_art_can      LIKE Cct_stock.cantidad.
DEFINE VARIABLE pto_art_grl      LIKE Cct_stock.granel.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Entregas previstas por Artículo y Partida" AT 40
   "Página:" AT  145 PAGE-NUMBER FORMAT ">>9" AT 154
   SKIP
   fecha_lis
   "Período" AT 40
   des_fecha " - " has_fecha
   hora_lis AT 145
   SKIP(1) 
   WITH WIDTH 231 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
   Articulo.cdg_articulo                      COLUMN-LABEL "Código!Artículo"
   Articulo.descripcion                       COLUMN-LABEL "Descripción!Artículo"
   Partida.cdg_partida                        COLUMN-LABEL "Código!Partida"
   Ocm_detalle.fecha_temprana                 COLUMN-LABEL "Fecha!Entrega"
   Ocm_header.tip_comprob                     COLUMN-LABEL "Ti-!po"
   Ocm_header.prf_comprob                     COLUMN-LABEL "Pre-!fijo"
   Ocm_header.nro_comprob                     COLUMN-LABEL "Número!Ocompra"
   Ocm_detalle.cantidad                       COLUMN-LABEL "Cantidad!Comprada"
   Ocm_detalle.cantidad_rec                   COLUMN-LABEL "Cantidad!Recibida"
   poc_par_can                                COLUMN-LABEL "Cantidad!Pendiente"
/* Ocm_detalle.granel                         COLUMN-LABEL "Granel!Comprado"*/
/* Ocm_detalle.granel_rec                     COLUMN-LABEL "Granel!Recibido"*/
   Articulo.cdg_umed     FORMAT "X(5)"        COLUMN-LABEL "Unidad!Medida"
   Ocm_detalle.precio                         COLUMN-LABEL "Precio!Unitario"
   WITH WIDTH 231 FRAME frm-listado USE-TEXT STREAM-IO DOWN.

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

    tot_art_can = 0.
    tot_art_grl = 0.
    rec_art_can = 0.
    rec_art_grl = 0.

    tot_par_can = 0.
    tot_par_grl = 0.
    rec_par_can = 0.
    rec_par_grl = 0.

    {dirprinfile.i}
    
    FOR EACH Ocm_detalle NO-LOCK
         WHERE Ocm_detalle.fecha_temprana >= des_fecha
           AND Ocm_detalle.fecha_temprana <= has_fecha
           AND LOOKUP(Ocm_detalle.cdg_estado,"AA,AM") <> 0 ,
           EACH Ocm_header OF Ocm_detalle, 
                FIRST Articulo OF Ocm_detalle 
                      WHERE Articulo.cdg_articulo <= has_codigo
                        AND Articulo.cdg_articulo >= des_codigo
                            NO-LOCK,
                FIRST Partida OF Ocm_detalle
                BREAK BY Articulo.cdg_articulo
                      BY Partida.cdg_partida
                      BY Ocm_detalle.fecha_temprana 
                       WITH FRAME frm-listado:
    
          VIEW FRAME frm-titulo.

          poc_par_can = Ocm_detalle.cantidad  - Ocm_detalle.cantidad_rec.

          DISPLAY Articulo.cdg_articulo           WHEN FIRST-OF(Articulo.cdg_articulo)
                  Articulo.descripcion            WHEN FIRST-OF(Articulo.cdg_articulo)
                  Partida.cdg_partida             WHEN FIRST-OF(Partida.cdg_partida)
                  Ocm_detalle.fecha_temprana      WHEN FIRST-OF(Ocm_detalle.fecha_temprana)
                  Ocm_header.tip_comprob    
                  Ocm_header.prf_comprob    
                  Ocm_header.nro_comprob    
                /*Ocm_detalle.granel        */
                  Ocm_detalle.cantidad      
                /*Ocm_detalle.granel_rec    */
                  Ocm_detalle.cantidad_rec  
                  poc_par_can
                  Articulo.cdg_umed    
                  Ocm_detalle.precio  
                  WITH FRAME frm-listado.
    
          ASSIGN tot_par_can = tot_par_can + Ocm_detalle.cantidad  
                 tot_par_grl = tot_par_grl + Ocm_detalle.granel
                 rec_par_can = rec_par_can + Ocm_detalle.cantidad_rec  
                 rec_par_grl = rec_par_grl + Ocm_detalle.granel_rec
                 pto_par_can = pto_par_can + poc_par_can.

          DOWN WITH FRAME frm-listado.
                         
          IF LAST-OF(Partida.cdg_partida) 
          THEN DO:
              UNDERLINE /*Ocm_detalle.granel        */
                        Ocm_detalle.cantidad      
                        /*Ocm_detalle.granel_rec    */
                        Ocm_detalle.cantidad_rec  
                        poc_par_can
                        WITH FRAME frm-listado.  

              DISPLAY 
                  /*tot_art_grl @ Ocm_detalle.granel    */
                  tot_par_can @ Ocm_detalle.cantidad  
                  rec_par_can @ Ocm_detalle.cantidad_rec  
                  pto_par_can @ poc_par_can
                         WITH FRAME frm-listado.  

              ASSIGN tot_art_can = tot_art_can + tot_par_can
                     tot_art_grl = tot_art_grl + tot_par_grl
                     rec_art_can = rec_art_can + rec_par_can
                     rec_art_grl = rec_art_grl + rec_par_grl
                     pto_art_can = pto_art_can + pto_par_can
                     tot_par_can = 0
                     tot_par_grl = 0
                     rec_par_can = 0
                     rec_par_grl = 0
                     pto_par_can = 0.

              DOWN 2 WITH FRAME frm-listado.  
          END.

          IF LAST-OF(Articulo.cdg_articulo) 
          THEN DO:
              UNDERLINE /*Ocm_detalle.granel    */
                        Ocm_detalle.cantidad  
                       Ocm_detalle.cantidad_rec  
                       poc_par_can
                        WITH FRAME frm-listado.  

              DISPLAY 
                  tot_art_can @ Ocm_detalle.cantidad    
                  rec_art_can @ Ocm_detalle.cantidad_rec  
                  pto_art_can @ poc_par_can
                         WITH FRAME frm-listado.  

              ASSIGN tot_art_can = 0
                     tot_art_grl = 0
                     rec_art_can = 0
                     rec_art_grl = 0
                     pto_art_can = 0.

              DOWN 2 WITH FRAME frm-listado.  
          END.
              
   
    END.

    OUTPUT CLOSE.

    RUN veresult.w ( INPUT arch_salida, INPUT 22).

END PROCEDURE.

