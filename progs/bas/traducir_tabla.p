/*=============================================================================================*/
/*                 TRADUCE UN CODIGO EN UNA DESCRIPCIÒN EN BASE A UNA TABLA                    */
/*=============================================================================================*/

DEFINE INPUT  PARAMETER v-nombre_tabla       AS CHARACTER INITIAL "Cliente".
DEFINE INPUT  PARAMETER v-campo_clave        AS CHARACTER INITIAL "cdg_cliente".
DEFINE INPUT  PARAMETER v-campo_descripcion  AS CHARACTER INITIAL "nom_cliente".
DEFINE INPUT  PARAMETER v-valor_clave        AS CHARACTER INITIAL "B00001".
DEFINE OUTPUT PARAMETER v-valor_descripcion  AS CHARACTER FORMAT "X(30)".

/*=============================================================================================*/
/*                                         VARIABLES                                           */
/*=============================================================================================*/

DEFINE VARIABLE fh           AS WIDGET-HANDLE EXTENT 200.
DEFINE VARIABLE qh           AS WIDGET-HANDLE.
DEFINE VARIABLE hTabla       AS WIDGET-HANDLE.
DEFINE VARIABLE i            AS INTEGER.
DEFINE VARIABLE i-cdg        AS INTEGER.
DEFINE VARIABLE i-dsc        AS INTEGER.

DEFINE VARIABLE v-predicado  AS CHARACTER.

/*=============================================================================================*/
/*                                     BLOQUE PRINCIPAL                                        */
/*=============================================================================================*/

CREATE QUERY qh.
CREATE BUFFER hTabla FOR TABLE v-nombre_tabla.
qh:SET-BUFFERS(hTabla:HANDLE). 

DO i = 1 TO hTabla:NUM-FIELDS:
    fh[i] = hTabla:BUFFER-FIELD(i).
    IF fh[i]:NAME = v-campo_clave       THEN i-cdg = i.
    IF fh[i]:NAME = v-campo_descripcion THEN i-dsc = i.
END.

IF v-valor_clave = ? 
    THEN v-valor_clave = "?".

v-predicado = "FOR EACH " 
              + v-nombre_tabla
              + " WHERE " 
              + v-campo_clave
              + " = " 
              + ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" )
              + v-valor_clave
              + ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" ).

v-valor_descripcion = ?.

qh:QUERY-PREPARE(v-predicado).
qh:QUERY-OPEN().
qh:GET-NEXT().
IF qh:QUERY-OFF-END THEN LEAVE.
v-valor_descripcion = fh[i-dsc]:BUFFER-VALUE.

qh:QUERY-CLOSE().
DELETE OBJECT qh.



