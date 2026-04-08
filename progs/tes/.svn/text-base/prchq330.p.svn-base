/*=================================================================================*/
/*   IMPRESION DE UN CHEQUE SEGUN FORMATO DE: 255 - BANCO DEL SUQUIA               */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_cheque  AS ROWID.

DEFINE VARIABLE v-letras  AS CHARACTER FORMAT "X(70)".
DEFINE VARIABLE v-pago    AS CHARACTER FORMAT "X(90)".
DEFINE VARIABLE v-emit    AS CHARACTER FORMAT "X(90)".
DEFINE VARIABLE v-importe AS CHARACTER FORMAT "X(20)".

DEFINE SHARED STREAM lst-cheques.

{nommeses.i}

FIND Cheque WHERE ROWID(Cheque) = rid_cheque NO-LOCK.

RUN toletras.p ( INPUT Cheque.importe,
                 OUTPUT v-letras ). 

v-letras = TRIM(v-letras) + FILL("-", 95 - LENGTH(v-letras)).

ASSIGN
    SUBSTRING(v-pago,12,2)   = STRING(DAY(Cheque.fecha_salida),">9")
    SUBSTRING(v-pago,15,2)  = "de"
    SUBSTRING(v-pago,18,12) = nom_mes [ MONTH(Cheque.fecha_salida) ]
    SUBSTRING(v-pago,41,4)  = STRING(YEAR(Cheque.fecha_salida),"9999").

ASSIGN
    SUBSTRING(v-emit,8,2)   = STRING(DAY(Cheque.fecha_emision),">9")
    SUBSTRING(v-emit,15,12) = nom_mes [ MONTH(Cheque.fecha_emision) ]
    SUBSTRING(v-emit,32,4)  = STRING(YEAR(Cheque.fecha_emision),"9999")
    SUBSTRING(v-emit,46,40) = Cheque.orden.

ASSIGN
    v-importe = STRING(Cheque.importe,"**,***,**9.99"). 


/*=================================================================================*/
/*                          IMPRESION PROPIAMENTE DICHA                            */
/*=================================================================================*/

                            /* Caracteres de Control */

PUT STREAM lst-cheques CONTROL CHR(15).
PUT STREAM lst-cheques CONTROL "~033C" + CHR(22).  /* Ajustamos el largo de pagina a 22 lineas */.
PUT STREAM lst-cheques CONTROL "~033" + CHR(48).  /* Ajustamos el interlineado a 1/8 */.
/*PUT STREAM lst-cheques CONTROL "~033" + CHR(67) + CHR(0) + CHR(3) .  /* Ajustamos la hoja a 3 pulgadas */.*/

                            /* Datos del Cheque */

PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques v-importe AT 72 SKIP.
PUT STREAM lst-cheques " " SKIP.

PUT STREAM lst-cheques v-pago SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques v-emit SKIP.

PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques v-letras AT 18 SKIP.

PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.
PUT STREAM lst-cheques " " SKIP.

