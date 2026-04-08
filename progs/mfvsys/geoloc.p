
/*------------------------------------------------------------------------
    File        : geoloc.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sat Mar 07 15:02:55 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
USING System.Net.*.
USING mfvsys.Geoloc.Forms.SeleccionDireccionDialog.
USING System.IO.*.
USING System.Xml.Linq.*.
USING System.Windows.Forms.* FROM ASSEMBLY.
USING Progress.Util.*        FROM ASSEMBLY.
USING mfvsys.Geoloc.Forms.WaitAddressForm.

DEFINE INPUT-OUTPUT PARAMETER pcDireccion AS CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER pcLocalidad AS CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER pcProvincia AS CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER pcPais      AS CHARACTER NO-UNDO.
DEFINE OUTPUT       PARAMETER pdLat       AS DECIMAL   NO-UNDO.
DEFINE OUTPUT       PARAMETER pdLong      AS DECIMAL   NO-UNDO.
/*
DEFINE VARIABLE pcdireccion AS CHARACTER NO-UNDO INITIAL "Paysandu 1621".
DEFINE VARIABLE pclocalidad AS CHARACTER NO-UNDO INITIAL "caba".
DEFINE VARIABLE pcprovincia AS CHARACTER NO-UNDO INITIAL "caba".
DEFINE VARIABLE pcpais  AS CHARACTER NO-UNDO INITIAL "argentina".
DEFINE VARIABLE pdlat AS DECIMAL NO-UNDO.
DEFINE VARIABLE pdlong AS DECIMAL NO-UNDO.
*/
DEFINE VARIABLE address    AS CHARACTER              NO-UNDO.
DEFINE VARIABLE requestUri AS System.Uri             NO-UNDO.
DEFINE VARIABLE wrequest   AS System.Net.WebRequest  NO-UNDO.
DEFINE VARIABLE wresponse  AS System.Net.WebResponse NO-UNDO.
DEFINE VARIABLE reader     AS StreamReader           NO-UNDO.
DEFINE VARIABLE cXML       AS LONGCHAR               NO-UNDO.
DEFINE VARIABLE hDoc       AS HANDLE                 NO-UNDO.
DEFINE VARIABLE hRoot      AS HANDLE                 NO-UNDO.
DEFINE VARIABLE cStatus    AS CHARACTER              NO-UNDO.
DEFINE VARIABLE iLocs AS INT64 NO-UNDO.
DEFINE VAR clave AS CHAR NO-UNDO.
DEFINE VARIABLE waitForm AS WaitAddressForm.
DEFINE VAR nf AS CHAR NO-UNDO.

{inc/ttlocations.i}
nf = session:NUMERIC-FORMAT.
session:NUMERIC-FORMAT="European".
/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
waitForm = NEW WaitAddressForm().
waitForm:Show().
RUN GETparametro_c.p ("GEOKEY", OUTPUT clave).
ASSIGN address    = TRIM(pcDireccion) + "," /*+ TRIM(pcLocalidad) + "," */ + TRIM(pcProvincia) + "," + TRIM(pcPais).
       requestURI = NEW System.URI("https://maps.googleapis.com/maps/api/geocode/xml?sensor=true&key=" + clave + "&address=" + address).
       wrequest   = System.Net.WebRequest:Create(requestUri).
       wresponse  = wrequest:GetResponse().
       reader     = NEW StreamReader(wresponse:GetResponseStream(), System.Text.Encoding:UTF7).
       cXML       = reader:ReadToEnd().
COPY-LOB FROM cXML TO FILE "c:\temp\cxml2.xml".
       
IF NOT mfvsys.Geoloc.Utils:XMLtoLocation(cXML, OUTPUT cStatus, OUTPUT TABLE ttLocations) THEN DO:
    waitForm:Close().
    waitForm:Dispose().
    RETURN ERROR "Direccion Invalida. Server status: " + cStatus.
END.

waitForm:Close().
waitForm:Dispose().
FOR EACH ttLocations NO-LOCK:
    ASSIGN iLocs = iLocs + 1.
    IF iLocs > 1 THEN LEAVE.
END.
pdlat = 0.
pdlong = 0.
IF iLocs = 0 THEN DO:
    RETURN ERROR "La Direccion Ingresada es Inexistente".
END.

IF iLocs = 1 THEN DO:
    FIND FIRST ttLocations NO-LOCK NO-ERROR.
    ASSIGN pcDireccion = ttLocations.Calle + " " + ttLocations.Numero
           pcLocalidad = ttLocations.Partido
           pcProvincia = ttLocations.Provincia
           pcPais      = ttLocations.Pais
           pdLat       = ttLocations.Latitud
           pdLong      = ttLocations.Longitud.
END.
ELSE DO:
    DEFINE VARIABLE selec AS mfvsys.Geoloc.Forms.SeleccionDireccionDialog NO-UNDO.
    DEFINE VARIABLE enDialogResult AS DialogResult NO-UNDO.

    ASSIGN selec = NEW mfvsys.Geoloc.Forms.SeleccionDireccionDialog(INPUT TABLE ttLocations BY-REFERENCE).

    WAIT-FOR selec:ShowDialog() SET enDialogResult.

    IF EnumHelper:AreEqual (INPUT enDialogResult, INPUT DialogResult:OK) THEN DO:
        FIND FIRST ttLocations WHERE ttLocations.Orden = selec:Seleccion NO-LOCK NO-ERROR.
        ASSIGN pcDireccion = ttLocations.Calle + " " + ttLocations.Numero
               pcLocalidad = ttLocations.Partido
               pcProvincia = ttLocations.Provincia
               pcPais      = ttLocations.Pais
               pdLat       = ttLocations.Latitud
               pdLong      = ttLocations.Longitud.
    END.
    ELSE
        RETURN ERROR "Debe Seleccionar una Direccion Valida".
    selec:Dispose().
    waitForm:Close().
    waitForm:Dispose().
    session:NUMERIC-FORMAT=nf.
END.
