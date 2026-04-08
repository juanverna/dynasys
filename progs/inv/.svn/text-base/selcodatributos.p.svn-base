/*========================================================================================*/
/*                    SELECCIONA UNA SERIE DE CODIGOS DE Atributo                          */
/*========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER seleccion AS CHARACTER.

DEFINE VARIABLE disponibles     AS CHARACTER.
DEFINE VARIABLE elegidos        AS CHARACTER.

DEFINE VARIABLE j               AS INTEGER.

/*========================================================================================*/
/*                                     PROCESO                                            */
/*========================================================================================*/

disponibles = "".
elegidos = "".
FOR EACH Atributo BY Atributo.dsc_atributo:
    IF LOOKUP(Atributo.cdg_atributo,seleccion,",") = 0
         THEN disponibles = disponibles + "," + Atributo.dsc_atributo.
         ELSE elegidos = elegidos + "," + Atributo.dsc_atributo.
END.
disponibles = SUBSTRING(disponibles,2).
elegidos    = SUBSTRING(elegidos,2).

RUN d-selectar.w ( INPUT-OUTPUT elegidos, INPUT-OUTPUT disponibles, INPUT "Selección de Atributos" ).

seleccion = "".
DO j = 1 TO NUM-ENTRIES(elegidos,","):
    FIND Atributo WHERE Atributo.dsc_atributo = ENTRY(j,elegidos,",") NO-LOCK.
    seleccion = seleccion + "," + Atributo.cdg_atributo.
END.
seleccion = SUBSTRING(seleccion,2).
  
