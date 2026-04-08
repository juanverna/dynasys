/*==========================================================================================================*/
/*              LISTADO DE TOTAL DE VENTAS POR ARTICULO. PUEDE INCLUIR CLIENTES O NO                        */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER         des_vendedor   LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER         has_vendedor   LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER         des_codigo     LIKE Familia_articulo.cdg_familia.
DEFINE INPUT PARAMETER         has_codigo     LIKE Familia_articulo.cdg_familia.
DEFINE INPUT PARAMETER         des_fecha      AS DATE.
DEFINE INPUT PARAMETER         has_fecha      AS DATE.
DEFINE INPUT PARAMETER         lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER         modo_importe   AS CHARACTER.

/*==========================================================================================================*/
/*                                          VARIABLES                                                       */
/*==========================================================================================================*/

DEFINE VARIABLE cero_sino      AS LOGICAL INITIAL NO.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE cantidad_ven   LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_ven     LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_ven    LIKE Acum_ventas.subtotal LABEL "Tot. articulo".

DEFINE VARIABLE cantidad_art   LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_art     LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_art    LIKE Acum_ventas.subtotal LABEL "Tot.Cliente".

DEFINE VARIABLE cantidad_gen   LIKE Acum_ventas.cantidad.
DEFINE VARIABLE granel_gen     LIKE Acum_ventas.granel.
DEFINE VARIABLE gastado_gen    LIKE Acum_ventas.subtotal LABEL "Tot. articulo".

DEFINE VARIABLE precio_prom    LIKE Acum_ventas.subtotal LABEL "Precio Promedio".

DEFINE VARIABLE x-importe      AS DECIMAL.
DEFINE VARIABLE tit_listado    AS CHARACTER FORMAT "X(70)".
DEFINE VARIABLE v-cdg_empresa  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE j              AS INTEGER.

{WGLISTAR.I}
{dfvarimp.i}

DEFINE TEMP-TABLE Acumulado
    FIELD cdg_vendedor LIKE Vendedor.cdg_vendedor
    FIELD cdg_familia  LIKE Familia_articulo.cdg_familia
    FIELD cdg_cliente  LIKE Cliente.cdg_cliente
    FIELD cantidad     LIKE Fac_detalle.cantidad
    FIELD granel       LIKE Fac_detalle.granel
    FIELD importe      LIKE Fac_detalle.subtotal_neto
    INDEX por_vendedor IS UNIQUE PRIMARY cdg_vendedor cdg_familia cdg_cliente.

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    tit_listado AT 55
    "Página:" AT 156 PAGE-NUMBER FORMAT ">>>9" AT 164
    SKIP
    fecha_lis
    "del" AT 55
    des_fecha
    "al"
    has_fecha
    hora_lis AT 156
    SKIP
    WITH WIDTH 230 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Vendedor.cdg_vendedor            COLUMN-LABEL "Código!Vendedor"
    Vendedor.nombre                  COLUMN-LABEL "Nombre!Vendedor"
    Familia_articulo.cdg_familia     COLUMN-LABEL "Código!Familiar"
    Familia_articulo.dsc_familia     COLUMN-LABEL "Descripción!Familia"
    Cliente.cdg_cliente              COLUMN-LABEL "Código!Cliente"
    Cliente.nom_cliente              COLUMN-LABEL "Razón!Social"
    Acumulado.cantidad               COLUMN-LABEL "Unidades!Vendidas"
    Acumulado.importe                COLUMN-LABEL "Total!Vendido" 
    WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE listar:

    IF modo_importe = "Ventas"
       THEN tit_listado = "Ranking de Ventas por Vendedor/Artículo".
       ELSE tit_listado = "Ranking de C.Marginal por Vendedor/Artículo".

    {dirprinfile.i}

    que_empresa = "Empresas: " + lista_empresas.

    ASSIGN

        gastado_ven  = 0
        cantidad_ven = 0
        granel_ven   = 0

        gastado_art  = 0
        cantidad_art = 0
        granel_art   = 0

        gastado_gen  = 0
        cantidad_gen = 0
        granel_gen   = 0.


    DO j = 1 TO NUM-ENTRIES(lista_empresas,","):
    
       v-cdg_empresa = ENTRY(j,lista_empresas).
       RUN acumular_empresa.
    
    END.
        
    FOR EACH Acumulado,
          FIRST Cliente OF Acumulado,
          FIRST Vendedor OF Acumulado,
          FIRST Familia_articulo WHERE Familia_articulo.cdg_familia = Acumulado.cdg_familia 
                BREAK BY Vendedor.cdg_vendedor
                      BY Familia_articulo.cdg_familia
                      BY Acumulado.importe DESCENDING:
        
        VIEW FRAME frm-titulo.

        precio_prom = Acumulado.importe / Acumulado.cantidad.

        DISPLAY Vendedor.cdg_vendedor          WHEN FIRST-OF(Vendedor.cdg_vendedor)
                Vendedor.nombre                WHEN FIRST-OF(Vendedor.cdg_vendedor)
                Familia_articulo.cdg_familia   WHEN FIRST-OF(Familia_articulo.cdg_familia)
                Familia_articulo.dsc_familia   WHEN FIRST-OF(Familia_articulo.cdg_familia)
                Cliente.cdg_cliente
                Cliente.nom_cliente
                Acumulado.cantidad
                Acumulado.importe
                WITH FRAME frm-listado.
 
        DOWN WITH FRAME frm-listado.

        ASSIGN
            cantidad_art = cantidad_art + Acumulado.cantidad
            gastado_art  = gastado_art  + Acumulado.importe.
        
                   
        IF LAST-OF(Familia_articulo.cdg_familia) /* Fin del cliente y se pidió un detalle */
        THEN DO:
    
             UNDERLINE Vendedor.cdg_vendedor
                       Vendedor.nombre
                       Familia_articulo.cdg_familia
                       Familia_articulo.dsc_familia
                       Cliente.cdg_cliente
                       Cliente.nom_cliente
                       Acumulado.cantidad
                       Acumulado.importe
                       WITH FRAME frm-listado.

             DISPLAY   "Total Familia" @ Cliente.nom_cliente
                       cantidad_art @ Acumulado.cantidad
                       gastado_art @ Acumulado.importe
                       WITH FRAME frm-listado.

             DOWN WITH FRAME frm-listado.

             UNDERLINE Vendedor.cdg_vendedor
                       Vendedor.nombre
                       Familia_articulo.cdg_familia
                       Familia_articulo.dsc_familia
                       Cliente.cdg_cliente
                       Cliente.nom_cliente
                       Acumulado.cantidad
                       Acumulado.importe
                       WITH FRAME frm-listado.

             ASSIGN
                       cantidad_ven = cantidad_ven + cantidad_art
                       gastado_ven  = gastado_ven  + gastado_art
                       cantidad_art = 0
                       gastado_art  = 0.

        END.
    
        IF LAST-OF(Vendedor.cdg_vendedor)
        THEN DO:
    
             UNDERLINE Vendedor.cdg_vendedor
                       Vendedor.nombre
                       Familia_articulo.cdg_familia
                       Familia_articulo.dsc_familia
                       Cliente.cdg_cliente
                       Cliente.nom_cliente
                       Acumulado.cantidad
                       Acumulado.importe
                       WITH FRAME frm-listado.

             DISPLAY   "Total Vendedor" @ Familia_articulo.dsc_familia
                       cantidad_ven @ Acumulado.cantidad
                       gastado_ven @ Acumulado.importe
                       WITH FRAME frm-listado.

             DOWN WITH FRAME frm-listado.

             UNDERLINE Vendedor.cdg_vendedor
                       Vendedor.nombre
                       Familia_articulo.cdg_familia
                       Familia_articulo.dsc_familia
                       Cliente.cdg_cliente
                       Cliente.nom_cliente
                       Acumulado.cantidad
                       Acumulado.importe
                       WITH FRAME frm-listado.

             ASSIGN
                       cantidad_gen = cantidad_gen + cantidad_ven
                       gastado_gen  = gastado_gen  + gastado_ven
                       cantidad_ven = 0
                       gastado_ven  = 0.

        END.

  END. /* De los articulos   */


  UNDERLINE Vendedor.cdg_vendedor
            Vendedor.nombre
            Familia_articulo.cdg_familia
            Familia_articulo.dsc_familia
            Cliente.cdg_cliente
            Cliente.nom_cliente
            Acumulado.cantidad
            Acumulado.importe
            WITH FRAME frm-listado.
    
  DISPLAY   "TOTAL GENERAL" @ Vendedor.nombre
            cantidad_gen @ Acumulado.cantidad
            gastado_gen @ Acumulado.importe
            WITH FRAME frm-listado.

  UNDERLINE Vendedor.cdg_vendedor
            Vendedor.nombre
            Familia_articulo.cdg_familia
            Familia_articulo.dsc_familia
            Cliente.cdg_cliente
            Cliente.nom_cliente
            Acumulado.cantidad
            Acumulado.importe
            WITH FRAME frm-listado.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

PROCEDURE acumular_empresa:

    FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = v-cdg_empresa
          AND Fac_header.fecha <= has_fecha
          AND Fac_header.fecha >= des_fecha
          AND NOT Fac_header.anulado,
          FIRST Cliente OF Fac_header,
          FIRST Vendedor OF Fac_header
          WHERE Vendedor.cdg_vendedor <= has_vendedor
            AND Vendedor.cdg_vendedor >= des_vendedor,
          EACH Fac_detalle OF Fac_header,
         FIRST Articulo OF Fac_detalle, 
         FIRST Familia_articulo OF Articulo
          WHERE Familia_articulo.cdg_familia <= has_codigo
            AND Familia_articulo.cdg_familia >= des_codigo:
        
        FIND Acumulado 
             WHERE Acumulado.cdg_vendedor = Vendedor.cdg_vendedor
               AND Acumulado.cdg_familia  = Familia_articulo.cdg_familia
               AND Acumulado.cdg_cliente  = Cliente.cdg_cliente
                   NO-ERROR.
                   
        IF NOT AVAILABLE Acumulado
        THEN DO:
             CREATE Acumulado.
             ASSIGN Acumulado.cdg_vendedor = Vendedor.cdg_vendedor
                    Acumulado.cdg_familia  = Familia_articulo.cdg_familia
                    Acumulado.cdg_cliente  = Cliente.cdg_cliente.
        END.           
        
        
        IF modo_importe = "Ventas"
           THEN x-importe = Fac_detalle.subtotal_neto.
           ELSE x-importe = Fac_detalle.cantidad * Fac_detalle.costo.
        
        IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0
        THEN DO:
      
             ASSIGN
                Acumulado.cantidad = Acumulado.cantidad + Fac_detalle.cantidad
                Acumulado.granel   = Acumulado.granel   + Fac_detalle.granel
                Acumulado.importe  = Acumulado.importe  + x-importe.
      
        END.
        ELSE DO:
      
             ASSIGN
                Acumulado.cantidad = Acumulado.cantidad - Fac_detalle.cantidad
                Acumulado.granel   = Acumulado.granel   - Fac_detalle.granel
                Acumulado.importe  = Acumulado.importe  - x-importe.
      
        END.         
        
    END.        

END PROCEDURE.
