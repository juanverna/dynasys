/*=================================================================================*/
/*           EMITE EL LISTADO DE LAS TAREAS POR ESTADO/PROYECTO/RECURSO            */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_estado   LIKE Tarea.estado.
DEFINE INPUT PARAMETER que_proyecto LIKE Tarea.cdg_proyecto.
DEFINE INPUT PARAMETER que_recurso  LIKE Tarea.cdg_recurso.

/*{VRSHARED.I }*/

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_archivo    AS   CHARACTER.
DEFINE VARIABLE th_estimadas   LIKE Tarea.horas_estimadas.
DEFINE VARIABLE th_reales      LIKE Tarea.horas_reales.


DEFINE FRAME frm-titulo HEADER
       "SISTEMAS DINAMICOS S.A." 
       "Tareas por Estado/Recurso/Proyecto" AT 47
       "Página:" AT 154 PAGE-NUMBER FORMAT ">9" AT 161 
       SKIP
       fecha_lis 
       titulo-2 AT 47 
       hora_lis AT 154
       SKIP(1)
       WITH WIDTH 182 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Tarea.cdg_sitio
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.fecha_reportado
       Tarea.fecha_prevista
       Tarea.horas_estimadas
       Tarea.horas_reales 
       WITH WIDTH 182 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                        B L O Q U E   P R I N C I P A L                          */
/*=================================================================================*/

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE("c:\sic-temp\tareas.txt") PAGED PAGE-SIZE 72.

RUN listar.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\tareas.txt", 
                 INPUT 21).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/


PROCEDURE LISTAR:

   titulo-2 = "Estado:" + que_estado + " Proy.:" + que_proyecto + " Rec.:" + que_recurso.

   th_estimadas = 0.
   th_reales = 0.

   FOR EACH Tarea 
       WHERE Tarea.estado = que_estado
         AND CAN-DO(que_proyecto,Tarea.cdg_proyecto) 
         AND CAN-DO(que_recurso,Tarea.cdg_recurso) 
          WITH FRAME frm-listado:
       
       VIEW FRAME frm-titulo.

       DISPLAY   
           Tarea.cdg_sitio
           Tarea.nro_tarea
           Tarea.estado
           Tarea.cdg_recurso
           Tarea.cdg_proyecto
           Tarea.titulo
           Tarea.fecha_reportado
           Tarea.fecha_prevista
           Tarea.horas_estimadas
           Tarea.horas_reales 
           WITH FRAME frm-listado.
              
       ASSIGN
           th_estimadas = th_estimadas + Tarea.horas_estimadas
           th_reales = th_reales + Tarea.horas_reales .

       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
       Tarea.cdg_sitio
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.fecha_reportado
       Tarea.fecha_prevista
       Tarea.horas_estimadas
       Tarea.horas_reales 
       WITH FRAME frm-listado.

   DISPLAY th_estimadas @ Tarea.horas_estimadas
           th_reales    @ Tarea.horas_reales 
           WITH FRAME frm-listado.
   
END PROCEDURE.   

