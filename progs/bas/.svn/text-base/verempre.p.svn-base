/*==========================================================================================*/
/*       EDICION DE LOS DATOS DE LA EMPRESA Y DE LAS CLAVES DE AUTORIZACION DE SIC          */
/*==========================================================================================*/

DEFINE VARIABLE codigo      AS INTEGER.
DEFINE VARIABLE que_clave   AS INTEGER.
DEFINE VARIABLE que_clave_d AS DECIMAL.
DEFINE VARIABLE que_clave_o AS DECIMAL.
DEFINE VARIABLE que_fecha   AS DATE.
DEFINE VARIABLE que_hora    AS CHARACTER.
DEFINE VARIABLE tiempo      AS INTEGER.
DEFINE VARIABLE titulo      AS CHARACTER FORMAT "X(40)".

{VRSHARED.I }

/*==========================================================================================*/
/*                                     FRAMES                                               */
/*==========================================================================================*/

DEFINE BUTTON BTN_GRABAR
     LABEL "&Grabar":L 
     SIZE 10 BY 0.9 FONT 4.
     
DEFINE BUTTON BTN_SALIR
     LABEL "&Salir":L 
     SIZE 10 BY 0.9 FONT 4.

FORM 
   SKIP(1)
   Empresa.nombre            COLON 15 FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.1)
   Empresa.direccion         COLON 15 FGCOLOR fe_c BGCOLOR be_c SPACE(2)
   SKIP(0.1)
   Empresa.localidad         COLON 15 FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.1)
   Empresa.telefono          COLON 15 FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.1)
   Empresa.cuit              COLON 15 FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.1)
   Empresa.sistema           COLON 15 FGCOLOR fe_c BGCOLOR be_c FORMAT "X(35)" LABEL "Modulos"
   SKIP(0.1)
   Empresa.fecha_limite      COLON 15 FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.1)
   Empresa.clave             COLON 15 FGCOLOR fe_c BGCOLOR be_c FORMAT "999999999"
   SKIP(1)
   BTN_GRABAR SPACE(20) BTN_SALIR
   WITH FRAME frm-empresa FONT 4  THREE-D
        SIDE-LABELS FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE titulo ROW 5 CENTERED VIEW-AS DIALOG-BOX.

/*==========================================================================================*/
/*                                    TRIGGERS                                              */
/*==========================================================================================*/

ON CHOOSE OF BTN_GRABAR IN FRAME frm-empresa
DO:

  DO TRANSACTION:

    FIND CURRENT Empresa EXCLUSIVE-LOCK.

    ASSIGN
        Empresa.nombre         
        Empresa.direccion      
        Empresa.localidad      
        Empresa.telefono       
        Empresa.cuit
        Empresa.sistema        
        Empresa.fecha_limite   
        Empresa.clave.
  
     RUN TOCARSND.P ( INPUT "SOUND\COMIENZO.WAV").
     APPLY "U1" TO FRAME frm-empresa.

     FIND CURRENT Empresa NO-LOCK.

  END.

END.   

ON CHOOSE OF BTN_SALIR IN FRAME frm-empresa
DO:

   RUN TOCARSND.P ( INPUT "SOUND\ELIMINAR.WAV").
   APPLY "U1" TO FRAME frm-empresa.

END.   

/*==========================================================================================*/
/*                                BLOQUE PRINCIPAL                                          */
/*==========================================================================================*/

{findempresa.i}

BTN_SALIR:COLUMN IN FRAME frm-empresa = FRAME frm-empresa:WIDTH - BTN_SALIR:WIDTH - 0.5.

que_fecha = TODAY.
que_hora =  STRING(TIME,"HH:MM:SS").
tiempo = INTEGER(SUBSTRING(que_hora,4,2)) * 100 + INTEGER(SUBSTRING(que_hora,7,2)).
que_clave_d = tiempo * 10000 + MONTH(que_fecha) * 100 + DAY(que_fecha).  
que_clave_d = TRUNCATE(que_clave_d / 311303,4).
que_clave =  INTEGER(TRUNCATE(que_clave_d * 10000,0) MOD 10000).

titulo = "Datos de la empresa " + STRING(que_fecha) + " - " + que_hora.
RUN TOCARSND.P ( INPUT "SOUND\ABREVENT.WAV").

DISPLAY
   Empresa.nombre         
   Empresa.direccion      
   Empresa.localidad      
   Empresa.telefono       
   Empresa.cuit
   Empresa.sistema        
   Empresa.fecha_limite   
   Empresa.clave          
   WITH FRAME frm-empresa.

ENABLE
   Empresa.nombre         
   Empresa.direccion      
   Empresa.localidad      
   Empresa.telefono       
   Empresa.cuit
   Empresa.sistema        
   Empresa.fecha_limite   
   Empresa.clave          
   BTN_GRABAR BTN_SALIR
   WITH FRAME frm-empresa.
   
WAIT-FOR U1 OF FRAME frm-empresa.

/*IF Empresa.clave = que_clave THEN RUN AUTORIZA.P ( INPUT 1 , OUTPUT cod_aut). */
IF Empresa.clave = que_clave THEN RUN AUTORIZA.P ( INPUT 1 ) .
