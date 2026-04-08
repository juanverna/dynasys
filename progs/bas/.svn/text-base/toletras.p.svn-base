/*===========================================================================*/
/*                     CONVERSION DE MONTO A LETRAS                          */
/*===========================================================================*/

   DEFINE INPUT  PARAMETER numero    AS DECIMAL.      /* Numero a convertir */
   DEFINE OUTPUT PARAMETER como_digo AS CHARACTER.    /* Resultado de la conversion */

/* {VPERSINM.I} */

   DEFINE VARIABLE entero    AS INTEGER.
   DEFINE VARIABLE centavos  AS INTEGER.
   DEFINE VARIABLE ord       AS INTEGER INITIAL 1.
   DEFINE VARIABLE letras    AS CHARACTER FORMAT "X(50)".
   DEFINE VARIABLE numero1   AS INTEGER.
   DEFINE VARIABLE numero2   AS INTEGER.
   DEFINE VARIABLE numero3   AS INTEGER.

/*===========================================================================*/
/*                     CONVERSION PROPIAMENTE DICHA                          */
/*===========================================================================*/

     /*------------------------------------------------------------------*/
     /* Separa los centavos y deja el numero entero, luego desarma el nu-*/
     /* mero en los tres ordenes (millones, mile y unidades) y los con-  */
     /* vierte para ir pegandolos en la frase final. Antes valida que el */
     /* numero no se vaya de rango: el maximo es de 9 cifras enteras.    */
     /*------------------------------------------------------------------*/
     
   IF numero > 999999999.99
   THEN DO:
        como_digo = "EL NUMERO " + STRING(numero) + " ESTA FUERA DE RANGO PARA LA CONVERSION".
        RETURN.
   END.        

   entero = INTEGER(TRUNC(numero,0)).
   centavos = INTEGER(TRUNC((numero - entero) * 100,0)).

   numero3 = TRUNC(entero / 1000000, 0). 
   numero2 = TRUNC((entero - numero3 * 1000000) / 1000, 0).
   numero1 = entero - numero3 * 1000000 - numero2 * 1000.

   como_digo = "".

   IF numero3 <> 0
   THEN DO:
      RUN LETRAS ( INPUT 3 , INPUT numero3 , OUTPUT letras ).
      IF numero3 = 1
         THEN como_digo = letras + " MILLON".
         ELSE como_digo = letras + " MILLONES".         
   END.

   IF numero2 <> 0
   THEN DO:
      RUN LETRAS ( INPUT 2 , INPUT numero2 , OUTPUT letras ).
      como_digo = como_digo + " " + letras + " MIL".
   END.

   IF numero1 <> 0
   THEN DO:
      RUN LETRAS ( INPUT 1 , INPUT numero1 , OUTPUT letras ).
      como_digo = como_digo + " " + letras.
   END.

   IF centavos <> 0
      THEN como_digo = como_digo + " CON " + STRING(centavos,"99") + " CENTAVOS".

   como_digo = como_digo + ".-".

/*===========================================================================*/
/*                              PROCEDIMIENTOS                               */
/*===========================================================================*/

PROCEDURE LETRAS:

    DEFINE INPUT  PARAMETER orden   AS INTEGER.     /* Orden: 3=Millones, 2=miles, 1=unidad */
    DEFINE INPUT  PARAMETER digitos AS INTEGER.     /* Es un numero de tres cifras */
    DEFINE OUTPUT PARAMETER sedice  AS CHARACTER.   /* Equivalente en letras       */

    DEFINE VARIABLE w1  AS CHARACTER EXTENT 10 
           INITIAL ["","UNO","DOS","TRES","CUATRO","CINCO","SEIS","SIETE","OCHO","NUEVE"].
    DEFINE VARIABLE w2  AS CHARACTER EXTENT 10 
           INITIAL ["","DIECI","VEINTI","TREINTA","CUARENTA","CINCUENTA","SESENTA","SETENTA","OCHENTA","NOVENTA"].
    DEFINE VARIABLE w3  AS CHARACTER EXTENT 10 INITIAL 
           ["","CIENTO","DOSCIENTOS","TRESCIENTOS","CUATROCIENTOS","QUINIENTOS","SEISCIENTOS","SETECIENTOS","OCHOCIENTOS","NOVECIENTOS"].
    DEFINE VARIABLE wes AS CHARACTER EXTENT 6 INITIAL 
           ["DIEZ","ONCE","DOCE","TRECE","CATORCE","QUINCE"].
                                                     
    DEFINE VARIABLE cifra1       AS INTEGER.
    DEFINE VARIABLE cifra2       AS INTEGER.
    DEFINE VARIABLE cifra3       AS INTEGER.

                         /* Comienza el proceso de conversion */
           /* Inicializa la salida y desarma el numero en sus tres digitos */

    sedice = "".  
    cifra3 = INTEGER(TRUNC(digitos / 100,0)).
    cifra2 = INTEGER(TRUNC((digitos - cifra3 * 100) / 10, 0)).
    cifra1 = digitos - cifra3 * 100 - cifra2 * 10.

    IF cifra3 = 1 AND cifra2 = 0 AND cifra1 = 0 
    THEN DO:
         sedice = "CIEN ".
    END.
    ELSE DO:     
         sedice = w3[ cifra3 + 1 ].
    END.     

    IF cifra2 <> 0
    THEN DO:
         IF cifra2 = 2 AND cifra1 = 0
         THEN DO:
              sedice = sedice + " VEINTE".
         END.
         ELSE DO:
              IF cifra2 * 10 + cifra1 <= 15 
              THEN DO:
                   sedice = sedice + " " + wes[ cifra1 + 1 ].
                   RETURN.
              END.
              ELSE DO:
                   sedice = sedice + " " + w2[ cifra2 + 1 ].
              END.    
         END.               
    END.     
    ELSE DO:
         sedice = sedice + " ".
    END.     

    IF cifra1 <> 0
    THEN DO:
         IF cifra2 < 3
            THEN sedice = sedice + w1[ cifra1 + 1 ].
            ELSE sedice = sedice + " Y " + w1[ cifra1 + 1 ].
    END.     

    IF orden <> 1
       THEN IF cifra1 = 1 
               THEN sedice = SUBSTRING(sedice,1,LENGTH(sedice) - 1 ).

    
END PROCEDURE.    


