/*genera el xml para los ardenes*/
USING ThoughtWorks.QRCode.Codec.*.
USING System.Drawing.*.
{extrae.i}
    DEFINE VAR quecod AS CHAR NO-UNDO.
DEFINE BUFFER bevento FOR evento.
    DEFINE VAR quetipo LIKE articulo.cdg_tipoart NO-UNDO.
DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".

DEFINE TEMP-TABLE lstorden
    FIELD ind AS INT
    FIELD nro_evento AS int 
    FIELD operario AS CHAR 
    FIELD direccion LIKE cliente.direccion
    FIELD fecha AS date
    FIELD turno AS CHAR FORMAT "x(10)"
    FIELD cdg_tipoart LIKE  articulo.cdg_tipoart
    FIELD cdg_articulo LIKE articulo.cdg_articulo
    FIELD prf_comprob LIKE contrato_hd.prf_contrato
    FIELD origen LIKE evento.origen
    FIELD nro_identificacion LIKE evento.nro_identificacion
    FIELD leyenda LIKE evento.leyenda
    FIELD observacion LIKE evento.observacion
    FIELD laboratorio LIKE evento_protocolo.laboratorio
    FIELD nomb_operario AS CHAR
    /*para la orden*/
    FIELD url2 LIKE evento.url2
    FIELD frealizado LIKE evento.frealizado
    FIELD fvencimiento LIKE evento.frealizado
    FIELD nro_certif LIKE evento.nro_certif
    FIELD tanques AS INT
    FIELD cliente AS CHAR 
    FIELD imagen AS CHAR
    FIELD unidades LIKE Cliente_otros_datos.Unidades
    INDEX ind ind.
    
{crystal_dyna.p}

FUNCTION qrcode RETURNS character ( pp AS CHAR ):
    DEFINE VARIABLE oEncoder AS ThoughtWorks.QRCode.Codec.QRCodeEncoder NO-UNDO.
    DEFINE VARIABLE oImage  AS System.Drawing.Image  NO-UNDO.
    DEFINE VAR cc AS CHAR NO-UNDO.
    oEncoder = NEW QRCodeEncoder().
    oEncoder:QRCodeVersion = 7.
    oEncoder:QRCodeErrorCorrect = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ERROR_CORRECTION:L.
    oEncoder:qrcodeEncodeMode = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ENCODE_MODE:byte.
    oImage = oEncoder:Encode("http://www.dghpsh.agcontrol.gob.ar/EDA/Mobile/CEDyT/GetOblea/" + pp ).
    DELETE OBJECT oEncoder.
    cc = TempFile("") + pp + ".bmp".
    oImage:RotateFlip(System.Drawing.RotateFlipType:Rotate90FlipXY).
    oImage:Save( cc,System.Drawing.Imaging.ImageFormat:bmp).
    RETURN cc.
END FUNCTION.


DEFINE INPUT PARAMETER TABLE FOR aimp.
DEFINE OUTPUT PARAMETER xfile1 AS CHAR.
DEFINE INPUT PARAMETER pcant AS INT.

DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE VAR ccant AS INT NO-UNDO.
DEFINE DATASET dset FOR lstorden.
DEFINE VAR vind AS INT NO-UNDO.
DEFINE BUFFER administracion FOR cliente.
DEFINE VAR oblea AS LOGICAL INITIAL TRUE.
i = 0.
FOR EACH aimp:
    i = i + 1.
    IF i>1 THEN DO:
        oblea = FALSE.
        LEAVE.
    END.
END.


FOR EACH aimp:
    FIND evento WHERE evento.nro_evento = aimp.nro_evento NO-LOCK.
    IF NOT evento.fasignado<>? THEN NEXT.
    IF evento.anulado THEN NEXT.
    IF evento.frealizado<>? THEN NEXT.
    FIND cliente OF evento NO-LOCK.
    FIND Cliente_otros_datos OF cliente NO-LOCK NO-ERROR. 
    FIND recurso NO-LOCK WHERE recurso.cdg_recurso = entry( 1 , evento.recursos ) NO-ERROR.
    
    CREATE lstorden.
        ASSIGN vind = vind + 1
               lstorden.ind = vind
               lstorden.nro_evento = evento.nro_evento
               lstorden.operario = evento.recursos 
               lstorden.nomb_operario = recurso.nom_recurso
               lstorden.direccion = cliente.direccion
               lstorden.fecha = evento.fasignado
               lstorden.turno = evento.turno
               lstorden.leyenda = evento.leyenda.
        IF AVAILABLE Cliente_otros_datos THEN
            lstorden.unidades = Cliente_otros_datos.Unidades.

        IF evento.origen = "CONTRATO" THEN DO:
          FIND contrato_hd  WHERE contrato_hd.nro_contrato = evento.nro_identificacion NO-LOCK NO-ERROR.
          FIND cliente NO-LOCK OF evento.
          FIND cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
          quecod = "".
          FOR EACH contrato_dt OF contrato_hd WHERE (contrato_dt.nro_articulo <> 167 AND contrato_dt.nro_articulo <> 121) NO-LOCK:
            FIND articulo OF contrato_dt NO-LOCK NO-ERROR.
            quecod = quecod + "," + trim(Articulo.descripcion).
            quetipo = articulo.cdg_tipoart.
          END.
          quecod = SUBSTRING(quecod,2).
          IF quecod = "" THEN NEXT.
          FIND restriccion WHERE restriccion.cdg_restriccion = "ANAGUA" NO-LOCK.
          FIND FIRST contrato_restriccion WHERE contrato_restriccion.nro_contrato = evento.nro_identificacion and
                contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
          IF AVAILABLE contrato_restriccion THEN
                lstorden.laboratorio = contrato_restriccion.valor.
          ELSE
                lstorden.laboratorio = "1".
                ASSIGN 
                    lstorden.prf_comprob = contrato_hd.prf_contrato
                    lstorden.cdg_articulo = quecod
                    lstorden.cdg_tipoart = quetipo
                    lstorden.nro_identificacion = contrato_hd.nro_contrato
                    lstorden.origen = "C".
                    lstorden.leyenda = trim(contrato_hd.leyenda) + " " + trim(lstorden.leyenda).
                IF oblea THEN DO:
                  FOR EACH bevento WHERE bevento.nro_identificacion = evento.nro_identificacion AND                                                            
                          bevento.sub_evento = evento.sub_evento AND NOT bevento.anulado AND                                                                                   
                          bevento.origen = evento.origen AND                                                                                              
                          bevento.url2 <> "" AND 
                          bevento.periodo < evento.periodo NO-LOCK BY bevento.periodo DESC:  
                          ASSIGN lstorden.url2 = bevento.url2
                             lstorden.frealizado = bevento.frealizado
                             lstorden.cliente = IF cliente.nom_cliente BEGINS "CP" THEN "CONSORCIO DE PROPIETARIOS" ELSE cliente.nom_cliente
                             lstorden.tanques = IF AVAILABLE cliente_otros_datos THEN cliente_otros_datos.tanques ELSE 0                                                  
                             lstorden.fvencimiento = bevento.frealizado + IF bevento.nro_tipo_evento = 1 THEN 30 ELSE 180
                             lstorden.nro_certif = bevento.nro_certif
                             lstorden.imagen = qrcode(bevento.url1).
                          LEAVE.
                  END.
                END.
        END.
        IF evento.origen BEGINS "REMIT" THEN DO:
            FIND rem_header WHERE rem_header.nro_remito = evento.nro_identificacion NO-LOCK NO-ERROR.
            FIND FIRST rem_detalle OF rem_header NO-LOCK.
            FIND articulo OF rem_detalle NO-LOCK.
            ASSIGN 
              lstorden.prf_comprob = rem_header.prf_comprob
              lstorden.cdg_articulo = quecod
              lstorden.cdg_tipoart = quetipo
              lstorden.nro_identificacion = rem_header.nro_comprob
              lstorden.origen = "R".
        END.
        IF evento.origen = "TAREA" THEN DO:
            FIND tarea WHERE tarea.nro_tarea = evento.nro_identificacion NO-LOCK NO-ERROR.
            IF AVAILABLE tarea THEN DO:
                IF tarea.cdg_tipotarea = "J" THEN DO:
                    CASE extrae("texto_adic",tarea.datos-template):
                        WHEN "A" THEN DO:
                            FIND administracion WHERE administracion.nro_admin = cliente.nro_admin NO-LOCK.
                            lstorden.direccion = administracion.direccion + "-".
                        END.
                        WHEN "O" THEN DO:
                            lstorden.direccion = "".
                        END.
                        OTHERWISE DO:
                            lstorden.direccion = lstorden.direccion + "-".
                        END.
                    END CASE.
                    lstorden.direccion = lstorden.direccion + extrae("texto_adic",tarea.datos-template).
                END.
                     
            END.
        END.

END.

xfile1 = TempFile("") + ".xml".

DATASET dset:WRITE-XML ("FILE", xfile1, TRUE,?,"",YES,YES).
