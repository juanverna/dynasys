    DEFINE VARIABLE v-ultrans AS INTEGER.

    FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1}
                  AND {1}.{3} = INPUT FRAME {&FRAME-NAME} v-dsc_{1} NO-LOCK NO-ERROR.

    IF NOT AVAILABLE {1}
    THEN DO:
        FIND LAST Transportista.
        v-ultrans = INTEGER(Transportista.cdg_transportista) + 1.
MESSAGE Transportista.cdg_transportista VIEW-AS ALERT-BOX.
MESSAGE v-ultrans VIEW-AS ALERT-BOX.        
 hay_error = TRUE. 
/*         RUN PONMENSJ.P ( '{3}' ). */
 END. 
