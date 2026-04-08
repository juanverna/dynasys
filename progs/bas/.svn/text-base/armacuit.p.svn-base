/*=================================================================================*/
/*                                                                                 */
/*  CALCULA EL CUIT/CUIL EN BASE A UN NUMERO DE DOCUMENTO O DE INSCRIPCION         */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-numero AS CHARACTER.
DEFINE INPUT PARAMETER  p-tipo   AS CHARACTER.
DEFINE OUTPUT PARAMETER p-cuit   AS CHARACTER.

DEFINE VARIABLE calculado        AS LOGICAL.
DEFINE VARIABLE v-cuit           AS CHARACTER.
DEFINE VARIABLE v-numero         AS CHARACTER.
DEFINE VARIABLE v-digito         AS CHARACTER.

v-numero = STRING(p-numero,"99999999").

/* Intenta primer calculo */

CASE p-tipo:
     WHEN "M" THEN v-cuit = "20" + v-numero.
     WHEN "F" THEN v-cuit = "27" + v-numero.
     WHEN "E" THEN v-cuit = "30" + v-numero.
END CASE.

RUN calcular_digito ( INPUT v-cuit, OUTPUT v-digito ).

/* Si el primer calculo es ambiguo, entonces hace otro */


IF INTEGER(v-digito) >= 10 
THEN DO:

     v-cuit = "23" + v-numero.
     RUN calcular_digito ( INPUT v-cuit, OUTPUT v-digito ).

     IF INTEGER(v-digito) >= 10 
     THEN DO:
          v-cuit = "24" + v-numero.
          RUN calcular_digito ( INPUT v-cuit, OUTPUT v-digito ).
     END.

END.

/* Toma directamente el resultado, sin mas consideraciones */

p-cuit = v-cuit + v-digito.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/


PROCEDURE calcular_digito:

   DEFINE INPUT  PARAMETER tira   AS CHARACTER.
   DEFINE OUTPUT PARAMETER digito AS CHARACTER.
   
   DEFINE VARIABLE j              AS INTEGER.
   DEFINE VARIABLE factor         AS INTEGER.
   DEFINE VARIABLE acumulado      AS INTEGER.
   DEFINE VARIABLE factores       AS INTEGER EXTENT 10 INITIAL [ 5,4,3,2,7,6,5,4,3,2 ].
   
   acumulado = 0.
   DO j = 1 TO 10: 
      factor = factores [ j ].
      acumulado = acumulado + factor * INTEGER(SUBSTRING(tira,j,1)).
   END.
   
   digito = STRING( 11 - acumulado MOD 11 ).   
  
END.
