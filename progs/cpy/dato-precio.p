    DEFINE VAR de AS DECIMAL EXTENT 14 INITIAL 
[280
,305
,710
,775
,1140
,1690
,1940
,2010
,2320
,2720
,2780
,3100
,3850
 ].
    DEFINE VAR ha AS DECIMAL EXTENT 14 INITIAL 
[320
,350
,810
,890
,1310
,1940
,2230
,2310
,2660
,3120
,3190
,3560
,4430
 ].
DEFINE VAR k AS INT.
FOR EACH dato-precio:
    REPEAT k = 14 TO 1 BY -1.
    IF dato-precio.PrecioUrg = de[k] THEN dato-precio.PrecioUrg = ha[k].
    IF dato-precio.PrecioNor =de[k] THEN dato-precio.PrecioNor = ha[k].
    IF dato-precio.PrecioCli =de[k] THEN dato-precio.PrecioCli = ha[k].
    IF dato-precio.ptramo =de[k] THEN dato-precio.ptramo = ha[k].
END.
END.
