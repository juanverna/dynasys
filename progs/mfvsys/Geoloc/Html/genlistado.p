
/*------------------------------------------------------------------------
    File        : genlistado.p
    Purpose     : 

    Syntax      :

    Description : Genera el HTML para el listado te sitios a mostrar y seleccionar en un mapa

    Author(s)   : Marcelo Ferrante
    Created     : Sat Mar 21 17:09:14 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
{inc/ttlocations.i}

DEFINE INPUT PARAMETER pcArchivo AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER TABLE FOR ttLocations.

DEFINE VARIABLE impComa AS LOGICAL NO-UNDO.
DEFINE VARIABLE cMarkers AS CHARACTER NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
FILE-INFO:FILE-NAME = "mfvsys/Geoloc/Markers/blank.png".
ASSIGN cMarkers = REPLACE(REPLACE(FILE-INFO:FULL-PATHNAME, "blank.png":U, "marker":U), "\":U, "/":U).

OUTPUT TO VALUE(pcArchivo).
    PUT UNFORMATTED
      '<!DOCTYPE html><html><head>' SKIP 
      '<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>' SKIP 
      '<title>Google Maps Demo</title>' SKIP 
      '<script src="https://maps.google.com/maps?file=api&amp;v=3&amp;key=AIzaSyDWJAlUHjKWv4cB1O2QKRt1JI-khfVvy4s"></script>' SKIP 
      '<script src="jquery.min.js"></script><script type="text/javascript">' SKIP
      'function initialize() ~{' SKIP
      'var myOptions = ~{' SKIP
      'zoom: 11,' SKIP
      'mapTypeId: google.maps.MapTypeId.ROADMAP }' SKIP
      'var map = new google.maps.Map(document.getElementById("map"), myOptions);' SKIP
      'var bounds = new google.maps.LatLngBounds();' SKIP
      'var locations=['.

      FOR EACH ttLocations NO-LOCK BREAK BY orden:
          IF impComa THEN
              PUT UNFORMATTED ",".
          PUT UNFORMATTED "[" QUOTER(ttLocations.Descripcion) ",".
          PUT UNFORMATTED REPLACE(STRING(ttLocations.Latitud), ",":U, ".":U) "," REPLACE(STRING(ttLocations.Longitud), ",":U, ".":U) "," ttLocations.Orden "]" SKIP.
          impComa = TRUE.
      END.
      PUT UNFORMATTED
       '];' SKIP
       'for (var i = 0; i < locations.length; i++) ~{' SKIP
       "var image = new google.maps.MarkerImage('" + cMarkers + "' + (i + 1) + '.png'," SKIP
       'new google.maps.Size(20, 34), new google.maps.Point(0, 0), new google.maps.Point(10, 34));' SKIP
       'var location = locations[i];' SKIP
       'var myLatLng = new google.maps.LatLng(location[1], location[2]);' SKIP
       'bounds.extend(myLatLng);' SKIP
       'var marker = new google.maps.Marker(~{' SKIP
       'position: myLatLng,' SKIP
       'map: map,' SKIP
       'icon: image,' SKIP
       'title: location[0],' SKIP
       'zIndex: location[3]' SKIP
       '});' SKIP
       'map.fitBounds(bounds);' SKIP
       'map.panToBounds(bounds);' SKIP
       '}}</script></head>' SKIP
       '<body style="margin:0px; padding:0px;" onload="initialize();">' SKIP
       '<div id="map" style="width:100%; height:580px;"></div></body></html>' SKIP.
OUTPUT CLOSE.
