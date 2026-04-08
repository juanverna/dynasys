/*=================================================================================*/
/*           GENERA EL LISTADO DE BALANCE DE SUMAS Y SALDOS CLASIFICADO            */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-primer_nodo  AS CHARACTER.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE VARIABLE c-linea AS INTEGER.

DEFINE TEMP-TABLE T-Listado NO-UNDO 
    FIELD que_codigo        AS CHARACTER FORMAT "X(30)" 
    FIELD que_nombre        AS CHARACTER FORMAT "X(50)" 
    FIELD linea             AS INTEGER 
    INDEX por_linea IS UNIQUE PRIMARY linea.


DEFINE VARIABLE que_subclase AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_archivo  AS CHARACTER.

DEFINE BUFFER   Clase  FOR Clase_de_articulo.
DEFINE BUFFER Subclase FOR Clase_de_articulo.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

DEFINE VARIABLE mensaje   AS CHARACTER FORMAT "X(40)".

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Clasificación de artículos" AT 40 
  "Página:" AT 110 PAGE-NUMBER FORMAT "ZZZ9" AT 117
  SKIP  
  fecha_lis   
  "Nodo:" AT 40 que_subclase
  hora_lis AT 110
  SKIP(1)
  WITH WIDTH 195 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-listado
  T-Listado.que_codigo  FORMAT "X(40)"   COLUMN-LABEL "Código!Clasificación"
  T-Listado.que_nombre  FORMAT "X(100)"  COLUMN-LABEL "Descripción!Clasificación"   
  WITH WIDTH 195 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX
       FRAME frm-listado FONT 2.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND FIRST Clase WHERE Clase.cdg_subclaseart = p-primer_nodo NO-LOCK.
que_subclase = Clase.cdg_subclase + " - " + Clase.nombre_subclaseart .

SESSION:IMMEDIATE-DISPLAY = YES.             

EMPTY TEMP-TABLE T-Listado.

FOR EACH Clase WHERE Clase.cdg_clase = p-primer_nodo NO-LOCK:

    RUN recorrer_clasificacion_articulos.p ( INPUT ROWID(Clase), 
                                             INPUT 0,
                                             INPUT-OUTPUT c-linea,
                                             INPUT-OUTPUT TABLE T-Listado).

END.

DO TRANSACTION:

   c-linea = c-linea + 1.
   CREATE T-Listado.
   ASSIGN T-Listado.que_codigo  = FILL("-",10)
          T-Listado.que_nombre  = FILL("-",35)
          T-Listado.linea       = c-linea.

END.

/*=================================================================================*/
/*              EJECUTA LA IMPRESION PROPIAMENTE DICHA                             */
/*=================================================================================*/

{dirprinfile.i}

FOR EACH T-Listado NO-LOCK:
    
    VIEW FRAME frm-titulo.

    DISPLAY 
          T-Listado.que_codigo
          T-Listado.que_nombre
          WITH FRAME frm-listado.

    DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT (arch_salida),
                 INPUT 22 ).


