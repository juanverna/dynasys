/******************************************************************************/
/*                                                                            */
/*       MODIFICA O ELIMINA LA LISTA DE SECTORES DE LOS ARTICULOS             */
/*                                                                            */ 
/******************************************************************************/

DEFINE INPUT PARAMETER p-add_del        AS CHARACTER FORMAT "X(3)".
DEFINE INPUT PARAMETER des_articulo     AS CHARACTER.
DEFINE INPUT PARAMETER has_articulo     AS CHARACTER.
DEFINE INPUT PARAMETER p-lista_sectores AS CHARACTER.

DEFINE VARIABLE v-lista_final AS CHARACTER.
DEFINE VARIABLE j             AS INTEGER.
DEFINE VARIABLE v-sectores    AS CHARACTER.

{findempresa.i}

FOR EACH Articulo 
    WHERE CAN-DO(Articulo.lista_empresas, Empresa.cdg_empresa)
      AND Articulo.cdg_articulo >= des_articulo
      AND Articulo.cdg_articulo <= has_articulo EXCLUSIVE-LOCK:
          
          v-sectores = SUBSTRING(ENTRY(1,Articulo.lista_sectores,"|"),1,INTEGER(LENGTH(ENTRY(1,Articulo.lista_sectores,"|")) - 1)).
          v-lista_final = "".

          DO j = 1 TO NUM-ENTRIES(v-sectores, ","):

               IF LOOKUP(ENTRY(j, v-sectores, ","), p-lista_sectores) = 0
                   THEN v-lista_final = v-lista_final + "," + ENTRY(j, v-sectores, ",").
          END.

          IF p-add_del = "ADD"
                THEN v-lista_final = v-lista_final + "," + p-lista_sectores.
          
          v-lista_final = SUBSTRING(v-lista_final, 2).

          RUN tratar_lista_permisos.p ( INPUT v-lista_final, OUTPUT Articulo.lista_sectores, INPUT "UNIR" ).

END.

