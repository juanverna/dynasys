/*========================================================================================*/
/*              MANDA A EXCEL UNA SERIE DE DATOS DE CLIENTES                              */
/*========================================================================================*/

DEFINE TEMP-TABLE ttReprt NO-UNDO
    FIELD ttValr AS CHARACTER
    FIELD ttRango AS CHARACTER
    FIELD ttOper AS CHARACTER
    FIELD ttSheet AS INTEGER
    FIELD ttOrden AS INTEGER
    INDEX xorden ttorden ASCENDING.

DEFINE VARIABLE orden AS INTEGER NO-UNDO INITIAL 0.

FUNCTION ax RETURNS INTEGER (INPUT Valr AS CHARACTER,Rango AS CHARACTER,Sheet AS INTEGER,Oper AS CHARACTER).
    orden = orden + 1.
    CREATE ttReprt.
    ASSIGN 
       ttValr = Valr
       ttRango = Rango
       ttSheet = Sheet 
       ttOper = Oper
       ttorden = orden.
    RETURN ?.
END FUNCTION.  

FUNCTION axcol RETURN CHAR ( INPUT orden AS INTEGER ).
    DEFINE VARIABLE aux AS CHARACTER.
    DEFINE VARIABLE i AS INTEGER.
    i = TRUNCATE( orden / 26 , 0 ).
    aux = IF i <> 0 THEN CHR( 64 + i ) ELSE "".
    aux = aux + CHR(64 + orden MOD 26 ).
    RETURN aux.
END FUNCTION.  


DEFINE VARIABLE i AS INTEGER NO-UNDO.
DEFINE VARIABLE aux AS CHARACTER NO-UNDO.

/*procesar estadistica*/

ax("Codigo","A4",1,"Valor").
ax("Razon Social","B4",1,"Valor").
ax("CUIT","C4",1,"Valor").
ax("Nro.Int","C4",1,"Valor").
i = 5.
FOR EACH Cliente WHILE i < 10: 
   ax(Cliente.cdg_cliente,"A" + TRIM(STRING(I,">>>9")),1,"Valor").
   ax(Cliente.nom_cliente,"B" + TRIM(STRING(I,">>>9")),1,"Valor").
   ax(Cliente.cuit,"C" + TRIM(STRING(I,">>>9")),1,"Valor").
   ax(TRIM(STRING(Cliente.nro_cliente,">>>>>9")),"D" + TRIM(STRING(I,">>>9")),1,"Valor").

   i = i + 1.
END.

ax("=SUMA(D4:D" + TRIM(STRING(I - 1,">>>9")) + ")","D" + TRIM(STRING(I,">>>9")),1,"Valor").
ax("","",1,"Calculate").

run xlsreprt.p ( input "clientes.xlt", input table ttReprt).
