/*=================================================================================*/
/*                                                                                 */
/*  PRODUCE EN MEMORIA LA SENTENCIA DE VALIDACION DE BAJAS PARA UNA TABLA DADA     */
/*  EN BASE AL USO DE UN CAMPO DETERMINADO                                         */
/*                                                                                 */
/*=================================================================================*/

DEFINE VARIABLE linea     AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE lin       AS CHARACTER FORMAT "X(132)" EXTENT 20.
DEFINE VARIABLE izquierda AS CHARACTER FORMAT "X(32)".
DEFINE VARIABLE derecha   AS CHARACTER FORMAT "X(32)".
DEFINE VARIABLE que_tabla LIKE _File._File-name.
DEFINE VARIABLE salida    AS CHARACTER FORMAT "X(32)" INITIAL "CPCAMPOS.I".
DEFINE VARIABLE salida_clip AS LOGICAL VIEW-AS TOGGLE-BOX INITIAL YES.
DEFINE VARIABLE lmaxi     AS INTEGER.
DEFINE VARIABLE lmaxd     AS INTEGER.
DEFINE VARIABLE li        AS INTEGER.
DEFINE VARIABLE ld        AS INTEGER.
DEFINE VARIABLE k         AS INTEGER.

DEFINE VARIABLE que_campo AS CHARACTER FORMAT "X(32)" .
DEFINE VARIABLE p-derecha   AS CHARACTER FORMAT "X(30)" INITIAL "~{~&DE-TABLA~}".

{VRSHARED.I "NEW"}

FORM

   que_tabla    COLON 15 LABEL "Tabla"      FGCOLOR 9 BGCOLOR 15
   que_campo    COLON 15 LABEL "Campo"  FGCOLOR 9 BGCOLOR 15
   salida       COLON 15 LABEL "Archivo"    FGCOLOR 9 BGCOLOR 15   
   salida_clip  COLON 15 LABEL "Clipboard"  FGCOLOR 9
   WITH FRAME aa VIEW-AS DIALOG-BOX THREE-D 
        FONT 8  SIDE-LABELS TITLE "Generacion de Validacion de Bajas".

FORM
   linea NO-LABEL
   WITH USE-TEXT FONT 2 WIDTH 260 FRAME bb DOWN.

/*=================================================================================*/
/*                      B L O Q U E     P R I N C I P A L                          */
/*=================================================================================*/

lin [ 01 ] = '/*=========================================================================================*/'.
lin [ 02 ] = '/*                      VALIDACION DE BAJAS DE LA TABLA:&TABLA                             */'.
lin [ 03 ] = '/*=========================================================================================*/'.
lin [ 04 ] = '                                                                                             '.
lin [ 05 ] = 'DEFINE INPUT  PARAMETER rid_&TABLA AS ROWID.                                           '.
lin [ 06 ] = 'DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.                                               '.
lin [ 07 ] = '                                                                                             '.
lin [ 08 ] = 'FIND &TABLA WHERE ROWID(&TABLA) = rid_&TABLA NO-LOCK.                      '.
lin [ 09 ] = 'RUN VALIDAR_BAJA.                                                                            '.
lin [ 10 ] = '                                                                                             '.
lin [ 11 ] = 'RETURN.                                                                                      '.
lin [ 12 ] = '                                                                                             '.
lin [ 13 ] = 'PROCEDURE VALIDAR_BAJA:                                                                      '.
lin [ 14 ] = '                                                                                             '.
lin [ 15 ] = '  hay_error = YES.                                                                           '.
lin [ 16 ] = '                                                                                             '.


SESSION:DATA-ENTRY-RETURN = YES.

REPEAT:

  UPDATE que_tabla 
         que_campo 
         salida 
         salida_clip
         WITH FRAME aa.
         
  FIND FIRST _File WHERE _File._File-name = que_tabla NO-LOCK NO-ERROR.
  IF NOT AVAILABLE _File
  THEN DO:
     MESSAGE "No es posible encontrar la tabla mencionada"
             VIEW-AS ALERT-BOX ERROR TITLE "Se ha detectado un error".
     UNDO,RETRY.
  END.
  ELSE DO:
     MESSAGE "Procedemos a generar validacion de la tabla " que_tabla
             VIEW-AS ALERT-BOX MESSAGE TITLE "Inicia proceso de generacion".
     LEAVE.
  END.
  
END.     

IF salida_clip THEN OUTPUT TO "CLIPBOARD".
               ELSE OUTPUT TO VALUE(salida).


DO k = 1 TO 16:
   linea = REPLACE( lin [ k ] ,"&TABLA",_File-name).
   DISPLAY linea NO-LABEL
           WITH FRAME bb.
   DOWN WITH FRAME bb.
END.

FOR EACH _Field WHERE _Field._Field-name BEGINS que_campo , _File OF _Field NO-LOCK
                     BREAK BY _Field._Field-name BY _File._File-name WITH FRAME bb:
              
    IF _File._File-name <> que_tabla
    THEN DO:
    
         IF FIRST-OF(_Field._Field-name)
         THEN DO:
              linea = "  IF CAN-FIND(FIRST " + 
                     _File._File-name + 
                     " WHERE " +
                     _File._File-name + "." + _Field._Field-name +
                     " = " + que_tabla + "." + que_campo + ") OR".
         END.
         ELSE IF LAST-OF(_Field._Field-name)
         THEN DO:
              linea = "     CAN-FIND(FIRST " + 
                     _File._File-name + 
                     " WHERE " +
                     _File._File-name + "." + _Field._Field-name +
                     " = " + que_tabla + "." + que_campo + ")".
         END.
         ELSE DO:
              linea = "     CAN-FIND(FIRST " + 
                     _File._File-name + 
                     " WHERE " +
                     _File._File-name + "." + _Field._Field-name +
                     " = " + que_tabla + "." + que_campo + ") OR".
         END.            

         DISPLAY linea NO-LABEL
                 WITH FRAME bb.
         DOWN WITH FRAME bb.

    END.             
    
END.    

linea = "     THEN RETURN.".
DISPLAY linea NO-LABEL
        WITH FRAME bb.
DOWN WITH FRAME bb.

linea = " ".
DISPLAY linea NO-LABEL
        WITH FRAME bb.
DOWN WITH FRAME bb.

linea = "  hay_error = NO.".
DISPLAY linea NO-LABEL
        WITH FRAME bb.
DOWN WITH FRAME bb.

linea = " ".
DISPLAY linea NO-LABEL
        WITH FRAME bb.
DOWN WITH FRAME bb.

linea = "END PROCEDURE.".
DISPLAY linea NO-LABEL
        WITH FRAME bb.
DOWN WITH FRAME bb.

OUTPUT CLOSE.
    
         
