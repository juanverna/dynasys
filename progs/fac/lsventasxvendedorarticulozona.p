/*==========================================================================================================*/
/*              LISTADO DE TOTAL DE VENTAS POR ARTICULO. PUEDE INCLUIR CLIENTES O NO                        */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER       des_zona       LIKE Zona_geografica.cdg_zona.
DEFINE INPUT PARAMETER       has_zona       LIKE Zona_geografica.cdg_zona.
DEFINE INPUT PARAMETER       des_vendedor   LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER       has_vendedor   LIKE Vendedor.cdg_vendedor.
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

DEFINE VARIABLE cantidad_ven LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_ven   LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_ven  LIKE Acum_ventas.subtotal LABEL "Tot. articulo".

DEFINE VARIABLE cantidad_art LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_art   LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_art  LIKE Acum_ventas.subtotal LABEL "Tot.Cliente".

DEFINE VARIABLE cantidad_cli LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_cli   LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_cli  LIKE Acum_ventas.subtotal LABEL "Tot. articulo".

DEFINE VARIABLE precio_prom  LIKE Acum_ventas.subtotal LABEL "Precio Promedio".

DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE v-zona_nombre AS CHARACTER.
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Totales de Ventas por Vendedor/Artículo/Cliente" AT 37
  "Página:" AT 99 PAGE-NUMBER FORMAT ">>>9" AT 107
  SKIP
  fecha_lis
  "del" AT 37
  des_fecha
  "al"
  has_fecha
  hora_lis AT 99
  SKIP
  tit_vendedor AT 37
  SKIP
  "Zonas: " AT 37  
  des_zona " - " has_zona
  SKIP(1)
  "--------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Descripción                                                                                        " SKIP
  "Artículo   Artículo                                                                                           " SKIP 
  "                                                                                                              " SKIP
  "      Código     Razón                                             Total     Total         Total        Precio" SKIP
  "     Cliente     Social                                         Unidades    Granel       Vendido      Promedio" SKIP
  "--------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-art
  Articulo.cdg_articulo
  SPACE(1)
  Articulo.descripcion
  Articulo.a_granel FORMAT " */  "
  SPACE(5)
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

DEFINE STREAM Seguimiento.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

PROCEDURE listar:

    {dirprinfile.i}

    que_empresa = Empresa.nombre.

    ASSIGN

        gastado_ven  = 0
        cantidad_ven = 0
        granel_ven   = 0

        gastado_art  = 0
        cantidad_art = 0
        granel_art   = 0

        gastado_cli  = 0
        cantidad_cli = 0
        granel_cli   = 0.

    OUTPUT STREAM Seguimiento TO "c:\sic-temp\estadisticas.txt" PAGE-SIZE 0.

    FOR EACH Fac_header 
        WHERE Fac_header.fecha <= has_fecha
          AND Fac_header.fecha >= des_fecha
          AND Fac_header.anulado = NO
          AND Fac_header.cdg_empresa = Empresa.cdg_empresa,
          FIRST Cliente OF Fac_header,
          FIRST Domicilio OF Fac_header 
          WHERE Domicilio.cdg_zonag >= des_zona
            AND Domicilio.cdg_zonag <= has_zona,
          FIRST Zona_geografica OF Domicilio,
          FIRST Vendedor OF Fac_header
          WHERE Vendedor.cdg_vendedor <= has_vendedor
            AND Vendedor.cdg_vendedor >= des_vendedor,
          EACH Fac_detalle OF Fac_header,
         FIRST Articulo OF Fac_detalle
          WHERE Articulo.cdg_articulo <= has_codigo
            AND Articulo.cdg_articulo >= des_codigo
                BREAK BY Vendedor.cdg_vendedor
                      BY Articulo.cdg_articulo
                      BY Cliente.cdg_cliente:
 
        tit_vendedor = "Vendedor: " + Vendedor.cdg_vendedor + " - " + Vendedor.nombre.
  
        VIEW FRAME frm-titulo.
        
        IF FIRST-OF(Articulo.cdg_articulo)
        THEN DO:

            IF det_sino
            THEN DO:
                 DISPLAY Articulo.cdg_articulo
                         Articulo.descripcion
                         Articulo.a_granel
                         WITH FRAME frm-listado-art.
                 DOWN 2 WITH FRAME frm-listado-art.
            END.

        END.

        IF FIRST-OF(Cliente.cdg_cliente)
        THEN DO:

            gastado_cli  = 0.
            cantidad_cli = 0.
            granel_cli   = 0.

         END.
                    
        PUT STREAM Seguimiento
            Vendedor.cdg_vendedor              ";"
            Fac_header.cdg_empresa             ";"
            Articulo.cdg_subclase              ";"
            Articulo.cdg_articulo              ";"
            Fac_header.tip_comprob             ";"
            Fac_header.prf_comprob             ";"
            Fac_header.nro_comprob             ";"
            Fac_detalle.cantidad SKIP.


        IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0
        THEN DO:
      
             ASSIGN
                cantidad_cli = cantidad_cli + Fac_detalle.cantidad
                granel_cli   = granel_cli   + Fac_detalle.granel
                gastado_cli  = gastado_cli  + Fac_detalle.subtotal_neto.
      
        END.
        ELSE DO:
      
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
                    cantidad_art = cantidad_art + cantidad_cli
                    granel_art   = granel_art   + granel_cli
                    gastado_art  = gastado_art  + gastado_cli
                    cantidad_cli = 0
                    granel_cli   = 0
                    gastado_cli  = 0.
    
        END.
    
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:
            IF det_sino 
            THEN DO:              
                  
                  UNDERLINE Cliente.cdg_cliente
                            Cliente.nom_cliente
                            cantidad_cli
                            granel_cli  
                            gastado_cli
                            precio_prom
                            WITH FRAME frm-listado-cli.
                  DOWN WITH FRAME frm-listado-cli.
        
                  precio_prom = ( IF Articulo.a_granel 
                                     THEN gastado_art / granel_art
                                     ELSE gastado_art / cantidad_art ).
        
       
                  DISPLAY  Articulo.cdg_articulo  @ Cliente.cdg_cliente
                           Articulo.descripcion   @ Cliente.nom_cliente
                           cantidad_art @ cantidad_cli
                           granel_art   @ granel_cli
                           gastado_art  @ gastado_cli
                           precio_prom
                           WITH FRAME frm-listado-cli.
                  DOWN 2 WITH FRAME frm-listado-cli.
            END.

            ASSIGN
                    cantidad_ven = cantidad_ven + cantidad_art
                    granel_ven   = granel_ven   + granel_art
                    gastado_ven  = gastado_ven  + gastado_art
                    cantidad_art = 0
                    granel_art   = 0
                    gastado_art  = 0.

        END.  

        IF LAST-OF(Vendedor.cdg_vendedor)
        THEN DO:
                  
            UNDERLINE Cliente.cdg_cliente
                      Cliente.nom_cliente
                      cantidad_cli
                      granel_cli  
                      gastado_cli
                      precio_prom
                      WITH FRAME frm-listado-cli.
            DOWN WITH FRAME frm-listado-cli.
  
            precio_prom = ( IF Articulo.a_granel 
                               THEN gastado_ven / granel_ven
                               ELSE gastado_ven / cantidad_ven ).
  
            DISPLAY                
                     cantidad_ven @ cantidad_cli
                     granel_ven   @ granel_cli
                     gastado_ven  @ gastado_cli
                     precio_prom
                     WITH FRAME frm-listado-cli.
            DOWN WITH FRAME frm-listado-cli.

            ASSIGN
                    cantidad_ven = 0
                    granel_ven   = 0
                    gastado_ven  = 0.

            IF NOT LAST(Vendedor.cdg_vendedor) THEN PAGE.

        END.  

  END. /* De los articulos   */

  OUTPUT CLOSE.
  OUTPUT STREAM Seguimiento CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.


