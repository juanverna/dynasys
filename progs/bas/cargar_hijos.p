/*------------------------------------------------------------------------------
  Purpose:     
  PARAMETERs:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT-OUTPUT PARAMETER a           AS CHARACTER.
  DEFINE INPUT PARAMETER p-cdg_padre        LIKE Treemenu.cdg_padre.
  DEFINE INPUT PARAMETER lista_funciones    AS CHARACTER.
  DEFINE INPUT PARAMETER p-nivel            AS INTEGER.
  
  DEFINE VARIABLE j-funcion          AS INTEGER.
  DEFINE VARIABLE tiene_permiso      AS LOGICAL.

  DEFINE BUFFER B-Treemenu FOR Treemenu.
  
  {findempresa.i}

  FOR EACH Treemenu 
      WHERE Treemenu.cdg_empresa = Empresa.cdg_empresa 
        AND Treemenu.cdg_padre   = p-cdg_padre BY Treemenu.cdg_item :
        
        IF lista_funciones = "*"
        THEN DO:
            tiene_permiso = YES.
        END.
        ELSE DO:
            tiene_permiso = NO.
            DO j-funcion = 1 TO NUM-ENTRIES(lista_funciones,",") WHILE NOT tiene_permiso:
                tiene_permiso = CAN-DO(Treemenu.permitidos,ENTRY(j-funcion,lista_funciones,",")).
            END.
        END.

        IF tiene_permiso
        THEN DO:
            IF CAN-FIND(FIRST B-Treemenu WHERE B-Treemenu.cdg_padre = Treemenu.cdg_item AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa)
            THEN DO:
                 a = a  + "~n" + STRING(p-nivel,">9") + "~t" + Treemenu.titulo + "~t0~t1~t~t" +
                     "Accion=" + Treemenu.accion + "|" + Treemenu.cdg_item.           
                 RUN cargar_hijos.p ( INPUT-OUTPUT a, INPUT Treemenu.cdg_item, INPUT lista_funciones, INPUT p-nivel + 1).
            END.
            ELSE DO:
                 a = a  + "~n" + STRING(p-nivel,">9") + "~t" + Treemenu.titulo + "~t25~t41~t~t" + 
                     "Accion=" + Treemenu.accion + "|" + Treemenu.cdg_item.           
            END.
        END.
             
  END.


