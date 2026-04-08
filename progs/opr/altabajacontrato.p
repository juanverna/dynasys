/*====================================================================================*/
/*      ALTAS Y BAJAS DE CONTRATOS EN EL PERIODO                                */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_fecha AS DATE.
DEFINE INPUT PARAMETER has_fecha AS DATE.
DEFINE INPUT PARAMETER des_feve AS DATE.
DEFINE INPUT PARAMETER has_feve AS DATE.
DEFINE INPUT PARAMETER soloabono AS LOGICAL.
DEFINE INPUT PARAMETER precursos AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER p-xfile       AS CHARACTER.

/*====================================================================================*/
/*                          DEFINICION DE TABLAS TEMPORALES                           */
/*====================================================================================*/
DEFINE TEMP-TABLE tempresa no-undo LIKE empresa.
DEFINE BUFFER administrador FOR cliente.

DEFINE TEMP-TABLE tcontratos
    FIELD OPER                  AS CHAR FORMAT "X(4)"
    FIELD nro_contrato          LIKE contrato_hd.nro_contrato
    FIELD cdg_emp              LIKE empresa.cdg_empresa
    FIELD fecha_alta            LIKE contrato_hd.fecha_alta
    FIELD fecha_baja            LIKE contrato_hd.fecha_baja
    FIELD cdg_cliente           LIKE cliente.cdg_cliente
    FIELD direccion             LIKE cliente.direccion
    FIELD nom_cliente           LIKE cliente.nom_cliente
    FIELD cdg_articulo          LIKE articulo.cdg_articulo
    FIELD imp_total             LIKE Contrato_hd.imp_total 
    FIELD motivo_baja           LIKE Contrato_hd.motivo_baja 
    FIELD cdg_tipo_evento       LIKE tipo_evento.cdg_tipo_evento 
    FIELD numero_eventos        LIKE Contrato_hd.numero_eventos 
    FIELD resto_periodos        LIKE Contrato_hd.resto_periodos 
    FIELD rige_desde            LIKE Contrato_hd.rige_desde 
    FIELD rige_hasta            LIKE Contrato_hd.rige_hasta
    FIELD cdg_admin             LIKE cliente.cdg_cliente
    FIELD administrador         LIKE cliente.nom_cliente
    FIELD recursos             AS CHAR
    FIELD unidades              LIKE Cliente_otros_datos.Unidades.
DEFINE VAR vv AS CHAR NO-UNDO.
DEFINE VAR k AS INT NO-UNDO.
DEFINE DATASET dset FOR Tempresa, tcontratos.
    DEFINE VAR kk AS INT64.


/*====================================================================================*/
/*                  VARIABLES, FRAMES Y TABLAS TEMPORALES                             */
/*====================================================================================*/

{crystal_dyna.p}

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

{findempresa.i}
CREATE tempresa.
BUFFER-COPY empresa TO tempresa.
/*altas*/

FOR EACH contrato_hd NO-LOCK
  WHERE contrato_hd.rige_desde >= des_fecha and
    contrato_hd.rige_desde <= has_fecha
    AND contrato_hd.estado = "A" :
    IF soloabono THEN
           IF contrato_hd.cant_periodos <> 0  THEN NEXT.
    FIND FIRST cliente OF contrato_hd NO-LOCK NO-ERROR.
    FIND cliente_otros OF cliente NO-LOCK NO-ERROR.
    FIND FIRST administrador NO-LOCK WHERE administrador.nro_cliente = cliente.nro_admin NO-ERROR.
    FIND FIRST tipo_evento NO-LOCK where contrato_hd.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-ERROR.
  CREATE tcontratos.
  ASSIGN 
      tcontratos.OPER   = "ALTA"           
      tcontratos.nro_contrato = contrato_hd.nro_contrato     
      tcontratos.fecha_alta = contrato_hd.rige_desde       
      tcontratos.fecha_baja = contrato_hd.fecha_baja       
      tcontratos.cdg_cliente = cliente.cdg_cliente      
      tcontratos.direccion = cliente.direccion        
      tcontratos.nom_cliente = cliente.nom_cliente       
      tcontratos.imp_total         = contrato_hd.imp_total 
      tcontratos.motivo_baja       = contrato_hd.motivo_baja
      tcontratos.cdg_tipo_evento   = tipo_evento.cdg_tipo_evento
      tcontratos.numero_eventos    = contrato_hd.numero_eventos 
      tcontratos.resto_periodos = contrato_hd.resto_periodos   
      tcontratos.rige_desde = contrato_hd.rige_desde       
      tcontratos.rige_hasta = contrato_hd.rige_hasta       
      tcontratos.cdg_admin  = administrador.cdg_cliente    
      tcontratos.administrador = administrador.nom_cliente
      tcontratos.cdg_emp = empresa.cdg_empresa
      tcontratos.unidades = IF AVAILABLE cliente_otros THEN cliente_otros.unidades ELSE 0.   
      FOR EACH evento WHERE evento.nro_tipo_evento = contrato_hd.nro_tipo_evento AND
          evento.origen = "Contrato" AND evento.nro_identificacion = contrato_hd.nro_contrato AND
          NOT evento.anulado AND evento.frealizado >= des_feve AND evento.frealizado <= has_feve :
             tcontratos.recursos = tcontratos.recursos + "," + replace(evento.recursos,"#","").
      END.
      tcontratos.recursos = SUBSTRING(tcontratos.recursos,2).
      
      IF precursos <> "*" THEN do:
          IF LOOKUP( precursos, tcontratos.recursos ) = 0 THEN 
           DELETE tcontratos.
          IF AVAILABLE tcontratos THEN DO:
              kk=0.
          REPEAT k = 1 TO NUM-ENTRIES( tcontratos.recursos ):
              IF ENTRY(k,tcontratos.recursos ) = precursos THEN
                  kk = kk + 1.
          END.
          tcontratos.recursos = STRING(kk,">>9") + "/" + STRING (NUM-ENTRIES( tcontratos.recursos ),">>9" ).
          END.

     
      END.
END.
/*bajas*/
FOR EACH contrato_hd NO-LOCK
  WHERE contrato_hd.fecha_baja >= des_fecha and
    contrato_hd.fecha_baja <= has_fecha AND contrato_hd.Estado = "A":
    IF soloabono THEN
           IF contrato_hd.cant_periodos <> 0  THEN NEXT.
    FIND FIRST cliente OF contrato_hd NO-LOCK NO-ERROR.
    FIND FIRST administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
    FIND FIRST tipo_evento where contrato_hd.nro_tipo_evento = tipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
    FIND cliente_otros OF cliente NO-LOCK NO-ERROR.
  
      CREATE tcontratos.
      ASSIGN 
          tcontratos.cdg_emp = empresa.cdg_empresa
          tcontratos.OPER   = "BAJA"           
          tcontratos.nro_contrato = contrato_hd.nro_contrato     
          tcontratos.fecha_alta = contrato_hd.fecha_alta       
          tcontratos.fecha_baja = contrato_hd.fecha_baja       
          tcontratos.cdg_cliente = cliente.cdg_cliente      
          tcontratos.direccion = cliente.direccion        
          tcontratos.nom_cliente = cliente.nom_cliente       
          tcontratos.imp_total         = contrato_hd.imp_total 
          tcontratos.motivo_baja       = contrato_hd.motivo_baja
          tcontratos.cdg_tipo_evento   = tipo_evento.cdg_tipo_evento
          tcontratos.numero_eventos    = contrato_hd.numero_eventos 
          tcontratos.resto_periodos = contrato_hd.resto_periodos   
          tcontratos.rige_desde = contrato_hd.rige_desde       
          tcontratos.rige_hasta = contrato_hd.rige_hasta       
          tcontratos.cdg_admin  = administrador.cdg_cliente    
          tcontratos.administrador = administrador.nom_cliente
          tcontratos.unidades = IF AVAILABLE cliente_otros THEN cliente_otros.unidades ELSE 0.
       
          FOR EACH evento WHERE evento.nro_tipo_evento = contrato_hd.nro_tipo_evento AND
                   evento.origen = "Contrato" AND evento.nro_identificacion = contrato_hd.nro_contrato AND
                   NOT evento.anulado AND evento.frealizado >= des_feve AND evento.frealizado <= has_feve :
                       tcontratos.recursos = tcontratos.recursos + "," + replace( evento.recursos , "#" , "" ).
          END.
          tcontratos.recursos = SUBSTRING(tcontratos.recursos,2).
          IF precursos <> "*" THEN do:
              IF LOOKUP( precursos, tcontratos.recursos ) = 0 THEN 
               DELETE tcontratos.
              IF AVAILABLE tcontratos THEN DO:
                  kk=0.
                  REPEAT k = 1 TO NUM-ENTRIES( tcontratos.recursos ):
                      IF ENTRY(k,tcontratos.recursos ) = precursos THEN
                          kk = kk + 1.
                  END.
                  tcontratos.recursos = STRING(kk,">>9") + "/" + string( NUM-ENTRIES( tcontratos.recursos ),">>9" ).
              END.
          END.
END.
IF p-xfile = "" OR p-xfile = ?
    THEN p-xfile = tempfile("") + ".xml".

DATASET dset:WRITE-XML ("FILE", p-xfile, TRUE,
                                     ?,"",YES,YES).
