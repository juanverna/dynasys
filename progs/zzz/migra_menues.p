/*--------------------------------------------------------------------------------------------*/
/*              MIGRA LOS MENUES DE LA VERSION 3.5.2 A LA VERSION 10                          */
/*--------------------------------------------------------------------------------------------*/

DEFINE VARIABLE x-programa    AS CHARACTER.
DEFINE VARIABLE x-modo        AS CHARACTER.
DEFINE VARIABLE x-comprobante AS CHARACTER.

FOR EACH Treemenu WHERE Treemenu.accion <> "":
    
     /* Treemenu.accion puede ser "w-pirulo.w:X" o "w-pirulo.w:j" con j ente 0 y 9 */

     x-programa = ENTRY(1,Treemenu.accion,":").

     IF NUM-ENTRIES(Treemenu.accion,":") > 1
     THEN DO:
         x-modo     = ENTRY(2,Treemenu.accion,":").
     END.
     ELSE DO:
         x-modo     = "".
     END.

     IF NUM-ENTRIES(Treemenu.accion,":") > 2
     THEN DO:
         x-comprobante = ENTRY(3,Treemenu.accion,":").
     END.
     ELSE DO:
         x-comprobante = "".
     END.

     ASSIGN Treemenu.accion          = x-programa
            Treemenu.modo            = x-modo
            Treemenu.cdg_comprobante = x-comprobante.

END.
