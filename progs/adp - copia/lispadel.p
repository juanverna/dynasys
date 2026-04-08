/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/


DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER ver_pagos   AS INTEGER.

{VRSHARED.I }

DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE con_p          AS   INTEGER INITIAL 1.
DEFINE VARIABLE sin_p          AS   INTEGER INITIAL 2.
DEFINE VARIABLE tot_solicitado LIKE Anticipo_sue.importe_sol.
DEFINE VARIABLE tot_pagado     LIKE Anticipo_sue.importe_pag.
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_Empleado   LIKE Empleado.nro_legajo.
DEFINE VARIABLE que_nombre     LIKE Empleado.nombre.
DEFINE VARIABLE st_ing         AS   INTEGER INITIAL 0.
DEFINE VARIABLE st_apr         AS   INTEGER INITIAL 1.
DEFINE VARIABLE st_all         AS   INTEGER INITIAL 2.

DEFINE QUERY qry_movimiento   FOR Anticipo_sue, Empleado.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Empleado.nro_legajo
       Empleado.nombre FORMAT "X(20)"
       Anticipo_sue.tip_comprob
       Anticipo_sue.nro_comprob FORMAT "ZZZZZ9"
       Anticipo_sue.fecha
       Anticipo_sue.importe_sol
       Anticipo_sue.Importe_pag              
       Anticipo_sue.estado
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(dire_tmp + "lispadel.txt") PAGED.
RUN ABRE_QUERY.
RUN LISTAR.
OUTPUT CLOSE.
RUN PROPRINT.P ( INPUT dire_tmp + "lispadel.txt" ).

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/

PROCEDURE LISTAR:

   GET FIRST qry_movimiento.
   DO WHILE AVAILABLE Anticipo_sue WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       DISPLAY   
           Empleado.nro_legajo
           Empleado.nombre
           Anticipo_sue.tip_comprob
           Anticipo_sue.nro_comprob
           Anticipo_sue.fecha
           Anticipo_sue.importe_sol
           Anticipo_sue.Importe_pag              
           Anticipo_sue.estado
           WITH FRAME frm-listado.

       tot_solicitado = tot_solicitado + Anticipo_sue.importe_sol.
       tot_pagado = tot_pagado + Anticipo_sue.importe_pag.
           
       DOWN WITH FRAME frm-listado.
       GET NEXT qry_movimiento.

   END.

   UNDERLINE 
           Empleado.nro_legajo
           Empleado.nombre
           Anticipo_sue.tip_comprob
           Anticipo_sue.nro_comprob
           Anticipo_sue.fecha
           Anticipo_sue.importe_sol
           Anticipo_sue.Importe_pag
           Anticipo_sue.estado
           WITH FRAME frm-listado.

   DISPLAY tot_solicitado @ Anticipo_sue.importe_sol
           tot_pagado     @ Anticipo_sue.Importe_pag
           WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.
   
END PROCEDURE.      

PROCEDURE ABRE_QUERY:

  CASE ver_pagos:
    WHEN st_ing
    THEN DO:
        titulo-f = "Anticipos solicitados por empleado".
        OPEN QUERY qry_movimiento
             FOR EACH Anticipo_sue
                WHERE Anticipo_sue.estado = 0
                  AND Anticipo_sue.fecha_emision <= has_fecha
                  AND Anticipo_sue.fecha_emision >= des_fecha,
                FIRST Empleado OF Anticipo_sue
                   BY Anticipo_sue.fecha_emision.
    END.
    WHEN st_apr
    THEN DO:
        titulo-f = "Anticipos acordados por empleado".
        OPEN QUERY qry_movimiento
             FOR EACH Anticipo_sue
                WHERE Anticipo_sue.estado = 1
                  AND Anticipo_sue.fecha_emision <= has_fecha
                  AND Anticipo_sue.fecha_emision >= des_fecha,
                FIRST Empleado OF Anticipo_sue
                   BY Anticipo_sue.fecha_emision.

    END.
    WHEN st_all
    THEN DO:
        titulo-f = "Anticipos por empleado".
        OPEN QUERY qry_movimiento
             FOR EACH Anticipo_sue
                WHERE Anticipo_sue.estado <= 1
                  AND Anticipo_sue.fecha_emision <= has_fecha
                  AND Anticipo_sue.fecha_emision >= des_fecha,
                FIRST Empleado OF Anticipo_sue
                   BY Anticipo_sue.fecha_emision.
    END.
  END CASE.

END PROCEDURE.

{CODIMPRE.I}
