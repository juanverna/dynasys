DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".
DEFINE TEMP-TABLE presenta
    FIELD Fecha AS DATE
    FIELD Certificado AS CHAR FORMAT "X(15)"
    FIELD Domicilio LIKE Cliente.direccion
    FIELD Empresa AS CHAR 
    FIELD Registro AS CHAR
    FIELD FBAC AS DATE COLUMN-LABEL "Fecha Bacteriologico"
    INDEX certificado certificado.
OUTPUT TO c:\temp\MCBALibroFumSETOCT2014.csv.
DEFINE VAR fdesde AS DATE INITIAL 09/01/2014 NO-UNDO.
DEFINE VAR fhasta AS DATE INITIAL 10/31/2014 NO-UNDO.
FOR EACH evento NO-LOCK WHERE evento.frealizado >= fdesde AND evento.frealizado <= fhasta
     AND NOT evento.anulado AND evento.nro_tipo_evento = 1
    AND evento.nro_certif <> 0  BY evento.frealizado  :
    FIND contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-ERROR.
    IF AVAILABLE contrato_hd THEN
        IF contrato_hd.numero_eventos <> evento.sub_evento THEN NEXT.
  FIND cliente NO-LOCK OF evento NO-ERROR.
  IF NOT AVAILABLE cliente THEN NEXT.
  IF cliente.cdg_provincia <> "01" THEN NEXT.
  EXPORT DELIMITER ";" cliente.direccion evento.frealizado evento.frealizado + 31 "Fabiana Santa". 
END.
  OUTPUT CLOSE.
