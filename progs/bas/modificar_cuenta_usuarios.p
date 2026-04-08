/*===============================================================================================================================*/
/*       MODIFICA EN MAS O MENOS LA CUENTA DE USUARIOS UTILIZANDO EL SISTEMA SEGÚN EL PARÁMETRO DE OPERACIÓN SEA "+" O "-"       */
/*===============================================================================================================================*/  

DEFINE INPUT  PARAMETER p-cdg_sigla-sic LIKE Modulo-SIC.cdg_sigla-sic.
DEFINE INPUT  PARAMETER p-operacion     AS CHARACTER.
DEFINE OUTPUT PARAMETER p-ok            AS LOGICAL.

/*===============================================================================================================================*/
/*                                                  VARIABLES                                                                    */
/*===============================================================================================================================*/  

DEFINE VARIABLE v-pc_name AS CHARACTER.
DEFINE VARIABLE v-cdg_usuario AS CHARACTER.

DEFINE BUFFER B-Modulo-sic FOR Modulo-sic.

/*===============================================================================================================================*/
/*                                                  PROCESO                                                                      */
/*===============================================================================================================================*/  

FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
v-cdg_usuario = Usuario.cdg_usuario.
RUN pcname1.p ( OUTPUT v-pc_name ).

FIND Modulo-sic WHERE Modulo-sic.cdg_sigla-sic = p-cdg_sigla-sic NO-LOCK.
IF p-operacion = "+"
THEN DO:
    
    IF Modulo-sic.cdg_sigla-sic = "BAS" /* es el logging inicial */
    THEN DO:
        
        IF LOOKUP(v-cdg_usuario,Modulo-sic.usuarios_conectados) = 0 /* no está conectado el usuario */
        THEN DO:
             RUN agregar_usuario  ( INPUT v-cdg_usuario, OUTPUT p-ok ). /* Intenta agregar el usuario. La rutina chequea la cantidad de usuarios conectados */
             IF p-ok AND LOOKUP(v-pc_name,Modulo-sic.estaciones_conectadas) = 0 
                 THEN RUN agregar_estacion ( INPUT v-pc_name ).
        END.
        ELSE DO: /* Ya estaba conectada. es porque tenia una sesion que termino anormalmente */
                 /* Se quita la estacion de los otros modulos que pudiera estar utilizando   */
            FOR EACH B-Modulo-sic WHERE B-Modulo-sic.cdg_sigla-sic <> Modulo-sic.cdg_sigla-sic EXCLUSIVE-LOCK:
                RUN quitar_entrada.p ( INPUT v-cdg_usuario, INPUT-OUTPUT B-Modulo-sic.usuarios_conectados, INPUT ",").
                B-Modulo-sic.usuarios_actuales = NUM-ENTRIES(B-Modulo-sic.usuarios_conectados,",").
            END.
            p-ok = YES. 
        END.
    END.
    ELSE DO:
        RUN agregar_usuario  ( INPUT v-cdg_usuario, OUTPUT p-ok ). /* Intenta agregar el usuario. La rutina chequea la cantidad de usuarios conectados */
        IF p-ok AND LOOKUP(v-pc_name,Modulo-sic.estaciones_conectadas) = 0 
            THEN RUN agregar_estacion ( INPUT v-pc_name ).
    END.

END.
ELSE DO TRANSACTION:
    RUN quitar_usuario  ( INPUT v-cdg_usuario).
    RUN quitar_estacion ( INPUT v-pc_name ).
    p-ok = YES.
END.

/*===============================================================================================================================*/
/*                                              PROCEDIMIENTOS INTERNOS                                                          */
/*===============================================================================================================================*/  

PROCEDURE agregar_estacion:

    DEFINE INPUT PARAMETER p-pc_name LIKE v-pc_name.    

    FIND CURRENT Modulo-sic EXCLUSIVE-LOCK.
    RUN agregar_entrada.p ( INPUT p-pc_name, INPUT-OUTPUT Modulo-sic.estaciones_conectadas, INPUT ",").
    FIND CURRENT Modulo-sic NO-LOCK.

END PROCEDURE.

PROCEDURE quitar_estacion:

    DEFINE INPUT PARAMETER p-pc_name LIKE v-pc_name.    

    FIND CURRENT Modulo-sic EXCLUSIVE-LOCK.
    RUN quitar_entrada.p ( INPUT p-pc_name, INPUT-OUTPUT Modulo-sic.estaciones_conectadas, INPUT ",").
    FIND CURRENT Modulo-sic NO-LOCK.

END PROCEDURE.

PROCEDURE agregar_usuario:

    DEFINE INPUT PARAMETER p-cdg_usuario LIKE v-cdg_usuario.
    DEFINE OUTPUT PARAMETER p-xok AS LOGICAL.

    IF Modulo-sic.usuarios_actuales < Modulo-sic.usuarios_maximo
    THEN DO TRANSACTION:
        FIND CURRENT Modulo-sic EXCLUSIVE-LOCK.
        RUN agregar_entrada.p ( INPUT p-cdg_usuario, INPUT-OUTPUT Modulo-sic.usuarios_conectados, INPUT ",").
        Modulo-sic.usuarios_actuales = NUM-ENTRIES(Modulo-sic.usuarios_conectados,",").
        FIND CURRENT Modulo-sic NO-LOCK.
        p-xok = YES.
    END.
    ELSE DO:
        MESSAGE "SE ALCANZO EL LIMITE DE USUARIOS" VIEW-AS ALERT-BOX ERROR TITLE "DEMASIADOS USUARIOS".
        p-xok = NO.
    END.

END PROCEDURE.

PROCEDURE quitar_usuario:

    DEFINE INPUT PARAMETER p-cdg_usuario LIKE v-cdg_usuario.

    FIND CURRENT Modulo-sic EXCLUSIVE-LOCK.
    RUN quitar_entrada.p ( INPUT p-cdg_usuario, INPUT-OUTPUT Modulo-sic.usuarios_conectados, INPUT ",").
    Modulo-sic.usuarios_actuales = NUM-ENTRIES(Modulo-sic.usuarios_conectados,",").
    FIND CURRENT Modulo-sic NO-LOCK.

END PROCEDURE.



