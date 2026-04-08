DEFINE VARIABLE sel_especs AS CHARACTER.
DEFINE VARIABLE seleccion  AS CHARACTER.
DEFINE VARIABLE sty        AS CHARACTER.
DEFINE VARIABLE ed         AS CHARACTER VIEW-AS EDITOR SIZE 20 by 2.
DEFINE VARIABLE excelon    AS LOGICAL INITIAL FALSE.

DEFINE VARIABLE hora1      AS INTEGER.
DEFINE VARIABLE hora2      AS INTEGER.
DEFINE VARIABLE hora3      AS INTEGER.

DEFINE VARIABLE tiempo     AS INTEGER LABEL "Elapso".
DEFINE VARIABLE nregs      AS INTEGER LABEL "Registros".
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE sys        AS INTEGER.
DEFINE VARIABLE sheet      AS INTEGER.
DEFINE VARIABLE nreg       AS INTEGER.
DEFINE VARIABLE fili       AS INTEGER.
DEFINE VARIABLE coli       AS INTEGER.
DEFINE VARIABLE itemn      AS CHARACTER.

/*   Definicion de la macro de Excel para denominar el rango de datos a tratar 
     posteriormente con las tablas dinamicas  y demas tareas de preparacion de
     la planilla VISITAS                                                            */

DEFINE VARIABLE n_instruc AS INTEGER INITIAL 4.
DEFINE VARIABLE macro AS CHARACTER EXTENT 10 INITIAL 
  [       
  "[SELECCIONAR(~"L2C1:L#C11~")]" ,
  "[DEFINIR.NOMBRE(~"Datos_visitas~";~"=Hoja1!L2C1:L#C11~")]",
  "[VOLVER()]",
  "[EJECUTAR(~"Especialidades~";~"FALSO~")]"  
  ].

PROCEDURE WinExec EXTERNAL "krnl386.exe":
    DEFINE INPUT PARAMETER prog_name AS CHARACTER. 
    DEFINE INPUT PARAMETER prog_style AS SHORT. 
END PROCEDURE.