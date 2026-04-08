FUNCTION fncomprobante RETURN CHARACTER
    ( INPUT p-tip_comprob AS CHARACTER,
      INPUT p-prf_comprob AS INTEGER,
      INPUT p-nro_comprob AS INTEGER):

    RETURN STRING(p-tip_comprob,"X(3)")  + " " + STRING(p-prf_comprob,"9999") + " " + STRING(p-nro_comprob,"99999999").

END FUNCTION.
