
DEFINE BUTTON BTN_GRABAR
     LABEL "Grabar":L 
     SIZE 10 BY 0.9 FONT 10.
     
DEFINE BUTTON BTN_CANCEL
     LABEL "Cancelar":L 
     SIZE 10 BY 0.9 FONT 10.

DEFINE BUTTON BTN_BAJA
     LABEL "Eliminar":L 
     SIZE 10 BY 0.9 FONT 10.
     
DEFINE BUTTON BTN_IMPRIM
     LABEL "Imprimir":L 
     SIZE 10 BY 0.9 FONT 10.

DEFINE BUTTON BTN_SALIR
     LABEL "Salir":L 
     SIZE 10 BY 0.9 FONT 10.
     

DEFINE BUTTON BTN_OBSERV
     LABEL "Obs":L 
     SIZE 5 BY 1 FONT 10.
     

DEFINE BUTTON btn_horarios
     LABEL "Destinos":L 
     SIZE 12 BY 1.0 FONT 10.

DEFINE BUTTON btn_Novedades
     LABEL "Novedades":L 
     SIZE 12 BY 1.0 FONT 10.
     
DEFINE BUTTON btn_Conc_empl
     LABEL "Conceptos":L 
     SIZE 12 BY 1.0 FONT 10.

DEFINE BUTTON btn_familiar
     LABEL "Familiares":L 
     SIZE 12 BY 1.0 FONT 10.

DEFINE BUTTON btn_datos
     LABEL "Datos Liq.":L 
     SIZE 12 BY 1.0 FONT 10.

DEFINE BUTTON btn_sueldos
     LABEL "Haberes":L 
     SIZE 12 BY 1 FONT 10.


DEFINE RECTANGLE rct-paleta     SIZE 12 BY 5.4 FGCOLOR 14 BGCOLOR 1.
DEFINE RECTANGLE rct-relaciones SIZE 79 BY 1.4 FGCOLOR 14 BGCOLOR 1.
DEFINE RECTANGLE rct-observ     SIZE  7 BY 1.4 FGCOLOR 14 BGCOLOR 1.

FORM 

                /*  Identificacion del  Empleado  */

    Empleado.nro_legajo                   FGCOLOR fg_c BGCOLOR bg_c
    Empleado.nombre                       FGCOLOR fg_c BGCOLOR bg_c
    Empleado.nro_cuil                     FGCOLOR fg_c BGCOLOR bg_c
    Empleado.fecha_ingreso                FGCOLOR fg_c BGCOLOR bg_c
    Empleado.fecha_baja                   FGCOLOR fg_c BGCOLOR bg_c
    SKIP
    Empleado.cdg_estado                   FGCOLOR fg_c BGCOLOR bg_c
    Estado.descripcion           NO-LABEL FGCOLOR fg_c BGCOLOR bg_nh
    SKIP(1)
  
                       /*   Domicilio   */
  
    Empleado.calle                        FGCOLOR fg_c BGCOLOR bg_c
    Empleado.numero                       FGCOLOR fg_c BGCOLOR bg_c  
    Empleado.piso                         FGCOLOR fg_c BGCOLOR bg_c
    Empleado.depto                        FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cdg_postal                   FGCOLOR fg_c BGCOLOR bg_c
    Empleado.localidad                    FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cdg_provincia                FGCOLOR fg_c BGCOLOR bg_c
    Provincia.nombre             NO-LABEL FGCOLOR fg_c BGCOLOR bg_nh
    Empleado.telefono                     FGCOLOR fg_c BGCOLOR bg_c
    Empleado.zona                         FGCOLOR fg_c BGCOLOR bg_c
    SKIP(1)  
                             /*   Filiacion   */

    Empleado.cdg_sexo                     FGCOLOR fg_c BGCOLOR bg_c
    Empleado.tipo_doc                     FGCOLOR fg_c BGCOLOR bg_c
    Empleado.numero_doc                   FGCOLOR fg_c BGCOLOR bg_c 
    Empleado.expedido_por                 FGCOLOR fg_c BGCOLOR bg_c
    Empleado.fecha_nac                    FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cdg_est_civil                FGCOLOR fg_c BGCOLOR bg_c
    Estado_civil.descripcion     NO-LABEL FGCOLOR fg_c BGCOLOR bg_nh
    Empleado.lugar_nac                    FGCOLOR fg_c BGCOLOR bg_c
    Empleado.nacionalid                   FGCOLOR fg_c BGCOLOR bg_c
    Empleado.nom_madre                    FGCOLOR fg_c BGCOLOR bg_c
    Empleado.nom_padre                    FGCOLOR fg_c BGCOLOR bg_c
    SKIP(1)  
                        /*  Datos laborales  */

    Empleado.cdg_convenio                 FGCOLOR fg_c BGCOLOR bg_c
    Empleado.carac_servicios              FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cdg_categoria                FGCOLOR fg_c BGCOLOR bg_c
    Categoria.descripcion        NO-LABEL FGCOLOR fg_c BGCOLOR bg_nh
    Empleado.cdg_especialidad             FGCOLOR fg_c BGCOLOR bg_c
    Especialidad.descripcion     NO-LABEL FGCOLOR fg_c BGCOLOR bg_nh
    Empleado.cdg_sector                   FGCOLOR fg_c BGCOLOR bg_c
    Empleado.forma_de_pago                FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cdg_banco                    FGCOLOR fg_c BGCOLOR bg_c
    Empleado.cuenta_nro                   FGCOLOR fg_c BGCOLOR bg_c
    Empleado.obra_social                  FGCOLOR fg_c BGCOLOR bg_c
    Empleado.sindicato                    FGCOLOR fg_c BGCOLOR bg_c

   btn_GRABAR AT ROW 1.2 COL 79
   btn_CANCEL AT ROW 2.2 COL 79
   btn_BAJA   AT ROW 3.2 COL 79
   btn_IMPRIM AT ROW 4.2 COL 79
   btn_SALIR  AT ROW 5.2 COL 79
   rct-paleta AT ROW 1 COL 78
    
   rct-observ AT ROW 13.8 COL 80.6
   btn_observ AT ROW 14.0 COL 81.5
  
   btn_horarios   AT ROW 15.5 COL 8
   btn_Novedades
   btn_Conc_empl
   btn_familiar
   btn_datos
   btn_sueldos
   rct-relaciones AT ROW 15.3 COL 7
   SKIP(0.3)  
   WITH CENTERED AT ROW 1 COL 1 1 DOWN 
        TITLE FONT 9 "Actualizacion de datos de Empleados"
        SIDE-LABELS  FGCOLOR 14 BGCOLOR 3 WIDTH 88 FONT 9
        FRAME frm-empleado.

FORM        
  Empleado.observacion NO-LABEL FGCOLOR fg_c BGCOLOR bg_c VIEW-AS EDITOR SIZE 70 BY 4
   btn_GRABAR AT 1
   btn_CANCEL AT 60
   WITH FRAME frm-observaciones TITLE "Edicion de observaciones"
   VIEW-AS DIALOG-BOX FGCOLOR 14 BGCOLOR 3 CENTERED FONT 9. 
