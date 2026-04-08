/*---------------------------------------------------------------------------------*/

DEFINE VARIABLE modo_configurar AS LOGICAL.
DEFINE VARIABLE wig_label AS WIDGET-HANDLE.
DEFINE VARIABLE anterior  AS WIDGET-HANDLE.
DEFINE VARIABLE primero   AS WIDGET-HANDLE.
DEFINE VARIABLE grupo     AS WIDGET-HANDLE.
DEFINE VARIABLE proximo   AS WIDGET-HANDLE.
DEFINE VARIABLE widgets_mover AS CHARACTER 
        INITIAL "BUTTON,BROWSE,EDITOR,FILL-IN,RADIO-SET,RECTANGLE,SELECTION-LIST,TOGGLE-BOX,LITERAL".
DEFINE VARIABLE widgets_init AS CHARACTER 
        INITIAL "BROWSE,EDITOR,FILL-IN,RADIO-SET,SELECTION-LIST".
DEFINE VARIABLE widgets_side_labels AS CHARACTER 
        INITIAL "EDITOR,FILL-IN,TEXT,RADIO-SET,SELECTION-LIST".

/*---------------------------------------------------------------------------------*/

DEFINE TEMP-table  Tabulacion
       FIELD  tab_table         AS CHARACTER
       FIELD  tab_name          AS CHARACTER
       FIELD  tab_frame-name    AS CHARACTER
       FIELD  tab_auto-return   AS LOGICAL
       FIELD  tab_auto-zap      AS LOGICAL
       FIELD  tab_blank         AS LOGICAL
       FIELD  tab_label         AS CHARACTER
       FIELD  tab_help          AS CHARACTER
       FIELD  tab_bgcolor       AS INTEGER
       FIELD  tab_fgcolor       AS INTEGER
       FIELD  tab_font          AS INTEGER
       FIELD  tab_format        AS CHARACTER
       FIELD  tab_height-pixels AS INTEGER
       FIELD  tab_width-pixels  AS INTEGER
       FIELD  tab_x             AS INTEGER
       FIELD  tab_y             AS INTEGER
       FIELD  tab_handle        AS WIDGET-HANDLE
       FIELD  tab_sensitive     AS LOGICAL.

/*---------------------------------------------------------------------------------*/
