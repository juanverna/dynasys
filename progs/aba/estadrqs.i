DEFINE VARIABLE que_estado AS CHARACTER LABEL "Estado"
                VIEW-AS RADIO-SET HORIZONTAL 
                                  RADIO-BUTTONS "Ingresadas","",
                                                "Aprobadas","AA",
                                                "Cumplidas","CC",
                                                "Rechazadas","RE",
                                                "Retenidas","HH" INITIAL "AA".