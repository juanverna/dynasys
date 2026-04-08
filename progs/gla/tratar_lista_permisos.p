/*==============================================================================================*/
/*   GENERA UNA LISTA SEPARADA POR COMAS CON TODOS LOS SECTORES JERÁRQUICOS DE UNO DADO         */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-lista_sectores     AS CHARACTER.
DEFINE OUTPUT PARAMETER p-lista_permisos     AS CHARACTER.
DEFINE INPUT  PARAMETER p-operacion          AS CHARACTER.

/*==============================================================================================*/
/*                                         VARIABLES                                            */
/*==============================================================================================*/

DEFINE VARIABLE ls                           AS INTEGER.
DEFINE VARIABLE j-item                       AS INTEGER.
DEFINE VARIABLE k-sector                     AS INTEGER.
DEFINE VARIABLE x-voy_sector                 AS CHARACTER.
DEFINE VARIABLE x-voy_permiso                AS CHARACTER.

/*==============================================================================================*/
/*                                          PROCESOS                                            */
/*==============================================================================================*/

IF p-lista_sectores = "*"
THEN DO:
    p-lista_permisos = "*".
END.
ELSE DO:
    IF p-operacion = "UNIR"
    THEN DO:
        p-lista_permisos = "".
        DO k-sector = 1 TO NUM-ENTRIES(p-lista_sectores,","):
            x-voy_sector = ENTRY(k-sector,p-lista_sectores,",").
            x-voy_permiso = "".
            DO j-item = 1 TO NUM-ENTRIES(x-voy_sector,".") - 1:
                x-voy_permiso = IF j-item = 1 THEN ENTRY(1,x-voy_sector,".") ELSE x-voy_permiso + "." + ENTRY(j-item,x-voy_sector,".").
                IF LOOKUP(x-voy_permiso,p-lista_permisos,",") = 0
                    THEN p-lista_permisos = p-lista_permisos + "," + x-voy_permiso.
            END.
        END.
        p-lista_permisos = SUBSTRING(p-lista_permisos,2).
        p-lista_permisos = p-lista_sectores + ",|," + p-lista_permisos.        
        p-lista_permisos = REPLACE(p-lista_permisos,",,",",").
    END.
    ELSE DO:
        p-lista_permisos = ENTRY(1,REPLACE(p-lista_sectores,",|,","|"),"|").
        /*
        p-lista_permisos = ENTRY(1,p-lista_sectores,"|").
        ls = LENGTH(p-lista_permisos).
        IF SUBSTRING(p-lista_permisos,ls,1) = ","
            THEN p-lista_permisos =  SUBSTRING(v-lista_sectores,1,ls - 1).
        */    
    END.
END.







