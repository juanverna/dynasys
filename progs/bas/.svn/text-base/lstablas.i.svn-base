/*=================================================================================*/
/*                        LISTADO DE UNA TABLA EN FORMA GENERAL                    */
/*=================================================================================*/

DEFINE INPUT PARAMETER disp_out  AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}
{DFVRANGO.I}

DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       "{&TITULO-LST}" AT {&POS-TITULO}
       "Pagina:" AT {&POS-PAGINA} PAGE-NUMBER FORMAT ">9" AT {&POS-NROPAG} 
       SKIP
       fecha_lis hora_lis AT {&POS-PAGINA}
       SKIP(1)
       WITH WIDTH {&ANCHO-FRAME} FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.


FORM 
    {&FRAME-LISTADO}
    WITH WIDTH {&ANCHO-FRAME} DOWN CENTERED FRAME frm-entidad USE-TEXT STREAM-IO.


que_empresa = Empresa.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(dire_tmp + "ls{&ARCHIVO-ID}.txt") PAGE-SIZE 72.

IF ver_por = 1
THEN DO:
   OPEN QUERY qry_listado 
   FOR EACH {&TABLA} WHERE {&TABLA}.{&CODIGO} >= des_codigo
                       AND {&TABLA}.{&CODIGO} <= has_codigo
                        BY {&TABLA}.{&CODIGO}.
END.
ELSE DO:
   OPEN QUERY qry_listado
   FOR EACH {&TABLA} WHERE {&TABLA}.{&NOMBRE} >= des_nombre
                       AND {&TABLA}.{&NOMBRE} <= has_nombre
                        BY {&TABLA}.{&NOMBRE}.
END.

GET FIRST qry_listado.
DO WHILE AVAILABLE {&TABLA}:     

    VIEW FRAME frm-titulo.

    &IF DEFINED(PRE-PROCESO) NE 0
    &THEN 
       {&PRE-PROCESO}
    &ENDIF   

    DISPLAY 
           {&CAMPOS-LISTADO}
           WITH FRAME frm-entidad.

    DOWN   WITH FRAME frm-entidad.

    &IF DEFINED(POS-PROCESO) NE 0
    &THEN 
       {&POS-PROCESO}
    &ENDIF   

    GET NEXT qry_listado.

END.           
    
OUTPUT CLOSE.    

IF disp_out <> "A" THEN RUN veresult.w ( INPUT dire_tmp + "ls{&ARCHIVO-ID}.txt",
                                         INPUT 8).

