/*===========================================================================================================*/
/*                   IMPORTA LA CUENTA CORRIENTE DESDE UN ARCHIVO CSV A TABLAS DE DYNASYS                    */
/*===========================================================================================================*/

DEFINE INPUT PARAMETER arch_entrada AS CHARACTER FORMAT "X(40)".
DEFINE INPUT PARAMETER arch_salida  AS CHARACTER FORMAT "X(40)".

/*===========================================================================================================*/
/*                                                   VARIABLES                                               */
/*===========================================================================================================*/

DEFINE VARIABLE v-cliente AS CHARACTER.
DEFINE VARIABLE v-tipo_com AS CHARACTER.
DEFINE VARIABLE v-ini_com AS CHARACTER.
DEFINE VARIABLE v-nro_com AS CHARACTER.
DEFINE VARIABLE v-fec_com AS CHARACTER.
DEFINE VARIABLE v-imp_total AS CHARACTER.
DEFINE VARIABLE v-imp_neto AS CHARACTER.
DEFINE VARIABLE v-imp_exentos AS CHARACTER.
DEFINE VARIABLE v-empresa AS CHARACTER.
DEFINE VARIABLE v-sucursal AS CHARACTER.


DEFINE VARIABLE registro AS CHARACTER.
DEFINE VARIABLE v-nreg AS INTEGER.
DEFINE VARIABLE j     AS INTEGER.

DEFINE VARIABLE lista_zonas AS CHARACTER.

DEFINE TEMP-TABLE T-Movimientos
    FIELD f-nreg AS INTEGER FORMAT ">>>>>>9"
    FIELD f-cliente AS CHARACTER FORMAT "X(12)"
    FIELD f-cdg_empresa AS CHARACTER FORMAT "X(2)"
    FIELD f-tipo_com AS CHARACTER FORMAT "X(2)"
    FIELD f-ini_com AS INTEGER FORMAT "9999"
    FIELD f-nro_com AS INTEGER FORMAT "99999999"
    FIELD f-fec_com AS DATE 
    FIELD f-imp_total AS DECIMAL
    FIELD f-imp_neto AS DECIMAL
    FIELD f-imp_exentos AS DECIMAL
    INDEX por_registro IS PRIMARY UNIQUE f-nreg.

DEFINE TEMP-TABLE T-Cta_cte LIKE Cta_cte.
DEFINE STREAM Errores.

/*===========================================================================================================*/
/*                                         PROCESO DE IMPORTACION                                            */
/*===========================================================================================================*/

SESSION:NUMERIC-FORMAT = "american".

DO :

    EMPTY TEMP-TABLE T-Cta_cte.
    EMPTY TEMP-TABLE T-Movimientos.

    OUTPUT STREAM Errores TO VALUE(arch_salida).
    PUT STREAM Errores UNFORMATTED
        "*************************************************************************************" SKIP
        " L E C T U R A   D E   I N T E R F A S E   D E   M O V I M I E N T O S   A D C O M   " SKIP
        "*************************************************************************************" SKIP
        TODAY SPACE(4) STRING(TIME,"HH:MM:SS") SPACE(4) arch_entrada SKIP
        "*************************************************************************************" SKIP(2).

    INPUT FROM VALUE(arch_entrada).    
    IMPORT UNFORMATTED registro. /* SALTEO LOS TITULOS */
    IMPORT UNFORMATTED registro. /* SALTEO LOS TITULOS */  
    v-nreg = 0.
    REPEAT :
        IMPORT UNFORMATTED registro.
        IF ENTRY(1,registro,";") <> ""
        THEN DO:
            RUN desarmar_registro.
            IF v-tipo_com <> "" THEN RUN asignar_movimiento.   
           /* RUN mostrar. */
        END.
    
    END.
    INPUT CLOSE.
    
    FOR EACH T-Movimientos WHERE T-Movimientos.f-cliente <> "":
    
        FIND Cliente WHERE Cliente.cdg_cliente = T-Movimientos.f-cliente NO-LOCK NO-ERROR.
        IF AVAILABLE Cliente
        THEN DO:
            RUN tratar_registro.
        END.
        ELSE DO:
            RUN grabar_log ( "***** Cliente no hallado" ).
        END.
    
    END.

    /*---------------------------------------------------------------------------------*/
    /*                    baja los datos a la base de datos                            */
    /*---------------------------------------------------------------------------------*/
    
    FOR EACH T-Cta_cte:                   
        CREATE Cta_cte.                   
        BUFFER-COPY T-Cta_cte TO Cta_cte. 
    END.                                  

END.
OUTPUT STREAM Errores CLOSE.

RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

/*===========================================================================================================*/
/*                                             PROCEDIMIENTOS                                                */
/*===========================================================================================================*/

PROCEDURE desarmar_registro:

    DEFINE VARIABLE c AS INTEGER.
    
    ASSIGN     
         v-cliente = ?
         v-tipo_com = ?
         v-ini_com = ?
         v-nro_com = ?
         v-fec_com = ?
         v-imp_total = ?
         v-imp_neto = ?
         v-imp_exentos = ?.

    c = 1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-cliente = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-tipo_com = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-ini_com = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-nro_com = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-fec_com = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-imp_total = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-imp_neto = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-imp_exentos = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-empresa = ENTRY(c,registro,";"). c = c +  1.
    IF NUM-ENTRIES(registro,";") >= c THEN v-sucursal = ENTRY(c,registro,";"). c = c +  1.

END PROCEDURE.

PROCEDURE asignar_movimiento:

    CREATE T-Movimientos.

    ASSIGN  v-nreg = v-nreg + 1
            T-Movimientos.f-nreg             = v-nreg 
            T-Movimientos.f-cliente          = v-cliente
            T-Movimientos.f-cdg_empresa      = IF v-empresa = "B" THEN "F" ELSE "R"
            T-Movimientos.f-tipo_com         = v-tipo_com
            T-Movimientos.f-ini_com          = INTEGER(v-ini_com) 
            T-Movimientos.f-nro_com          = INTEGER(v-nro_com)  
            T-Movimientos.f-fec_com          = DATE(v-fec_com)      
            T-Movimientos.f-imp_total        = DECIMAL(v-imp_total)  
            T-Movimientos.f-imp_neto         = DECIMAL(v-imp_neto)    
            T-Movimientos.f-imp_exentos      = DECIMAL(v-imp_exentos).

END PROCEDURE.

PROCEDURE mostrar:

    DEFINE FRAME f-reg
        v-cliente COLON 30
        v-tipo_com COLON 30
        v-ini_com COLON 30
        v-nro_com COLON 30
        v-fec_com COLON 30
        WITH FRAME f-reg SIDE-LABELS.

    DISPLAY 
        v-cliente 
        v-tipo_com 
        v-ini_com 
        v-nro_com 
        v-fec_com 
        WITH FRAME f-reg.
    
END PROCEDURE.

PROCEDURE tratar_registro:

    FIND Vendedor OF Cliente NO-LOCK.
    FIND T-Cta_cte WHERE T-Cta_cte.cdg_empresa     = T-Movimientos.f-cdg_empresa 
                     AND T-Cta_cte.tip_comprob     = T-Movimientos.f-tipo_com 
                     AND T-Cta_cte.prf_comprob     = T-Movimientos.f-ini_com 
                     AND T-Cta_cte.nro_comprob     = T-Movimientos.f-nro_com
                     AND T-Cta_cte.nro_vencimiento = 1
                         NO-ERROR.

    IF NOT AVAILABLE T-Cta_cte
    THEN DO:
        FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa     = T-Movimientos.f-cdg_empresa 
                             AND Cta_cte.tip_comprob     = T-Movimientos.f-tipo_com 
                             AND Cta_cte.prf_comprob     = T-Movimientos.f-ini_com 
                             AND Cta_cte.nro_comprob     = T-Movimientos.f-nro_com
                                 NO-ERROR.
        IF NOT AVAILABLE Cta_cte
        THEN DO:
            CREATE  T-Cta_cte.
            ASSIGN  T-Cta_cte.ano                 = YEAR(T-Movimientos.f-fec_com)
                    T-Cta_cte.cambio              = 1
                    T-Cta_cte.cdg_imputacion      = 1
                    T-Cta_cte.fecha_emision       = T-Movimientos.f-fec_com
                    T-Cta_cte.fecha_vencimiento   = T-Movimientos.f-fec_com
                    T-Cta_cte.fecha_iva           = T-Movimientos.f-fec_com
                    T-Cta_cte.liberada            = YES
                    T-Cta_cte.mes                 = MONTH(T-Movimientos.f-fec_com)
                    T-Cta_cte.nro_cliente         = Cliente.nro_cliente
                    T-Cta_cte.nro_cobrador        = Cliente.nro_cobrador
                    T-Cta_cte.nro_comprob         = T-Movimientos.f-nro_com
                    T-Cta_cte.nro_moneda          = 1
                    T-Cta_cte.nro_vencimiento     = 1
                    T-Cta_cte.nro_vendedor        = Vendedor.nro_vendedor
                    T-Cta_cte.prf_comprob         = T-Movimientos.f-ini_com
                    T-Cta_cte.tip_comprob         = T-Movimientos.f-tipo_com
                    T-Cta_cte.cdg_empresa         = T-Movimientos.f-cdg_empresa.
            IF T-Movimientos.f-tipo_com BEGINS "F" OR T-Movimientos.f-tipo_com BEGINS "D"
                 THEN ASSIGN T-Cta_cte.debito = T-Movimientos.f-imp_total
                             T-Cta_cte.credito = 0.
                 ELSE ASSIGN T-Cta_cte.debito = 0
                             T-Cta_cte.credito = T-Movimientos.f-imp_total.
            RUN grabar_log ( "Incorporado" ).

        END.
        ELSE DO:
            RUN grabar_log ( "***** Comprobante ya existente" ).
        END.
    END.
    ELSE DO:
        RUN grabar_log ( "***** Comprobante duplicado" ).
    END.

END PROCEDURE.

PROCEDURE grabar_log:

    DEFINE INPUT PARAMETER p-texto AS CHARACTER FORMAT "X(30)".

    PUT STREAM Errores
        T-Movimientos.f-nreg             " "
        T-Movimientos.f-cliente          " "
        T-Movimientos.f-cdg_empresa      " "
        T-Movimientos.f-tipo_com         " "
        T-Movimientos.f-ini_com          " "
        T-Movimientos.f-nro_com          " "
        T-Movimientos.f-fec_com          " "
        T-Movimientos.f-imp_total        " "
        T-Movimientos.f-imp_neto         " "
        T-Movimientos.f-imp_exentos      " "
        p-texto
        SKIP.


END PROCEDURE.
