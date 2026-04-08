DEFINE VARIABLE hay_permiso AS LOGICAL.
RUN segvrprm.p ( INPUT -1, OUTPUT hay_permiso ).
IF NOT hay_permiso THEN RETURN.
{findempresa.i}

