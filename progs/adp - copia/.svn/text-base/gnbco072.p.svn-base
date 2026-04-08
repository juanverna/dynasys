/*=======================================================================================*/
/*    ARMA LA INTERFACE DE SALIDA PARA ACREDITACION DE HABERES EN BANCO RIO              */
/*=======================================================================================*/

DEFINE INPUT PARAMETER des_liquid LIKE Liquidacion.sec_liquidacion.
DEFINE INPUT PARAMETER has_liquid LIKE Liquidacion.sec_liquidacion.
DEFINE INPUT PARAMETER fecha_pago AS DATE.

      /* Variables para el registro de header y control  */

DEFINE VARIABLE h-idreg         AS CHARACTER.
DEFINE VARIABLE h-nrosuc        AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-nroemp        AS CHARACTER.
DEFINE VARIABLE h-namemp        AS CHARACTER.
DEFINE VARIABLE h-nrosuc-deb    AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-tipcta-deb    AS CHARACTER.
DEFINE VARIABLE h-nrocta-deb    AS CHARACTER.
DEFINE VARIABLE h-fecacred      AS CHARACTER.
DEFINE VARIABLE h-total_a_pagar AS CHARACTER.
DEFINE VARIABLE h-cant_movim    AS CHARACTER.
DEFINE VARIABLE h-nrosuc-adm    AS CHARACTER INITIAL "086".
DEFINE VARIABLE h-obligat       AS CHARACTER INITIAL "9".
DEFINE VARIABLE h-filler1       AS CHARACTER.

      /* Variables para el registro de movimientos */

DEFINE VARIABLE m-idreg         AS CHARACTER.
DEFINE VARIABLE m-nrosuc        AS CHARACTER INITIAL "086".
DEFINE VARIABLE m-nroemp        AS CHARACTER.
DEFINE VARIABLE m-filler1       AS CHARACTER.
DEFINE VARIABLE m-nrocta        AS CHARACTER.
DEFINE VARIABLE m-filler2       AS CHARACTER.
DEFINE VARIABLE m-importe       AS CHARACTER.
DEFINE VARIABLE m-filler3       AS CHARACTER.

            /* Variables para el proceso */

DEFINE VARIABLE cant_empleados  AS INTEGER.
DEFINE VARIABLE total_a_pagar   AS DECIMAL.
DEFINE VARIABLE total_empleado  AS DECIMAL.

DEFINE TEMP-TABLE Salida
  FIELD s-idreg  AS INTEGER
  FIELD s-regis  AS CHARACTER.
  
/*=======================================================================================*/
/*        ARMA LA INTERFACE DE SALIDA PARA ACREDITACION DE HABERES EN BANCO RIO          */
/*=======================================================================================*/

FOR EACH Empleado 
    WHERE Empleado.cdg_estado = "AA" 
      AND Empleado.cdg_forma  = "A" 
      AND Empleado.cdg_banco  = 072 NO-LOCK:   
      
    total_empleado = 0.
    FOR EACH Rcb_header OF Empleado 
        WHERE Rcb_header.sec_liquidacion <= has_liquid 
          AND Rcb_header.sec_liquidacion <= has_liquid 
              NO-LOCK:
              
        total_empleado = total_empleado + Rcb_header.a_pagar.
    
    END.
    IF total_empleado <> 0
    THEN DO:
         cant_empleados  = cant_empleados + 1.
         total_a_pagar   = total_a_pagar + total_empleado.
         RUN CREA_REGISTRO_MOVIMIENTO.
    END.
    
END. /* Fin de los empleados */    

OUTPUT TO "BANCORIO".

RUN CREAR_REGISTRO_CONTROL.
FIND FIRST Salida WHERE Salida.s-idreg = 1.
PUT Salida.s-idreg Salida.s-regis SKIP.
FOR EACH Salida WHERE Salida.s-idreg = 2:
    PUT Salida.s-idreg Salida.s-regis SKIP.
END.

OUTPUT CLOSE.

/*=======================================================================================*/
/*                                   PROCEDIMIENTOS                                      */
/*=======================================================================================*/

PROCEDURE CREAR_REGISTRO_CONTROL:

   ASSIGN h-idreg         = "0"
          h-nrosuc        = "000"
          h-nroemp        = "8702"
          h-namemp        = SUBSTRING(Empresa.nombre,1,30)
          h-nrosuc-deb    = "086"
          h-tipcta-deb    = "1"
          h-nrocta-deb    = "0012663"
          h-fecacred      = STRING(fecha_pago,"999999")
          h-cant_movim    = STRING(cant_empleados,"9999")
          h-nrosuc-adm    = "086"
          h-obligat       = "9"
          h-filler1       = FILL(" ",48).

   h-total_a_pagar = STRING(total_a_pagar,"999999999999999.99").
   h-total_a_pagar = ENTRY(1,h-total_a_pagar,".") + ENTRY(2,h-total_a_pagar,".").   

   CREATE Salida.
   ASSIGN Salida.s-idreg = 1
          Salida.s-regis = h-idreg         +
                           h-nrosuc        +
                           h-nroemp        +
                           h-namemp        +
                           h-nrosuc-deb    +
                           h-tipcta-deb    +
                           h-nrocta-deb    +
                           h-fecacred      +
                           h-total_a_pagar +
                           h-cant_movim    +
                           h-nrosuc-adm    +
                           h-obligat       +
                           h-filler1       .
          

END PROCEDURE.

PROCEDURE CREAR_REGISTRO_MOVMIENTO:

   ASSIGN m-idreg         = IF SUBSTRING(Empleado.cuenta_nro,1,1) = "1" THEN "7" ELSE "6"
          m-nrosuc        = SUBSTRING(Empleado.cuenta_nro,2,3)
          m-nroemp        = "8702"
          m-filler1       = FILL(" ",2)
          m-nrocta        = SUBSTRING(Empleado.cuenta_nro,5,7)
          m-filler2       = FILL(" ",4)
          m-filler3       = FILL(" ",94).

   m-importe = STRING(total_empleado,"99999999999.99").
   m-importe = ENTRY(1,m-importe,".") + ENTRY(2,m-importe,".").   

   CREATE Salida.
   ASSIGN Salida.s-idreg = 2
          Salida.s-regis = m-idreg         +
                           m-nrosuc        +
                           m-nroemp        +
                           m-filler1       +
                           m-nrocta        +
                           m-filler2       +
                           m-importe       +
                           m-filler3       .

END PROCEDURE.
