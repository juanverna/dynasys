/*===========================================================================*/
/*              CONSISTENCIA DE CUENTA CORRIENTE DE CLIENTES                 */
/*===========================================================================*/

DEFINE INPUT PARAMETER des_cliente LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_cliente LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha   LIKE Cta_cte.fecha_emision COLUMN-LABEL "Desde!Fecha".
DEFINE INPUT PARAMETER has_fecha   LIKE Cta_cte.fecha_emision COLUMN-LABEL "Desde!Fecha".

/*===========================================================================*/
/*                             VARIABLES Y FRAMES                            */
/*===========================================================================*/

DEFINE VARIABLE v-moneda AS CHARACTER FORMAT "X(5)" COLUMN-LABEL "Código!Moneda".
DEFINE VARIABLE n-mens  AS INTEGER FORMAT "9" COLUMN-LABEL "Num!Err".
DEFINE VARIABLE mensaje AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE errores AS CHARACTER EXTENT 5 FORMAT "X(40)"
    INITIAL [ "Clausula dolar y cambio en 1",
              "No es Clausula dolar y cambio <> 1",
              "Clausula dolar no permitida en dólares",
              "Moneda Extranjera y cambio en 1",
              "Valor de cambio sospechoso"
            ].

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       "Consistencia de Cuenta Corriente" AT 37
       "Página:" AT 90 PAGE-NUMBER FORMAT ">9" AT 97 
       SKIP
       fecha_lis 
       "Periodo:" AT 37  
       des_fecha " al " has_fecha 
       hora_lis AT 90
       SKIP(1)
       WITH WIDTH 300 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
    Cta_cte.tip_comprob 
    Cta_cte.prf_comprob 
    Cta_cte.nro_comprob 
    Cta_cte.fecha_emision 
    Cta_cte.cambio 
    v-moneda
    Cliente.cdg_cliente
    Cliente.clausula_dolar COLUMN-LABEL "Clau-!sula"
    mensaje COLUMN-LABEL "Mensaje!Error"
    WITH WIDTH 300 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*===========================================================================*/
/*                                 PROCESO                                   */
/*===========================================================================*/

{dirprinfile.i}

FOR EACH Cta_cte 
    WHERE Cta_cte.fecha_emision <= has_fecha 
      AND Cta_cte.fecha_emision >= des_fecha NO-LOCK,
          FIRST Cliente OF Cta_cte 
                WHERE Cliente.cdg_cliente <= has_cliente
                  AND Cliente.cdg_cliente >= des_cliente NO-LOCK,
                FIRST Moneda OF Cta_cte NO-LOCK:

    VIEW FRAME frm-titulo.

    n-mens = 0.

    v-moneda = Moneda.cdg_moneda.
    IF Cta_cte.clausula_dolar 
        THEN v-moneda = v-moneda + "+CL".

    IF Moneda.es_local 
    THEN DO:
        IF Cta_cte.clausula_dolar 
        THEN DO:
            IF Cta_cte.cambio = 1
            THEN DO:
                n-mens = 1.
            END.
            ELSE DO:
                IF Cta_cte.cambio > 3.2 OR Cta_cte.cambio < 2.6
                THEN DO:
                    n-mens = 5.
                END.
            END.
        END.
        ELSE DO:
            IF Cta_cte.cambio <> 1
            THEN DO:
                n-mens = 2.
            END.
        END.
    END.
    ELSE DO:
        IF Cta_cte.clausula_dolar 
        THEN DO:
            n-mens = 3.
        END.
        ELSE DO:
            IF Cta_cte.cambio = 1
            THEN DO:
                n-mens = 4.
            END.
            ELSE DO:
                IF Cta_cte.cambio > 3.2 OR Cta_cte.cambio < 2.6
                THEN DO:
                    n-mens = 5.
                END.
            END.
        END.
    END.

    IF n-mens <> 0 
        THEN RUN mostrar.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

/*===========================================================================*/
/*                                 PROCEDIMIENTOS                            */
/*===========================================================================*/

PROCEDURE mostrar:
    
    mensaje = errores [ n-mens ].

    DISPLAY Cta_cte.tip_comprob 
            Cta_cte.prf_comprob 
            Cta_cte.nro_comprob 
            Cta_cte.fecha_emision 
            Cta_cte.cambio 
            v-moneda
            Cliente.cdg_cliente
            Cliente.clausula_dolar COLUMN-LABEL "Clau-!sula"
            mensaje 
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.

END PROCEDURE.
