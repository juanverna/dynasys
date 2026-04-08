/*=========================================================================================*/
/*                               IMPRESION DE ETIQUETAS                                    */
/*=========================================================================================*/

/*=========================================================================================*/
/*                                  V A R I A B L E S                                      */
/*=========================================================================================*/

DEFINE VARIABLE arch_salida AS CHARACTER.


DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".

DEFINE STREAM sstream.


{xprint.i}

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.        

OUTPUT STREAM sstream TO VALUE("c:\sic-temp\barra.xpr")  CONVERT TARGET "iso8859-1".

PUT STREAM sstream CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
/*  PUT STREAM sstream CONTROL '<TOOLBAR=!PRINT>'.*/

PUT STREAM sstream CONTROL "<OPORTRAIT><Title=Impresion de barras><UNITS=mm><|2>".
PUT STREAM sstream CONTROL "<FORMAT=Letter>".

PUT STREAM sstream UNFORMATTED "<=#1><AT=+1,+1><#2>".
PUT STREAM sstream UNFORMATTED "<=#2><AT=+7,+55><#3>".

PUT STREAM sstream UNFORMATTED "<=#2><FROM><BARCODE#3,TYPE=2_5_interleaved,CHECKSUM=TRUE,VALUE="   "01234567890123456789" ">".

OUTPUT STREAM sstream CLOSE.
RUN printFile( "c:\sic-temp\barra.xpr").



