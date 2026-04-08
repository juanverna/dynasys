/*=================================================================================*/
/*                            DATOS DE CLIENTES X VENDEDOR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER has_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER des_zonag   LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER has_zonag   LIKE Zona_geografica.cdg_zonag.

/*=================================================================================*/
/*                            VARIABLES Y FRAMES                                   */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE ant_zonag   LIKE Zona_geografica.cdg_zonag.

DEFINE VARIABLE tot_vendr   AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_saldo   AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE t-credito   AS DECIMAL.
DEFINE VARIABLE t-debito    AS DECIMAL.

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

DEFINE VARIABLE linpag  AS INTEGER INITIAL 60.

DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Datos de Clientes por Vendedor/Zona" AT 58
  "Página:" AT 132 PAGE-NUMBER FORMAT ">>9" AT 140
  SKIP  
  fecha_lis
  tit_vendedor AT 58
  hora_lis AT 132
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código   Razón                          Número          Cn Nro      Dirección                 Localidad       Número de                       " SKIP
  "Cliente  Social                         C.U.I.T.       IVA Cob      de cobranza               de cobranza     Teléfono                        " SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  Cliente.nom_cliente FORMAT "X(30)"
  Cliente.cuit
  Cliente.cdg_condiva
  Cobrador.cdg_cobrador
  Domicilio.direccion FORMAT "X(25)"
  Domicilio.localidad FORMAT "X(15)" 
  Domicilio.telefono FORMAT "X(26)"
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
  
  {OPQRYVND.I}
  
  GET FIRST qry_vendedor.
  DO WHILE AVAILABLE Vendedor:
     RUN LISTAR.
     GET NEXT qry_vendedor.
  END.   
    
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).

END PROCEDURE.  

PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre +
                 " " + des_zonag + " <-> " + has_zonag.

  ASSIGN t-debito  = 0
         t-credito = 0
         tot_saldo = 0.

  ant_zonag = "".
  
  OPEN QUERY q_clientes 
       FOR EACH Cliente NO-LOCK OF Vendedor,
           FIRST Domicilio NO-LOCK OF Cliente 
                 WHERE Domicilio.cdg_zonag <= has_zonag
                   AND Domicilio.cdg_zonag >= des_zonag
                       BY Domicilio.cdg_zonag 
                       BY Cliente.nom_cliente.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

        VIEW FRAME frm-titulo.
           
        IF LINE-COUNTER >= linpag - 3 THEN PAGE.
    
        IF Domicilio.cdg_zonag <> ant_zonag
        THEN DO:
             FIND Zona_geografica OF Domicilio NO-LOCK.
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
                WITH FRAME frm-listado-cli.
        DOWN 1 WITH FRAME frm-listado-cli.
    
        ant_zonag = Domicilio.cdg_zonag.

        GET NEXT q_clientes.

  END.   
  PAGE.

END PROCEDURE.

