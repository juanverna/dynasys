/*=================================================================================*/
/*           EMITE EL LISTADO DE LAS TAREAS POR ESTADO/PROYECTO/RECURSO            */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_estado     LIKE Tarea.estado.
DEFINE INPUT PARAMETER que_proyecto   LIKE Tarea.cdg_proyecto.
DEFINE INPUT PARAMETER que_recurso    LIKE Tarea.cdg_recurso.
DEFINE INPUT PARAMETER des_prioridad  LIKE Tarea.prioridad.
DEFINE INPUT PARAMETER has_prioridad  LIKE Tarea.prioridad.
DEFINE INPUT PARAMETER des_fecha      LIKE Tarea.fecha_prevista.
DEFINE INPUT PARAMETER has_fecha      LIKE Tarea.fecha_prevista.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(65)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(65)".
DEFINE VARIABLE titulo-3       AS   CHARACTER FORMAT "X(65)".
DEFINE VARIABLE titulo-4       AS   CHARACTER FORMAT "X(65)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_archivo    AS   CHARACTER.

DEFINE FRAME frm-titulo HEADER
       "SISTEMAS DINAMICOS S.A." 
       "Tareas por Estado/Recurso/Proyecto" AT 57
       "Página:" AT 168 PAGE-NUMBER FORMAT ">>9" AT 175 
       SKIP
       fecha_lis 
       titulo-2 AT 57 
       hora_lis AT 168
       SKIP
       titulo-3 AT 57 
       SKIP
       titulo-4 AT 57 
       SKIP(1)
       WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Tarea.nro_tarea
       Tarea.estado
       Tarea.prioridad    COLUMN-LABEL "Prio-!ridad"
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.fecha_reportado
       Tarea.fecha_prevista
       Tarea.fecha_resuelto
       Tarea.version-arreglo
       Tarea.reportado_ref
       Tarea.horas_estimadas
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
   titulo-4 = "Prioridad:" + STRING(des_prioridad,"99") + " - " + STRING(has_prioridad,"99") + 
              "  Entrega Prevista:" + STRING(des_fecha,"99/99/99") + " - " + STRING(has_fecha,"99/99/99").

   FOR EACH Tarea 
       WHERE Tarea.estado = que_estado
         AND CAN-DO(que_proyecto,Tarea.cdg_proyecto) 
         AND CAN-DO(que_recurso,Tarea.cdg_recurso) 
         AND Tarea.prioridad <= has_prioridad
         AND Tarea.prioridad >= des_prioridad
         AND Tarea.fecha_prevista <= has_fecha
         AND Tarea.fecha_prevista >= des_fecha
          WITH FRAME frm-listado:
       
       VIEW FRAME frm-titulo.

       DISPLAY   
           Tarea.nro_tarea
           Tarea.estado
           Tarea.prioridad
           Tarea.cdg_recurso
           Tarea.cdg_proyecto
           Tarea.titulo
           Tarea.fecha_reportado
           Tarea.fecha_prevista
           Tarea.fecha_resuelto
           Tarea.version-arreglo
           Tarea.reportado_ref
           Tarea.horas_estimadas
           WITH FRAME frm-listado.
              
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.fecha_reportado
       Tarea.fecha_prevista
       Tarea.fecha_resuelto
       Tarea.version-arreglo
       Tarea.reportado_ref
       Tarea.horas_estimadas
       WITH FRAME frm-listado.
   
END PROCEDURE.   

