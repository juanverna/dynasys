/*=========================================================================================*/
/*                                   GENERA XML para la IMPRESION DE RESUMENES DE DEUDA                       */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_cliente      AS char.
DEFINE INPUT PARAMETER p-has_cliente      AS char.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.
DEFINE INPUT PARAMETER p-vencimiento      AS DATE.
DEFINE INPUT PARAMETER p-punto-vta        AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_por AS INTEGER.
DEFINE OUTPUT PARAMETER pxfile AS CHAR NO-UNDO.

/*=========================================================================================*/
/*                                          VARIABLES                                      */
/*=========================================================================================*/

{crystal_dyna.p}
{findempresa.i}

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE k                         AS INTEGER.
DEFINE VARIABLE x-importe                 LIKE Cta_cte.debito.
DEFINE VARIABLE t-importe                 LIKE Cta_cte.debito.
DEFINE VAR senal AS LOGICAL NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.

DEFINE BUFFER Administrador FOR Cliente.

DEFINE TEMP-TABLE T-Administrador 
        field nro_cliente              like Administrador.nro_cliente 
        field horario_de_atencion      like Administrador.horario_de_atencion 
        field HAT                      like Administrador.HAT 
        field horario_de_pago          like Administrador.horario_de_pago 
        field cdg_cliente              like Administrador.cdg_cliente 
        field direccion                like Administrador.direccion 
        field dias_de_pago             like Administrador.dias_de_pago 
        field nom_cliente              like Administrador.nom_cliente 
        field localidad                like Administrador.localidad
        FIELD telefonos                LIKE Administrador.telefonos
        FIELD texto                    LIKE Administrador.texto
    FIELD ulttrans  AS DATE
        FIELD cobranzas                AS CHAR 
        FIELD email                    AS CHAR
        FIELD fechac                   AS CHAR
        FIELD fechai                   AS DATE
        FIELD horac                    AS CHAR
    INDEX I1 cdg_cliente.
DEFINE TEMP-TABLE T-Cta_cte       
    FIELD nro_administrador LIKE Cta_cte.nro_administrador
    FIELD fnComprobante AS char FORMAT "x(16)"
    FIELD cli_direccion LIKE fac_header.direccion
    FIELD codigo_cliente LIKE Fac_header.codigo_cliente
    FIELD cli_nombre LIKE  Fac_header.nombre
    FIELD credito LIKE Cta_cte.credito
    FIELD debito LIKE Cta_cte.debito
    FIELD fecha_emision LIKE Cta_cte.fecha_emision 
    FIELD fecha_vencimiento LIKE Cta_cte.fecha_vencimiento 
    FIELD imp_total LIKE Cta_cte.imp_total
    FIELD ListaArticulo AS CHAR FORMAT "X(20)"
    FIELD debita LIKE Tipocomprobante.debita
    FIELD tip_comprob LIKE fac_header.tip_comprob
    FIELD nro_comprob LIKE fac_header.nro_comprob
    FIELD desc_listaArticulo AS CHAR
    INDEX I1 nro_administrador.

DEFINE DATASET dset FOR T-Administrador,T-Cta_cte
    DATA-RELATION ACTACTE FOR T-Administrador, T-Cta_cte NESTED
        RELATION-FIELDS ( T-Administrador.nro_cliente,T-Cta_cte.nro_administrador ).

/*=========================================================================================*/
/*                                    FUNCIONES                                            */
/*=========================================================================================*/

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/
IF p-ver_por = 1 THEN DO:

 FOR EACH Administrador  
    WHERE Administrador.cdg_cliente >= p-des_cliente
      AND Administrador.cdg_cliente <= p-has_cliente
      AND CAN-DO(Administrador.lista_empresas,empresa.cdg_empresa)
        /*AND LOOKUP(Administrador.lista_sectores, que_sector) = 1 */
            USE-INDEX cdg_cliente NO-LOCK:

       CREATE T-Administrador.
       BUFFER-COPY Administrador  EXCEPT administrador.telefono TO T-Administrador.
/*ver contacto con email*/
       FIND FIRST domicilio OF administrador NO-LOCK NO-ERROR.
       FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" and  can-do(Cliente-contacto.canal-email,"COB") NO-LOCK :
            T-Administrador.email = persona.email.
            DO i = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
             IF entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!") = "" THEN NEXT.
               FIND tipo_dato WHERE tipo_dato.cdg_tipo_dato = entry(1,ENTRY(i,persona.numeros_telefono,"|"),"!") NO-LOCK NO-ERROR.
               T-Administrador.telefono = T-Administrador.telefono + " " + IF AVAILABLE tipo_dato THEN trim(tipo_dato.descripcion) ELSE "Desconocido".
               T-Administrador.telefono = T-Administrador.telefono + ":" + entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!").
            END.
            LEAVE.
       END.
       T-Administrador.telefono = SUBSTRING(T-Administrador.telefono,2).
       IF T-Administrador.telefono = "" THEN DO:
        /*un segundo intento para alguno con datos aunque no tenga email*/
               FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto NO-LOCK :
                    DO i = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
                     IF entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!") = "" THEN NEXT.
                       FIND tipo_dato WHERE tipo_dato.cdg_tipo_dato = entry(1,ENTRY(i,persona.numeros_telefono,"|"),"!") NO-LOCK NO-ERROR.
                       T-Administrador.telefono = T-Administrador.telefono + " " + IF AVAILABLE tipo_dato THEN trim(tipo_dato.descripcion) ELSE "Desconocido".
                       T-Administrador.telefono = T-Administrador.telefono + ":" + entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!").
                    END.
                    LEAVE.
               END.
               T-Administrador.telefono = SUBSTRING(T-Administrador.telefono,2).
       END.

       FOR EACH rendicion_hd NO-LOCK WHERE rendicion_hd.nro_admin = administrador.nro_cliente ,
       EACH sic.Caj_header OF sic.Rendicion_hd NO-LOCK,
      EACH sic.Caj_detalle OF sic.Caj_header NO-LOCK,
      FIRST sic.Rubro OF sic.Caj_detalle NO-LOCK
           BY rendicion_hd.fecha DESC
           BY Rubro.cdg_rubro:
           IF rubro.cdg_rubro = 20 THEN DO:
                t-administrador.ulttrans = rendicion_hd.fecha.
                LEAVE.
           END.
       END.
       senal = FALSE.
       
           FOR EACH Cta_cte NO-LOCK
                WHERE cta_cte.nro_administrador = administrador.nro_cliente
                  AND Cta_cte.cdg_empresa     = p-que_empresa
                  AND Cta_cte.fecha_emision  <= p-has_fecha
                  AND Cta_cte.debito <> Cta_cte.credito 
                       BY cta_cte.fecha_emision:

                IF NOT can-do("F*,D*",cta_cte.tip_comprob) THEN NEXT.

                IF NOT CAN-DO(p-punto-vta, string(cta_cte.prf_comprob,"9999") ) THEN NEXT.
                IF cta_cte.fecha_vencimiento > p-vencimiento THEN NEXT.
                FIND FIRST Tipocomprobante OF Cta_cte NO-LOCK.
                FIND FIRST cliente OF cta_cte NO-LOCK. 
                senal = TRUE.
                FIND fac_header WHERE 
                    fac_header.cdg_empresa = cta_cte.cdg_empresa AND
                    fac_header.tip_comprob = cta_cte.tip_comprob AND
                    fac_header.prf_comprob = cta_cte.prf_comprob AND
                    fac_header.nro_comprob = cta_cte.nro_comprob NO-LOCK.

                CREATE T-Cta_cte.
                BUFFER-COPY Cta_cte TO T-Cta_cte
                    ASSIGN T-Cta_cte.debita = Tipocomprobante.debita.
                    ASSIGN T-Cta_cte.fnComprobante = fnComprobante(cta_cte.tip_comprob,cta_cte.prf_comprob,cta_cte.nro_comprob)
                           T-Cta_cte.cli_nombre = fac_header.nombre
                           T-Cta_cte.codigo_cliente = fac_header.codigo_cliente      
                           T-Cta_cte.cli_direccion = fac_header.direccion
                           T-Cta_cte.tip_comprob = fac_header.tip_comprob
                           T-Cta_cte.nro_comprob = fac_header.nro_comprob.

                T-Cta_cte.ListaArticulo = "".
                FOR EACH fac_detalle OF fac_header,articulo OF fac_detalle:
                    T-Cta_cte.ListaArticulo = T-Cta_cte.ListaArticulo + " " + Articulo.cdg_tipoart.
                    FIND tipo_articulo OF articulo.
                    T-Cta_cte.desc_ListaArticulo = T-Cta_cte.ListaArticulo + " " + Tipo_articulo.dsc_tipoart.
                END.
               T-Cta_cte.ListaArticulo = substring(T-Cta_cte.ListaArticulo,2).
               T-Cta_cte.desc_ListaArticulo = substring(T-Cta_cte.desc_ListaArticulo,2).
                FOR EACH rendicion_hd WHERE rendicion_hd.nro_admin = administrador.nro_cliente BY rendicion_hd.fecha DESC:
                       IF LOOKUP(string(rendicion_hd.fecha),t-administrador.cobranza,",") = 0 THEN DO:
                          t-administrador.cobranza = t-administrador.cobranza  + "," + string(rendicion_hd.fecha).
                          
                       END.
                       IF NUM-ENTRIES(t-administrador.cobranza,",") >= 2 THEN LEAVE.
                END.
                IF t-administrador.cobranza BEGINS "," THEN 
                t-administrador.cobranza = SUBSTRING(t-administrador.cobranza,2).
    
    END. /* De los movimientos de un administador */
    IF NOT senal THEN do:
        DELETE t-administrador.
        NEXT.
    END.
    FIND restriccion WHERE restriccion.cdg_restriccion = "FECHAC" NO-LOCK.
    FIND FIRST cliente_restriccion of restriccion WHERE cliente_restriccion.nro_cliente = administrador.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN T-Administrador.fechac = cliente_restriccion.valor.
    FIND restriccion WHERE restriccion.cdg_restriccion = "HORAC" NO-LOCK.
    FIND FIRST cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = administrador.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN T-Administrador.horac = cliente_restriccion.valor.
    FIND restriccion WHERE restriccion.cdg_restriccion = "FECHAI" NO-LOCK.
    FIND FIRST cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = administrador.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN T-Administrador.fechai = date(cliente_restriccion.valor) NO-ERROR.


 END. /* Del rango de administradores */
END.
ELSE DO:
     FOR EACH Administrador  
    WHERE Administrador.nom_cliente >= p-des_cliente
      AND Administrador.nom_cliente <= p-has_cliente
      AND CAN-DO(Administrador.lista_empresas,empresa.cdg_empresa)
        /*AND LOOKUP(Administrador.lista_sectores, que_sector) = 1 */
      USE-INDEX por_nombre NO-LOCK:
       CREATE T-Administrador.
       BUFFER-COPY Administrador TO T-Administrador.
       senal = FALSE.
           FOR EACH Cta_cte NO-LOCK
                WHERE cta_cte.nro_administrador = administrador.nro_cliente
                  AND Cta_cte.cdg_empresa     = p-que_empresa
                  AND Cta_cte.fecha_emision  <= p-has_fecha
                  AND Cta_cte.debito <> Cta_cte.credito 
                       BY cta_cte.fecha_emision:
               IF cta_cte.fecha_vencimiento > p-vencimiento THEN NEXT.
               IF NOT CAN-DO(p-punto-vta, string(cta_cte.prf_comprob,"9999") ) THEN NEXT.
                FIND FIRST Tipocomprobante OF Cta_cte NO-LOCK.
                FIND FIRST cliente OF cta_cte NO-LOCK. 
                senal = TRUE.
                FIND fac_header WHERE 
                    fac_header.cdg_empresa = cta_cte.cdg_empresa AND
                    fac_header.tip_comprob = cta_cte.tip_comprob AND
                    fac_header.prf_comprob = cta_cte.prf_comprob AND
                    fac_header.nro_comprob = cta_cte.nro_comprob NO-LOCK.

                CREATE T-Cta_cte.
                BUFFER-COPY Cta_cte TO T-Cta_cte
                    ASSIGN T-Cta_cte.debita = Tipocomprobante.debita.
                    ASSIGN T-Cta_cte.fnComprobante = fnComprobante(cta_cte.tip_comprob,cta_cte.prf_comprob,cta_cte.nro_comprob)
                           T-Cta_cte.cli_nombre = fac_header.nombre
                           T-Cta_cte.codigo_cliente = fac_header.codigo_cliente
                           T-Cta_cte.cli_direccion = fac_header.direccion.
                T-Cta_cte.ListaArticulo = "".
                FOR EACH fac_detalle OF fac_header,articulo OF fac_detalle:
                    T-Cta_cte.ListaArticulo = T-Cta_cte.ListaArticulo + " " + Articulo.cdg_tipoart.
                END.
    END. /* De los movimientos de un administador */
    IF NOT senal THEN DELETE t-administrador.

END. /* Del rango de administradores */

END.
FIND FIRST t-administrador NO-ERROR.
IF AVAILABLE t-administrador THEN DO:
    pxfile =TempFile("") + ".xml".
    DATASET dset:WRITE-XML ("FILE", pxfile, TRUE,
                                         ?,"",YES,YES).
END.
ELSE pxfile = ?.
