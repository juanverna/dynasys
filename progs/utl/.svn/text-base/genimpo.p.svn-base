/*=================================================================================*/
/*                                                                                 */
/*      GENERACION DE PROGRAMAS DE IMPORTACION EN BASE A DATOS DEL DICCIONARIO     */
/*                                                                                 */
/*=================================================================================*/

DEFINE VARIABLE que_tabla   LIKE _FILE._FILE-NAME LABEL "Tabla:".
DEFINE VARIABLE ant_tabla   LIKE _FILE._FILE-NAME LABEL "Tabla:".
DEFINE VARIABLE que_numero  LIKE X_Pares.orden.
DEFINE VARIABLE linea       AS CHARACTER.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE sino        AS LOGICAL.


SESSION:DATA-ENTRY-RETURN = YES.

DEFINE BUTTON btn_ordenar
       LABEL "&Ordenar"
       SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_numerar
       LABEL "&Numerar"
       SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_generar
       LABEL "&Generar"
       SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_asignar
       LABEL "&Asignar"
       SIZE 10 BY 1 FONT 4.

DEFINE QUERY qry_pares FOR X_Pares .
DEFINE BROWSE brw_pares QUERY qry_pares 
       DISPLAY X_Pares.orden COLUMN-LABEL "Or!den"
               X_Pares.par_campo COLUMN-LABEL "Nombre!Campo"
               X_Pares.tipo_dato  COLUMN-LABEL "Dato!Tipo"
               X_Pares.es_clave   COLUMN-LABEL "Es Clave!Maestra"
               X_Pares.valor_si 
               X_Pares.par_variable
               X_Pares.des_columna
               X_Pares.has_columna
       ENABLE  X_Pares.orden
               X_Pares.par_campo
               X_Pares.tipo_dato 
               X_Pares.es_clave
               X_Pares.valor_si
               X_Pares.par_variable
               X_Pares.des_columna
               X_Pares.has_columna
               WITH 10 DOWN SEPARATORS FONT 4 TITLE "Campos de la tabla a importar".

DEFINE QUERY qry_maestras FOR X_Maestras.
DEFINE BROWSE brw_maestras QUERY qry_maestras 
       DISPLAY X_Maestras.orden COLUMN-LABEL "Or!den"
               X_Maestras.maestra  COLUMN-LABEL "Nombre de!la Tabla"
               X_Maestras.par_campo COLUMN-LABEL "Nombre del!campo a usar"
               X_Maestras.tipo_dato COLUMN-LABEL "El campo!es de tipo"
               X_Maestras.par_variable COLUMN-LABEL "Relacionar con!la variable"
               X_Maestras.relaciona
       ENABLE  X_Maestras.orden
               X_Maestras.maestra 
               X_Maestras.par_campo
               X_Maestras.tipo_dato
               X_Maestras.par_variable
               X_Maestras.relaciona
               WITH 5 DOWN SEPARATORS FONT 4 TITLE "Tablas maestras contra las que se valida integridad" .

FORM 
     SKIP(0.2)
     btn_ordenar AT 12
     btn_numerar btn_generar btn_asignar
     SKIP(0.2)
     que_tabla COLON 10  
     X_Programa.secuencia
     X_Programa.numerar     
     SKIP 
     X_Programa.directorio COLON 10 
     SKIP
     X_Programa.nom_programa COLON 10 
     X_Programa.tipo_validacion
     SKIP
     X_Programa.entrada COLON 10  
     X_Programa.formato_entrada
     SKIP(0.2)
     brw_maestras AT 1
     SKIP(0.2)
     brw_pares AT 1
     WITH FRAME b THREE-D VIEW-AS DIALOG-BOX FONT 4 
          SIDE-LABELS TITLE "Generacion de programa" WIDTH 110.

/*=====================================================================================*/
/*                                        TRIGGERS                                     */
/*=====================================================================================*/


ON ENTRY OF que_tabla IN FRAME b
DO:
   ant_tabla = que_tabla.
END.
   
ON RETURN OF que_tabla IN FRAME b
DO:

   ASSIGN que_tabla.            
   IF que_tabla = "" OR que_tabla = ant_tabla THEN RETURN.

   que_tabla = CAPS(SUBSTRING(que_tabla,1,1)) + LC(SUBSTRING(que_tabla,2)).
   DISPLAY que_tabla WITH FRAME b.
   FIND FIRST _FILE WHERE _FILE._FILE-NAME = que_tabla NO-ERROR.
   IF AVAILABLE _FILE
   THEN DO:
      IF NOT CAN-FIND(FIRST X_Pares WHERE X_Pares.par_tabla = que_tabla)
      THEN DO:

         CREATE X_Programa.
         ASSIGN 
                X_Programa.par_tabla       = que_tabla
                X_Programa.tipo_validacion = "A".

         j = 0.
         FOR EACH _FIELD OF _FILE:

             CREATE X_Pares.
             ASSIGN 
                    j = j + 10
                    X_Pares.par_tabla = que_tabla
                    X_Pares.orden     = j
                    X_Pares.par_campo = _FIELD._FIELD-NAME
                    X_Pares.tipo_dato = _FIELD._DATA-TYPE.
  
             CASE  X_Pares.tipo_dato:
               WHEN "character"
                 THEN DO:
                   X_Pares.par_variable = X_Pares.par_campo. 
                 END.
               WHEN "integer"
                 THEN DO:
                   X_Pares.par_variable = X_Pares.par_campo. 
                 END.
               WHEN "logical"
                 THEN DO:
                   X_Pares.par_variable = X_Pares.par_campo. 
                 END.
               WHEN "decimal"
                 THEN DO:
                   X_Pares.par_variable = X_Pares.par_campo. 
                 END.
               WHEN "date"
                 THEN DO:
                   X_Pares.par_variable = X_Pares.par_campo. 
                 END.
             END CASE.                        
         END.  

      END.              
      ELSE DO:
         FIND FIRST X_Programa WHERE X_Programa.par_tabla = que_tabla EXCLUSIVE-LOCK.
      END.   
      ENABLE ALL WITH FRAME b.
      DISABLE que_tabla WITH FRAME b.
      DISPLAY X_Programa.tipo_validacion
              X_Programa.nom_programa
              X_Programa.entrada
              X_Programa.secuencia
              X_Programa.numerar
              X_Programa.formato_entrada
              X_Programa.directorio
              WITH FRAME b.
      RUN ABRE_QUERY.
   END.
   ELSE DO:
      MESSAGE "No se encuentra la tabla indicada"
               VIEW-AS ALERT-BOX ERROR TITLE "Error de datos".
      RETURN NO-APPLY.            
   END.
   
END.

ON LEAVE OF X_Programa.numerar IN FRAME b
DO:
   ASSIGN X_Programa.numerar.
END.
   
ON CHOOSE OF btn_ordenar IN FRAME b
DO:
   RUN ABRE_QUERY.
END.

ON CHOOSE OF btn_numerar IN FRAME b
DO:

   IF NUM-ENTRIES(X_Programa.numerar,",") = 1
      THEN j = 0.
      ELSE j = INTEGER(ENTRY(2,X_Programa.numerar,",")) - 
               INTEGER(ENTRY(1,X_Programa.numerar,",")).

   GET FIRST qry_pares.
   DO WHILE AVAILABLE X_Pares:
 
      CASE  X_Pares.tipo_dato:
        WHEN ""
          THEN DO:
               j = j + INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "character"
          THEN DO:
               j = j + INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "integer"
          THEN DO:
               j = j + INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "logical"
          THEN DO:
               j = j + INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "decimal"
          THEN DO:
               j = j + 2 * INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "date"
          THEN DO:
               j = j + 3 * INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
      END CASE.    

      GET NEXT qry_pares.

   END.   

   GET LAST qry_pares.
   DO WHILE AVAILABLE X_Pares:

      X_Pares.orden = j.
      CASE  X_Pares.tipo_dato:
        WHEN ""
          THEN DO:
               j = j - INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "character"
          THEN DO:
               j = j - INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "integer"
          THEN DO:
               j = j - INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "logical"
          THEN DO:
               j = j - INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "decimal"
          THEN DO:
               j = j - 2 * INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
        WHEN "date"
          THEN DO:
               j = j - 3 * INTEGER(ENTRY(1,X_Programa.numerar,",")).
          END.
      END CASE.    
      GET PREV qry_pares.

   END.   
   RUN ABRE_QUERY.

END.

ON CHOOSE OF btn_generar IN FRAME b
DO:
   RUN GENERAR_PROGRAMA.
END.

ON CHOOSE OF btn_asignar IN FRAME b
DO:
   ASSIGN FRAME b X_Programa.nom_programa
                  X_Programa.tipo_validacion
                  X_Programa.entrada
                  X_Programa.secuencia
                  X_Programa.numerar
                  X_Programa.formato_entrada
                  X_Programa.directorio.
END.


ON INSERT OF brw_pares
DO:
   que_numero = X_Pares.orden.
   CREATE X_Pares.
   ASSIGN
          X_Pares.orden       = que_numero - 1
          X_Pares.par_tabla   = que_tabla.
   RUN ABRE_QUERY.
END.      

ON DEL OF brw_pares
DO:
   sino = NO.
   MESSAGE "Se dispone a ELIMINAR un campo del proceso de importacion. Confirma?"
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "CUIDADO!!!!" SET sino.
   FIND CURRENT X_Pares EXCLUSIVE-LOCK.
   DELETE X_Pares.
   RUN ABRE_QUERY.
END.      

ON INSERT OF brw_maestras
DO:
   CREATE X_Maestras.
   ASSIGN
          X_Maestras.par_tabla   = que_tabla.
   RUN ABRE_QUERY.

END.      

ON DEL OF brw_maestras
DO:
   FIND CURRENT X_Maestras EXCLUSIVE-LOCK.
   DELETE X_Maestras.
   RUN ABRE_QUERY.
END.      

/*=====================================================================================*/
/*                          TRANSACCION DE INGRESO DE DATOS                            */
/*=====================================================================================*/

ENABLE que_tabla
       WITH FRAME b.
WAIT-FOR F2 OF FRAME b FOCUS que_tabla.

/*=====================================================================================*/
/*                                   PROCEDIMIENTOS                                    */
/*=====================================================================================*/

PROCEDURE MOSTRAR:

   DEFINE INPUT PARAMETER l AS CHARACTER FORMAT "X(256)".

   PUT l.
   PUT SKIP.
   
END PROCEDURE.   

PROCEDURE ABRE_QUERY:

   OPEN QUERY qry_pares FOR EACH X_Pares EXCLUSIVE-LOCK
                            WHERE X_Pares.par_tabla = que_tabla BY X_Pares.orden.

   OPEN QUERY qry_maestras FOR EACH X_Maestras EXCLUSIVE-LOCK
                            WHERE X_Maestras.par_tabla = que_tabla 
                            BY X_Maestras.par_tabla BY X_Maestras.orden.

END PROCEDURE.   

PROCEDURE GENERAR_PROGRAMA:

  ASSIGN FRAME b X_Programa.nom_programa
                 X_Programa.tipo_validacion
                 X_Programa.entrada
                 X_Programa.secuencia
                 X_Programa.numerar
                 X_Programa.formato_entrada.

  DISPLAY "Generando..." X_Programa.nom_programa NO-LABEL
  WITH FRAME xxx VIEW-AS DIALOG-BOX THREE-D.

  OUTPUT TO VALUE(X_Programa.directorio + "\" + X_Programa.nom_programa).

  RUN MOSTRAR ( "DEFINE VARIABLE c_secuen AS INTEGER NO-UNDO." ).  /* Por si hay secuencia */
  RUN MOSTRAR ( "" ).

            /*  Genera las definiciones de variables de importacion */

  FOR EACH X_Pares WHERE X_Pares.par_tabla = que_tabla
                     AND X_Pares.par_variable <> "" 
                     AND X_Pares.par_campo <> "^"
                   BREAK BY X_Pares.orden:

      IF X_Pares.par_campo = "-"
      THEN DO:
         RUN DEFINIR_VAR ( "v_" + X_Pares.par_variable ). 
      END.
      ELSE DO:   

         CASE  X_Pares.tipo_dato:
           WHEN "character"
             THEN DO:
                 RUN DEFINIR_VAR ( "v_" + X_Pares.par_campo ). 
             END.
           WHEN "integer"
             THEN DO:
                 RUN DEFINIR_VAR ( "v_" + X_Pares.par_campo ). 
             END.
           WHEN "logical"
             THEN DO:
                 RUN DEFINIR_VAR ( "v_" + X_Pares.par_campo ). 
             END.
           WHEN "decimal"
             THEN DO:
                 RUN DEFINIR_VAR ( "v_n_" + X_Pares.par_campo ). 
                 RUN DEFINIR_VAR ( "v_s_" + X_Pares.par_campo ). 
             END.
           WHEN "date"
             THEN DO:
                 RUN DEFINIR_VAR ( "v_aa_" + X_Pares.par_campo ). 
                 RUN DEFINIR_VAR ( "v_mm_" + X_Pares.par_campo ). 
                 RUN DEFINIR_VAR ( "v_dd_" + X_Pares.par_campo ). 
             END.
         END CASE.    
      END.   
  END.   
  RUN MOSTRAR ( "" ).

             /* Genera el comienzo del lazo y sentencia de importacion */

  RUN MOSTRAR ( "INPUT FROM '" + X_Programa.directorio + "\" + X_Programa.entrada + "'.").
  RUN MOSTRAR ( "REPEAT:").
  RUN MOSTRAR ( "   IMPORT DELIMITER ' ' ").

  FOR EACH X_Pares WHERE X_Pares.par_tabla = que_tabla
                     AND X_Pares.par_variable <> "" BREAK BY X_Pares.orden :

      IF X_Pares.par_campo = "-"
      THEN DO:
         RUN MOSTRAR ( "          v_" + X_Pares.par_variable  ). 
      END.
      ELSE DO:   

         IF X_Pares.par_campo = "^"
         THEN DO:
            RUN MOSTRAR ( "          ^" ). 
         END.

         ELSE DO:

            CASE  X_Pares.tipo_dato:
              WHEN "character"
                THEN DO:
                    RUN MOSTRAR ( "          v_" + X_Pares.par_campo  ). 
                END.
              WHEN "integer"
                THEN DO:
                    RUN MOSTRAR ( "          v_" + X_Pares.par_campo  ). 
                END.
              WHEN "logical"
                THEN DO:
                    RUN MOSTRAR ( "          v_" + X_Pares.par_campo  ). 
                END.
              WHEN "decimal"
                THEN DO:
                    RUN MOSTRAR ( "          v_n_" + X_Pares.par_campo  ). 
                    RUN MOSTRAR ( "          v_s_" + X_Pares.par_campo  ). 
                END.
              WHEN "date"
                THEN DO:
                    RUN MOSTRAR ( "          v_aa_" + X_Pares.par_campo  ). 
                    RUN MOSTRAR ( "          v_mm_" + X_Pares.par_campo  ). 
                    RUN MOSTRAR ( "          v_dd_" + X_Pares.par_campo  ). 
                END.
            END CASE.    
            
         END.   

      END.   

  END.   
  RUN MOSTRAR ( "          .").
  RUN MOSTRAR ( "" ).

            /* Si hay maestro asociado, genera FIND de cada maestro */

  FOR EACH X_Maestras WHERE X_Maestras.par_tabla = que_tabla
                        AND NOT X_Maestras.relaciona
                            BREAK BY X_Maestras.maestra:
      
      IF FIRST-OF(X_Maestras.maestra)
      THEN DO:
         RUN MOSTRAR ( "" ).
         RUN MOSTRAR ( "   FIND FIRST " + X_Maestras.maestra ).
      END.

      linea = X_Maestras.maestra + "." + X_Maestras.par_campo.
      linea = linea + FILL(" ",40 - LENGTH(linea )) + "= ".
      CASE X_Maestras.tipo_dato:
         WHEN "character"  THEN linea = linea + "v_" + X_Maestras.par_variable.
         WHEN "integer"    THEN linea = linea + "INTEGER(v_" + X_Maestras.par_variable + ")".
      END CASE.        
      IF FIRST-OF(X_Maestras.maestra) THEN linea = "        WHERE " + linea.
                                      ELSE linea = "          AND " + linea.

      RUN MOSTRAR ( linea ).

      IF LAST-OF(X_Maestras.maestra)
      THEN DO:
         RUN MOSTRAR ( "              NO-LOCK.").
         RUN MOSTRAR ( "" ).
      END.   

  END.

            /* Genera creacion de registro y asignacion de VARIABLEs */

  IF X_Programa.tipo_validacion = "A"
     THEN RUN MOSTRAR ( "   CREATE " + que_tabla + ".").
     ELSE RUN PONER_VALIDACION.
  RUN MOSTRAR ( "   ASSIGN ").

  IF X_Programa.secuencia <> ""
  THEN DO:
      linea = FILL(" ",10) + "c_secuen".
      linea = linea + FILL(" ",40 - LENGTH(linea )) + "= c_secuen + 1".
      RUN MOSTRAR ( linea ).
  END.

  FOR EACH X_Pares 
      WHERE X_Pares.par_tabla = que_tabla
        AND X_Pares.par_variable <> "" 
        AND X_Pares.tipo_dato <> "date"
        AND X_Pares.par_campo <> "-" 
        AND X_Pares.par_campo <> "^"
        BREAK BY X_Pares.par_variable :
  
      linea = FILL(" ",10) + que_tabla + "." + X_Pares.par_campo.
      linea = linea + FILL(" ",40 - LENGTH(linea )) + "= ".
      CASE X_Pares.tipo_dato:
         WHEN "character"  
              THEN linea = linea + "v_" + X_Pares.par_campo.
         WHEN "logical"  
              THEN linea = linea + "( v_" + X_Pares.par_campo + " = '" + X_Pares.valor_si + "' )".
         WHEN "integer"    
              THEN linea = linea + "INTEGER(v_" + X_Pares.par_campo + ")".
         WHEN "decimal"    
              THEN linea = linea + 
                   "IF v_s_" + X_Pares.par_campo + " = '+' THEN " + 
                   "DECIMAL(v_n_" + X_Pares.par_campo +  
                   ") / 100 ELSE DECIMAL(v_n_" + X_Pares.par_campo + ") * ( -1 ) / 100".                                 
      END CASE.        
      RUN MOSTRAR ( linea ).
  
  END.

  FOR EACH X_Maestras WHERE X_Maestras.par_tabla = que_tabla
                        AND X_Maestras.relaciona
                            BREAK BY X_Maestras.maestra:
      
      linea = FILL(" ",10) + que_tabla + "." + X_Maestras.par_campo.
      linea = linea + FILL(" ",40 - LENGTH(linea )) + "= ".
      linea = linea + X_Maestras.maestra + "." + X_Maestras.par_campo.
      RUN MOSTRAR ( linea ).     

  END.

  IF X_Programa.secuencia <> ""
  THEN DO:
      linea = FILL(" ",10) + que_tabla + "." + X_Programa.secuencia.
      linea = linea + FILL(" ",40 - LENGTH(linea )) + "= c_secuen".
      RUN MOSTRAR ( linea ).
  END.

  RUN MOSTRAR ( FILL(" ",10) + "." ).
  RUN MOSTRAR ( "" ).

                /* Genera el final del ciclo de REPEAT */

  FOR EACH X_Pares 
      WHERE X_Pares.par_tabla = que_tabla
        AND X_Pares.par_variable <> "" 
        AND X_Pares.tipo_dato = "date"
        BREAK BY X_Pares.par_variable :
  
      linea = "   IF INTEGER(v_dd_" + X_Pares.par_campo + ") <> 0 ".
      RUN MOSTRAR ( linea ).
      linea = "      THEN " +
          " RUN CONVERTIR_FECHA ( INPUT v_dd_" + X_Pares.par_campo + 
                               ", INPUT v_mm_" + X_Pares.par_campo + 
                               ", INPUT v_aa_" + X_Pares.par_campo + 
                               ", OUTPUT " + que_tabla + "." + X_Pares.par_campo + 
                               ", INPUT '" + X_Pares.par_campo + "' ).".
      RUN MOSTRAR ( linea ).
 
  END.                

  RUN MOSTRAR ( "" ).

               /* Genera el final del programa */

  RUN MOSTRAR ( "END.").
  RUN MOSTRAR ( "").
  RUN MOSTRAR ( "INPUT CLOSE.").  
  RUN MOSTRAR ( "").
  RUN MOSTRAR ( "~{CNVFECHA.I~}").

  OUTPUT CLOSE.
  HIDE FRAME xxx NO-PAUSE.
  
END PROCEDURE.  

PROCEDURE PONER_VALIDACION:

  RUN MOSTRAR ( "").
  RUN MOSTRAR ( "   FIND FIRST " + que_tabla).
  FOR EACH X_Pares WHERE X_Pares.par_tabla = que_tabla
                     AND X_Pares.es_clave BREAK BY X_Pares.par_campo:      

      IF FIRST(X_Pares.par_campo)
         THEN linea = FILL(" ",15) + "WHERE " + que_tabla + "." + X_Pares.par_campo.
         ELSE linea = FILL(" ",15) + "  AND " + que_tabla + "." + X_Pares.par_campo.

      linea = linea + FILL(" ",40 - LENGTH(linea )) + " = ".

      CASE X_Pares.tipo_dato:
           WHEN "character"  THEN linea = linea + "v_" + X_Pares.par_variable.
           WHEN "integer"    THEN linea = linea + "INTEGER(v_" + X_Pares.par_variable + ")".
           WHEN "decimal"    THEN linea = linea + "DECIMAL(v_" + X_Pares.par_variable + ")".
           WHEN "date"       THEN linea = linea + "DATE(v_"    + X_Pares.par_variable + ")".
      END CASE.        

      RUN MOSTRAR ( linea ).

   END.
   RUN MOSTRAR ( FILL(" ",20) + " EXCLUSIVE-LOCK NO-ERROR.").
   RUN MOSTRAR ( "").
   RUN MOSTRAR ( "   IF NOT AVAILABLE " + que_tabla + " THEN CREATE " + que_tabla + ".").   
   RUN MOSTRAR ( "").
     
END.

PROCEDURE DEFINIR_VAR:

  DEFINE INPUT PARAMETER v AS CHARACTER.
  DEFINE VARIABLE q AS CHARACTER.  

  q = "DEFINE VARIABLE " + v. 
  q = q + FILL(" ",50 - LENGTH(q)) + " AS CHARACTER NO-UNDO.".
  RUN MOSTRAR ( q ). 
  
END PROCEDURE.  
