DEFINE INPUT  PARAMETER cadena   AS CHARACTER.
DEFINE OUTPUT PARAMETER clave    AS INTEGER.
DEFINE OUTPUT PARAMETER rc       AS INTEGER.

DEFINE VARIABLE numeric1 AS INTEGER INITIAL 0.
DEFINE VARIABLE numeric2 AS INTEGER INITIAL 0.
DEFINE VARIABLE suma     AS INTEGER INITIAL 0.
DEFINE VARIABLE j        AS INTEGER INITIAL 0.
DEFINE VARIABLE producto AS INTEGER INITIAL 1.

IF LENGTH(cadena) < 3
THEN DO:
   rc = 1.
END.   
ELSE DO:

   DO j = 1 TO LENGTH(cadena) - 1:

      numeric1 = ASC(SUBSTRING(cadena,j,1)).
      numeric2 = ASC(SUBSTRING(cadena,j + 1,1)).
      suma = suma + numeric1.
      producto = producto + numeric1 * numeric2.

   END.
   suma = suma + ASC(SUBSTRING(cadena,LENGTH(cadena),1)).
   clave = ROUND( (producto / suma ) * 1000000,0) MOD 1000000 .
   rc = 0.
   
END.   
RETURN.
