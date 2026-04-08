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

DEFINE VAR fdesde AS DATE INITIAL 09/01/2014 NO-UNDO.
DEFINE VAR fhasta AS DATE INITIAL 10/31/2014 NO-UNDO.
FOR EACH evento WHERE evento.frealizado >= fdesde AND evento.frealizado <= fhasta
     AND NOT evento.anulado AND evento.nro_tipo_evento = 3, evento_protocolo OF evento BY evento.nro_certif :
  FIND cliente OF evento NO-ERROR.
  IF NOT AVAILABLE cliente THEN NEXT.
  IF cliente.cdg_provincia <> "01" THEN NEXT.
  IF evento_protocolo.estado <> "I" THEN NEXT.
  CREATE aimp.
    ASSIGN aimp.c_nro_tipo_evento = evento.nro_tipo_evento
           aimp.nro_evento = evento.nro_evento
           aimp.nro_evento = evento.nro_evento
           aimp.recurso = evento.recurso
           aimp.turno = evento.turno.
  CREATE presenta.
      ASSIGN presenta.fecha = evento.frealizado
             presenta.domicilio = cliente.direccion
             presenta.certificado = evento.letra + "-" + string(evento.nro_certif)
             presenta.empresa = "FUMIGADORA PAULISTA S.R.L."
             presenta.registro = ""
             presenta.FBAC = evento_protocolo.fecha_analisis.
  END.
  
  OUTPUT TO c:\temp\MCBASEPOCT2014.cvs.
  FOR EACH presenta:
      EXPORT DELIMITER ";" presenta.
  END.
  OUTPUT CLOSE.
  RUN analisisdef.p ( INPUT TABLE aimp , 4 ). 
  /*RUN impcertif.p ( aimp.nro_evento , "*" , 4 ).*/

