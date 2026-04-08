ON RETURN, MOUSE-SELECT-DBLCLICK OF brw_otros IN FRAME frm-entidad
DO:
  sino_grabar = NO.
  act_mpl_sup = ROWID(Empleado_supertabla).
  IF act_mpl_sup <> ?
  THEN DO:
      RUN ACTRGOTR.P (INPUT 2).
      RUN PONER_SESION.
      OPEN QUERY qry_otros FOR EACH Empleado_supertabla OF Empleado, 
                               EACH Supertabla OF Empleado_supertabla,
                              FIRST B-Supertabla WHERE B-Supertabla.cdg_tabla =
                                    Empleado_supertabla.cdg_tabla AND
                                    B-Supertabla.cdg_secuencia = 0.
  END.
  ELSE DO:
     BELL.
     MESSAGE "NO hay conceptos asociados al Empleado"
             VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
  END.          
END.  

ON DELETE OF brw_otros IN FRAME frm-entidad
DO:
  sino = NO.
  act_mpl_sup = ROWID(Empleado_supertabla).
  IF act_mpl_sup <> ?
  THEN DO:
     FIND Empleado_supertabla WHERE ROWID(Empleado_supertabla) = act_mpl_sup
                            EXCLUSIVE-LOCK.
     MESSAGE "Realmente desea eliminar este Dato?"
             VIEW-AS ALERT-BOX QUESTION BUTTONS OK-CANCEL 
             TITLE "Se pide Confirmacion" SET sino.
     IF sino 
     THEN DO:
        DELETE Empleado_supertabla.
        OPEN QUERY qry_otros  FOR EACH Empleado_supertabla OF Empleado, 
                                  EACH Supertabla OF Empleado_supertabla,
                                  FIRST B-Supertabla WHERE B-Supertabla.cdg_tabla =
                                        Empleado_supertabla.cdg_tabla AND
                                        B-Supertabla.cdg_secuencia = 0.
        APPLY "VALUE-CHANGED" TO ver IN FRAME frm-entidad.
     END.
  END.
  ELSE DO:
     BELL.
     MESSAGE "NO hay conceptos asociados al Empleado"
             VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
  END.                       
END.  

ON INSERT OF brw_otros IN FRAME frm-entidad
DO:

  act_mpl_sup = ROWID(Empleado_supertabla).
  RUN ACTRGOTR.P (INPUT 1).
  RUN PONER_SESION.
  IF ult_mpl_sup <> ?
  THEN DO:
      ver = 7.
      APPLY "VALUE-CHANGED" TO ver IN FRAME frm-entidad.
  END.    

END.
