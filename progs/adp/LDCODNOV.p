DEFINE VARIABLE WS-NOV-CODIGO         AS INTEGER.
DEFINE VARIABLE WS-NOV-NOMBRE         AS CHARACTER.

INPUT FROM "CNOVEDAD.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WS-NOV-CODIGO
         WS-NOV-NOMBRE.

  CREATE Novedad.
  ASSIGN  
         Novedad.cdg_novedad = WS-NOV-CODIGO
         Novedad.descripcion = WS-NOV-NOMBRE
         Novedad.nro_novedad = NEXT-VALUE(proxima_novedad).
         
END.         