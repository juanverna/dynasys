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
DEFINE VARIABLE titulo-3       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_archivo    AS   CHARACTER.
DEFINE VARIABLE t_horas_prev   AS   DECIMAL.
DEFINE VARIABLE t_horas_cons   AS   DECIMAL.

DEFINE FRAME frm-titulo HEADER
       "SISTEMAS DINAMICOS S.A." 
       "Horas por Tarea" AT 57
       "Página:" AT 137 PAGE-NUMBER FORMAT ">9" AT 144 
       SKIP
       fecha_lis 
       titulo-2 AT 57 
       hora_lis AT 137
       titulo-3 AT 57 
       SKIP(1)
       WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.reportado_ref
       Tarea.horas_estimadas
       Tarea.horas_reales
       Tarea.prioridad
       WITH WIDTH 202 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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

   titulo-2 = "Estado:" + que_estado + " Rec.:" + que_recurso.
   titulo-3 = "Proyecto:" + que_proyecto.

   ASSIGN            
       t_horas_prev = 0
       t_horas_cons = 0.

   FOR EACH Tarea 
       WHERE Tarea.estado = que_estado
         AND CAN-DO(que_proyecto,Tarea.cdg_proyecto) 
         AND CAN-DO(que_recurso,Tarea.cdg_recurso) 
          WITH FRAME frm-listado:
       
       VIEW FRAME frm-titulo.

       ASSIGN 
           t_horas_prev = t_horas_prev + Tarea.horas_estimadas
           t_horas_cons = t_horas_cons + Tarea.horas_reales.   

       DISPLAY   
           Tarea.nro_tarea
           Tarea.estado
           Tarea.cdg_recurso
           Tarea.cdg_proyecto
           Tarea.titulo
           Tarea.reportado_ref
           Tarea.horas_estimadas
           Tarea.horas_reales
           Tarea.prioridad
           WITH FRAME frm-listado.
              
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.reportado_ref
       Tarea.horas_estimadas
       Tarea.horas_reales
       Tarea.prioridad
       WITH FRAME frm-listado.

   DISPLAY   
       t_horas_prev @ Tarea.horas_estimadas
       t_horas_cons @ Tarea.horas_reales
       WITH FRAME frm-listado.
   
END PROCEDURE.   

