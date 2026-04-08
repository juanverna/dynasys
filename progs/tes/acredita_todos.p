/*===================================================================================================*/
/*      MARCA COMO ACREDITADOS TODOS LOS VALORES EN CARTERA ANTERIORES A UNA FECHA DADA              */
/*===================================================================================================*/

DEFINE VARIABLE V-FECHA AS DATE.

DEFINE VARIABLE barra_dir           AS CHARACTER.
DEFINE VARIABLE fecha_proceso       AS DATE.
DEFINE VARIABLE arch_err            AS CHARACTER.
DEFINE VARIABLE arch_cab            AS CHARACTER.
DEFINE VARIABLE arch_det            AS CHARACTER.
DEFINE VARIABLE arch_val            AS CHARACTER.
DEFINE VARIABLE arch_log            AS CHARACTER.
DEFINE VARIABLE directorio          AS CHARACTER.

/*===================================================================================================*/
/*                                     PROCESO                                                       */
/*===================================================================================================*/

SESSION:NUMERIC-FORMAT = "AMERICAN".

{findempresa.i}

barra_dir = IF OPSYS = "WIN32" THEN CHR(92) ELSE CHR(47).
FIND Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
                 AND Parametro.cdg_parametro = "DIRINCAJ"
                     NO-LOCK.
directorio = Parametro.observacion.

arch_log = directorio + barra_dir + "valores" + 
                         STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99") + "." + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2) + ".log".

OUTPUT TO VALUE(arch_log) PAGE-SIZE 72. 

PUT "=============================================================" SKIP
    "                                                             " SKIP
    "                   ACREDITACION DE VALORES                   " SKIP
    "                                                             " SKIP
    " Proceso: " STRING(TODAY,"99/99/9999") " - " STRING(TIME,"HH:MM:SS") SKIP
    "                                                             " SKIP
    "=============================================================" SKIP(2).


v-fecha = TODAY.
    
FOR EACH Valor WHERE Valor.fecha_emision < v-fecha AND Valor.estado = "00" EXCLUSIVE-LOCK:

    PUT cdg_banco cdg_sucurbanco numero_cheque fecha_recepcion fecha_emision dias_clearing  importe 
        SKIP.
    ASSIGN 
       Valor.fecha_deposito = v-fecha - 1
       Valor.fecha_acredita = fecha_deposito
       Valor.estado = "02".
END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_log, INPUT 22 ).
