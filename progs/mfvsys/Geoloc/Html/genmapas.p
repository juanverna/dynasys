
/*------------------------------------------------------------------------
    File        : genmapas.p
    Purpose     : 

    Syntax      :

    Description : Genera los mapas con una o mas de una hubicacion.

    Author(s)   : Marcelo Ferrante
    Created     : Fri Mar 27 17:40:54 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
{inc/ttlocmapa.i}

DEFINE INPUT PARAMETER pcArchivo AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER TABLE FOR ttLocMapa.

DEFINE VARIABLE impComa  AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cMarkers AS CHARACTER NO-UNDO.
DEFINE VARIABLE cJS      AS CHARACTER NO-UNDO.
DEFINE VARIABLE cMarker  AS CHARACTER NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
ASSIGN FILE-INFO:FILE-NAME = "mfvsys/Geoloc/Markers/blank.png"
       cMarkers = REPLACE(REPLACE(FILE-INFO:FULL-PATHNAME, "blank.png":U, "":U), "\":U, "/":U).

ASSIGN FILE-INFO:FILE-NAME = "mfvsys/Geoloc/Html/genmapas.r"
       cJS = REPLACE(REPLACE(FILE-INFO:FULL-PATHNAME, "genmapas.r":U, "":U), "\":U, "/":U).

OUTPUT TO VALUE(pcArchivo).
    PUT UNFORMATTED
      '<!DOCTYPE html><html><head>' SKIP 
      '<meta http-equiv="content-type" content="text/html; charset=UTF-8" />' SKIP 
      '<title>Google Maps Multiple Markers</title>' SKIP
      '<script src="https://maps.google.com/maps?file=api&amp;v=3&amp;key=AIzaSyDWJAlUHjKWv4cB1O2QKRt1JI-khfVvy4s" type="text/javascript"></script>' SKIP
      '<script src="' cJS 'markerwithlabel.js" type="text/javascript"></script>' SKIP
      '<style>  .labels ~{text-align: center; height: 40px; width: 40px; white-space: nowrap; } </style></head>' SKIP 
      '<script type="text/javascript">' SKIP
      'function initialize() ~{' SKIP
      'var locations = ['.

      FOR EACH ttLocMapa NO-LOCK BY id:
          IF impComa THEN
              PUT UNFORMATTED ",".
          ASSIGN cMarker = cMarkers + (IF ttLocMapa.marker = "":U THEN "blank.png":U ELSE ttLocMapa.marker).
          PUT UNFORMATTED "[" QUOTER(ttLocMapa.descripcion) ",".
          PUT UNFORMATTED REPLACE(STRING(ttLocMapa.Latitud), ",":U, ".":U) "," REPLACE(STRING(ttLocMapa.Longitud), ",":U, ".":U) "," ttLocMapa.id "," QUOTER(cMarker) "," (IF ttLocMapa.popupLabel = ? THEN "":U ELSE QUOTER(STRING(ttLocMapa.popupLabel))) "]" SKIP.
          impComa = TRUE.
      END.

      PUT UNFORMATTED
       '];' SKIP
      'var myOptions = ~{' SKIP
      'zoom: 11,' SKIP
      'mapTypeId: google.maps.MapTypeId.ROADMAP }' SKIP
      "var map = new google.maps.Map(document.getElementById('map'), myOptions);" SKIP
      'var bounds = new google.maps.LatLngBounds();' SKIP
      'var infowindow = new google.maps.InfoWindow();' SKIP
      'var marker, i;' SKIP
      'for (i = 0; i < locations.length; i++) ~{' SKIP
      "var image = new google.maps.MarkerImage(locations[i][4]," SKIP
      'new google.maps.Size(20, 34),' SKIP
      'new google.maps.Point(0, 0),' SKIP
      'new google.maps.Point(10, 34));' SKIP.

/*
    var pictureLabel = document.createElement("img");
     pictureLabel.src = "img/atanor.png";
     pictureLabel.height = 40;
     pictureLabel.width = 40;
*/
      PUT UNFORMATTED
        'var myLatLng = new google.maps.LatLng(locations[i][1], locations[i][2]);' SKIP
        'bounds.extend(myLatLng);' SKIP
        'marker = new MarkerWithLabel(~{' SKIP
        'position: myLatLng,' SKIP
        'map: map,' SKIP
        'icon: image,' SKIP
        'title: locations[i][0],' SKIP.
        /*'labelContent: pictureLabel,'*/

        PUT UNFORMATTED
        'labelAnchor: new google.maps.Point(20, 0),' SKIP
        'labelClass: "labels",' SKIP
        'labelStyle: ~{opacity: 0.5}});' SKIP
        'map.fitBounds(bounds);' SKIP
        'map.panToBounds(bounds);' SKIP
        "google.maps.event.addListener(marker, 'click', (function(marker, i) ~{" SKIP
        'return function() ~{' SKIP
        'infowindow.setContent(locations[i][5]);' SKIP
        'infowindow.open(map, marker);}})(marker, i));}}' SKIP
        '</script>' SKIP
        '<body style="margin:0px; padding:0px;" onload="initialize();">' SKIP
        '<div id="map" style="width:100%; height:580px;"></div>
            <div id="leyenda">
        <h3><img src="img/dewalt.png" style="width:30px">Leyenda</h3>
        <hr size="2px" color="black" />
    </div></body></html>' SKIP.
