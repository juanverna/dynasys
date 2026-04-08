/*==========================================================================================================*/
/*              LISTADO DE TOTAL DE VENTAS POR ARTICULO. PUEDE INCLUIR CLIENTES O NO                        */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER       des_codigo     LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER       has_codigo     LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER       des_fecha      AS DATE.
DEFINE INPUT PARAMETER       has_fecha      AS DATE.
DEFINE INPUT PARAMETER       det_sino       AS LOGICAL.

/*==========================================================================================================*/
/*                                          VARIABLES                                                       */
/*==========================================================================================================*/

DEFINE VARIABLE cero_sino    AS LOGICAL INITIAL NO.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE cantidad_art LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_art   LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_art  LIKE Acum_ventas.subtotal LABEL "Tot.Cliente".
DEFINE VARIABLE cantidad_cli LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_cli   LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_cli  LIKE Acum_ventas.subtotal LABEL "Tot. articulo".
DEFINE VARIABLE precio_prom  LIKE Acum_ventas.subtotal LABEL "Precio Promedio".

{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Totales de Ventas por Artículo/Cliente" AT 42
  "Página:" AT 99 PAGE-NUMBER FORMAT ">>>9" AT 107
  SKIP
  fecha_lis
  "del" AT 42
  des_fecha
  "al"
  has_fecha
  hora_lis AT 99
  SKIP
  SKIP(1)
  "--------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Descripción                                                                                        " SKIP
  "Artículo   Artículo                                                                                           " SKIP 
  "                                                                                                              " SKIP
  "   Código        Razón                                             Total     Total         Total        Precio" SKIP
  "  Cliente        Social                                         Unidades    Granel       Vendido      Promedio" SKIP
  "--------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-art
  Articulo.cdg_articulo
  SPACE(1)
  Articulo.descripcion
  Articulo.a_granel FORMAT " */  "
  Partida.cdg_partida
  cantidad_art
  granel_art
  gastado_art
  precio_prom
  WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-cli
  SPACE(6)
  Cliente.cdg_cliente
  SPACE(3)
  Cliente.nom_cliente
  SPACE(2)
  cantidad_cli
  granel_cli  
  gastado_cli
  precio_prom
  WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

PROCEDURE listar:

  {dirprinfile.i}

  FOR EACH Articulo 
      WHERE Articulo.cdg_articulo <= has_codigo
        AND Articulo.cdg_articulo >= des_codigo
            BY Articulo.cdg_articulo
            BY Partida.cdg_partida:
 
     VIEW FRAME frm-titulo.
  
     gastado_cli  = 0.
     gastado_art  = 0.
     cantidad_art = 0.
     granel_art   = 0.
     precio_prom  = 0.     

     IF det_sino
     THEN DO:
          DISPLAY Articulo.cdg_articulo
                  Articulo.descripcion
                  Articulo.a_granel
                  Partida.cdg_partida
                  WITH FRAME frm-listado-art.
          DOWN 2 WITH FRAME frm-listado-art.
     END.

     FOR EACH Fac_detalle OF Partida, FIRST Fac_header OF Fac_detalle
              WHERE Fac_header.fecha <= has_fecha
                AND Fac_header.fecha >= des_fecha
                AND Fac_header.cdg_empresa = Empresa.cdg_empresa,
                    FIRST Cliente OF Fac_header
                    BREAK BY Cliente.cdg_cliente:
                 
         IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0
         THEN DO:

              ASSIGN
                  cantidad_art = cantidad_art + Fac_detalle.cantidad
                  granel_art   = granel_art   + Fac_detalle.granel
                  gastado_art  = gastado_art  + Fac_detalle.subtotal_neto.

              ASSIGN
                  cantidad_cli = cantidad_cli + Fac_detalle.cantidad
                  granel_cli   = granel_cli   + Fac_detalle.granel
                  gastado_cli  = gastado_cli  + Fac_detalle.subtotal_neto.

         END.
         ELSE DO:

              ASSIGN
                  cantidad_art = cantidad_art - Fac_detalle.cantidad
                  granel_art   = granel_art   - Fac_detalle.granel
                  gastado_art  = gastado_art  - Fac_detalle.subtotal_neto.

              ASSIGN
                  cantidad_cli = cantidad_cli - Fac_detalle.cantidad
                  granel_cli   = granel_cli   - Fac_detalle.granel
                  gastado_cli  = gastado_cli  - Fac_detalle.subtotal_neto.

         END.         
         
         IF LAST-OF(Cliente.cdg_cliente) AND det_sino /* Fin del cliente y se pidió un detalle */
         THEN DO:

                precio_prom = gastado_cli / cantidad_cli.
                DISPLAY Cliente.cdg_cliente
                        Cliente.nom_cliente
                        cantidad_cli
                        granel_cli  
                        gastado_cli
                        precio_prom
                        WITH FRAME frm-listado-cli.
                DOWN WITH FRAME frm-listado-cli.

                ASSIGN
                     cantidad_cli = 0
                     granel_cli   = 0
                     gastado_cli  = 0.

          END.

     END. /* De las facturas del artículo */

     IF det_sino 
     THEN DO:              
          
          UNDERLINE Articulo.cdg_articulo
                    Articulo.descripcion
                    Articulo.a_granel
                    Partida.cdg_partida
                    cantidad_art
                    granel_art
                    gastado_art      
                    precio_prom
                    WITH FRAME frm-listado-art.
          DOWN WITH FRAME frm-listado-art.

          precio_prom = ( IF Articulo.a_granel 
                             THEN gastado_art / granel_art
                             ELSE gastado_art / cantidad_art ).

      END.                             

      DISPLAY Articulo.cdg_articulo  WHEN NOT det_sino
              Articulo.descripcion   WHEN NOT det_sino
              Articulo.a_granel      WHEN NOT det_sino 
              Partida.cdg_partida
              cantidad_art
              granel_art
              gastado_art      
              precio_prom
              WITH FRAME frm-listado-art.
      DOWN WITH FRAME frm-listado-art.

  END. /* De los articulos   */

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.


