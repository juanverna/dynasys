/*===========================================================================*/
/*     VERIFICA LA AUTORIZACION DE LICENCIA DE UNA EMPRESA DETERMINADA       */
/*===========================================================================*/

DEFINE INPUT  PARAMETER modo   AS INTEGER.
DEFINE OUTPUT PARAMETER cod_aut AS INTEGER.

/*===========================================================================*/
/*                               VARIABLES                                   */
/*===========================================================================*/

DEFINE VARIABLE clave_n    AS INTEGER FORMAT "999999".
DEFINE VARIABLE clave_s    AS INTEGER FORMAT "999999".
DEFINE VARIABLE clave_f    AS INTEGER FORMAT "999999".
DEFINE VARIABLE clave_m    AS INTEGER FORMAT "999999" INITIAL 311303.
DEFINE VARIABLE calculo    AS INTEGER FORMAT "99999999".
DEFINE VARIABLE rc         AS INTEGER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}

cod_aut = 0. /* Asumimos que esta autorizado */

RUN cryptogr ( INPUT Empresa.nombre, OUTPUT clave_n, OUTPUT rc).
IF rc <> 0
THEN DO:
   cod_aut = 3.
   RETURN.
END.
RUN cryptogr ( INPUT Empresa.sistema, OUTPUT clave_s, OUTPUT rc).
IF rc <> 0
THEN DO:
   cod_aut = 4.
   RETURN.
END.
RUN cryptogr ( INPUT STRING(Empresa.fecha_limite), OUTPUT clave_f, OUTPUT rc).
IF rc <> 0
THEN DO:
   cod_aut = 5.
   RETURN.
END.
RUN cryptogr ( INPUT "ALUMAILI", OUTPUT clave_m, OUTPUT rc).
IF rc <> 0
THEN DO:
   cod_aut = 6.
   RETURN.
END.

calculo = ( clave_n / clave_s * clave_f / clave_m ) * 1000000.

/*
         display clave calculo clave_n clave_s clave_f clave_m
         with frame ff view-as dialog-box title "de autoriza"
                 side-labels 1 column font 8.
         pause.
         hide frame ff no-pause.        
*/          

IF modo = 0
THEN DO:
  IF calculo <> Empresa.clave 
     THEN cod_aut = 1.
     ELSE cod_aut = 0.
END.
ELSE DO:
  DO TRANSACTION:
    FIND CURRENT Empresa EXCLUSIVE-LOCK.
    Empresa.clave = calculo.
    message string(calculo) view-as alert-box.
    RELEASE Empresa.
  END.
END.

RETURN.

/*===========================================================================*/
/*                        P R O C E D I M I E N T O S                        */
/*===========================================================================*/

PROCEDURE cryptogr:

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

END PROCEDURE.

