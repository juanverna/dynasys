        /* -------------------- Cobrador ------------------*/

&SCOPED-DEFINE TABLA            Cobrador
&SCOPED-DEFINE CODIGO           cdg_cobrador
&SCOPED-DEFINE NOMBRE           nom_cobrador
&SCOPED-DEFINE RUTINA           SELCOBRA
&SCOPED-DEFINE FRAME-INGRESO    {2}
&SCOPED-DEFINE ROWID-TABLA      act_cobrador
&SCOPED-DEFINE TRADUCIR         {3}
&SCOPED-DEFINE MOSTRAR          {4}
&SCOPED-DEFINE PROCESO          ASIGNAR_COBRADOR
&SCOPED-DEFINE ALTA-MODIF       ACTCOBRA
&SCOPED-DEFINE ULT_REGISTRO     ult_cobrador
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 

&UNDEFINE PROCESO
