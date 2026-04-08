/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_liquidacion AS ROWID.

{VRSHARED.I }

DEFINE VARIABLE titulo-f         AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2         AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis         AS   CHARACTER.
DEFINE VARIABLE que_hora         AS   CHARACTER.
DEFINE VARIABLE fecha_lis        AS   DATE.
DEFINE VARIABLE que_empresa      LIKE Empresa.nombre.
DEFINE VARIABLE que_liquidacion  LIKE Liquidacion.sec_liquidacion.
DEFINE VARIABLE que_nombre       LIKE Liquidacion.descripcion.


DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP
       fecha_lis titulo-2 AT 28 hora_lis AT 70
       SKIP(1)
       que_liquidacion  AT 28
       que_nombre
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       SPACE(3)
       Empleado.nro_legajo
       Empleado.nombre
       Aud_liquidacion.fecha_grab 
       que_hora
       Aud_liquidacion.liquidado FORMAT "Si/No"
       Aud_liquidacion.resultado 
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Liquidacion WHERE ROWID(Liquidacion) = rid_liquidacion.

que_liquidacion = Liquidacion.sec_liquidacion.
que_nombre =  Liquidacion.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(dire_tmp + "lsaudliq.txt") PAGE-SIZE 72.

RUN LISTAR.

OUTPUT CLOSE.

RUN VERESULTE.P ( INPUT dire_tmp + "lsaudliq.txt", INPUT  8 ).

/*=================================================================================*/
/*                           PROCEDIMIENTOS                                        */
/*=================================================================================*/

PROCEDURE LISTAR:

   titulo-f = "Auditoria de liquidacion".
  
   FOR EACH Aud_liquidacion OF Liquidacion, Empleado OF Aud_liquidacion WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       DISPLAY   
            Aud_liquidacion.fecha_grab 
            STRING(Aud_liquidacion.hora_grab,"HH:MM:SS")  @ que_hora
            Aud_liquidacion.liquidado 
            Empleado.nro_legajo
            Empleado.nombre
            Aud_liquidacion.resultado 
            WITH FRAME frm-listado.
           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
            Aud_liquidacion.fecha_grab 
            que_hora
            Aud_liquidacion.liquidado 
            Empleado.nro_legajo
            Empleado.nombre
            Aud_liquidacion.resultado 
           WITH FRAME frm-listado.
           
END PROCEDURE.   


{CODIMPRE.I}
