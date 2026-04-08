/*=================================================================================*/
/*         EMITE UN LISTADO CON TODOS LOS CLIENTES DE UNA ZONA DETERMINADA         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_zonag        LIKE Domicilio.cdg_subclasezng.
DEFINE INPUT PARAMETER has_zonag        LIKE Domicilio.cdg_subclasezng.
DEFINE INPUT PARAMETER p-estado_cliente LIKE Cliente.cdg_estado.
DEFINE INPUT PARAMETER des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_vendedor     LIKE Vendedor.cdg_vendedor.

/*=================================================================================*/
/*                                  VARIABLES                                      */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

DEFINE VARIABLE linpag  AS INTEGER INITIAL 58.

DEFINE VARIABLE ultimo         AS LOGICAL.
DEFINE VARIABLE tit_vendedor   AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda    LIKE Moneda.descripcion.
DEFINE VARIABLE v-estado       AS CHARACTER INITIAL "xx".
DEFINE VARIABLE v-des_vendedor AS INTEGER.
DEFINE VARIABLE v-has_vendedor AS INTEGER.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Datos de Clientes por Zona / Vendedor" AT 73
  "Página:" AT 169 PAGE-NUMBER FORMAT ">>9" AT 177
  SKIP  
  fecha_lis
  tit_vendedor AT 73
  SKIP
  "Vendedores: " AT 73
  des_vendedor FORMAT "X(4)"
  " <-> "
  has_vendedor
  hora_lis AT 169
  SKIP(1)
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código      Razón                          Número          Cn      Dirección                       Localidad                  Número de                " SKIP
  "Cliente     Social                         C.U.I.T.       IVA      de cobranza                     de cobranza                Teléfono                 " SKIP
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 260 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  Cliente.cdg_estado
  Cliente.nom_cliente FORMAT "X(30)"
  Cliente.cuit
  Cliente.cdg_condiva
  Domicilio.direccion FORMAT "X(35)"
  Domicilio.localidad FORMAT "X(23)"
  Domicilio.telefono FORMAT "X(25)"
  WITH WIDTH 260 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-zona
  SKIP(1)
  SPACE(35)
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

FIND Vendedor WHERE Vendedor.cdg_vendedor = des_vendedor NO-ERROR.
IF AVAILABLE Vendedor THEN v-des_vendedor = Vendedor.nro_vendedor.

FIND Vendedor WHERE Vendedor.cdg_vendedor = has_vendedor NO-ERROR.
IF AVAILABLE Vendedor THEN v-has_vendedor = Vendedor.nro_vendedor.

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

      {findempresa.i}
      que_empresa = Empresa.nombre.

      {dirprinfile.i}

      tit_vendedor = "Zonas: " + des_zonag + " <-> " + has_zonag.

      FOR EACH Cliente WHERE p-estado_cliente = "" OR Cliente.cdg_estado = p-estado_cliente,
               FIRST Domicilio NO-LOCK OF Cliente 
                     WHERE Cliente.nro_vendedor >= v-des_vendedor
                       AND Cliente.nro_vendedor <= v-has_vendedor
                       AND Domicilio.cdg_subclasezng <= has_zonag
                       AND Domicilio.cdg_subclasezng >= des_zonag
                           BREAK BY Domicilio.cdg_subclasezng 
                                 BY Cliente.cdg_cliente:

          VIEW FRAME frm-titulo.

          IF LINE-COUNTER >= linpag - 3 THEN PAGE.

          IF FIRST-OF(Domicilio.cdg_subclasezng)
          THEN DO:
              FIND Zona_geografica WHERE Zona_geografica.cdg_zonag = Domicilio.cdg_subclasezng NO-LOCK.
              DISPLAY Zona_geografica.cdg_zonag 
                      Zona_geografica.nombre
                      WITH FRAME frm-listado-zona.
              DOWN 1 WITH FRAME frm-listado-zona.
          END.


          DISPLAY Cliente.cdg_cliente
                  Cliente.cdg_estado
                  Cliente.nom_cliente
                  Cliente.cuit
                  Cliente.cdg_condiva
                  Domicilio.direccion
                  Domicilio.localidad
                  Domicilio.telefono
                  WITH FRAME frm-listado-cli.
          DOWN 1 WITH FRAME frm-listado-cli.

      END.   

      OUTPUT CLOSE.

      RUN veresult.w ( INPUT arch_salida,
                       INPUT 22).
   
END PROCEDURE.  



 
