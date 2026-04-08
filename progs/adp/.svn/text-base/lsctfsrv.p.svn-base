/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_empleado AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

{VPERSINM.I}
{VRSHARED.I}
{NOMMESES.I}

DEFINE VARIABLE que_mes        AS   CHARACTER FORMAT "X(12)" LABEL "Mes".
DEFINE VARIABLE ano            AS   INTEGER.
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_empleado   LIKE Empleado.nro_legajo.
DEFINE VARIABLE que_nombre     LIKE Empleado.nombre.

DEFINE SHARED TEMP-TABLE Total_remunerativo
  FIELD fecha         AS DATE
  FIELD importe       AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Total Rem."
  FIELD cdg_categoria LIKE Categoria.cdg_categoria.
  
DEFINE QUERY qry_totales    FOR Total_remunerativo, Categoria.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP
       fecha_lis titulo-2 AT 28 hora_lis AT 70
       SKIP(1)
       que_Empleado  AT 28
       que_nombre
       SKIP(1)
       WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       que_mes  
       ano  FORMAT "9999" LABEL "A¤o"
       Total_remunerativo.importe
       Total_remunerativo.cdg_categoria
       Categoria.descripcion
       WITH DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Empleado WHERE ROWID(Empleado) = rid_empleado.

que_Empleado = Empleado.nro_legajo.
que_nombre =  Empleado.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(DIRE_TMP + "lsctfsrv.txt") PAGED PAGE-SIZE 72.

RUN LISTAR.

OUTPUT CLOSE.

RUN veresult.w ( INPUT DIRE_TMP + "lsctfsrv.txt", INPUT 8).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE LISTAR:

   titulo-f = "Certificacion de servicios".
   titulo-2 = STRING(des_fecha) +  " - " + STRING(has_fecha).

   FOR EACH Total_remunerativo 
           WHERE Total_remunerativo.fecha >= des_fecha 
             AND Total_remunerativo.fecha <= has_fecha,
             FIRST Categoria OF Total_remunerativo
                 BY Total_remunerativo.fecha. 

      VIEW FRAME frm-titulo.

      que_mes = nom_mes [ MONTH(Total_remunerativo.fecha) ].
      DISPLAY   
           que_mes
           YEAR(Total_remunerativo.fecha)  @ ano
           Total_remunerativo.importe
           Total_remunerativo.cdg_categoria
           Categoria.descripcion
           WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.
              
   END.

   UNDERLINE 
           que_mes
           ano
           Total_remunerativo.importe
           Total_remunerativo.cdg_categoria
           Categoria.descripcion
           WITH FRAME frm-listado.
           
END PROCEDURE.   

{CODIMPRE.I}
 
