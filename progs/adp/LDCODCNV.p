DEFINE VARIABLE WL-CCN-CODCNV         AS INTEGER.
DEFINE VARIABLE WL-CCN-CODIGO         AS INTEGER.

INPUT FROM "CODCONVE.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-CCN-CODCNV
         WL-CCN-CODIGO.

  FIND Concepto WHERE Concepto.cdg_concepto = WL-CCN-CODIGO.
  CREATE Concepto_Convenio.
  ASSIGN  
         Concepto_Convenio.cdg_convenio = WL-CCN-CODCNV.
         Concepto_Convenio.nro_concepto = Concepto.nro_concepto.
END.         