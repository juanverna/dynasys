/*============================================================================================*/
/*                                    EJECUTA DYNASYS                                         */
/*============================================================================================*/

/*--------------------------------------------------------------------------------------------*/
/*                                       VARIABLES                                            */
/*--------------------------------------------------------------------------------------------*/

DEFINE VARIABLE hubo_logon      AS LOGICAL.
DEFINE VARIABLE usuarios_ok     AS LOGICAL.
DEFINE VARIABLE v-entidad-logon AS LOGICAL.

DEFINE VARIABLE v-big-icono     AS CHARACTER.
DEFINE VARIABLE v-small-icono   AS CHARACTER.

{parlocales.i}
{nrorelea.i}

/*--------------------------------------------------------------------------------------------*/
/*                             ESTABLECE PARAMETROS DE SESION                                 */
/*--------------------------------------------------------------------------------------------*/

SESSION:TIME-SOURCE = "SIC".
SESSION:DATA-ENTRY-RETURN = YES.
SESSION:NUMERIC-FORMAT = "AMERICAN".
SESSION:IMMEDIATE-DISPLAY = YES.
SESSION:DATE-FORMAT = "dmy".

/*--------------------------------------------------------------------------------------------*/
/*                   VERIFICA EL LOGIN Y FIJA ICONOS Y TITULOS DE SESSION                     */
/*--------------------------------------------------------------------------------------------*/

RUN c-logon.w ( OUTPUT hubo_logon, OUTPUT v-entidad-logon).
IF hubo_logon 
THEN DO:
    RUN modificar_cuenta_usuarios.p ( INPUT "BAS", INPUT "+", OUTPUT usuarios_ok ).
    IF usuarios_ok
    THEN DO:

        RUN getparametro.p (  INPUT  "ICONOBIG",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).

        SESSION:LOAD-ICON(v-valor_c).
/*
        IF SEARCH("seticonotarea.p") <> ?
           OR SEARCH("seticonotarea.r") <> ?
        THEN DO:

            RUN getparametro.p (  INPUT  "ICONOSML",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).

            RUN seticonotarea.p ( INPUT "Sistemas Dinamicos - Dynasys " + NRO_RELEASE + "User:" + USERID("SIC"),
                                  INPUT v-valor_c).

        END.
        
        IF SEARCH("setsyscolors.p") <> ?
           OR SEARCH("setsyscolors.r") <> ?
        THEN DO:

            RUN getparametro.p (  INPUT  "SYSCOLOR",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).
    
            IF v-valor_c <> ?
                THEN RUN setsyscolors.p (INTEGER(ENTRY(1,v-valor_c,",")),INTEGER(ENTRY(2,v-valor_c,",")),INTEGER(ENTRY(3,v-valor_c,","))). 
             /* ELSE RUN setsyscolors.p (192,192,192). /* Default de Windows */ */
   
        END.
*/        
        RUN w-sic.w.
        RUN modificar_cuenta_usuarios.p ( INPUT "BAS", INPUT "-", OUTPUT usuarios_ok ).
    END.
END.

/*--------------------------------------------------------------------------------------------*/
/*                            TERMINA LA SESION DE PROGRESS                                   */
/*--------------------------------------------------------------------------------------------*/

QUIT.
