/*============================================================================================*/
/*  GENERA EL MAESTRO DE LOCALIDADES EN BASE A LAS DESCRIPCIONES DE LOS DOMICILIOS            */
/*============================================================================================*/

FOR EACH Grupo-domicilio:
    FIND Zona_geografica WHERE Zona_geografica.nombre = Grupo-domicilio.cdg_localidad NO-ERROR.
    IF NOT AVAILABLE Zona_geografica
    THEN DO:
         CREATE Zona_geografica.
         ASSIGN Zona_geografica.cdg_zonag = Grupo-domicilio.cdg_localidad
                Zona_geografica.nombre    = Grupo-domicilio.cdg_localidad.
    END.
END.                
