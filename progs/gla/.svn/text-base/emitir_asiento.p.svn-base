/*=================================================================================*/
/*    EMITE UN ASIENTO CONTABLE: ACUMULA LOS DEBITOS, CREDITOS Y SALDOS POR DIA    */
/*=================================================================================*/

/*=================================================================================*/
/*                          TABLAS TEMPORALES                                      */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Asn_header  LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales LIKE Asn_totales.

/*=================================================================================*/
/*                               PARAMETROS                                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Asn_header.
DEFINE INPUT PARAMETER TABLE FOR T-Asn_detalle.
DEFINE INPUT PARAMETER TABLE FOR T-Asn_totales.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

DEFINE VARIABLE v-ant_debitos   AS DECIMAL.
DEFINE VARIABLE v-ant_creditos  AS DECIMAL.
DEFINE VARIABLE v-ant_saldo     AS DECIMAL.
DEFINE VARIABLE v-des_fecha     AS DATE.
DEFINE VARIABLE v-has_fecha     AS DATE.
DEFINE VARIABLE v-voy_fecha     AS DATE.
DEFINE VARIABLE v-debug         AS LOGICAL INITIAL NO.

DEFINE BUFFER Nuevo FOR Saldos_x_cuenta.

DEFINE STREAM Logmov.

IF v-debug THEN OUTPUT STREAM Logmov TO "c:\sic-temp\emitir.txt" APPEND. 

/*=================================================================================*/
/*                            BLOQUE PRINCIPAL                                     */
/*=================================================================================*/

FIND FIRST T-Asn_header.

FIND Parametro WHERE Parametro.cdg_parametro = "PROXNASN" 
                AND Parametro.cdg_empresa   = T-Asn_header.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Parametro
THEN DO:
    CREATE Parametro.
    ASSIGN Parametro.cdg_empresa   = T-Asn_header.cdg_empresa
           Parametro.cdg_parametro = "PROXNASN"
           Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
           Parametro.observacion   = ""
           Parametro.tipo          = "N"
           Parametro.valor_n       = 1.
END.         

CREATE Asn_header.
BUFFER-COPY T-Asn_header TO Asn_header
   ASSIGN  Asn_header.nro_asiento    = NEXT-VALUE(proximo_asiento) 
           Asn_header.nro_idcabecera = Asn_header.nro_asiento
           Asn_header.tip_comprob    = "AS"
           Asn_header.nro_comprob    = Parametro.valor_n
           Asn_header.posteo         = "0".
           

FOR EACH T-Asn_detalle:
   CREATE Asn_detalle.
   BUFFER-COPY T-Asn_detalle TO Asn_detalle
       ASSIGN  Asn_detalle.nro_asiento = Asn_header.nro_asiento.
   DELETE T-Asn_detalle.
END.

FOR EACH T-Asn_totales:
   CREATE Asn_totales.
   BUFFER-COPY T-Asn_totales TO Asn_totales
       ASSIGN  Asn_totales.nro_asiento = Asn_header.nro_asiento.
   DELETE T-Asn_totales.
END.

Parametro.valor_n = Parametro.valor_n + 1.

{crearauditoria.i}

RELEASE Parametro.

/*--------------------------------------------------------------------------------------*/

IF v-debug THEN PUT STREAM Logmov "Asiento:" Asn_header.nro_comprob SKIP.
IF v-debug THEN PUT STREAM Logmov FILL("-",114) FORMAT "X(114)" SKIP.

FOR EACH Asn_detalle OF Asn_header:

    Asn_detalle.posteo = Asn_header.posteo.

    FIND Saldos_x_cuenta 
         WHERE Saldos_x_cuenta.cdg_empresa  = Asn_header.cdg_empresa
           AND Saldos_x_cuenta.nro_cuenta   = Asn_detalle.nro_cuenta
           AND Saldos_x_cuenta.nro_entidad  = Asn_detalle.nro_entidad
           AND Saldos_x_cuenta.nro_obra     = Asn_detalle.nro_obra
           AND Saldos_x_cuenta.nro_moneda   = Asn_detalle.nro_moneda
           AND Saldos_x_cuenta.reexpresion  = Asn_detalle.reexpresion
           AND Saldos_x_cuenta.fch_saldo    = Asn_detalle.fecha_mayor
               NO-ERROR.
    
    IF v-debug THEN PUT  STREAM Logmov 
         "Acumular:" 
         " E:" Asn_header.cdg_empresa FORMAT "X(3)"
         " Cta:" Asn_detalle.nro_cuenta
         " Ent:" Asn_detalle.nro_entidad
         " Obra:" Asn_detalle.nro_obra
         " $:" Asn_detalle.nro_moneda
         " Ex: " Asn_detalle.reexpresion
         " F:" Asn_detalle.fecha_mayor 
         " AV: " AVAILABLE Saldos_x_cuenta 
         SKIP.

            /* ------------------------------------------------------ */
            /* Si no encuentra el acumulador debe buscar el último    */
            /* anterior y generar todos desde allí en adelante. Si no */
            /* existe el primero, es porque se trata del primer mo-   */
            /* vimiento con lo que solo generamos el del día con los  */
            /* valores acumulados anteriores iguales a CERO           */ 
            /* ------------------------------------------------------ */

    IF NOT AVAILABLE Saldos_x_cuenta           
    THEN DO:

         FIND LAST Saldos_x_cuenta 
              WHERE Saldos_x_cuenta.cdg_empresa  = Asn_header.cdg_empresa
                AND Saldos_x_cuenta.nro_cuenta   = Asn_detalle.nro_cuenta
                AND Saldos_x_cuenta.nro_entidad  = Asn_detalle.nro_entidad
                AND Saldos_x_cuenta.nro_obra     = Asn_detalle.nro_obra
                AND Saldos_x_cuenta.nro_moneda   = Asn_detalle.nro_moneda
                AND Saldos_x_cuenta.reexpresion  = Asn_detalle.reexpresion
                AND Saldos_x_cuenta.fch_saldo    < Asn_detalle.fecha_mayor
                    NO-ERROR.

         IF v-debug THEN PUT  STREAM Logmov 
              "Ultimo  :" 
              " E:" Asn_header.cdg_empresa FORMAT "X(3)"
              " Cta:" Asn_detalle.nro_cuenta
              " Ent:" Asn_detalle.nro_entidad
              " Obra:" Asn_detalle.nro_obra
              " $:" Asn_detalle.nro_moneda
              " Ex: " Asn_detalle.reexpresion
              " F:" Asn_detalle.fecha_mayor 
              " AV: " AVAILABLE Saldos_x_cuenta 
              SKIP.

         IF AVAILABLE Saldos_x_cuenta
         THEN DO:
              ASSIGN
                    v-des_fecha    = Saldos_x_cuenta.fch_saldo + 1
                    v-has_fecha    = Asn_detalle.fecha_mayor
                    v-ant_debitos  = Saldos_x_cuenta.tot_debitos
                    v-ant_creditos = Saldos_x_cuenta.tot_creditos
                    v-ant_saldo    = Saldos_x_cuenta.saldo_total.
         END.
         ELSE DO:
              ASSIGN
                    v-des_fecha    = Asn_detalle.fecha_mayor
                    v-has_fecha    = Asn_detalle.fecha_mayor
                    v-ant_debitos  = 0
                    v-ant_creditos = 0
                    v-ant_saldo    = 0.
         END.          
              
         IF v-debug THEN PUT  STREAM Logmov 
              "Adelante:" 
              " E:" Asn_header.cdg_empresa FORMAT "X(3)"
              " Cta:" Asn_detalle.nro_cuenta
              " Ent:" Asn_detalle.nro_entidad
              " Obra:" Asn_detalle.nro_obra
              " $:" Asn_detalle.nro_moneda
              " Ex: " Asn_detalle.reexpresion
              " F:" Asn_detalle.fecha_mayor 
              "  S: ".
         IF AVAILABLE Saldos_x_cuenta 
            THEN IF v-debug THEN PUT  STREAM Logmov Saldos_x_cuenta.fch_saldo. 
            ELSE IF v-debug THEN PUT  STREAM Logmov "        ".

               /* Este CREATE debería estar dentro de un DO voy_fecha... si se quiere tener
                  un acumulado por día, aunque no se tengan movimientos                      */

         CREATE Saldos_x_cuenta.
         ASSIGN Saldos_x_cuenta.cdg_empresa  = Asn_header.cdg_empresa
                Saldos_x_cuenta.nro_cuenta   = Asn_detalle.nro_cuenta
                Saldos_x_cuenta.nro_entidad  = Asn_detalle.nro_entidad
                Saldos_x_cuenta.nro_obra     = Asn_detalle.nro_obra
                Saldos_x_cuenta.nro_moneda   = Asn_detalle.nro_moneda
                Saldos_x_cuenta.reexpresion  = Asn_detalle.reexpresion
                Saldos_x_cuenta.fch_saldo    = Asn_detalle.fecha_mayor
                   
                Saldos_x_cuenta.tot_debitos  = v-ant_debitos
                Saldos_x_cuenta.tot_creditos = v-ant_creditos
                Saldos_x_cuenta.saldo_total  = v-ant_saldo.
          
        IF v-debug THEN PUT  STREAM Logmov SKIP.

    END.
    
    Saldos_x_cuenta.tot_debitos  = Saldos_x_cuenta.tot_debitos  + Asn_detalle.debito.
    Saldos_x_cuenta.tot_creditos = Saldos_x_cuenta.tot_creditos + Asn_detalle.credito.
    Saldos_x_cuenta.saldo_total = Saldos_x_cuenta.saldo_total + Asn_detalle.debito - Asn_detalle.credito.

    FOR EACH Saldos_x_cuenta 
         WHERE Saldos_x_cuenta.cdg_empresa  = Asn_header.cdg_empresa
           AND Saldos_x_cuenta.nro_cuenta   = Asn_detalle.nro_cuenta
           AND Saldos_x_cuenta.nro_entidad  = Asn_detalle.nro_entidad
           AND Saldos_x_cuenta.nro_obra     = Asn_detalle.nro_obra
           AND Saldos_x_cuenta.nro_moneda   = Asn_detalle.nro_moneda
           AND Saldos_x_cuenta.reexpresion  = Asn_detalle.reexpresion
           AND Saldos_x_cuenta.fch_saldo    > Asn_detalle.fecha_mayor:
    
        Saldos_x_cuenta.tot_debitos  = Saldos_x_cuenta.tot_debitos  + Asn_detalle.debito.
        Saldos_x_cuenta.tot_creditos = Saldos_x_cuenta.tot_creditos + Asn_detalle.credito.
        Saldos_x_cuenta.saldo_total = Saldos_x_cuenta.saldo_total + Asn_detalle.debito - Asn_detalle.credito.

    END.

END.   

IF v-debug THEN PUT  STREAM Logmov FILL("=",114) FORMAT "X(114)" SKIP.

IF v-debug THEN OUTPUT STREAM Logmov CLOSE.
