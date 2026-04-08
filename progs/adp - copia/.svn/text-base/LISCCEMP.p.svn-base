/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_Empleado AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER ficha       AS INTEGER.

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.
DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_Empleado    LIKE Empleado.nro_legajo.
DEFINE VARIABLE que_nombre     LIKE Empleado.nombre.
DEFINE VARIABLE hubo_saldo     AS   LOGICAL INITIAL NO.

DEFINE QUERY qry_movimiento   FOR Cta_cte_emp.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP
       fecha_lis hora_lis AT 70
       SKIP
       que_Empleado  AT 28
       que_nombre
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       SPACE(3)
       Cta_cte_emp.sec_liquidacion
       Cta_cte_emp.tip_comprob
       Cta_cte_emp.nro_comprob
       Cta_cte_emp.fecha_emision
       Cta_cte_emp.debito 
       Cta_cte_emp.credito 
       saldo
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Empleado WHERE ROWID(Empleado) = rid_Empleado.

que_Empleado = Empleado.nro_legajo.
que_nombre =  Empleado.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").
titulo-f = "Movimientos de CC. del empleado".

OUTPUT TO VALUE(DIRE_TMP + "lisccemp.txt") PAGED PAGE-SIZE 72.
RUN LISTAR_HISTORICO.
OUTPUT CLOSE.

RUN PRINFILE.P ( INPUT DIRE_TMP + "lisccemp.txt", INPUT port).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

  CASE ficha:
  WHEN 0 THEN OPEN QUERY qry_movimiento       
                   FOR EACH Cta_cte_emp OF Empleado 
                       WHERE Cta_cte_emp.fecha_emision <= has_fecha
                         AND Cta_cte_emp.estado = 0
                          BY Cta_cte_emp.fecha_emision. 

  WHEN 1 THEN OPEN QUERY qry_movimiento       
                   FOR EACH Cta_cte_emp OF Empleado 
                       WHERE Cta_cte_emp.fecha_emision <= has_fecha
                         AND Cta_cte_emp.estado = 1
                          BY Cta_cte_emp.fecha_emision. 

  WHEN 2 THEN OPEN QUERY qry_movimiento       
                   FOR EACH Cta_cte_emp OF Empleado 
                       WHERE Cta_cte_emp.fecha_emision <= has_fecha
                         AND Cta_cte_emp.estado = 2
                          BY Cta_cte_emp.fecha_emision. 

  WHEN 3 THEN OPEN QUERY qry_movimiento       
                   FOR EACH Cta_cte_emp OF Empleado 
                       WHERE Cta_cte_emp.fecha_emision <= has_fecha
                         AND ( Cta_cte_emp.estado = 0 OR Cta_cte_emp.estado = 1 )
                          BY Cta_cte_emp.fecha_emision. 

  WHEN 4 THEN OPEN QUERY qry_movimiento       
                   FOR EACH Cta_cte_emp OF Empleado 
                       WHERE Cta_cte_emp.fecha_emision <= has_fecha
                          BY Cta_cte_emp.fecha_emision. 
  
  END CASE.                        

END PROCEDURE.


PROCEDURE LISTAR_HISTORICO:

   debitos  = 0.
   creditos = 0.

   RUN ABRE_QUERY.
   GET FIRST qry_movimiento.
   DO WHILE AVAILABLE Cta_cte_emp:

      VIEW FRAME frm-titulo.

      IF Cta_cte_emp.fecha_emision >= des_fecha
      THEN DO:
         IF NOT hubo_saldo
         THEN DO:
            DISPLAY "SI" @ Cta_cte_emp.tip_comprob
                    des_fecha @ Cta_cte_emp.fecha_emision
                    saldo
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
            hubo_saldo = YES.
         END.           
      END.

      IF Cta_cte_emp.estado <> 2
         THEN IF Cta_cte_emp.tip_comprob = "RC"
                 THEN debitos  = debitos  + Cta_cte_emp.debito.
                 ELSE creditos = creditos + Cta_cte_emp.credito.

      saldo = debitos - creditos.
      IF Cta_cte_emp.fecha_emision >= des_fecha
      THEN DO:
         DISPLAY Cta_cte_emp.sec_liquidacion
                 Cta_cte_emp.tip_comprob
                 Cta_cte_emp.nro_comprob
                 Cta_cte_emp.fecha_emision
                 Cta_cte_emp.debito 
                 Cta_cte_emp.credito 
                 saldo
                 WITH FRAME frm-listado.

         DOWN WITH FRAME frm-listado.

      END.

      GET NEXT qry_movimiento.

   END.

END.

{CODIMPRE.I}
 