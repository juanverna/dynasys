DEFINE VARIABLE cuit AS CHARACTER FORMAT "X(10)".
DEFINE VARIABLE factor AS INTEGER EXTENT 10
/*       INITIAL [11,7,5,3,2,11,7,5,3,2].*/
         INITIAL [2,3,5,7,11,2,3,5,7,11].  
/*       INITIAL [11,10,9,8,7,6,5,4,3,2].*/
/*         INITIAL [2,3,4,5,6,7,8,9,10,11].*/

DEFINE VARIABLE j AS INTEGER.       
DEFINE VARIABLE p AS INTEGER.       
DEFINE VARIABLE digito AS INTEGER.
DEFINE VARIABLE suma AS INTEGER.


REPEAT:

   SET cuit.
   suma = 0.
   DO j = 10 TO 1 BY -1:
      suma = suma + INTEGER(SUBSTRING(cuit,j,1)) * factor [ j ].
   END.
   
   digito = suma MOD 11.
   DISPLAY digito.

END.   
