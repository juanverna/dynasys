DEFINE NEW SHARED STREAM listado.
DEFINE VARIABLE que_subclase AS CHARACTER.

DEFINE NEW shared FRAME frm-titulo.
   FORM
   "CLASIFICACION DE LOS ARTICULOS" AT 40 SKIP
   "------------------------------" AT 40
   skip(1)                         
   WITH FRAME frm-titulo
    NO-LABEL PAGE-TOP  FONT 8 USE-TEXT NO-BOX STREAM-IO.
   
DEFINE new shared FRAME frm-clases.
  FORM
  que_subclase
  Clase_de_articulo.nombre_subclase
  WITH FRAME frm-clases NO-LABEL DOWN USE-TEXT FONT 8 NO-BOX WIDTH 132.

DEFINE new shared FRAME frm-articulos.
  form
  Articulo.cdg_articulo
  Articulo.descripcion
  WITH FRAME frm-articulos NO-LABEL DOWN USE-TEXT FONT 8 NO-BOX WIDTH 132.

   
FIND FIRST Clase_de_articulo WHERE cdg_clase = ?.
SESSION:IMMEDIATE-DISPLAY = YES.
OUTPUT STREAM Listado TO "AA".     
RUN RCRCLASE.P ( INPUT ROWID(Clase_de_articulo) , INPUT 0 ).
OUTPUT CLOSE.



