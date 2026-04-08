/*=================================================================================*/
/*           EMITE EL LISTADO DE LAS ACTIVIDADES POR TAREA                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_estado   LIKE Tarea.estado.
DEFINE INPUT PARAMETER que_proyecto LIKE Tarea.cdg_proyecto.
DEFINE INPUT PARAMETER que_recurso  LIKE Tarea.cdg_recurso.

/*{VRSHARED.I }*/

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE titulo-f               AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2               AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-3               AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis               AS   CHARACTER.
DEFINE VARIABLE v-tiempo_asignado      AS   DECIMAL COLUMN-LABEL "Tiempo!Insumido" FORMAT ">>>>9.99".
DEFINE VARIABLE v-total_proyecto       AS   DECIMAL.
DEFINE VARIABLE v-total_tarea          AS   DECIMAL.
DEFINE VARIABLE fecha_lis              AS   DATE.
DEFINE VARIABLE que_archivo            AS   CHARACTER.
DEFINE VARIABLE t_horas_prev           AS   DECIMAL.
DEFINE VARIABLE t_horas_cons           AS   DECIMAL.

DEFINE FRAME frm-titulo HEADER
       "SISTEMAS DINAMICOS S.A." 
       "Actividades por Tarea" AT 57
       "Página:" AT 144 PAGE-NUMBER FORMAT ">9" AT 151 
       SKIP
       fecha_lis 
       titulo-2 AT 57 
       hora_lis AT 144
       titulo-3 AT 57 
       SKIP(1)
       WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.horas_estimadas
       Partetareas.fch_parte 
       Partetareas.hms_desde 
       Partetareas.hms_hasta 
       v-tiempo_asignado
       Partetareas.lugar_prestacion 
       Partetareas.observacion_parte
       WITH WIDTH 292 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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
           Tarea.horas_estimadas
           WITH FRAME frm-listado.

       v-total_tarea = 0.
       
       FOR EACH Partetarea OF Tarea NO-LOCK:

           v-tiempo_asignado = ( Partetareas.hor_hasta - Partetareas.hor_desde ) / 3600.

           DISPLAY  Partetareas.fch_parte 
                    Partetareas.hms_desde 
                    Partetareas.hms_hasta 
                    v-tiempo_asignado
                    Partetareas.lugar_prestacion 
                    Partetareas.observacion_parte
                    WITH FRAME frm-listado.
           DOWN WITH FRAME frm-listado.

           v-total_tarea = v-total_tarea + v-tiempo_asignado.

       END.

       UNDERLINE v-tiempo_asignado
                 WITH FRAME frm-listado.

       DISPLAY v-total_tarea @ v-tiempo_asignado
                 WITH FRAME frm-listado.
              
       DOWN 2 WITH FRAME frm-listado.

       ASSIGN v-total_proyecto = v-total_proyecto + v-total_tarea 
              v-total_tarea = 0.

   END.

   UNDERLINE 
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_recurso
       Tarea.cdg_proyecto
       Tarea.titulo
       Tarea.horas_estimadas
       Partetareas.fch_parte 
       Partetareas.hms_desde 
       Partetareas.hms_hasta 
       v-tiempo_asignado
       Partetareas.lugar_prestacion 
       Partetareas.observacion_parte
       WITH FRAME frm-listado.

   DISPLAY   
       t_horas_prev @ Tarea.horas_estimadas
       v-total_proyecto @ v-tiempo_asignado
       WITH FRAME frm-listado.
   
END PROCEDURE.   

