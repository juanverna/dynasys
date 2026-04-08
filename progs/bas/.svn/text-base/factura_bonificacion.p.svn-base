
DEFINE VARIABLE titulo    AS CHARACTER.
DEFINE VARIABLE fch_desde AS DATE.
DEFINE VARIABLE fch_hasta AS DATE.

MESSAGE "Cargue las Fechas y Presione F2 para Ejecutar.".

DEFINE FRAME frm-frame
    fch_desde COLUMN-LABEL "Fecha!Desde"
    fch_hasta COLUMN-LABEL "Fecha!Desde"
    WITH STREAM-IO.

UPDATE
    fch_desde
    fch_hasta
    WITH FRAME frm-fame.

OUTPUT TO "c:\sic-temp\factura_bonificacion.txt".

FOR EACH Fac_header WHERE Fac_header.fecha > fch_desde
                      AND Fac_header.fecha < fch_hasta
                      AND Fac_header.tip_comprob BEGINS "F" NO-LOCK:

    FIND FIRST Fac_header-bon OF Fac_header NO-LOCK NO-ERROR.

    DISPLAY Fac_header.tip_comprob  COLUMN-LABEL "Tipo! "    SPACE(2)
            Fac_header.prf_comprob  COLUMN-LABEL "Prefijo! " SPACE(2)
            Fac_header.nro_comprob  COLUMN-LABEL "Número! "  SPACE(2)
            Fac_header.imp_total    COLUMN-LABEL "importe! " SPACE(2)
            Fac_header.fecha        COLUMN-LABEL "Fecha! "   SPACE(2)
            Fac_header.nombre       COLUMN-LABEL "cliente! " SPACE(2)
            Fac_header.nro_vendedor COLUMN-LABEL "vendedor! "SPACE(2)
            Fac_header.cdg_empresa  COLUMN-LABEL "Empresa! " SPACE(2) WITH WIDTH 200.
            
    IF AVAILABLE Fac_header-bon
            THEN DISPLAY Fac_header-bon.porcentaje COLUMN-LABEL "Bonificación %! " WITH WIDTH 200.
END.

OUTPUT CLOSE.

MESSAGE "Archivo Generado en: 'c:\sic-temp\factura_bonificacion.txt'.".
MESSAGE "Presione Esc para Salir.".
