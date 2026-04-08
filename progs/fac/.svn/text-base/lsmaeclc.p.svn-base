  /*=================================================================================*/
/*                              MAESTRO DE CLIENTES                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.


/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/



{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Maestro de Clientes por código" AT 75
    "Página:" AT 153 PAGE-NUMBER FORMAT "9999" AT 161
    SKIP  
  
    WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Cliente.cdg_cliente                         COLUMN-LABEL "Código!Cliente"     
    Cliente.cdg_estado          FORMAT "X(02)"  COLUMN-LABEL "Es-!tado"     
    Cliente.nom_cliente         FORMAT "X(30)"  COLUMN-LABEL "Razón!Social"   
    Cliente.cuit                                COLUMN-LABEL "Cuit"
    Cliente.cdg_condiva                         COLUMN-LABEL "Cond!IVA"
    Condicion_impos.descripcion                 COLUMN-LABEL "Cond!IVA"
    Domicilio.nro_domicilio                     COLUMN-LABEL "Nro!Domicilio"
    Domicilio.direccion         FORMAT "X(30)"  COLUMN-LABEL "Dirección"
    Domicilio.localidad         FORMAT "X(20)"  COLUMN-LABEL "Localidad"
    Domicilio.telefono          FORMAT "X(30)"  COLUMN-LABEL "Telefonos"
    Vendedor.cdg_vendedor                       COLUMN-LABEL "Vendedor"
    WITH WIDTH 250 DOWN CENTERED USE-TEXT STREAM-IO.

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

    FOR EACH Domicilio,
            FIRST Cliente OF Domicilio,
            FIRST Provincia OF Domicilio,
            FIRST Vendedor OF Cliente,
            FIRST Condicion_impos OF Cliente
            WHERE Cliente.cdg_cliente >= des_codigo
            AND Cliente.cdg_cliente <= has_codigo
            BREAK BY Cliente.cdg_cliente
                  BY Domicilio.nro_domicilio:

       VIEW FRAME frm-titulo.

       DISPLAY Cliente.cdg_cliente     WHEN FIRST-OF(Cliente.cdg_cliente)          
               Cliente.cdg_estado      WHEN FIRST-OF(Cliente.cdg_cliente)
               Cliente.nom_cliente     WHEN FIRST-OF(Cliente.cdg_cliente)         
               Cliente.cuit            WHEN FIRST-OF(Cliente.cdg_cliente)
               Cliente.cdg_condiva     WHEN FIRST-OF(Cliente.cdg_cliente)
               Condicion_impos.descripcion 
               Domicilio.nro_domicilio
               Domicilio.direccion
               Domicilio.localidad
               Domicilio.telefono          
               Vendedor.cdg_vendedor       
               WITH FRAME frm-listado.
       DOWN WITH FRAME frm-listado.
       
    END.   
                           
OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).


END PROCEDURE.  


