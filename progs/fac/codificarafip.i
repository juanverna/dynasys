/*Codigo de barras de las facturas y documentos afip*/
/*
RUN codificar( REPLACE(Empresa.cuit,"-","") + 
                   TipocomprobanteAfip.cdg_afip + 
                   STRING(Fac_header.prf_comprob,"9999") + 
                   Fac_header.cai + 
                   STRING(YEAR(Fac_header.rige_hasta) ,"9999") + STRING(MONTH(Fac_header.rige_hasta) ,"99") + STRING(DAY(Fac_header.rige_hasta) ,"99")
                   , OUTPUT  CodigoBarra , OUTPUT  LecturaHumana ).
                   */

PROCEDURE Codificar :
    DEFINE INPUT PARAMETER tcTexto as char.
    DEFINE OUTPUT PARAMETER CodigoBarra as char.
    DEFINE OUTPUT PARAMETER LecturaHumana as char. 
    define var lcLH AS CHAR NO-UNDO.
    define var lcDV AS CHAR NO-UNDO.
    define var  lcCB AS CHAR NO-UNDO.
    define var lnLong AS INT NO-UNDO.
    define var lnI AS INT NO-UNDO.
    define var lnSum AS INT NO-UNDO.
    define var lnAux AS INT NO-UNDO.

    lcLH = RIGHT-TRIM(TRIM(tcTexto)).
    /*--- Genero dígito de control*/
    lnLong = LENGTH(lcLH).
    lnSum = 0.
    /*paso 1*/
    DO lnI = 1 to lnLong:
      lnSum = lnSum + INT ( SUBSTR( lcLH , lnI ,1)) * IF lnI MOD 2  = 0 THEN 1 ELSE 3 . 
    END.
    
    lnAux = lnSum MOD 10.

    lcDV = RIGHT-TRIM( TRIM( STRING( IF  lnAux = 0 THEN 0 ELSE 10 - lnAux ) ) ).
                                                               
    lcLH = lcLH + lcDV.
    lnLong = LENGTH (lcLH).
    /*--- La longitud debe ser par*/
    IF lnLong MOD 2 <> 0 THEN DO:
      lcLH = '0' + lcLH.
      lnLong = LENGTH(lcLH).
    END.
    /*--- Convierto los pares a caracteres*/
    lcCB = ''.
    DO lnI = 1 TO lnLong BY 2 :
      IF INT(SUBSTRING( lcLH , lnI ,2 )) < 50 THEN
        lcCB = lcCB + CHR (int(SUBString( lcLH , lnI , 2 ) ) + 48).
      ELSE
        lcCB = lcCB + CHR ( int ( SUBString (lcLH , lnI , 2 ) ) + 142 ).
    END.
    
    LecturaHumana = lcLH.
    CodigoBarra = CHR(40) + lcCB + CHR(41).
END PROCEDURE.
/*
define var aa as char.
define var bb as char.
run codificar("305467412530100655852337571677820090103",output aa, output bb).
display aa format "X(50)" skip bb format "X(50)".
*/
