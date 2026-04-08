/*-----------------------------------------------------------------------------------
  Esta rutina toma la entrada indicada en 'texto' y la trata como una lista separada
  por blancos. Con ella, arma una nueva lista, esta vez separada por 'separador'
  (usualmente usamos '@' o bien '#') donde cada item tiene una cantidad entera de 
  palabras y una longitud menor o igual a la indicada en 'largo'.

  NOTA: Se asume que no hay palabras mas largas que la longitud del renglon prevista.
        Esto, es, si decimos renglones de 10 caracteres y la frase contiene la palabra
        'veintinuevemil', la rutina no funciona correctamente.

  ----------------------------------------------------------------------------------*/

DEFINE INPUT  PARAMETER texto     AS CHARACTER. /* Texto a separar en renglones      */
DEFINE INPUT  PARAMETER largo     AS INTEGER.   /* Longitud deseada de cada renglon  */
DEFINE OUTPUT PARAMETER renglones AS CHARACTER. /* Texto ya separado en renglones    */
DEFINE INPUT  PARAMETER separador AS CHARACTER. /* Caracter que separa cada renglon  */

DEFINE VARIABLE total_chars    AS INTEGER.      /* Longitud del texto a separar, en chars */
DEFINE VARIABLE total_words    AS INTEGER.      /* Longitud del texto a separar, en words */
DEFINE VARIABLE este_renglon   AS CHARACTER.    /* Renglon que estamos armando            */
DEFINE VARIABLE esta_word      AS CHARACTER.    /* Palabra actual                         */
DEFINE VARIABLE pt_word        AS INTEGER.      /* Puntero a la palabra actual            */

/*----------------------------------------------------------------------------------------*/
/*                                 BLOQUE PRINCIPAL                                       */
/*----------------------------------------------------------------------------------------*/

texto = TRIM(texto).   /* Borramos todos los blancos demas adelante y atras de la cadena */
renglones = "".                                 /* Inicializa salida */
total_words = NUM-ENTRIES(texto," ").     /* Cuenta las palabras de la frase a separar */
este_renglon = "" .                             /* El renglon actual se halla vacio */

DO pt_word = 1 to total_words:

   total_chars = LENGTH(este_renglon).
   esta_word = ENTRY(pt_word,texto," ").

   CASE TRUE:
        
        WHEN total_chars + LENGTH(esta_word) > largo /* No cabe la palabra en el renglon. 
                        Pegamos y comenzamos renglon nuevo */
        THEN DO:
             renglones = renglones + este_renglon + separador.
             este_renglon = esta_word + " " .
        END.

        WHEN total_chars + LENGTH(esta_word) = largo /* Cabe la palabra en el renglon, pero no hay mas lugar */
        THEN DO:
             este_renglon = este_renglon + esta_word.
             renglones = renglones + este_renglon. 
             este_renglon = "" .
             IF pt_word < total_words /* Hay mas palabras */
             THEN DO:
                renglones = renglones + separador.
             END.
        END.

        WHEN total_chars + LENGTH(esta_word) < largo /* Cabe la palabra en el renglon, y hay lugar para otras */
        THEN DO:
             este_renglon = este_renglon + esta_word + " ".
        END.

   END CASE. /* Del CASE */

END. /* Del DO */


/* Pegamos el ultimo renglon, si no esta vacio */

IF LENGTH(este_renglon) <> 0
   THEN  renglones = renglones + este_renglon.

/* Si el largo de la frase es multiplo del largo del renglon, 
   puede aparecer un separador de mas. Chequeamos y lo removemos. El ultimo renglon 
   queda incializado vacio   */

total_chars = LENGTH(renglones).
IF SUBSTRING(renglones,total_chars,1) = separador
   THEN renglones =  SUBSTRING(renglones,1,total_chars - 1).

RETURN.
