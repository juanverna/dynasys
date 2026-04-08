/*

Parametros posibles de ingresar en la linea de comando

OBLIGATORIOS:

fdesde       Fecha desde la que se desea listar el log de auditoria
fhasta       Fecha hasta la que se desea listar el log de auditoria
udesde       Usuario desde el que se desea listar el log de auditoria
uhasta       Usuario desde el que se desea listar el log de auditoria
lempresas    Lista de empresas a considerar en el proceso, separada con "/"
archivo      Nombre del archivo de salida para generar interface

ERRORES

LAUD001      La lista de parametros esta vacia
LAUD002      No existe parametro de fecha desde
LAUD003      La fecha desde es incorrecta
LAUD004      No existe parametro de fecha hasta
LAUD005      La fecha hasta es incorrecta
LAUD006      La fecha hasta es menor que la desde
LAUD007      No existe parametro de usuario desde
LAUD008      No existe parametro de usuario hasta
LAUD009      EL usuario hasta es menor que el desde
LAUD010      No existe el parametro de lista de empresas
LAUD011      La lista empresas esta vacia
LAUD012      No existe el parametro de archivo de interface
LAUD013      Se indicó un parámetro no reconocido

*/


/*
OUTPUT STREAM Comprobantes TO VALUE(directorio + '\imbv' + dirfecha + '.reg').
*/

DEFINE VARIABLE v-fecha_desde       AS DATE.
DEFINE VARIABLE v-fecha_hasta       AS DATE.
DEFINE VARIABLE v-user_desde        LIKE Usuario.cdg_usuario.
DEFINE VARIABLE v-user_hasta        LIKE Usuario.cdg_usuario.
DEFINE VARIABLE v-lista_empresas    AS CHARACTER.
DEFINE VARIABLE v-archivo           AS CHARACTER.

DEFINE VARIABLE v-arch_log          AS CHARACTER.

DEFINE VARIABLE lista_parametros    AS CHARACTER FORMAT "X(120)".
DEFINE VARIABLE j_parametro         AS INTEGER.
DEFINE VARIABLE c_parametro         AS CHARACTER.
DEFINE VARIABLE hay_error           AS LOGICAL.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

/* Recupera la lista de parametros y verifica que sean correctos */

RUN ponempresa.p ("M").

lista_parametros = SESSION:PARAMETER.

IF lista_parametros = ""
THEN DO:
    RUN poner_error ( INPUT "LAUD001" ).
END.
ELSE DO:
    IF INDEX(lista_parametros,"fdesde")    = 0 
    THEN DO:   
        RUN poner_error ( INPUT "LAUD002" ).
    END.
    ELSE DO:   
        IF INDEX(lista_parametros,"fhasta")    = 0 
        THEN DO:   
            RUN poner_error ( INPUT "LAUD004" ).    
        END.
        ELSE DO:   
            IF INDEX(lista_parametros,"udesde")    = 0 
            THEN DO:   
                RUN poner_error ( INPUT "LAUD007" ).    
            END.
            ELSE DO:   
                IF INDEX(lista_parametros,"uhasta")    = 0 
                THEN DO:   
                    RUN poner_error ( INPUT "LAUD008" ).    
                END.
                ELSE DO:   
                    IF INDEX(lista_parametros,"lempresas") = 0 
                    THEN DO:
                        RUN poner_error ( INPUT "LAUD010" ).    
                    END.
                    ELSE DO:   
                        IF INDEX(lista_parametros,"archivo")   = 0 
                        THEN DO:  
                            RUN poner_error ( INPUT "LAUD012" ).    
                        END.
                    END.
                END.
            END.
        END.
    END.

    /* -------------------------------------------------------------------------- */
    /* Si paso por poner_error, hay_error esta en si y no recorre los parametros  */
    /* Si no, los parametros están todos, verificamos que haya valores correctos  */
    /* -------------------------------------------------------------------------- */

    DO j_parametro = 1 TO NUM-ENTRIES(lista_parametros) WHILE NOT hay_error:

        c_parametro = ENTRY(j_parametro,lista_parametros,",").

        IF ENTRY(1,c_parametro,"=") = "fdesde"
        THEN DO:   
            v-fecha_desde = DATE(ENTRY(2,c_parametro,"=")) NO-ERROR.
            IF ERROR-STATUS:ERROR
            THEN DO:
                RUN poner_error ( INPUT "LAUD003" ).    
            END.
        END.
    
        IF ENTRY(1,c_parametro,"=") = "fhasta"
        THEN DO:   
            v-fecha_hasta = DATE(ENTRY(2,c_parametro,"=")) NO-ERROR.
            IF ERROR-STATUS:ERROR
            THEN DO:
                RUN poner_error ( INPUT "LAUD005" ).    
            END.
        END.

        IF ENTRY(1,c_parametro,"=") = "udesde"
        THEN DO:   
            v-user_desde = ENTRY(2,c_parametro,"=").
        END.
    
        IF ENTRY(1,c_parametro,"=") = "uhasta"
        THEN DO:   
            v-user_hasta = ENTRY(2,c_parametro,"=").
        END.
    
        IF ENTRY(1,c_parametro,"=") = "lempresas"
        THEN DO:
            IF ENTRY(2,c_parametro,"=") = ""
            THEN DO:
                RUN poner_error ( INPUT "LAUD011" ).    
            END.
            ELSE DO:
                v-lista_empresas = REPLACE(ENTRY(2,c_parametro,"="),"/",",").
            END.
        END.

        IF ENTRY(1,c_parametro,"=") = "archivo"
        THEN DO:
            v-archivo = ENTRY(2,c_parametro,"=").
        END.

    END.

    IF NOT hay_error
    THEN DO:

        IF v-fecha_desde > v-fecha_hasta
        THEN DO:
            RUN poner_error ( INPUT "LAUD006" ).    
        END.
        ELSE DO:
            IF v-user_desde > v-user_hasta
            THEN DO:
                RUN poner_error ( INPUT "LAUD009" ).    
            END.
            ELSE DO:

                /* Ejecuta la corrida */
                
                RUN listar_auditoria.r ( INPUT v-fecha_desde,       
                                         INPUT v-fecha_hasta,       
                                         INPUT v-user_desde,        
                                         INPUT v-user_hasta,        
                                         INPUT v-lista_empresas,    
                                         INPUT v-archivo).

                RUN ponerlog ( INPUT "Ejecucion normal" ).

            END.
        END.
    END.
END.

/*=========================================================================================*/
/*                                  PROCEDIMIENTOS                                         */
/*=========================================================================================*/

PROCEDUR poner_error:
     
    DEFINE INPUT PARAMETER p-cdg_mensaje LIKE Mensaje.cdg_mensaje.

    FIND Mensaje WHERE Mensaje.cdg_mensaje = p-cdg_mensaje NO-LOCK.
    RUN ponerlog ( INPUT Mensaje.texto ).

    hay_error = YES.

END PROCEDURE.

PROCEDURE ponerlog:

    DEFINE INPUT PARAMETER p-mensaje LIKE Mensaje.texto.

    /* Halla el nombre del archivo en donde logear las corridas */
    
    {findempresa.i}
    
    FIND Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
                     AND Parametro.cdg_parametro = "ARLOGAUD"
                         NO-LOCK.
    v-arch_log = Parametro.valor_c.
    RELEASE Parametro.
    
    /* Pone el registro de log */

    OUTPUT TO VALUE(v-arch_log) APPEND PAGE-SIZE 0.
    PUT UNFORMATTED TODAY " " STRING(TIME,"HH:MM:SS") " " p-mensaje " Parm:" lista_parametros SKIP.
    OUTPUT CLOSE.

END PROCEDURE.

