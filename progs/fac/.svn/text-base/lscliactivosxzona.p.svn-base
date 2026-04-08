/*=================================================================================*/
/*                            DATOS DE CLIENTES X VENDEDOR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo    LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo    LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_zonag     LIKE Domicilio.cdg_subclasezng.
DEFINE INPUT PARAMETER has_zonag     LIKE Domicilio.cdg_subclasezng.
DEFINE INPUT PARAMETER a-que-fecha   AS DATE.
DEFINE INPUT PARAMETER fecha-ultimo  AS DATE.

/*=================================================================================*/
/*                            VARIABLES Y FRAMES                                   */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE ant_zonag            LIKE Domicilio.cdg_subclasezng.

DEFINE VARIABLE tot_vendr            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_saldo            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE t-clientes           AS INTEGER.
DEFINE VARIABLE v-clientes           AS INTEGER.
DEFINE VARIABLE z-clientes           AS INTEGER.

DEFINE VARIABLE linpag               AS INTEGER INITIAL 60.
DEFINE VARIABLE ver_por              AS INTEGER.
DEFINE VARIABLE por_cod              AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom              AS INTEGER INITIAL 0.

DEFINE VARIABLE ultimo               AS LOGICAL.
DEFINE VARIABLE tit_vendedor         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE tit_fechas           AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE desc_moneda          LIKE Moneda.descripcion.
DEFINE VARIABLE fch_ultima_compra    AS DATE.
DEFINE VARIABLE fch_ultimo_pago      AS DATE.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Clientes Activos x Vendedor/Zona" AT 58
  "Página:" AT 144 PAGE-NUMBER FORMAT ">>9" AT 152
  SKIP  
  fecha_lis
  tit_vendedor AT 58
  hora_lis AT 144
  tit_fechas AT 58
  hora_lis AT 144
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código   Razón                          Número          Cn Nro      Dirección                 Localidad       Número de                  Ultima   Ultimo  " SKIP
  "Cliente  Social                         C.U.I.T.       IVA Cob      de cobranza               de cobranza     Teléfono                   Compra   Pago    " SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 190 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  Cliente.nom_cliente FORMAT "X(30)"
  Cliente.cuit
  Cliente.cdg_condiva
  Cobrador.cdg_cobrador
  Domicilio.direccion FORMAT "X(25)"
  Domicilio.localidad FORMAT "X(15)" 
  Domicilio.telefono  FORMAT "X(26)"
  fch_ultima_compra
  fch_ultimo_pago
  WITH WIDTH 190 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-zona
  SKIP(1)
  SPACE(40)
  "----------<"
  Zona_geografica.cdg_zonag 
  SPACE(4)
  Zona_geografica.nombre 
  ">----------"  
  SKIP(1)
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  que_empresa = Empresa.nombre.

  {dirprinfile.i} 
  
  t-clientes = 0.
  FOR EACH Vendedor NO-LOCK 
      WHERE Vendedor.cdg_vendedor >= des_codigo
        AND Vendedor.cdg_vendedor <= has_codigo
            BREAK BY Vendedor.cdg_vendedor:
  
     RUN LISTAR.
     IF NOT LAST(Vendedor.cdg_vendedor) THEN PAGE.
  END.   

  UNDERLINE Cliente.nom_cliente
            WITH FRAME frm-listado-cli.
  DISPLAY "Total Activos:" + STRING(t-clientes,"ZZZZ9") @ Cliente.nom_cliente
            WITH FRAME frm-listado-cli.
    
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).

END PROCEDURE.  

PROCEDURE LISTAR:

  v-clientes = 0.
  z-clientes = 0.
  
  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre +
                 " " + des_zonag + " <-> " + has_zonag.

  tit_fechas   = "Referencia:" + STRING(a-que-fecha,"99/99/99") + " - " + 
                 "Ult.Movimiento:" + STRING(fecha-ultimo,"99/99/99").

  FOR EACH Cliente NO-LOCK OF Vendedor,
           FIRST Domicilio NO-LOCK OF Cliente 
                 WHERE Domicilio.cdg_subclasezng <= has_zonag
                   AND Domicilio.cdg_subclasezng >= des_zonag
                       BREAK BY Domicilio.cdg_subclasezng 
                             BY Cliente.nom_cliente.

        VIEW FRAME frm-titulo.

        fch_ultima_compra = ?.
        fch_ultimo_pago   = ?.
        
        FOR EACH Empresa:
            FOR EACH Cta_cte OF Cliente
                WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                  AND Cta_cte.fecha_emision >= fecha-ultimo
                  AND Cta_cte.fecha_emision <= a-que-fecha
                      BY Cta_cte.fecha_emision:
                
                IF Cta_cte.tip_comprob BEGINS "F"
                   THEN IF fch_ultima_compra < Cta_cte.fecha_emision OR
                           fch_ultima_compra = ?
                           THEN fch_ultima_compra = Cta_cte.fecha_emision.
                   
                IF Cta_cte.tip_comprob BEGINS "R"
                   THEN IF fch_ultimo_pago < Cta_cte.fecha_emision OR
                           fch_ultimo_pago = ?
                           THEN fch_ultimo_pago = Cta_cte.fecha_emision.

            END.
        END.
        
        
        IF fch_ultima_compra <> ? OR
           fch_ultimo_pago   <> ? 
        THEN DO:   

            z-clientes = z-clientes + 1.

        END.

        IF LINE-COUNTER >= linpag - 3 THEN PAGE.
    
        IF FIRST-OF(Domicilio.cdg_subclasezng)
        THEN DO:
             FIND Zona_geografica WHERE Zona_geografica.cdg_zonag = Domicilio.cdg_subclasezng NO-LOCK.
             DISPLAY Zona_geografica.cdg_zonag 
                     Zona_geografica.nombre
                     WITH FRAME frm-listado-zona.
             DOWN 1 WITH FRAME frm-listado-zona.
        END.
    
        FIND Cobrador OF Cliente NO-LOCK.

        DISPLAY Cliente.cdg_cliente
                Cliente.nom_cliente
                Cliente.cuit
                Cliente.cdg_condiva
                Cobrador.cdg_cobrador
                Domicilio.direccion
                Domicilio.localidad
                Domicilio.telefono
                fch_ultima_compra WHEN fch_ultima_compra <> ?
                fch_ultimo_pago   WHEN fch_ultimo_pago   <> ?
                WITH FRAME frm-listado-cli.
        DOWN 1 WITH FRAME frm-listado-cli.
    
        IF LAST-OF(Domicilio.cdg_subclasezng)
        THEN DO:
             UNDERLINE Cliente.nom_cliente
                       WITH FRAME frm-listado-cli.
             DISPLAY "Activos en la Zona:" + STRING(z-clientes,"ZZZZ9") @ Cliente.nom_cliente
                       WITH FRAME frm-listado-cli.
             DOWN 1 WITH FRAME frm-listado-cli.

             v-clientes = v-clientes +  z-clientes.
             z-clientes = 0.                                     
        END.

  END.   

  UNDERLINE Cliente.nom_cliente
            WITH FRAME frm-listado-cli.
  DISPLAY "Activos del Vendedor:" + STRING(v-clientes,"ZZZZ9") @ Cliente.nom_cliente
            WITH FRAME frm-listado-cli.
  t-clientes = t-clientes +  v-clientes.
  v-clientes = 0.                                     

END PROCEDURE.

