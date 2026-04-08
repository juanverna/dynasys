/*probador de evals*/
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR v AS DECIMAL NO-UNDO.
DEFINE VAR esdesborde AS LOGICAL NO-UNDO.
DEFINE VAR vmobs AS CHAR NO-UNDO.  
DEFINE VAR nroe AS INT INITIAL 262564.
/*OUTPUT TO c:\diasdif.txt.*/
FIND evento WHERE evento.nro_evento = nroe.
FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = evento.nro_cliente AND
   cliente_restriccion.nro_restriccion = 49.
    DO  i = 1 TO 30:
        RUN eval-crangosemdiasC.p (
            nroe
            , 
            DATE(6,i  ,2011) ,
            cliente_restriccion.valor,
            OUTPUT v,
            OUTPUT esdesborde,
            OUTPUT vmobs 
            ).
        /*EXPORT DELIMITER ";" i v vmobs DATE(1,i  ,2009).*/
        /*MESSAGE i v esdesborde vmobs VIEW-AS ALERT-BOX ERROR.*/
        DISPLAY i v esdesborde vmobs cliente_restriccion.valor WITH 20 DOWN.
        DOWN 1.
    END.



