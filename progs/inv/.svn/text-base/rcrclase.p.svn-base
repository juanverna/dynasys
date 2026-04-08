DEFINE SHARED STREAM listado.

DEFINE INPUT PARAMETER que_clase AS ROWID.
DEFINE INPUT PARAMETER nivel     AS INTEGER.

DEFINE BUFFER   Clase  FOR Clase_de_articulo.
DEFINE BUFFER Subclase FOR Clase_de_articulo.

DEFINE QUERY qry_clasificacion FOR Subclase.
DEFINE QUERY qry_articulos     FOR Articulo.

DEFINE VARIABLE que_subclase AS CHARACTER.

DEFINE shared FRAME frm-titulo.
   FORM
   "CLASIFICACION DE LOS ARTICULOS" AT 40 SKIP
   "------------------------------" AT 40
   skip(1)                         
   WITH FRAME frm-titulo
    NO-LABEL PAGE-TOP  FONT 8 USE-TEXT NO-BOX STREAM-IO.
   
DEFINE shared FRAME frm-clases.
  FORM
  que_subclase
  Clase.nombre_subclase
  WITH FRAME frm-clases NO-LABEL DOWN USE-TEXT FONT 8 NO-BOX WIDTH 132.

DEFINE shared FRAME frm-articulos.
  form
  Articulo.cdg_articulo
  Articulo.descripcion
  WITH FRAME frm-articulos NO-LABEL DOWN USE-TEXT FONT 8 NO-BOX WIDTH 132.

FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.
IF Clase.cdg_clase <> ?
THEN DO:
   nivel = nivel + 1.
   que_subclase:COLUMN IN FRAME frm-clases = 1 + 3 * ( nivel - 1 ).
   Clase.nombre_subclase:COLUMN IN FRAME frm-clases = que_subclase:COLUMN IN FRAME frm-clases + 10.
   que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
   DISPLAY STREAM listado 
           que_subclase 
           Clase.nombre_subclase 
           WITH FRAME frm-clases.   
   DOWN STREAM listado WITH FRAME frm-clases.
END.   

IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase)
THEN DO:

   RUN ABRE_QUERY.
   GET FIRST qry_clasificacion.
   DO WHILE AVAILABLE Subclase:              
/*      VIEW STREAM listado FRAME frm-titulo.*/
      RUN RCRCLASE.P ( INPUT ROWID(Subclase) , INPUT nivel ).
      GET NEXT qry_clasificacion.
   END.
   
END.
ELSE DO:

   RUN ABRE_QUERY_ARTICULOS.
   GET FIRST qry_articulos.
   Articulo.cdg_articulo:COLUMN IN FRAME frm-articulos = 3 * nivel + 5.
   Articulo.descripcion:COLUMN  IN FRAME frm-articulos = 
      Articulo.cdg_articulo:COLUMN IN FRAME frm-articulos + 13.
   DO WHILE AVAILABLE Articulo:
/*      VIEW STREAM listado FRAME frm-titulo.*/
      DISPLAY STREAM listado Articulo.cdg_articulo
              Articulo.descripcion
              WITH FRAME frm-articulos.   
      DOWN STREAM listado WITH FRAME frm-articulos.   
      GET NEXT qry_articulos.
   END.
      
END.


PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE ABRE_QUERY_ARTICULOS:

        OPEN QUERY qry_articulos 
             FOR EACH Articulo WHERE Articulo.cdg_subclase = Clase.cdg_subclase. 
                              
END PROCEDURE.                             
