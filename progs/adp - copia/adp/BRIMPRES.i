
DEFINE BROWSE brw_impresora QUERY qry_impresora
       DISPLAY Ctrl_impresora.cdg_funcion Ctrl_impresora.descripcion
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Codigos de Control para esta Impresora".

DEFINE BROWSE brw_list QUERY qry_list
       DISPLAY List_impresora.listado List_impresora.descripcion
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Listados asignados a esta Impresora".
