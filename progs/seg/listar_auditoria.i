    PUT STREAM Exportacion 
               Empresa.nombre FORMAT "X(50)"   ";"
               v-sistema                       ";"
               Usuario.cdg_usuario             ";"
               Usuario.nombre                  ";"
               Logusuario.pc_name              ";"
               cFuncion                        ";"
               cFechaHoraDesde                 ";"
               cFechaHoraHasta                 ";"
               cUsuarioSO                      ";"
  /*           cObservaciones                  ";"  */
               cObservaciones                  " "  
               SKIP.


       DISPLAY Empresa.nombre FORMAT "X(50)" 
               v-sistema
               Usuario.cdg_usuario 
               Usuario.nombre 
               Logusuario.pc_name
               cFuncion
               cFechaHoraDesde
               cFechaHoraHasta
               cUsuarioSO
               cObservaciones
               WITH FRAME frm-listado.
       DOWN WITH FRAME frm-listado.
