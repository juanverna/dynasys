/*========================================================================================*/
/*                    SELECCIONA UNA SERIE DE CODIGOS DE SECTOR                           */
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
FOR EACH Area, FIRST Empresa OF Area WHERE CAN-DO(Usuario.lista_empresas,Empresa.cdg_empresa) BY Area.denominacion:
    IF LOOKUP(Area.cdg_Area,seleccion,",") = 0
         THEN disponibles = disponibles + "," + Area.denominacion.
         ELSE elegidos = elegidos + "," + Area.denominacion.
END.
disponibles = SUBSTRING(disponibles,2).
elegidos    = SUBSTRING(elegidos,2).

RUN d-selectar.w ( INPUT-OUTPUT elegidos, INPUT-OUTPUT disponibles, INPUT "Selección de Areas" ).

seleccion = "".
DO j = 1 TO NUM-ENTRIES(elegidos,","):
    FIND Area WHERE Area.denominacion = ENTRY(j,elegidos,",") NO-LOCK.
    seleccion = seleccion + "," + Area.cdg_area.
END.
seleccion = SUBSTRING(seleccion,2).
  
