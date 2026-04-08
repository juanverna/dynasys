/*            Cambia el despliegue de los distintos browses en pantalla           */

ON VALUE-CHANGED OF ver IN FRAME frm-impresora
DO:
  IF ver <> 0
  THEN DO:

     ASSIGN ver.

     HIDE brw_impresora IN FRAME frm-impresora.
     HIDE brw_list IN FRAME frm-impresora.

     CASE ver:
        WHEN 1 
        THEN DO:
          OPEN QUERY qry_impresora FOR EACH Ctrl_impresora OF Impresora.
          ENABLE brw_impresora WITH FRAME frm-impresora.
        END.  

        WHEN 2 
        THEN DO:
          OPEN QUERY qry_list FOR EACH List_impresora OF Impresora.
          ENABLE brw_list WITH FRAME frm-impresora.
        END.            

      END CASE.   
   END.
   ELSE DO:
      BELL.
      MESSAGE " No se ha identificado la impresora" 
              VIEW-AS ALERT-BOX ERROR BUTTONS OK
              TITLE "Se ha detectado un error".
      RETURN NO-APPLY.        
   END.           
END.


/*--------------------- Tratamiendo del browse de cod.control-----------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_impresora
&SCOPED-DEFINE ACT_REGBROWSE    act_Ctrl_impresora
&SCOPED-DEFINE ULT_REGBROWSE    ult_Ctrl_impresora
&SCOPED-DEFINE TABLA-BRW        Ctrl_impresora
&SCOPED-DEFINE TABLA-MASTER     Impresora
&SCOPED-DEFINE ACTREGIS         ACTCDCTL
&SCOPED-DEFINE QRY_BROWSE       qry_impresora
&SCOPED-DEFINE QRY_CONDICION    Ctrl_impresora OF Impresora
&SCOPED-DEFINE MENSAJE-VACIO    NO hay codigos asignados a la impresora
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este codigo?

{TRGBROWS.I}


/*--------------------- Tratamiendo del browse de Listados -------------*/

&SCOPED-DEFINE VER              2
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_list
&SCOPED-DEFINE ACT_REGBROWSE    act_list
&SCOPED-DEFINE ULT_REGBROWSE    ult_list
&SCOPED-DEFINE TABLA-BRW        List_impresora
&SCOPED-DEFINE TABLA-MASTER     Impresora
&SCOPED-DEFINE ACTREGIS         ACTLISTA
&SCOPED-DEFINE QRY_BROWSE       qry_list
&SCOPED-DEFINE QRY_CONDICION    List_impresora OF Impresora
&SCOPED-DEFINE MENSAJE-VACIO    No hay Listados asignados a esta impresora
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Listado?

{TRGBROWS.I}
