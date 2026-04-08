/*================================================================================================================*/
/*                  VALIDA LA ESTRUCTURA DEL CODIGO DE PRODUCTO CONTRA LA TABLA DE ATRIBUTOS                      */
/*================================================================================================================*/

DEFINE INPUT  PARAMETER p-codigo          LIKE Articulo.cdg_articulo.
DEFINE INPUT  PARAMETER p-cdg_tipoart     LIKE Articulo.cdg_tipoart.
DEFINE OUTPUT PARAMETER p-lista_atributos AS CHARACTER.
DEFINE OUTPUT PARAMETER p-errores         AS LOGICAL.

/*================================================================================================================*/
/*                                 DEFINICION DE VARIABLES LOCALES                                                */
/*================================================================================================================*/

DEFINE VARIABLE v-st_codigo       AS CHARACTER INITIAL "2:ETAPA,S:-,4:?,S:-,2:SABOR".
DEFINE VARIABLE j                 AS INTEGER.
DEFINE VARIABLE k-voy-por         AS INTEGER.
DEFINE VARIABLE nt-entradas       AS INTEGER.
DEFINE VARIABLE X                 AS INTEGER.
DEFINE VARIABLE v-entrada         AS CHARACTER.
DEFINE VARIABLE cuantos_chars     AS CHARACTER.
DEFINE VARIABLE que_chars         AS CHARACTER.
DEFINE VARIABLE v-cdg_atributo    AS CHARACTER.

DEFINE VARIABLE v-valida-long      AS INTEGER INITIAL 0.

{parlocales.i}

/*================================================================================================================*/
/*                                       PROCESO DE VALIDACIÓN                                                    */
/*================================================================================================================*/

ASSIGN
    p-errores = NO
    p-lista_atributos = "".

/* RUN getparametro.p (  INPUT  "STCODART",                                                                                           */
/*                       OUTPUT v-valor_c,                                                                                            */
/*                       OUTPUT v-valor_d,                                                                                            */
/*                       OUTPUT v-valor_l,                                                                                            */
/*                       OUTPUT v-valor_n,                                                                                            */
/*                       OUTPUT v-st_codigo ).                                                                                        */
/*                                                                                                                                    */
/*                                                                                                                                    */
/* IF v-st_codigo = ? OR v-st_codigo = ""                                                                                             */
/* THEN DO:                                                                                                                           */
/*     RETURN. /* No hay string, consecuentemente, no hay validacion de estructura */                                                 */
/* END.                                                                                                                               */
/* ELSE DO:                                                                                                                           */
/*     nt-entradas = NUM-ENTRIES(v-st_codigo,",").                                                                                    */
/*                                                                                                                                    */
/*     k-voy-por = 1.                                                                                                                 */
/*     DO j = 1 TO nt-entradas:                                                                                                       */
/*         v-entrada = ENTRY(j,v-st_codigo,",").                                                                                      */
/*         cuantos_chars = ENTRY(1,v-entrada,":").                                                                                    */
/*         que_chars     = ENTRY(2,v-entrada,":").                                                                                    */
/*         IF cuantos_chars = "S"                                                                                                     */
/*         THEN DO:                                                                                                                   */
/*              IF SUBSTRING(p-codigo,k-voy-por,1) <> que_chars                                                                       */
/*              THEN DO:                                                                                                              */
/*                   RUN ponmensj.p (INPUT "CDAR001").                                                                                */
/*                   p-errores = YES.                                                                                                 */
/*              END.                                                                                                                  */
/*              k-voy-por = k-voy-por + 1.                                                                                            */
/*         END.                                                                                                                       */
/*         ELSE DO:                                                                                                                   */
/*              IF que_chars = "?"                                                                                                    */
/*              THEN DO:                                                                                                              */
/*                   k-voy-por = k-voy-por + INTEGER(cuantos_chars).                                                                  */
/*              END.                                                                                                                  */
/*              ELSE DO:                                                                                                              */
/*                   FIND Tipoatributo WHERE Tipoatributo.cdg_tipoatributo = que_chars NO-LOCK NO-ERROR.                              */
/*                   IF NOT AVAILABLE Tipoatributo                                                                                    */
/*                   THEN DO:                                                                                                         */
/*                        RUN ponmensj.p (INPUT "CDAR002").                                                                           */
/*                        p-errores = YES.                                                                                            */
/*                   END.                                                                                                             */
/*                   ELSE DO:                                                                                                         */
/*                        v-cdg_atributo = SUBSTRING(p-codigo,k-voy-por,INTEGER(cuantos_chars)).                                      */
/*                        FIND Atributo OF Tipoatributo WHERE Atributo.cdg_atributo = v-cdg_atributo NO-LOCK NO-ERROR.                */
/*                        IF NOT AVAILABLE Atributo                                                                                   */
/*                        THEN DO:                                                                                                    */
/*                             MESSAGE "NO existe el atributo '" Tipoatributo.dsc_tipoatributo "' con código '" v-cdg_atributo "'"    */
/*                                     VIEW-AS ALERT-BOX MESSAGE TITLE "CDAR003".                                                     */
/*                             p-errores = YES.                                                                                       */
/*                        END.                                                                                                        */
/*                        ELSE DO:                                                                                                    */
/*                             p-lista_atributos = p-lista_atributos + "," + Atributo.cdg_tipoatributo + ":" + Atributo.cdg_atributo. */
/*                        END.                                                                                                        */
/*                   END.                                                                                                             */
/*                   k-voy-por = k-voy-por + INTEGER(cuantos_chars).                                                                  */
/*              END.                                                                                                                  */
/*         END.                                                                                                                       */
/*                                                                                                                                    */
/*     END.                                                                                                                           */
/*                                                                                                                                    */
/*     IF p-lista_atributos BEGINS "," THEN p-lista_atributos = SUBSTRING(p-lista_atributos,2).                                       */
/* END.                                                                                                                               */

FIND Tipo_articulo WHERE Tipo_articulo.cdg_tipoart = p-cdg_tipoart NO-LOCK NO-ERROR.

v-st_codigo = Tipo_articulo.validacion_codigo.

IF v-st_codigo = ? OR v-st_codigo = ""
 THEN DO:
     RETURN. /* No hay string, consecuentemente, no hay validacion de estructura */
END.
ELSE DO:
    nt-entradas = NUM-ENTRIES(v-st_codigo,",").

    k-voy-por = 1.
    DO j = 1 TO nt-entradas:
        v-entrada = ENTRY(j,v-st_codigo,",").
        cuantos_chars = ENTRY(1,v-entrada,":").
        que_chars     = ENTRY(2,v-entrada,":").

        IF cuantos_chars = "S"
        THEN DO:
             cuantos_chars = "1".
             IF SUBSTRING(p-codigo,k-voy-por,1) <> que_chars
             THEN DO:
                  RUN ponmensj.p (INPUT "CDAR001").
                  p-errores = YES.
                  RETURN.
             END.
             k-voy-por = k-voy-por + 1.
        END.
        ELSE DO:
            CASE que_chars:
                 WHEN "?"
                 THEN DO:
                      k-voy-por = k-voy-por + INTEGER(cuantos_chars).
                 END.
                 WHEN "#"
                 THEN DO:
                      DO X = 1 TO INTEGER(cuantos_chars):
                          IF LOOKUP(SUBSTRING(p-codigo,k-voy-por,1), "0,1,2,3,4,5,6,7,8,9") = 0 THEN DO:
                              RUN ponmensj.p (INPUT "CDAR001").
                              p-errores = YES.
                              RETURN.
                          END.
                          k-voy-por = k-voy-por + 1.
                      END.
                 END.
                 WHEN "&"
                 THEN DO:
                      DO X = 1 TO INTEGER(cuantos_chars):
                            IF NOT (ASC(SUBSTRING(p-codigo,k-voy-por,1)) >= 65 AND ASC(SUBSTRING(p-codigo,k-voy-por,1)) <= 90) 
                                  AND NOT (ASC(SUBSTRING(p-codigo,k-voy-por,1)) >= 97 AND ASC(SUBSTRING(p-codigo,k-voy-por,1)) <= 122) THEN DO:
                                RUN ponmensj.p (INPUT "CDAR001").
                                p-errores = YES.
                                RETURN.
                            END.
                            k-voy-por = k-voy-por + 1.
                      END.
                 END.
                 WHEN "$"
                 THEN DO:
                      DO X = 1 TO INTEGER(cuantos_chars):
                             IF NOT (ASC(SUBSTRING(p-codigo,k-voy-por,1)) >= 65 AND ASC(SUBSTRING(p-codigo,k-voy-por,1)) <= 91) 
                                 AND NOT (ASC(SUBSTRING(p-codigo,k-voy-por,1)) >= 97 AND ASC(SUBSTRING(p-codigo,k-voy-por,1)) <= 122)
                                 AND LOOKUP(SUBSTRING(p-codigo,k-voy-por,1), "0,1,2,3,4,5,6,7,8,9") = 0 THEN DO:
                                  RUN ponmensj.p (INPUT "CDAR001").
                                  p-errores = YES.
                                  RETURN.
                             END.
                             k-voy-por = k-voy-por + 1.
                      END.
                 END.
                 OTHERWISE DO:
                      FIND Tipoatributo WHERE Tipoatributo.cdg_tipoatributo = que_chars NO-LOCK NO-ERROR.
                      IF NOT AVAILABLE Tipoatributo
                      THEN DO:
                           RUN ponmensj.p (INPUT "CDAR002").
                           p-errores = YES.
                           RETURN.
                      END.
                      ELSE DO:
                           v-cdg_atributo = SUBSTRING(p-codigo,k-voy-por,INTEGER(cuantos_chars)).
                           FIND Atributo OF Tipoatributo WHERE Atributo.cdg_atributo = v-cdg_atributo NO-LOCK NO-ERROR.
                           IF NOT AVAILABLE Atributo
                           THEN DO:
                                MESSAGE "NO existe el atributo '" Tipoatributo.dsc_tipoatributo "' con código '" v-cdg_atributo "'"
                                        VIEW-AS ALERT-BOX MESSAGE TITLE "CDAR003".
                                p-errores = YES.
                                RETURN.
                           END.
                           ELSE DO:
                                p-lista_atributos = p-lista_atributos + "," + Atributo.cdg_tipoatributo + ":" + Atributo.cdg_atributo.
                           END.
                      END.
                      k-voy-por = k-voy-por + INTEGER(cuantos_chars).
                 END.
            END CASE.
        END.

        v-valida-long = v-valida-long + INTEGER(cuantos_chars).

    END.

    IF NOT v-valida-long = LENGTH(p-codigo) THEN DO:
          RUN ponmensj.p (INPUT "CDAR001").
          p-errores = YES.
          RETURN.
    END.

    IF p-lista_atributos BEGINS "," THEN p-lista_atributos = SUBSTRING(p-lista_atributos,2).
END.
