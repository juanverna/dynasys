DEFINE {1} SHARED VARIABLE des_fecha    LIKE Fac_header.fecha.
DEFINE {1} SHARED VARIABLE has_fecha    LIKE Fac_header.fecha.
DEFINE {1} SHARED VARIABLE des_articulo LIKE Articulo.cdg_articulo   LABEL "Desde Artículo".
DEFINE {1} SHARED VARIABLE has_articulo LIKE Articulo.cdg_articulo   LABEL "Hasta Artículo".
DEFINE {1} SHARED VARIABLE listar_hora  AS LOGICAL LABEL "Fecha y Hora" VIEW-AS TOGGLE-BOX.
DEFINE {1} SHARED VARIABLE todas_cuent  AS LOGICAL LABEL "Incluir s/movim." VIEW-AS TOGGLE-BOX INITIAL NO.
DEFINE {1} SHARED VARIABLE ult_pagina   AS INTEGER FORMAT "999" LABEL "Ultima pagina".
DEFINE {1} SHARED VARIABLE lin_pagina   AS INTEGER FORMAT "999" LABEL "Lineas p/pagina" INITIAL 40.
DEFINE {1} SHARED VARIABLE fecha_lis    AS CHARACTER.
DEFINE {1} SHARED VARIABLE hora_lis     AS CHARACTER.
DEFINE {1} SHARED VARIABLE que_empresa  LIKE Empresa.nombre.
DEFINE {1} SHARED VARIABLE tit_clase    LIKE Clase_de_articulo.nombre_subclase.
DEFINE {1} SHARED VARIABLE pg           AS INTEGER.
DEFINE {1} SHARED VARIABLE primer_nodo  AS CHARACTER LABEL "Primer Nodo".




