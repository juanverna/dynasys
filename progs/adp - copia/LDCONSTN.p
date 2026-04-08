DEFINE VARIABLE WS-ACL-CODIGO         AS INTEGER.
DEFINE VARIABLE WS-ACL-NOMBRE         AS CHARACTER.
DEFINE VARIABLE WS-ACL-TIPOVR         AS INTEGER.
DEFINE VARIABLE WS-ACL-RESETC         AS INTEGER.
DEFINE VARIABLE WS-ACL-VALORN         AS INTEGER.

FOR EACH Constante:
    DELETE Constante.
END.    

INPUT FROM "CONSTANT.TXT".

REPEAT:


  IMPORT DELIMITER ","
         WS-ACL-CODIGO
         WS-ACL-NOMBRE
         WS-ACL-TIPOVR
         WS-ACL-RESETC
         WS-ACL-VALORN.

  CREATE Constante.
  ASSIGN  
         Constante.cdg_constante = WS-ACL-CODIGO
         Constante.descripcion   = WS-ACL-NOMBRE
         Constante.valor         = WS-ACL-VALORN.

END.         