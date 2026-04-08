/*=================================================================================*/
/*                   IMPORTA LOS ARTICULOS DE ABASTECIMIENTO                       */
/*=================================================================================*/

{VRSHARED.I "new"}

DEFINE STREAM Archivos.

DEFINE VARIABLE arch_err            AS CHARACTER.
DEFINE VARIABLE arch_cab            AS CHARACTER FORMAT "X(180)".
DEFINE VARIABLE arch_log            AS CHARACTER.
DEFINE VARIABLE directorio          AS CHARACTER.
DEFINE VARIABLE barra_dir           AS CHARACTER.
DEFINE VARIABLE que_archivo         AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_camino          AS CHARACTER.
DEFINE VARIABLE que_tipo            AS CHARACTER.
DEFINE VARIABLE seguir              AS LOGICAL INITIAL NO.
DEFINE VARIABLE bajar               AS LOGICAL.

DEFINE TEMP-TABLE Arch_ordenado
    FIELD nombre AS CHARACTER
    FIELD camino AS CHARACTER
    FIELD fecha AS CHARACTER
    INDEX por_fecha IS PRIMARY fecha.

/*=================================================================================*/
/*        AVERIGUA LOS NUMEROS INTERNOS DE LOS MOVIMIENTOS A IMPORTAR              */
/*=================================================================================*/

SESSION:NUMERIC-FORMAT = "AMERICAN".

{findempresa.i}


     /*---------------------------------------------*/ 
     /* Importa los Artículos en tablas temporarias */ 
     /*---------------------------------------------*/ 

barra_dir = IF OPSYS = "WIN32" THEN CHR(92) ELSE CHR(47).
FIND Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
                 AND Parametro.cdg_parametro = "DIRINART"
                     NO-LOCK.
directorio = Parametro.valor_c.

INPUT STREAM Archivos FROM OS-DIR(directorio).     

arch_log = directorio + barra_dir + "articulos" + 
                         STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99") + "." + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),7,4) + ".log".

OUTPUT TO VALUE(arch_log) PAGE-SIZE 72. 

PUT "================================================================================================================" SKIP
    "                                                                                                                " SKIP
    "                              INTERFACE DE CARGA DE ARTÍCULOS DE ABASTECIMIENTO                                 " SKIP
    "                                                                                                                " SKIP
    "                              Proceso: " STRING(TODAY) " - " STRING(TIME,"HH:MM:SS")                              SKIP
    "                                                                                                                " SKIP
    "================================================================================================================" SKIP(2).

REPEAT:

   IMPORT STREAM Archivos que_archivo que_camino que_tipo.

   /*abtmrep.20040407.16385112*/
   IF que_tipo = "F"   /* Es un archivo */
       AND NUM-ENTRIES(que_archivo,".") = 3  /* Con nombre de la forma xxxx.aaaammdd.hhmmsscc */
       AND ENTRY(1,que_archivo,".") = "abtmrep" /* Empieza con "abtmrep", con lo que asumimos cabecera */
   THEN DO:

         CREATE Arch_ordenado.
         ASSIGN
             nombre = que_archivo
             camino = que_camino
             fecha  = ENTRY(2,que_archivo,".") + ENTRY(3,que_archivo,".").
   END.
END.

FOR EACH Arch_ordenado USE-INDEX por_fecha:

        arch_cab = Arch_ordenado.camino. /* asignamos el full-path */
        PUT SKIP(3).
        PUT "Archivo: " arch_cab SKIP.
        arch_err = REPLACE(arch_cab,"abtmrep","errores").

        IF seguir THEN MESSAGE arch_cab VIEW-AS ALERT-BOX  MESSAGE TITLE "Procesando...".

        RUN interface_articulos.p ( INPUT arch_cab, OUTPUT hay_error ).
        IF NOT hay_error
        THEN DO:
            RUN renombrar_archivos.
        END.

END.  /* De recorrer el directorio de interfaces */


OUTPUT CLOSE.

RUN veresult.w ( arch_log, 22 ).

/*=================================================================================*/
/*                             PROCEDIMIENTOS                                      */
/*=================================================================================*/

PROCEDURE renombrar_archivos:

        OS-COPY VALUE(arch_cab) VALUE(REPLACE(arch_cab,"abtmrep","ok" + barra_dir + "abtmrep")).
        IF OS-ERROR = 0 THEN OS-DELETE VALUE(arch_cab).
    
        OS-COPY VALUE(arch_err) VALUE(REPLACE(arch_err,"errores","ok" + barra_dir + "errores")).
        IF OS-ERROR = 0 THEN OS-DELETE VALUE(arch_err).
    

END PROCEDURE.

