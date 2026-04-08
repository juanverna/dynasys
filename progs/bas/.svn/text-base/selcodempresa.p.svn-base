/*========================================================================================*/
/*                    SELECCIONA UNA SERIE DE CODIGOS DE EMPRESA                          */
/*========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER seleccion AS CHARACTER.

DEFINE VARIABLE disponibles     AS CHARACTER.
DEFINE VARIABLE elegidos        AS CHARACTER.

DEFINE VARIABLE j               AS INTEGER.

/*========================================================================================*/
/*                                     PROCESO                                            */
/*========================================================================================*/

{findempresa.i}

disponibles = "".
elegidos = "".
FOR EACH Empresa WHERE CAN-DO(Usuario.lista_empresas,Empresa.cdg_empresa) BY Empresa.nombre:
    IF LOOKUP(Empresa.cdg_empresa,seleccion,",") = 0
         THEN disponibles = disponibles + "," + Empresa.nombre.
         ELSE elegidos = elegidos + "," + Empresa.nombre.
END.
disponibles = SUBSTRING(disponibles,2).
elegidos    = SUBSTRING(elegidos,2).

RUN d-selectar.w ( INPUT-OUTPUT elegidos, INPUT-OUTPUT disponibles, INPUT "Selección de Empresas" ).

seleccion = "".
DO j = 1 TO NUM-ENTRIES(elegidos,","):
    FIND Empresa WHERE Empresa.nombre = ENTRY(j,elegidos,",") NO-LOCK.
    seleccion = seleccion + "," + Empresa.cdg_empresa.
END.
seleccion = SUBSTRING(seleccion,2).
  
