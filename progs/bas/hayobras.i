DEFINE VARIABLE hay_obras AS LOGICAL.
FIND Parametro "HAYOBRAS" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro
   THEN hay_obras = Parametro.valor_l.
