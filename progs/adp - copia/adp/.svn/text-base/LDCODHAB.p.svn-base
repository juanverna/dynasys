DEFINE VARIABLE WL-COD-CODIGO         AS INTEGER.
DEFINE VARIABLE WL-COD-NOMBRE         AS CHARACTER.
DEFINE VARIABLE WL-COD-ABREVD         AS CHARACTER.
DEFINE VARIABLE WL-COD-HABRET         AS CHARACTER.
DEFINE VARIABLE WL-COD-OBLIGA         AS CHARACTER.
DEFINE VARIABLE WL-COD-TEMPOR         AS CHARACTER.
DEFINE VARIABLE WL-COD-TOTALZ         AS INTEGER.
DEFINE VARIABLE WL-COD-UNIDAD         AS INTEGER.
DEFINE VARIABLE WL-COD-DESDEM         AS INTEGER.
DEFINE VARIABLE WL-COD-DESDED         AS INTEGER.
DEFINE VARIABLE WL-COD-HASTAM         AS INTEGER.
DEFINE VARIABLE WL-COD-HASTAD         AS INTEGER.
DEFINE VARIABLE WL-COD-FORMUL         AS CHARACTER.
DEFINE VARIABLE WL-COD-SALFAM         AS CHARACTER.

for each concepto:
    delete concepto.
end.
current-value(proximo_concepto) = 0.    

INPUT FROM "CODIGOSH.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WL-COD-CODIGO
         WL-COD-NOMBRE
         WL-COD-ABREVD
         WL-COD-HABRET
         WL-COD-OBLIGA
         WL-COD-TEMPOR
         WL-COD-TOTALZ
         WL-COD-UNIDAD
         WL-COD-DESDEM
         WL-COD-DESDED
         WL-COD-HASTAM
         WL-COD-HASTAD
         WL-COD-FORMUL
         WL-COD-SALFAM NO-ERROR.

  CREATE Concepto.
  ASSIGN 
         Concepto.nro_concepto = NEXT-VALUE(proximo_concepto).
         Concepto.cdg_concepto = WL-COD-CODIGO.
         Concepto.descripcion  = WL-COD-NOMBRE.
         Concepto.abreviatura  = WL-COD-ABREVD.
         Concepto.haber_retenc = WL-COD-HABRET.
         Concepto.obligatorio  = ( WL-COD-OBLIGA = "S").
         Concepto.temporario   = ( WL-COD-TEMPOR = "T").
         Concepto.cdg_sumador  = INTEGER(WL-COD-TOTALZ).
         Concepto.unidad       = INTEGER(WL-COD-UNIDAD).
         Concepto.formula      =  WL-COD-FORMUL.
         Concepto.salario_fliar = ( WL-COD-SALFAM = "S").
           
END.         