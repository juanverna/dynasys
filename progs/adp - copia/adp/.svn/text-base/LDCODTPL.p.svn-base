DEFINE VARIABLE WL-CCN-CODTPL         AS INTEGER.
DEFINE VARIABLE WL-CCN-CODIGO         AS INTEGER.

INPUT FROM "CODLIQUD.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-CCN-CODTPL
         WL-CCN-CODIGO.

  FIND Concepto WHERE Concepto.cdg_concepto = WL-CCN-CODIGO.
  CREATE Concepto_Liquidacion.
  ASSIGN  
         Concepto_Liquidacion.cdg_liquid   = WL-CCN-CODTPL.
         Concepto_Liquidacion.nro_concepto = Concepto.nro_concepto.
END.         