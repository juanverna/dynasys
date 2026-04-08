DEFINE VAR alosqueno AS CHAR INITIAL "A0124,A1898,A1375,A6294,C10524,C8690,A7922,C5627,C8646,C0282,C1366"/*"A2214,A0124,A1586,A6350,A0050"*/.
/*separados por coma los codigos de los admisnistradores a los que no*/
FUNCTION pagado
    RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
      FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac_header.cdg_empresa AND
      cta_cte.tip_comprob = fac_header.tip_comprob AND
      cta_cte.prf_comprob = fac_header.prf_comprob AND
      cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte THEN DO:
IF cta_cte.credito = 0 and cta_cte.debito = 0  then paga = "S".
else
      IF cta_cte.credito = 0 OR cta_cte.debito = 0 
          THEN paga = "N".
          ELSE IF cta_cte.credito = cta_cte.debito 
              THEN paga = "S".
              ELSE paga = "P".
  END.
  ELSE paga = "?".
RETURN paga.

END FUNCTION.
DEFINE VAR canti AS INT NO-UNDO.
DEFINE VAR rok AS LOGICAL NO-UNDO.
DEFINE TEMP-TABLE facturas NO-UNDO
    FIELD domicilio AS CHAR
    FIELD rfac AS rowid.
DEFINE TEMP-TABLE facturas1 NO-UNDO
    FIELD orden AS int
    FIELD rfac AS rowid.
DEFINE BUFFER bcliente FOR cliente.

FUNCTION perror RETURN LOGICAL (ms AS CHAR):
    OUTPUT TO c:\dynasys10\logs\emailfacturas.LOG append.
    PUT UNFORMATTED NOW cliente.cdg_cliente " " ms SKIP.
    OUTPUT CLOSE.
    RETURN FALSE.
END.
DEFINE VAR porden AS INT NO-UNDO.
DEFINE VAR ff AS DATE LABEL "Fecha desde".
UPDATE ff.
MESSAGE " Se enviaran solamente 375 emails" VIEW-AS ALERT-BOX INFORMATION.
canti = 0.
FOR EACH bcliente  WHERE bcliente.nro_admin <> 0 NO-LOCK BREAK BY bcliente.nro_admin :
   IF LAST-OF(bCliente.nro_admin) THEN DO:
        FIND cliente WHERE cliente.nro_cliente = bcliente.nro_admin NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            OUTPUT TO c:\dynasys10\logs\emailfacturas.LOG append.
            PUT UNFORMATTED NOW bcliente.cdg_cliente " ADMINISTRADOR NO REGISTRADO para cliente" SKIP.
            OUTPUT CLOSE.
            NEXT.
        END.
        EMPTY TEMP-TABLE facturas.   
        IF CAN-DO(alosqueno, cliente.cdg_cliente) THEN NEXT.
        FOR EACH fac_header WHERE fac_header.nro_admin = cliente.nro_cliente AND fac_header.prf_comprob = 3
            AND fecha >= ff AND cai <> "" AND fac_header.tip_comprob BEGINS "F":
            IF pagado() = "S" THEN NEXT.
            IF index(fac_header.observacion,"EMAIL ENVIO")>0 THEN NEXT.
/*            FIND contrato_hd WHERE fac_header.nro_contrato = contrato_hd.nro_contrato NO-LOCK NO-ERROR.
            IF NOT AVAILABLE contrato_hd THEN NEXT.
            IF contrato_hd.fecha_baja <> ?  THEN NEXT.*/
            CREATE facturas.
                ASSIGN facturas.rfac = rowid(fac_header)
                       facturas.domicilio = Fac_header.direccion.
        END.
        FIND FIRST facturas NO-ERROR.
        IF NOT AVAILABLE facturas THEN NEXT.
        FIND FIRST domicilio NO-LOCK OF cliente.
        FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  
            can-do(Cliente-contacto.canal-email,"COB"):
                LEAVE.
        END.
        IF NOT AVAILABLE persona THEN DO:
           perror( "El destino no tiene una email donde enviar").
           NEXT.
        END.

        IF persona.email = "" THEN DO:
            perror("El destino no tiene una email donde enviar").
            NEXT.
        END.
        IF num-entries(persona.email,"@") <> 2 THEN DO:
                  perror( "ERROR EMAIL Facturas la persona " + persona.nombre + " email invalido" ).
                  NEXT.
        END.
        IF NUM-ENTRIES( entry( 2 , persona.email, "@" ) , ".") < 2 THEN DO:
                  perror("ERROR EMAIL Certificado la persona " + persona.nombre + " email invalido").
                  NEXT.
        END.
         EMPTY TEMP-TABLE facturas1. 
        FOR EACH facturas BY facturas.domicilio:
            CREATE facturas1.
            ASSIGN facturas1.rfac = facturas.rfac
                   facturas1.orden = porden.
                   porden = porden + 1.
        END.
        canti = canti + 1.
        RUN factuemail.p ( INPUT persona.email, INPUT cliente.nom_cliente, INPUT TABLE facturas1,OUTPUT rok ).
        IF RETURN-VALUE <> "" OR NOT rok THEN perror( RETURN-VALUE ).
        IF canti > 375 THEN LEAVE.
    END.
END.




