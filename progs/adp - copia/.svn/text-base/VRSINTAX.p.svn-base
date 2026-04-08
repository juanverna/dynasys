/*=================================================================================*/
/*                                                                                 */
/*                       CONSISTENCIA DE SINTAXIS EN FORMULAS                      */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT  PARAMETER formula AS CHARACTER.
DEFINE OUTPUT PARAMETER rc AS INTEGER.
DEFINE OUTPUT PARAMETER token  AS CHARACTER.
DEFINE OUTPUT PARAMETER caracter AS CHARACTER.

DEFINE VARIABLE  hab_punto         AS LOGICAL.
DEFINE VARIABLE  hab_pariz         AS LOGICAL.
DEFINE VARIABLE  hab_parde         AS LOGICAL.
DEFINE VARIABLE  hab_calif         AS LOGICAL.
DEFINE VARIABLE  chrexs            AS INTEGER.
DEFINE VARIABLE  rc_palabra        AS INTEGER.
DEFINE VARIABLE  ptr_formula       AS INTEGER INITIAL 1.
DEFINE VARIABLE  ptr_palabra       AS INTEGER.
DEFINE VARIABLE  len_formula       AS INTEGER.
DEFINE VARIABLE  len_palabra       AS INTEGER.
DEFINE VARIABLE  tipo_palabra      AS INTEGER.

DEFINE VARIABLE  NADA              AS INTEGER INITIAL 0.
DEFINE VARIABLE  NUM               AS INTEGER INITIAL 1.
DEFINE VARIABLE  OPR               AS INTEGER INITIAL 2.
DEFINE VARIABLE  CAL               AS INTEGER INITIAL 3.

DEFINE VARIABLE  pch_palabra       AS CHARACTER.


DEFINE VARIABLE  PUNTO             AS CHARACTER INITIAL ".".
DEFINE VARIABLE  PARIZ             AS CHARACTER INITIAL "(".
DEFINE VARIABLE  PARDE             AS CHARACTER INITIAL ")".
DEFINE VARIABLE  CALIFICADORES     AS CHARACTER INITIAL "DKS=".
DEFINE VARIABLE  OPERADORES        AS CHARACTER INITIAL "+-*/%><@^_!#$\&".
DEFINE VARIABLE  IMPLEMENTADOS     AS CHARACTER INITIAL "+-*/%><@^_!#$\&=".
DEFINE VARIABLE  NUMEROS           AS CHARACTER INITIAL "0123456789".

/*
 RC:
 
   1.- Formula vacia.
   2.- Caracter no esperado.
   3.- Operador debe tener longitud 1.
   4.- ")" debe ser ultimo caracter.
      
*/   

rc = 0.
RUN ES_FORMULA. 

/*=================================================================================*/
/*                               PROCEDIMIENTOS                                    */
/*=================================================================================*/

PROCEDURE ES_FORMULA:

    formula = TRIM(formula).
    IF LENGTH(formula) = 0
    THEN DO:
         rc = 1.
        RETURN.
    END.   

    DO WHILE INDEX(formula,"  ") <> 0:
       formula = REPLACE(formula,"  "," ").
    END.

    DO ptr_formula = 1 TO NUM-ENTRIES(formula," ") /* WHILE rc = 0*/ :

       token = ENTRY(ptr_formula,formula," ").
       RUN VERIFICAR_PALABRA ( INPUT token ).

   END.
   
END PROCEDURE.   

PROCEDURE VERIFICAR_PALABRA:

   DEFINE INPUT PARAMETER palabra AS CHARACTER.


   pch_palabra = SUBSTRING(palabra,1,1).
   len_palabra = LENGTH(palabra).
   tipo_palabra = NADA.
   hab_pariz = NO.
   hab_parde = NO.
   hab_punto = NO.
   hab_calif = NO.

   IF pch_palabra = "X" THEN RETURN.

   IF INDEX(NUMEROS,pch_palabra) <> 0
   THEN DO:
      hab_pariz = NO.
      hab_parde = NO.
      hab_punto = YES.
      hab_calif = NO.      
      tipo_palabra = NUM.
   END.    

   IF INDEX(OPERADORES,pch_palabra) <> 0
   THEN DO:
      hab_pariz = NO.
      hab_parde = NO.
      hab_punto = NO.
      hab_calif = NO.
      tipo_palabra = OPR.
   END.    
   
   IF INDEX(CALIFICADORES,pch_palabra) <> 0
   THEN DO:
      hab_pariz = YES.
      hab_parde = NO.
      hab_punto = NO.
      hab_calif = NO.
      tipo_palabra = CAL.
   END.       

   CASE tipo_palabra:

      WHEN CAL
      THEN DO:
           DO ptr_palabra = 2 TO len_palabra:
              caracter= SUBSTRING(palabra,ptr_palabra,1).
              IF NOT INDEX(NUMEROS,caracter) <> 0
              THEN DO:
              
                 IF caracter = PARIZ
                 THEN DO:
                    IF hab_pariz
                    THEN DO:
                       hab_pariz = NO.
                       hab_parde = YES.
                       hab_calif = YES.
                       RUN VERIFICAR_PALABRA ( INPUT SUBSTRING(token,ptr_palabra + 1, len_palabra - ptr_palabra - 1 ) ).
                       IF rc <> 0 THEN RETURN.                      
                    END.
                    ELSE DO:
                       rc = 2.
                       RETURN.
                    END.
                 END.
                 ELSE DO:
                    IF caracter = PARDE
                    THEN DO:
                       IF hab_parde
                       THEN DO:
                          IF ptr_palabra <> len_palabra 
                          THEN DO:
                             rc = 4.
                             RETURN.
                          END.   
                       END.
                       ELSE DO:
                          rc = 2.
                          RETURN.
                       END.
                    END.                 
                    ELSE DO:
                       IF INDEX(caracter,CALIFICADORES) <> 0
                       THEN DO:
                          IF hab_calif
                          THEN DO:
                             hab_calif = NO.
                          END.
                       END.                 
                       ELSE DO:
                          rc = 2.
                          RETURN.
                       END.

                    END.        
                 END.
              END.
           END.
      END.   


      WHEN OPR
      THEN DO:
           caracter= SUBSTRING(palabra,1,1).      
           IF len_palabra <> 1 
           THEN DO:
              rc = 3.
              RETURN.
           END.   
      END.
   
      WHEN NUM
      THEN DO:
           DO ptr_palabra = 2 TO len_palabra:
              caracter = SUBSTRING(palabra,ptr_palabra,1).
              IF NOT INDEX(NUMEROS,caracter) <> 0
              THEN DO:
                 if caracter = PUNTO
                 THEN DO:
                    IF hab_punto
                    THEN DO:
                       hab_punto = NO.
                    END.
                    ELSE DO:
                       rc = 2.
                       RETURN.
                    END.                    
                 END.   
                 ELSE DO:
                    rc = 2.
                    RETURN.
                 END.
              END.
           END.   
      END.
     
      OTHERWISE
      DO:
           rc = 2.     
      END.

   END CASE.  
   
END PROCEDURE.   
