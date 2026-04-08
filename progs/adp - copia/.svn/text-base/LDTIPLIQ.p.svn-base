DEFINE VARIABLE WL-TPL-CODIGO         AS INTEGER.
DEFINE VARIABLE WL-TPL-NOMBRE         AS CHARACTER.
DEFINE VARIABLE WL-TPL-DESDEM         AS INTEGER.
DEFINE VARIABLE WL-TPL-DESDED         AS INTEGER.
DEFINE VARIABLE WL-TPL-HASTAM         AS INTEGER.
DEFINE VARIABLE WL-TPL-HASTAD         AS INTEGER.
DEFINE VARIABLE WL-TPL-FORPRE         AS CHARACTER.
DEFINE VARIABLE WL-TPL-FORPOS         AS CHARACTER.

FOR EACH Tipo_de_liquidac:
    DELETE Tipo_de_liquidac.
END.    

INPUT FROM "TIPLIQUD.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-TPL-CODIGO
         WL-TPL-NOMBRE
         WL-TPL-DESDEM
         WL-TPL-DESDED
         WL-TPL-HASTAM
         WL-TPL-HASTAD
         WL-TPL-FORPRE
         WL-TPL-FORPOS.

  CREATE Tipo_de_liquidac.
  ASSIGN                      
         Tipo_de_liquidac.cdg_liquid      = WL-TPL-CODIGO.
         Tipo_de_liquidac.descripcion     = WL-TPL-NOMBRE.
         Tipo_de_liquidac.formula_final   = WL-TPL-FORPOS.
         Tipo_de_liquidac.formula_inicial = WL-TPL-FORPRE.
         
END.         