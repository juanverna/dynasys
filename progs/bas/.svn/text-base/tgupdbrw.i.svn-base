ON INSERT OF {&BROWSE} IN FRAME {&FRAME-INGRESO}
DO:
  como_fue = {&BROWSE}:SET-REPOSITIONED-ROW(MAX(1,{&BROWSE}:NUM-ITERATIONS),"CONDITIONAL").
  GET LAST {&QRY_BROWSE}.
  que_linea = ROWID({&TABLA-BRW}).
  REPOSITION {&QRY_BROWSE} TO ROWID que_linea.
  como_fue = {&BROWSE}:INSERT-ROW("AFTER").

END.

ON ROW-LEAVE OF {&BROWSE} IN FRAME {&FRAME-INGRESO}
DO:

  IF {&BROWSE}:NEW-ROW IN FRAME {&FRAME-INGRESO}
  THEN DO:
     IF AVAILABLE Articulo
     THEN DO:
        RUN CREAR_DETALLE.
        ASSIGN BROWSE {&BROWSE} {&TABLA-BRW}.cantidad {&TABLA-BRW}.precio.
        ASSIGN {&TABLA-BRW}.subtotal = ROUND({&TABLA-BRW}.cantidad * {&TABLA-BRW}.precio, 2).
        DISPLAY {&TABLA-BRW}.nro_linea 
                {&TABLA-BRW}.cantidad 
                {&TABLA-BRW}.precio
                {&TABLA-BRW}.subtotal
                WITH BROWSE {&BROWSE}.
        como_fue = {&BROWSE}:CREATE-RESULT-LIST-ENTRY().
     END.
     ELSE DO:
        como_fue = {&BROWSE}:DELETE-CURRENT-ROW().        
     END.   
  END.     
  ELSE DO:
     FIND CURRENT {&TABLA-BRW} EXCLUSIVE-LOCK.
     ASSIGN BROWSE {&BROWSE} {&TABLA-BRW}.cantidad {&TABLA-BRW}.precio.
     ASSIGN {&TABLA-BRW}.subtotal = ROUND({&TABLA-BRW}.cantidad * {&TABLA-BRW}.precio, 2).
     DISPLAY {&TABLA-BRW}.subtotal WITH BROWSE {&BROWSE}.
     FIND CURRENT {&TABLA-BRW} NO-LOCK.
  END.
  
END.         

ON ENTRY OF Articulo.cdg_articulo IN BROWSE {&BROWSE}
DO:
   ant_articulo = Articulo.cdg_articulo:SCREEN-VALUE IN BROWSE {&BROWSE}.
END.   

ON LEAVE OF Articulo.cdg_articulo IN BROWSE {&BROWSE}
DO:
  IF Articulo.cdg_articulo:SCREEN-VALUE IN BROWSE {&BROWSE} <> ant_articulo
  THEN DO:
     IF NOT CAN-FIND(Articulo USING BROWSE {&BROWSE} Articulo.cdg_articulo)
     THEN DO:
        MESSAGE "No existe el articulo" VIEW-AS ALERT-BOX ERROR TITLE "Error detectado".
        RETURN NO-APPLY.
     END. 
     ELSE DO:
        FIND Articulo USING BROWSE {&BROWSE} Articulo.cdg_articulo NO-LOCK.
        IF {&BROWSE}:NEW-ROW IN FRAME {&FRAME-INGRESO}
        THEN DO:
           Articulo.descripcion:SCREEN-VALUE IN BROWSE {&BROWSE} = Articulo.descripcion.
        END.
        ELSE DO:
           FIND CURRENT {&TABLA-BRW} EXCLUSIVE-LOCK.
           {&TABLA-BRW}.nro_articulo = Articulo.nro_articulo.
           n_linea = {&BROWSE}:FOCUSED-ROW.
           RUN ABRE_QUERY.
           como_fue = {&BROWSE}:SELECT-ROW(n_linea).
        END.   
        APPLY "ENTRY" TO {&TABLA-BRW}.cantidad IN BROWSE {&BROWSE}.
     END.
     RETURN NO-APPLY.
  END.  
END.  

ON RETURN, TAB OF {&TABLA-BRW}.cantidad, {&TABLA-BRW}.precio IN BROWSE {&BROWSE}
DO:

  {&TABLA-BRW}.subtotal:SCREEN-VALUE IN BROWSE {&BROWSE}
       = STRING(ROUND(DECIMAL({&TABLA-BRW}.cantidad:SCREEN-VALUE IN BROWSE {&BROWSE}) *
                      DECIMAL({&TABLA-BRW}.precio:SCREEN-VALUE IN BROWSE {&BROWSE}), 2)).
  IF NOT {&BROWSE}:NEW-ROW IN FRAME {&FRAME-INGRESO}
  THEN DO:
     FIND CURRENT {&TABLA-BRW} EXCLUSIVE-LOCK.
     ASSIGN BROWSE {&BROWSE} {&TABLA-BRW}.cantidad {&TABLA-BRW}.precio.
     ASSIGN {&TABLA-BRW}.subtotal = ROUND({&TABLA-BRW}.cantidad * {&TABLA-BRW}.precio, 2).
     DISPLAY {&TABLA-BRW}.subtotal WITH BROWSE {&BROWSE}.
     FIND CURRENT {&TABLA-BRW} NO-LOCK.
  END.

END.  

ON DELETE OF {&BROWSE} IN FRAME {&FRAME-INGRESO}
DO:

  IF NOT {&BROWSE}:NEW-ROW IN FRAME {&FRAME-INGRESO}
  THEN DO:
     FIND CURRENT {&TABLA-BRW} EXCLUSIVE-LOCK.
     DELETE {&TABLA-BRW}.
     n_linea = {&BROWSE}:FOCUSED-ROW.
     RUN ABRE_QUERY.
     como_fue = {&BROWSE}:SELECT-ROW(n_linea) NO-ERROR.
  END.
  ELSE DO:
     como_fue = {&BROWSE}:DELETE-CURRENT-ROW().
  END.      

END.         