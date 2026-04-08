DEFINE VARIABLE centro_uno LIKE Entidad.cdg_entidad LABEL "Para los clientes en el centro de costo".
DEFINE VARIABLE centro_dos LIKE Entidad.cdg_entidad LABEL "Asignarles el nuevo centro de costo".
DEFINE VARIABLE que_lista  LIKE Cliente.dfl_lista LABEL "y que tengan la lista número".

DEFINE BUFFER Nuevocentro FOR Entidad.

UPDATE centro_uno COLON 50 space(5) SKIP que_lista COLON 50 SKIP centro_dos COLON 50 WITH SIDE-LABELS THREE-D.

FIND Nuevocentro WHERE Nuevocentro.cdg_entidad = centro_dos NO-LOCK.
FIND Entidad WHERE Entidad.cdg_entidad = centro_uno NO-LOCK.
FOR EACH Cliente WHERE Cliente.nro_entidad = Entidad.nro_entidad AND Cliente.dfl_lista = que_lista:
    Cliente.nro_entidad = Nuevocentro.nro_entidad.
END.
