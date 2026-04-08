
DEFINE VARIABLE delta_btn        AS DECIMAL INITIAL 0.1.

DEFINE BUTTON BTN_CANCEL
     LABEL "&Terminar":L
     SIZE 10 BY 0.9 FONT 4.
     
DEFINE BUTTON BTN_COMPROBTE
     LABEL "&Ver":L
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_LISTADOS
     LABEL "&Listar":L
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_IMPRIMIR
     LABEL "&Imprimir":L
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_EXIT
     LABEL "&Salir":L
     SIZE 10 BY 0.9 FONT 4.

DEFINE TEMP-table Boton 
         FIELD  orden            AS INTEGER
         FIELD  puntero          AS WIDGET-HANDLE.

DEFINE RECTANGLE rtn_botones
       EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
       SIZE 70 BY 1.1 BGCOLOR 8.
