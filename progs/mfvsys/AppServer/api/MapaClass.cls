 
 /*------------------------------------------------------------------------
    File        : MapaClass
    Purpose     :  
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Mon Mar 30 20:50:24 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

CLASS api.MapaClass ABSTRACT: 
	DEFINE PUBLIC PROPERTY TipoMapa      AS CHARACTER NO-UNDO INITIAL "google.maps.MapTypeId.ROADMAP":U GET. SET.
	DEFINE PUBLIC PROPERTY Zoom          AS INT64     NO-UNDO INITIAL 11 GET. SET.
	DEFINE PUBLIC PROPERTY Titulo        AS CHARACTER NO-UNDO GET. SET. 
    DEFINE PUBLIC PROPERTY ArchivoHTML   AS CHARACTER NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY UsarLeyenda   AS LOGICAL   NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY TituloLeyenda AS CHARACTER NO-UNDO GET. SET.

    METHOD PUBLIC ABSTRACT LONGCHAR GenerarHubicaciones().
	METHOD PUBLIC ABSTRACT LONGCHAR GenerarLeyenda().

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LONGCHAR GenerarIcono(INPUT path AS CHARACTER,   INPUT fillColor AS CHARACTER, INPUT fillOpacity AS DECIMAL,
                                        INPUT anchor AS CHARACTER, INPUT strokeWeight AS INT64,  INPUT scale AS DECIMAL):
        DEFINE VARIABLE ret AS LONGCHAR NO-UNDO.

        IF path = "":U OR path = ? THEN ASSIGN path = "M189 190 l-32 -40 -74 0 -73 0 0 -65 0 -65 215 0 215 0 0 65 0 65 -68 0 c-68 0 -69 0 -101 40 -17 22 -36 40 -41 40 -5 0 -24 -18 -41 -40z":U.
        IF fillColor = "":U OR fillColor = ? THEN ASSIGN fillColor = '#FFC90E':U.
        IF fillOpacity = 0 THEN ASSIGN fillOpacity = 0.8.        
        IF anchor = "":U OR anchor = ? THEN ASSIGN anchor = " new google.maps.Point(216,90)":U.
        IF strokeWeight = 0 THEN ASSIGN strokeWeight = 1.
        IF scale = 0 THEN ASSIGN scale = 0.15.

        ASSIGN ret = " var icon = ~{" +
                     ' path: "' + path + '", ' +
                     ' fillColor: "#' + fillColor + '", fillOpacity: ' + REPLACE(STRING(fillOpacity), ",", ".") + ", " +
                     " anchor: " + anchor + ", strokeWeight: " + STRING(strokeWeight) + ", scale: " + REPLACE(STRING(scale), ",", ".") + "}; ":U.
        RETURN ret.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LONGCHAR GenerarMarker(INPUT lat AS CHARACTER, INPUT lng AS CHARACTER,
                                         INPUT labelContent AS CHARACTER, INPUT labelAnchor AS CHARACTER, INPUT labelClass AS CHARACTER, INPUT labelStyle AS CHARACTER):
        DEFINE VARIABLE ret AS LONGCHAR NO-UNDO.

        IF labelAnchor = "":U OR labelAnchor = ? THEN ASSIGN labelAnchor = "new google.maps.Point(30, 5)":U.
        IF labelStyle  = "":U OR labelStyle  = ? THEN ASSIGN labelStyle  = "~{opacity: 0.5}":U.

        ASSIGN ret = " marker = new MarkerWithLabel(~{" +
                     " position: new google.maps.LatLng(":U + lat + ", ":U + lng + ")," +
                     " map: map, icon: icon," +
                     ' labelContent: ' + labelContent + ', ' +
                     " labelAnchor: " + labelAnchor + ", " +
                     ' labelClass: "' + labelClass + '", ' +
                     ' labelStyle: ' + labelStyle + '}); '.
        RETURN ret.
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LONGCHAR GenerarMapOptions():
        DEFINE VARIABLE ret AS LONGCHAR NO-UNDO.
        ASSIGN ret = " var myOptions = ~{zoom: " + STRING(Zoom) + ", mapTypeId: " + TipoMapa + "}; ".
        RETURN ret.
    END. /*GenerarMapOptions()*/

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LONGCHAR GenerarStyleCSS():
        DEFINE VARIABLE ret AS LONGCHAR NO-UNDO.
        ASSIGN ret = "<style> .labels ~{text-align: center; height: 40px; width: 60px; white-space: nowrap;}" +
                     " #leyenda ~{font-family: Arial, sans-serif; background: #fff; padding: 10px; margin: 10px; border: 3px solid #000; max-width: 100px}" +
                     " #leyenda h3 ~{margin-top: 0;}" +
                     " #leyenda img ~{vertical-align: middle;}" +
                     " #ley~{ width: 20px; height: 10px;}</style>".
        RETURN ret.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LONGCHAR GenerarScripts():
        DEFINE VARIABLE ret AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE cJS AS CHARACTER NO-UNDO.
        FIND FIRST Parametro WHERE Parametro.parametro = "MPJSURL":U NO-LOCK NO-ERROR.
        ASSIGN cJS = Parametro.valor + "markerwithlabel.js".

        ASSIGN ret = '<script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>' +
                     '<script src="' + cJS + '" type="text/javascript"></script>'.
        RETURN ret.
    END.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LOGICAL GenerarHtml():
        DEFINE VARIABLE cTemp   AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE cImgDir AS CHARACTER NO-UNDO.

        FIND FIRST Parametro WHERE Parametro.parametro = "MPIMGURL":U NO-LOCK NO-ERROR.
        ASSIGN cImgDir = Parametro.valor + "icon.png":U.

        IF ArchivoHTML = "":U OR ArchivoHTML = ? THEN
            ASSIGN ArchivoHTML = SESSION:TEMP-DIRECTORY + "mapa.html".

        ASSIGN cTemp = '<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text/html; charset=UTF-8" />'.
        IF Titulo NE "":U AND Titulo NE ? THEN
            ASSIGN cTemp = cTemp + "<title>" + Titulo + "</title>".

        ASSIGN cTemp = cTemp + GenerarScripts().

        COPY-LOB FROM cTemp TO FILE ArchivoHTML.
        ASSIGN cTemp = "":U.

        ASSIGN cTemp = GenerarStyleCSS() + '<script type="text/javascript">function initialize() ~{ var bounds = new google.maps.LatLngBounds(); ' +
                       ' var infowindow = new google.maps.InfoWindow( ~{ maxWidth: 180 } ); var marker, i; ' +
                       GenerarMapOptions() +
                       " var map = new google.maps.Map(document.getElementById('map'), myOptions); ".
        COPY-LOB FROM cTemp TO FILE ArchivoHTML APPEND.
        ASSIGN cTemp = "":U.

        IF UsarLeyenda THEN DO:
            ASSIGN cTemp = cTemp + GenerarLeyenda().
            COPY-LOB FROM cTemp TO FILE ArchivoHTML APPEND.
            ASSIGN cTemp = "":U.
        END.

        ASSIGN cTemp = GenerarHubicaciones().
        COPY-LOB FROM cTemp TO FILE ArchivoHTML APPEND.
        ASSIGN cTemp = "":U.

        IF UsarLeyenda THEN
            ASSIGN cTemp = cTemp + "map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(leyenda); ":U.

        ASSIGN cTemp = cTemp + '}</script></head><body style="margin:0px; padding:0px;" onload="initialize();">':U +
                       '<div id="map" style="width:100%; height:580px;"></div>':U.

        IF UsarLeyenda THEN
            ASSIGN cTemp = cTemp + '<div id="leyenda"><h3><img src="' + cImgDir + '" style="width:30px">' + TituloLeyenda + '</h3><hr size="2px" color="black" /></div>':U.

        ASSIGN cTemp = cTemp + '</body></html>':U.

        COPY-LOB FROM cTemp TO FILE ArchivoHTML APPEND.
        ASSIGN cTemp = "":U.
    END. /*GenerarHtml()*/
END CLASS.