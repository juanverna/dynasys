&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Include 
/*------------------------------------------------------------------------
    File        : Distancias Geodesicas
    Purpose     :

    Syntax      : Creadas por Fernando Vergniaud

    Description : 
    
    Para las formulas ver http://www.uwgb.edu/dutchs/UsefulData/UTMFormulas.HTM


    Author(s)   : Fernando Vergniaud
    Created     : 30/12/2009
    Notes       : Require MathLibrary.I
  ----------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
{MathLibrary.i}
/*constanrtes geodesicas*/

&SCOPED-DEFINE k0 0.9996 
&SCOPED-DEFINE sin1 0.0000048481368
&SCOPED-DEFINE CONSTANT_ECC 0.081819191
&SCOPED-DEFINE CONSTANT_PI 3.1415926536
    /*Meridional Arc Constanrts*/       
&SCOPED-DEFINE A0 6367449.146
&SCOPED-DEFINE B0 16038.42955
&SCOPED-DEFINE C0 16.83261333
&SCOPED-DEFINE D0 0.021984404
&SCOPED-DEFINE E0 0.000312705
&SCOPED-DEFINE a 6378137
&SCOPED-DEFINE e1sq 0.006739497


DEFINE TEMP-TABLE tt_recorrido
    field xx AS DECIMAL
    field yy AS DECIMAL
    field posi AS INTEGER
    FIELD tramo AS DECIMAL.

define var clee as char no-undo.
define temp-table internal-ttgeo
    field pid as INT FORMAT ">>9" COLUMN-LABEL "PID"
    field xal as char FORMAT "X(40)" COLUMN-LABEL "Direccion XAL"
    field CountryNameCode AS CHAR FORMAT "XXX" COLUMN-LABEL "PAIS"
    field LocalityName AS CHAR FORMAT "X(25)" COLUMN-LABEL "LOCALIDAD"
    FIELD Provincia AS CHAR FORMAT "X(25)" COLUMN-LABEL "PROVINCIA"
    field coordinates AS CHAR FORMAT "X(50)" COLUMN-LABEL "LAT/LONG"
    field Accuracy as CHAR FORMAT "X(18)" LABEL "Presicion" COLUMN-LABEL "PS"
    FIELD extra  AS CHAR FORMAT "X(30)" LABEL "Extra"
    INDEX p1 is PRIMARY pid
    INDEX w1 IS WORD-INDEX xal.
DEFINE VARIABLE hParser AS HANDLE NO-UNDO.
DEFINE VAR ittgeo AS INT NO-UNDO.
DEFINE VAR prevttgeo AS CHAR NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD distGeodesica Include 
FUNCTION distGeodesica RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD distgeodesicaUTM Include 
FUNCTION distgeodesicaUTM RETURN DECIMA ( INPUT x1 AS DECIMAL,
                INPUT y1 AS DECIMAL,
                INPUT x2 AS DECIMAL,
                INPUT y2 AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD disti Include 
FUNCTION disti RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD disti2 Include 
FUNCTION disti2 RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD LongZone Include 
FUNCTION LongZone RETURNS DECIMAL
  ( lon AS DECIMAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD LongZoner Include 
FUNCTION LongZoner RETURNS INTEGER ( INPUT lon AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD LongZonerCM Include 
FUNCTION LongZonerCM RETURNS INTEGER ( INPUT lon AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD nu Include 
FUNCTION nu RETURNS DECIMAL ( INPUT lat AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD p Include 
FUNCTION p RETURNS DECIMAL ( INPUT lon AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD point Include 
FUNCTION point RETURNS CHARACTER
  ( a AS char, b AS char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rho Include 
FUNCTION rho RETURNS DECIMAL ( INPUT lat AS DECIMAL )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD s Include 
FUNCTION s RETURNS DECIMAL ( INPUT lat AS DECIMAL ) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Temp-File Include 
FUNCTION Temp-File RETURNS CHARACTER
  ( direct AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD toxAL Include 
FUNCTION toxAL RETURNS CHARACTER
  ( dd AS CHAR , OUTPUT v-extra AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD X Include 
FUNCTION X RETURNS DECIMAL
  ( lat AS DECIMAL , lon AS decimal )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Xr Include 
FUNCTION Xr RETURNS DECIMAL ( INPUT lat AS DECIMAL, INPUT lon AS DECIMAL) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Y Include 
FUNCTION Y RETURNS DECIMAL
  ( lat AS DECIMAL , lon AS decimal )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Yr Include 
FUNCTION Yr RETURNS DECIMAL ( INPUT lat AS DECIMAL, INPUT lon AS DECIMAL) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Include
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: INCLUDE-ONLY
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Include ASSIGN
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Include 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Characters Include 
PROCEDURE Characters :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Lectura de cada item de xml
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER charDataA   AS MEMPTR NO-UNDO.
  DEFINE INPUT PARAMETER numChars AS INTEGER NO-UNDO.
  define var charData as memptr no-undo.
  define var tempchar as char no-undo.
  IF clee = "" THEN RETURN.
  tempchar = GET-STRING( charDataA, 1,numChars).
  IF tempchar = "~n   " THEN RETURN.
/*  MESSAGE "CH" clee tempchar VIEW-AS ALERT-BOX INFORMATION.*/
/*  IF clee BEGINS "GeocodeResponse,result,geometry,location,lng"  THEN DO:
      END. */
  case clee:
      WHEN "GeocodeResponse,status" THEN DO:
          IF NOT VALID-HANDLE(hParser) THEN RETURN.
          IF tempchar <> "OK" THEN hParser:STOP-PARSING() NO-ERROR.
          END.
      WHEN "GeocodeResponse,result,type" THEN DO:
          IF tempchar = "street_address" OR tempchar = "locality" 
              OR tempchar = "route" THEN DO:
              CREATE internal-ttgeo.
              ASSIGN internal-ttgeo.pid = ittgeo + 1
                     ittgeo = internal-ttgeo.pid.
          END.
      END.
      WHEN "GeocodeResponse,result,address_compoment,short_name" THEN 
          prevttgeo = tempchar.
      WHEN "GeocodeResponse,result,address_compoment,type" THEN DO:
          CASE tempchar:
              WHEN "locality" THEN DO:
                  internal-ttgeo.LocalityName = prevttgeo.
                  internal-ttgeo.LocalityName = REPLACE(internal-ttgeo.LocalityName,"Ciudad Autónoma de Buenos Aires","CABA").
              END.
              WHEN "administrative_area_level_1" THEN
                  internal-ttgeo.provincia = prevttgeo.
              WHEN "country" THEN
                  internal-ttgeo.CountryNameCode = prevttgeo.
          END CASE.
      END.
      WHEN "GeocodeResponse,result,geometry,location,lat" THEN 
                 internal-ttgeo.coordinates =  tempchar.
      WHEN "GeocodeResponse,result,geometry,location,lng" THEN DO:
                internal-ttgeo.coordinates = tempchar + "," + internal-ttgeo.coordinates.
      END.
      when "GeocodeResponse,result,formatted_address" THEN 
        internal-ttgeo.xal = tempchar.
  
      when "GeocodeResponse,result,location_type" THEN 
          internal-ttgeo.accuracy = tempchar. 

      END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE decodir Include 
PROCEDURE decodir :
/*------------------------------------------------------------------------------
  Purpose: Convierte una dd en sus componentes calle altura extra
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM dd AS CHAR NO-UNDO.
DEFINE OUTPUT PARAM v-calle AS CHAR NO-UNDO.
DEFINE OUTPUT PARAM v-altura AS CHAR NO-UNDO.
DEFINE OUTPUT PARAM v-refer AS CHAR NO-UNDO.
DEFINE OUTPUT PARAM v-extra AS CHAR NO-UNDO.

    DEFINE VAR i AS INT NO-UNDO.
    DEFINE VAR j AS INT NO-UNDO.
        dd = TRIM(dd).
    REPEAT: 
        dd = REPLACE(dd,"  "," ").
        IF INDEX(dd,"  ") = 0 THEN LEAVE.
    END.
    i = INDEX(dd," ").
    v-calle = substring(dd,1 , i - 1).
    dd = SUBSTRING(dd, i + 1).
    DO i = 1 TO LENGTH(dd):
        IF INDEX("123456789",substring(dd,i,1)) <> 0 THEN LEAVE.
    END.
    IF i <> LENGTH(dd) AND i <> 1 THEN DO:
        v-calle = trim(v-calle + " " + SUBSTRING(dd, 1 , i - 1)).
        dd = SUBSTRING(dd, i).
    END.
    i = INDEX(dd," ").
    IF i = 0 THEN do:
        v-altura = dd.
        v-extra = "".
        v-refer = "".
    END.
    ELSE DO:
        v-altura = substring(dd, 1 , i - 1).
        v-extra = SUBSTRING(dd, i + 1 ).
        i = INDEX(v-extra,"(").
        j = INDEX(v-extra,")").
        IF i <> 0 AND j <> 0 THEN DO:
            v-refer = SUBSTRING(v-extra,i + 1 , j - i - 1).
            SUBSTRING(v-extra,i + 1 , j - i - 1) = "".
        END.
         v-refer = TRIM(v-refer).
         v-calle = TRIM(v-calle).
         v-altura = TRIM(v-altura).
         v-extra = TRIM(v-extra).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE EndElement Include 
PROCEDURE EndElement :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER pcNamespaceURI AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcLocalName    AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAMETER pcQName        AS CHARACTER NO-UNDO.
  clee=substring( clee , 1  ,r-index(clee , "," ) - 1 ).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geocoding Include 
PROCEDURE geocoding :
/*------------------------------------------------------------------------------
  Purpose:   retornar la geocodificacion de la direccion solicitada  
  Parameters:  <none>
  Notes:  si no se aclara un pais pone Argentina AR     
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM vxal AS CHARACTER. /*direccion preferentemente en formato xAL ver toxAL*/
DEFINE OUTPUT PARAM glat AS DECIMAL.
DEFINE OUTPUT PARAM glong AS DECIMAL.
DEF VAR t AS CHAR NO-UNDO.
DEFINE VARIABLE mLine AS MEMPTR     NO-UNDO.
DEFINE VARIABLE oldnf AS CHAR NO-UNDO.
DEFINE VAR rta AS LOGICAL NO-UNDO.
DEFINE VAR q AS CHAR NO-UNDO.
define var i as int no-undo.
CREATE SAX-READER hParser.
DEFINE VAR clave AS CHAR NO-UNDO.
glong = 0.
glat = 0.
hParser:HANDLER = this-procedure.
vxal = replace(vxal ," " , "+").
vxal = REPLACE(vxal,",CABA",",CIUDAD AUTONOMA DE BUENOS AIRES").  
/*q="http://maps.googleapis.com/maps/api/geocode/xml?address=" + vxal + "&sensor=false".*/
T = Temp-File("").
RUN GETparametro_c.p ("GEOKEY", OUTPUT clave).
q="https://maps.googleapis.com/maps/api/geocode/xml?address=" + vxal + "&key=" + clave .
DOS SILENT VALUE("..\procs\curl  -k -o " + t + " " + q ).
INPUT FROM value(t) BINARY.
SEEK INPUT TO END .
SEEK INPUT TO (SEEK(INPUT) - 1) .
SET-SIZE(mLine) = 0 .
SET-SIZE(mLine) = 1 .
IMPORT UNFORMATTED mLine .
INPUT CLOSE .

IF get-byte(mLine,1) <> 10 THEN DO:
  OUTPUT TO value(t) APPEND .
  PUT UNFORMATTED "~n" .
  OUTPUT CLOSE .
END. 

hParser:SET-INPUT-SOURCE ("FILE", t) NO-ERROR.
hParser:SAX-PARSE() NO-ERROR.
CASE hParser:PARSE-STATUS :
     WHEN SAX-COMPLETE THEN DO :
         i = 0.

         FOR each internal-ttgeo:
                i = i + 1.
                IF i > 1 THEN leave.
         END.

         IF i = 1 THEN do:
             FIND first internal-ttgeo.
             IF internal-ttgeo.Accuracy <> "APPROXIMATE" THEN
                 rta = TRUE.
             ELSE DO:
                 rta = FALSE.
                 MESSAGE "La precision de la geocodificacion es " internal-ttgeo.Accuracy                      SET rta
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
                     TITLE  "Acepta la geocodificacion obtenida".
                END.
             END.
             IF rta THEN DO:
                 oldnf = SESSION:NUMERIC-FORMAT.
                 SESSION:NUMERIC-FORMAT = "AMERICAN".
                 glat = decimal(entry(2,internal-ttgeo.coordinates)).
                 glong = decimal(entry(1,internal-ttgeo.coordinates)).
                 SESSION:NUMERIC-FORMAT=oldnf.
             END.
         END.
        END.

        
        IF error-status:error THEN do:
        message "Ocurrio un error en Geocoding.i - geocoding " view-as alert-box error.
        return error.
    END.
    DELETE OBJECT hParser.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geocodingOPT Include 
PROCEDURE geocodingOPT :
/*------------------------------------------------------------------------------
  Purpose:   retornar la geocodificacion de la direccion solicitada  
  Parameters:  <none>
  Notes:  si no se aclara un pais pone Argentina AR     
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM vxal AS CHARACTER. /*direccion preferentemente en formato xAL ver toxAL*/
DEFINE OUTPUT PARAMETER TABLE FOR internal-ttgeo.

DEFINE VARIABLE oldnf AS CHAR NO-UNDO.
DEFINE VAR rta AS LOGICAL NO-UNDO.
DEFINE VARIABLE hParser AS HANDLE NO-UNDO.
DEFINE VAR q AS CHAR NO-UNDO.
define var i as int no-undo.
DEF VAR t AS CHAR NO-UNDO.
DEFINE VARIABLE mLine AS MEMPTR     NO-UNDO.
DEFINE VAR clave AS CHAR NO-UNDO.
CREATE SAX-READER hParser.
hParser:HANDLER = this-procedure.
vxal = replace(vxal ," " , "+").
vxal = REPLACE(vxal,",CABA",",CIUDAD+AUTONOMA+DE+BUENOS+AIRES").
vxal = REPLACE(vxal,",CAPITAL FEDERAL",",CIUDAD+AUTONOMA+DE+BUENOS+AIRES").
oldnf = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT = "AMERICAN".
DEFINE VAR llamadageo AS CHAR NO-UNDO.
T = Temp-File("").
RUN GETparametro_c.p ("GEOKEY", OUTPUT clave).
q="https://maps.googleapis.com/maps/api/geocode/xml?address=" + vxal + "&sensor=false&key="+ clave .
DOS SILENT VALUE("..\procs\curl  -k -o " + t + " " + q ).
INPUT FROM value(t) BINARY.
SEEK INPUT TO END .
SEEK INPUT TO (SEEK(INPUT) - 1) .
SET-SIZE(mLine) = 0 .
SET-SIZE(mLine) = 1 .
IMPORT UNFORMATTED mLine .
INPUT CLOSE .

IF get-byte(mLine,1) <> 10 THEN DO:
  OUTPUT TO value(t) APPEND .
  PUT UNFORMATTED "~n" .
  OUTPUT CLOSE .
END. 

hParser:SET-INPUT-SOURCE ("FILE", t) NO-ERROR.

hParser:SAX-PARSE() NO-ERROR.
CASE hParser:PARSE-STATUS :
     WHEN SAX-COMPLETE THEN DO :
         SESSION:NUMERIC-FORMAT=oldnf.  
         DELETE OBJECT hParser.
     END.
     WHEN SAX-PARSER-ERROR THEN DO :
           MESSAGE "Error busqueda en GoogleMaps" VIEW-AS ALERT-BOX.
           RETURN ERROR.
        END.
     OTHERWISE DO :
           MESSAGE "Status Desconocido" VIEW-AS ALERT-BOX.
           RETURN ERROR.
     END.      
END CASE.   

IF error-status:error THEN do:
    DELETE OBJECT hParser.
    message "Ocurrio un error en parser geocodingOPT" view-as alert-box error.
    return error.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE StartDocument Include 
PROCEDURE StartDocument :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    empty temp-table internal-ttgeo.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE StartElement Include 
PROCEDURE StartElement :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER namespaceURI AS CHARACTER.
DEFINE INPUT PARAMETER localName AS CHARACTER.
DEFINE INPUT PARAMETER qname AS CHARACTER.
DEFINE INPUT PARAMETER attributes AS HANDLE.
clee = IF clee = "" THEN localName ELSE clee + "," + localName.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION distGeodesica Include 
FUNCTION distGeodesica RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ):
/*Parametros angulares Lat/long retorna Metros*/
    
DEFINE VAR latr1 AS DECIMAL NO-UNDO.
DEFINE VAR longr1 AS DECIMAL NO-UNDO.
DEFINE VAR latr2 AS DECIMAL NO-UNDO.
DEFINE VAR longr2 AS DECIMAL NO-UNDO.
latr1 = radians(lat1).
longr1 = radians(long1).
latr2 = radians(lat2).
longr2 = radians(long2).

RETURN distGeodesicaUTM ( Xr(latr1,longr1),
                      Yr(latr1,longr1),
                      Xr(latr2,longr2),
                      Yr(latr2,longr2)).
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION distgeodesicaUTM Include 
FUNCTION distgeodesicaUTM RETURN DECIMA ( INPUT x1 AS DECIMAL,
                INPUT y1 AS DECIMAL,
                INPUT x2 AS DECIMAL,
                INPUT y2 AS DECIMAL ):
/*parametros en UTM retorna Metros*/
/*MESSAGE x1 y1 x2 y2 VIEW-AS ALERT-BOX ERROR.*/
    RETURN SQRT ( EXP( (x1 - x2 ) ,2 ) + EXP( (y1 - y2 ) , 2 )). 

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION disti Include 
FUNCTION disti RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ):
/*Parametros RADIANES Lat/long retorna Metros*/
    

DEFINE VAR S AS DECIMAL.
DEFINE VAR c AS DECIMAL.
DEFINE VAR O AS DECIMAL.
DEFINE VAR R AS DECIMAL.
DEFINE VAR W1 AS DECIMAL.
DEFINE VAR W2 AS DECIMAL.
  
S= SQRT(Sinr((lat1 - lat2) / 2 ) * Cosr((long1 - long2 ) / 2)) +
   SQRT(Cosr((lat1 + lat2) / 2 ) * Sinr((long1 - long2 ) / 2)).
    
C =  SQRT(Cosr((lat1 - lat2) / 2 ) * Cosr((long1 - long2) / 2 )) +
   SQRT(Sinr((lat1 + lat2) / 2 ) * Sinr((LONG1 - LONG2) / 2 )).
O = ATanR(Sqrt( S / C )).
R = Sqrt( S * C ) / ATanr( Sqrt( S / C )).


W1 = SQRT( Sinr((lat1 + lat2) / 2 ) * COSr((lat1 - lat2) / 2 ) ) * ( 3 * Sqrt( S * C ) / ATanR(Sqrt( S / C ) ) - 1 ) / ( 2 * C ) * ( 1 / 298.257 ) + 1.
W2 = SQRT( COSR((lat1 + lat2) / 2 ) * Sinr((lat1 - lat2) / 2 ) ) * ( 3 * Sqrt( S * C ) / ATanR(Sqrt( S / C ) ) + 1 ) / ( 2 * S ) * ( 1 / 298.257 ).

  RETURN 2 * ATanR( Sqrt( S / C ) ) * 6378.14 * ( W1 - W2 ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION disti2 Include 
FUNCTION disti2 RETURN DECIMAL ( INPUT lat1 AS DECIMAL,
                                             INPUT long1 AS DECIMAL, 
                                             INPUT lat2 AS DECIMAL, 
                                             INPUT long2 AS DECIMAL ):
/*Parametros angulares Lat/long retorna Metros*/
    
DEFINE VAR latr1 AS DECIMAL NO-UNDO.
DEFINE VAR longr1 AS DECIMAL NO-UNDO.
DEFINE VAR latr2 AS DECIMAL NO-UNDO.
DEFINE VAR longr2 AS DECIMAL NO-UNDO.
latr1 = radians(lat1).
longr1 = radians(long1).
latr2 = radians(lat2).
longr2 = radians(long2).
    
RETURN ACOS(  sinr(latr1) * sinr(latr2) + COSr(latr1) * COSr(latr2) * COSr( long2 - long1 ) ) * 111302 .
  

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION LongZone Include 
FUNCTION LongZone RETURNS DECIMAL
  ( lon AS DECIMAL ) :
/*------------------------------------------------------------------------------
  Purpose: Zona de geografica medidas en grados decimales 
    Notes:  
------------------------------------------------------------------------------*/

  RETURN LongZoner(radians(lon)).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION LongZoner Include 
FUNCTION LongZoner RETURNS INTEGER ( INPUT lon AS DECIMAL ):
/*latitud y longitud va en radianes*/
    RETURN  31 + INT( degrees(lon) / 6 ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION LongZonerCM Include 
FUNCTION LongZonerCM RETURNS INTEGER ( INPUT lon AS DECIMAL ):
/*long en radianes*/
    RETURN  int( 6 * LongZoner(lon) - 183 ).


END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION nu Include 
FUNCTION nu RETURNS DECIMAL ( INPUT lat AS DECIMAL ):
    RETURN {&a} / EXP( 1 - EXP( {&CONSTANT_ECC} , 2 ) * EXP( sinr( lat ) , 2 ) , 0.5 ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION p Include 
FUNCTION p RETURNS DECIMAL ( INPUT lon AS DECIMAL ):
/*latitud y longitud va en radianes*/
    /*delta zone*/
    RETURN ( degrees(lon) - LongZonerCM(lon)) * 3600 / 10000.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION point Include 
FUNCTION point RETURNS CHARACTER
  ( a AS char, b AS char ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  RETURN a + b.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rho Include 
FUNCTION rho RETURNS DECIMAL ( INPUT lat AS DECIMAL ) :
  RETURN {&a} * ( 1 - {&CONSTANT_ECC} * {&CONSTANT_ECC} ) / EXP( 1 - EXP( {&CONSTANT_ECC} * sinr( lat )  , 2 ) , 3 / 2 ).
    /*
    =a*(1-e*e)/((1-(e*SENO(LAT))^2)^(3/2))
    */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION s Include 
FUNCTION s RETURNS DECIMAL ( INPUT lat AS DECIMAL ):
/*la latitud en radianes*/
   
    RETURN {&A0} * lat - {&B0} * sinr( 2 * lat ) + {&C0} * sinr( 4 * lat )
     - {&D0} * sinr( 6 * lat ) + {&E0} * sinr( 8 * lat ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Temp-File Include 
FUNCTION Temp-File RETURNS CHARACTER
  ( direct AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: retorna el fullpath de  archivo temporal  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR seed AS CHAR NO-UNDO.
DEFINE VAR ERROR_nro AS LOGICAL NO-UNDO.
IF direct = "" THEN direct = SESSION:TEMP-DIRECTORY.
/*seed = GUID(GENERATE-UUID).*/
seed=USERID("sic").
xfile = SUBST('&1cr-' + seed , direct) . 
xfile = REPLACE(xfile,"/","\").
/*OS-DELETE value(xfile + ".xml" ).
IF ERROR-STATUS:ERROR THEN DO:
    MESSAGE "El archivo " xfile " esta siendo usado por otro usuario" SKIP 
            "no se puede proseguir" VIEW-AS alert-box error.
    RETURN ERROR.
END.
OS-DELETE value(xfile + ".pdf" ).
IF ERROR-STATUS:ERROR THEN DO:
    MESSAGE "El archivo " xfile " esta siendo usado por otro usuario" SKIP 
            "no se puede proseguir" VIEW-AS alert-box error.
    RETURN ERROR.
END.*/
RETURN xfile.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION toxAL Include 
FUNCTION toxAL RETURNS CHARACTER
  ( dd AS CHAR , OUTPUT v-extra AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose: retorna una direccion del tipo xAL limpia solo calle y altura para ser geocodificada 
    Notes:  v-extra se devuelve el sobrante de la direccion que puede utilizarse como complemento despues de la correccion
------------------------------------------------------------------------------*/
DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
RUN decodir(dd, OUTPUT v-calle,OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
v-altura = ENTRY(1,v-altura,"/"). /*Eliminal AS alturas de calle DEL tipo 3343/50.*/
RETURN v-altura + " " + v-calle + IF v-refer <> "" THEN " (" + v-refer + ")" ELSE "" .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION X Include 
FUNCTION X RETURNS DECIMAL
  ( lat AS DECIMAL , lon AS decimal ) :
/*------------------------------------------------------------------------------
  Purpose: posicion X UTM com medidas en grados decimales 
    Notes:  
------------------------------------------------------------------------------*/

  RETURN xr( radians(lat) , radians(lon) ).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Xr Include 
FUNCTION Xr RETURNS DECIMAL ( INPUT lat AS DECIMAL, INPUT lon AS DECIMAL):
/*latitud y longitud va en radianes*/
    /*
x = easting = K4p + K5p3, where

K4 = k0sinr1" nu cosr(lat) 
K5 = (k0sinr31" nu cosr3(lat)/6)[1 - tanr2(lat) + e'2cosr2(lat)] 
*/
    DEFINE VAR k4 AS DECIMAL NO-UNDO.
    DEFINE VAR k5 AS DECIMAL NO-UNDO.
    DEFINE VAR p AS DECIMAL NO-UNDO.
    DEFINE VAR nu AS DECIMAL NO-UNDO.
     p = p(lon).
     nu = nu(lat).
     K4 = 10000 * nu * cosr(lat) * {&sin1} * {&k0}  .
     K5 = EXP ( exp( 10 , 3 ) * {&Sin1} * COSr(lat) , 3 ) * ( nu / 6 )*( 1 - exp( TANr(lat) , 2 ) + {&e1sq} * exp( COS(lat) , 2 )) * {&k0} * 1000000000000 * exp( 10 , -9 ).
    RETURN 500000 + k4 * p + k5 * EXP( p , 3 ).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Y Include 
FUNCTION Y RETURNS DECIMAL
  ( lat AS DECIMAL , lon AS decimal ) :
/*------------------------------------------------------------------------------
  Purpose: posicion Y UTM com medidas en grados decimales 
    Notes:  
------------------------------------------------------------------------------*/

  RETURN Yr( radians(lat) , radians(lon) ).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Yr Include 
FUNCTION Yr RETURNS DECIMAL ( INPUT lat AS DECIMAL, INPUT lon AS DECIMAL):
/*latitud y longitud va en radianes*/
    /*
    y = northing = K1 + K2p2 + K3p4, where

K1 = Sk0, 
K2 = k0sinr21" nu sinr(lat)cosr(lat)/2 
K3 = [k0sinr41" nu sinr(lat)cosr3(lat)/24][(5 - tanr2(lat) + 9e'2cosr2(lat) + 4e'4cosr4(lat)] 
    */
    
    DEFINE VAR k1 AS DECIMAL  NO-UNDO.
    DEFINE VAR k2 AS DECIMAL NO-UNDO.
    DEFINE VAR k3 AS DECIMAL  NO-UNDO.
    DEFINE VAR p AS DECIMAL  NO-UNDO.
    DEFINE VAR ry AS DECIMAL  NO-UNDO.
    DEFINE VAR nu AS DECIMAL  NO-UNDO.
    p = p(lon).
    nu = nu(lat).

    K1 = S( lat ) * {&k0}.

    K2 = nu * 100000000 * {&k0} * sinr(lat) * cosr(lat) * {&sin1} * {&sin1}  / 2.
    /*la multiplicacion y division por exp( 10 , 15 ) es para mejorar la resolucion en las cuentas */
    K3 = (( exp( 10 , 15 ) * {&Sin1} * {&Sin1} * {&Sin1} * {&Sin1} * nu * sinr(lat) * exp( cosr(lat) , 3 )) / 24 ) 
       * ( 5 - exp( tanr( lat ) , 2 ) + 9 * {&e1sq} * exp( cosr(lat), 2) + 4  * {&e1sq} * {&e1sq} * exp(cosr(lat),4)  ) *  {&k0} * 10000000000000000 / exp( 10 , 15 ). 
    ry =  K1 + K2 * EXP( p ,2) + K3 * exp( p ,4).
    
    RETURN IF ry < 0 THEN 10000000 + ry ELSE ry.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

