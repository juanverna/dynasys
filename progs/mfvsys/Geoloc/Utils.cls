 
 /*------------------------------------------------------------------------
    File        : Utils
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Sat Mar 21 19:14:59 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

CLASS mfvsys.Geoloc.Utils FINAL: 
    {inc/ttlocations.i STATIC}

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC STATIC LOGICAL XMLtoLocation(INPUT xml AS LONGCHAR, OUTPUT cStatus AS CHARACTER, OUTPUT TABLE ttLocations):
		DEFINE VARIABLE hDoc    AS HANDLE NO-UNDO.
		DEFINE VARIABLE hRoot   AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo1  AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo2  AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo3  AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo4  AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo5  AS HANDLE NO-UNDO.
		DEFINE VARIABLE hNodo6  AS HANDLE NO-UNDO.
        DEFINE VARIABLE iNode   AS INT64  NO-UNDO.
        DEFINE VARIABLE iNodes  AS INT64  NO-UNDO.
        DEFINE VARIABLE iComp   AS INT64  NO-UNDO.
        DEFINE VARIABLE iComps  AS INT64  NO-UNDO.
        DEFINE VARIABLE iCampo  AS INT64  NO-UNDO.
        DEFINE VARIABLE iCampos AS INT64  NO-UNDO.

        DEFINE VARIABLE cTipo        AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cDescripcion AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cNumero      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cCalle       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cLocalidad   AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cCiudad      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cProvincia   AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cPais        AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cLong        AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cShort       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cType1       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cType2       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE dLat         AS DECIMAL   NO-UNDO.
        DEFINE VARIABLE dLong        AS DECIMAL   NO-UNDO.
        DEFINE VARIABLE cNodo4       AS CHARACTER NO-UNDO.

        DEFINE VARIABLE iOrden AS INT64 NO-UNDO.

		CREATE X-DOCUMENT hDoc.
        CREATE X-NODEREF hRoot.
        CREATE X-NODEREF hNodo1.
        CREATE X-NODEREF hNodo2.
        CREATE X-NODEREF hNodo3.
        CREATE X-NODEREF hNodo4.
        CREATE X-NODEREF hNodo5.
        CREATE X-NODEREF hNodo6.

        EMPTY TEMP-TABLE ttLocations.
        
        IF NOT hDoc:LOAD ("file":U, "c:\temp\cxml2.xml", FALSE) THEN
            RETURN FALSE.

        IF NOT hDoc:GET-DOCUMENT-ELEMENT(hRoot) THEN
            RETURN FALSE.

        /*Obtenemos el nodo <status> para saber el resultado*/
        hRoot:GET-CHILD (hNodo1, 2).
        hNodo1:GET-CHILD (hNodo2,1).
        ASSIGN cStatus = hNodo2:NODE-VALUE.
        IF hNodo2:NODE-VALUE NE "OK":U THEN
            RETURN FALSE.

        ASSIGN iNodes = hRoot:NUM-CHILDREN.

        /*Navega por los nodos "result", hay uno por cada direccion
          que hace match con lo ingresado*/
        principal:
        REPEAT iNode = 3 TO iNodes:
            hRoot:GET-CHILD (hNodo1, iNode).
            IF hNodo1:NAME = "result":U THEN DO:
                ASSIGN iComps        = hNodo1:NUM-CHILDREN
                       cTipo         = "":U
                       cDescripcion  = "":U
                       cNumero       = "":U
                       cCalle        = "":U
                       cLocalidad    = "":U
                       cCiudad       = "":U
                       cProvincia    = "":U
                       cPais         = "":U.

                    hNodo1:GET-CHILD (hNodo2, 2).
                    IF hNodo2:NAME = "type":U THEN DO:
                        hNodo2:GET-CHILD (hNodo3, 1).
                        ASSIGN cTipo = hNodo3:NODE-VALUE.
                    END.
                    IF cTipo NE "street_address":U THEN
                        NEXT.
/*
https://www.google.com/fusiontables/DataSource?docid=1awzbzy3y_ndadErwt6o4Nm5tH-0MrcxQTWCQftw
*/
                /*Navegamos los componentes de la direccion*/
                REPEAT iComp = 3 TO iComps:
                    hNodo1:GET-CHILD (hNodo2, iComp).
                    CASE hNodo2:NAME:
                        WHEN "formatted_address":U THEN DO:
                            hNodo2:GET-CHILD (hNodo3, 1).
                            ASSIGN cDescripcion = hNodo3:NODE-VALUE.
                        END.
                        WHEN "address_component":U THEN DO:
                            ASSIGN iCampos = hNodo2:NUM-CHILDREN
                                   cLong   = "":U
                                   cShort  = "":U
                                   cType1  = "":U
                                   cType2  = "":U.

                            REPEAT iCampo = 1 TO iCampos:
                                hNodo2:GET-CHILD(hNodo4, iCampo).
                                ASSIGN cNodo4 = hNodo4:NAME.

                                IF cNodo4 = "#text":U THEN
                                    NEXT.

                                hNodo4:GET-CHILD (hNodo5,1).

                                CASE cNodo4:
                                    WHEN "short_name":U THEN ASSIGN cShort = hNodo5:NODE-VALUE.
                                    WHEN "long_name":U  THEN ASSIGN cLong  = hNodo5:NODE-VALUE.
                                    WHEN "type" THEN DO:
                                         IF cType1 = "":U THEN
                                             ASSIGN cType1 = hNodo5:NODE-VALUE.
                                         ELSE
                                             ASSIGN cType2 = hNodo5:NODE-VALUE.
                                    END.
                                END CASE.
                                CASE cType2:
                                    WHEN "":U THEN DO:
                                        IF cType1 = "street_number":U THEN
                                            ASSIGN cNumero = cLong.
                                        ELSE IF cType1 = "route":U THEN
                                            ASSIGN cCalle = cShort.
                                    END.
                                    WHEN "political":U THEN DO:
                                        CASE cType1:
                                            WHEN "locality":U                    THEN ASSIGN cLocalidad = cLong.
                                            WHEN "administrative_area_level_2":U THEN ASSIGN cCiudad    = cLong.
                                            WHEN "administrative_area_level_1":U THEN ASSIGN cProvincia = cLong.
                                            WHEN "country":U                     THEN ASSIGN cPais      = cLong.
                                        END CASE.
                                    END.
                                END CASE. /*CASE cType2:*/
                            END. /*REPEAT iCampo = 1 TO iCampos:*/
                        END. /*address_component*/
                        WHEN "geometry":U THEN DO:
                            hNodo2:GET-CHILD(hNodo4, 2). /*Location*/
                            REPEAT iCampo = 1 TO 5:
                                hNodo4:GET-CHILD (hNodo5, iCampo).

                                IF hNodo5:NAME = "#text":U THEN
                                    NEXT. 

                                hNodo5:GET-CHILD (hNodo6, 1).
                                IF hNodo5:NAME = "lat":U THEN
                                    ASSIGN dLat = DECIMAL(REPLACE(hNodo6:NODE-VALUE, ".",",")).
                                 ELSE IF hNodo5:NAME = "lng":U THEN
                                    ASSIGN dLong = DECIMAL(REPLACE(hNodo6:NODE-VALUE, ".",",")).
                            END.
                        END.
                    END CASE. /*CASE hNodo2:NAME:*/
                END. /*REPEAT iComp = 1 TO iComps:*/
                CREATE ttLocations.
                ASSIGN ttLocations.Calle       = cCalle
                       ttLocations.Ciudad      = cCiudad
                       ttLocations.Descripcion = cDescripcion
                       ttLocations.Latitud     = dLat
                       ttLocations.Longitud    = dLong
                       ttLocations.Numero      = cNumero
                       ttLocations.Orden       = iOrden
                       ttLocations.Pais        = cPais
                       ttLocations.Partido     = cLocalidad
                       ttLocations.Provincia   = cProvincia
                       ttLocations.Tipo        = cTipo
                       iOrden                  = iOrden + 1.
            END. /*IF hNodo1:NAME = "result":U THEN DO:*/
        END. /*REPEAT iNode = 1 TO iNodes:*/

        DELETE OBJECT hNodo2 NO-ERROR.
        DELETE OBJECT hNodo1 NO-ERROR.
        DELETE OBJECT hRoot  NO-ERROR.
        DELETE OBJECT hDoc   NO-ERROR.

		RETURN TRUE.
	END METHOD.
END CLASS.
