/*=================================================================================*/
/*           EMITE EL LISTADO DE PARTE DE UN DETERMINADO RECURSO                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_recurso  LIKE Tarea.cdg_recurso.
DEFINE INPUT PARAMETER que_proyecto LIKE Tarea.cdg_proyecto.
DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.

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
       "Parte de tareas por recurso" AT 57
       "Página:" AT 144 PAGE-NUMBER FORMAT ">9" AT 151 
       SKIP
       fecha_lis 
       titulo-2 AT 57 
       hora_lis AT 144
       titulo-3 AT 57 
       SKIP(1)
       WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Partetareas.fch_parte 
       Partetareas.hms_desde 
       Partetareas.hms_hasta 
       v-tiempo_asignado
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_proyecto
       Tarea.titulo
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

   FIND Recurso WHERE Recurso.cdg_recurso = que_recurso NO-LOCK.

   titulo-2 = "Período:" + STRING(des_fecha,"99/99/99") + " a " + STRING(has_fecha,"99/99/99").
   titulo-3 = "Recurso:" + Recurso.nom_recurso + " Proyecto:" + que_proyecto.

   ASSIGN            
       t_horas_prev = 0
       t_horas_cons = 0.

   
   FOR EACH Partetareas OF Recurso
       WHERE Partetareas.fch_parte <= has_fecha
         AND Partetareas.fch_parte >= des_fecha,
         FIRST Tarea OF Partetareas
               WHERE CAN-DO(que_proyecto,Tarea.cdg_proyecto)
          BREAK BY Partetareas.fch_parte BY Partetareas.hms_desde
          WITH FRAME frm-listado:
       
       VIEW FRAME frm-titulo.

       v-tiempo_asignado = ( Partetareas.hor_hasta - Partetareas.hor_desde ) / 3600.

       DISPLAY   
           Partetareas.fch_parte WHEN FIRST-OF(Partetareas.fch_parte)
           Partetareas.hms_desde 
           Partetareas.hms_hasta 
           v-tiempo_asignado
           Tarea.nro_tarea
           Tarea.estado
           Tarea.cdg_proyecto
           Tarea.titulo
           Partetareas.lugar_prestacion 
           Partetareas.observacion_parte
           WITH FRAME frm-listado.

       DOWN WITH FRAME frm-listado.

       v-total_tarea = v-total_tarea + v-tiempo_asignado.

   END.

   UNDERLINE 
       Partetareas.fch_parte 
       Partetareas.hms_desde 
       Partetareas.hms_hasta 
       v-tiempo_asignado
       Tarea.nro_tarea
       Tarea.estado
       Tarea.cdg_proyecto
       Tarea.titulo
       Partetareas.lugar_prestacion 
       Partetareas.observacion_parte
       WITH FRAME frm-listado.

   DISPLAY   
       v-total_tarea @ v-tiempo_asignado
       WITH FRAME frm-listado.
   
END PROCEDURE.   

