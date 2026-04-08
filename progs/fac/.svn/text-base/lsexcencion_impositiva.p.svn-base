/*=================================================================================================================*/
/*                                 Listado de Excenciones Impositivas de Clientes                                  */
/*=================================================================================================================*/

DEFINE INPUT PARAMETER des_codigo LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo LIKE Cliente.cdg_cliente.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Excenciones Impositivas por Cliente" AT 80
    "Página:" AT 154 PAGE-NUMBER FORMAT ">>>9" AT 161
    SKIP  
    fecha_lis
    "del" AT 80
    des_codigo
    "al"
    has_codigo
    hora_lis AT 154
    SKIP (1) 
    WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado  
    Cliente.cdg_cliente                  COLUMN-LABEL "Código!Cliente"
    Cliente.nom_cliente                  COLUMN-LABEL "Nombre!Cliente"
    Condicion_impos.cdg_condiva          COLUMN-LABEL "Código!Condición"
    Condicion_impos.descripcion          COLUMN-LABEL "Condición!Impositiva"
    Impuesto.cdg_impuesto                COLUMN-LABEL "Código!Impuesto"
    Impuesto.nombre                      COLUMN-LABEL "Descripciòn!Impuesto"
    Cliente_excencion.prc_excencion      COLUMN-LABEL "Por-!centaje"
    Cliente_excencion.fch_desde          COLUMN-LABEL "Desde!Fecha" FORMAT "99/99/9999"
    Cliente_excencion.fch_hasta          COLUMN-LABEL "Hasta!Fecha" FORMAT "99/99/9999"  
    Cliente_excencion.fch_boletin        COLUMN-LABEL "Fecha!Boletín" FORMAT "99/99/9999"
    WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO.


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

  
      FOR EACH Cliente WHERE Cliente.cdg_cliente <= has_codigo
                         AND Cliente.cdg_cliente >= des_codigo,
          FIRST Condicion_impos OF Cliente,
          EACH  Cliente_excencion OF Cliente, FIRST Impuesto OF Cliente_excencion:

           VIEW FRAME frm-titulo.
            
           DISPLAY 
               Cliente.cdg_cliente                  
               Cliente.nom_cliente                  
               Condicion_impos.cdg_condiva        
               Condicion_impos.descripcion          
               Impuesto.cdg_impuesto
               Impuesto.nombre
               Cliente_excencion.prc_excencion      
               Cliente_excencion.fch_desde          
               Cliente_excencion.fch_hasta          
               Cliente_excencion.fch_boletin
               WITH FRAME frm-listado.
           DOWN WITH FRAME frm-listado.
      END.

END PROCEDURE.  

