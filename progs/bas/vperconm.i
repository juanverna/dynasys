DEFINE VARIABLE hay_permiso AS LOGICAL.
RUN SEGVRPRM.P ( INPUT modo, OUTPUT hay_permiso ).
IF NOT hay_permiso THEN RETURN.
{findempresa.i}
