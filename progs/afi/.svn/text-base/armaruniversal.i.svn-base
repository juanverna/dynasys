DEFINE VARIABLE linea AS CHARACTER FORMAT "X(156)".

FIND FIRST Grupofam.
FIND FIRST Afiliado OF Grupofam.
FIND FIRST Grupo-domicilio OF Grupofam.
FIND Provincia OF Grupo-domicilio.

OVERLAY(linea,1,3)   = "054".
OVERLAY(linea,4,20)  = Afiliado.cdg_grupofam.
OVERLAY(linea,24,3)  = STRING(Afiliado.num_integrante,"999").
OVERLAY(linea,27,50) = Afiliado.nom_afiliado.
OVERLAY(linea,77,55) = Grupo-domicilio.calle + " " +
                       Grupo-domicilio.nropta + " " +
                       Grupo-domicilio.piso + " " +
                       Grupo-domicilio.depto + "," +
                       Grupo-domicilio.cdg_localidad + "," +
                       Provincia.nombre.
OVERLAY(linea,132,8) = Grupo-domicilio.cdg_postal.
OVERLAY(linea,140,8) = STRING(YEAR(Afiliado.fecha_alta),"9999") + 
                       STRING(MONTH(Afiliado.fecha_alta),"99") + 
                       STRING(DAY(Afiliado.fecha_alta),"99").
OVERLAY(linea,148,8) = "99991231".
OVERLAY(linea,156,1) = "0".


MESSAGE linea VIEW-AS ALERT-BOX.
