/*=================================================================================*/
/*                           LISTADO DE DATOS DE LIQUIDACION                       */
/*=================================================================================*/

DEFINE INPUT PARAMETER sel_codigos   AS CHARACTER.
DEFINE INPUT PARAMETER n_liquidacion AS INTEGER.
DEFINE INPUT PARAMETER tit_reporte   AS CHARACTER FORMAT "X(50)".

{VRSHARED.I}
{VPERSINM.I}
{DFVRNEMP.I}

DEFINE VARIABLE hay_novedad AS LOGICAL.

DEFINE VARIABLE titulo1     AS CHARACTER.
DEFINE VARIABLE titulo2     AS CHARACTER.
DEFINE VARIABLE det_titulo  AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE columna    AS DECIMAL EXTENT 8 FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE r-acumval  AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumval  AS DECIMAL EXTENT 32.
DEFINE VARIABLE r-acumdlq  AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumdlq  AS DECIMAL EXTENT 32.
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE conta_empl AS INTEGER.

DEFINE VARIABLE nt_cols    AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(240)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(240)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(240)".
DEFINE VARIABLE str_linea  AS CHARACTER FORMAT "X(192)".

DEFINE TEMP-TABLE Acumulado
   FIELD nro_legajo   LIKE Empleado.nro_legajo
   FIELD cdg_datliq   LIKE Tit_dat_liq.cdg_datliq
   FIELD tot_valor    LIKE Datos_liq.valor
   FIELD nro_columna  AS INTEGER
   INDEX por_empleado IS PRIMARY nro_legajo cdg_datliq ASCENDING.

DEFINE BUFFER B-Acumulado FOR Acumulado.

{WGLISTAR.I}

FORM HEADER
   que_empresa 
   tit_reporte AT 55
   "Página:" AT 124 PAGE-NUMBER FORMAT ">9" AT 131
   SKIP
   fecha_lis
   det_titulo AT 55
   hora_lis AT 124
   SKIP(2)
   header_tt1 SKIP
   header_tt2 SKIP
   header_sry SKIP
   WITH FRAME frm-listado CENTERED TOP-ONLY WIDTH 256.

FORM
   Empleado.nro_legajo
   SPACE(1)
   Empleado.nombre
   SPACE(1)
   Empleado.ult_liquidacion
   str_linea
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

                    /* se arma el titulo */

  header_tt1 = "Legajo Apellido                             Ult.".
  header_tt2 = "Número y Nombre                             Liq.".
  header_sry = "------ ---------------------------------    ----".

  FIND Liquidacion WHERE Liquidacion.sec_liquidacion = n_liquidacion NO-LOCK.
  det_titulo = "Liquidacion:" + STRING(Liquidacion.sec_liquidacion) + " - " + Liquidacion.descripcion.

  nt_cols = NUM-ENTRIES(sel_codigos).
  DO j = 1 TO nt_cols:

     titulo1 = ENTRY(j,sel_codigos).
     FIND Tit_dat_liq WHERE Tit_dat_liq.cdg_datliq = INTEGER(titulo1) NO-LOCK.
     titulo2 = Tit_dat_liq.abrevia.
     
     header_tt1 = header_tt1 + " " + titulo1 + FILL(" ",11 - LENGTH(titulo1)).
     header_tt2 = header_tt2 + " " + titulo2 + FILL(" ",11 - LENGTH(titulo2)).
     header_sry = header_sry + " " + "-----------".

  END.

  OUTPUT TO VALUE(dire_tmp + "lsdatliq.txt") PAGED.

  RUN PONE_CODIGO ( INPUT "HORIZONT,SET17CPI").

  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND Empleado.cdg_estado = "AA"
                          BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND Empleado.cdg_estado = "AA"
                          BY Empleado.nombre.
  END.

  g-acumdlq = 0.
  conta_empl = 0.
  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado WITH FRAME frm-listado:

     hay_novedad = NO.
     columna = 0.

     str_linea = "".
     DO j = 1 TO nt_cols:
            
        FIND Datos_liq OF Empleado 
             WHERE Datos_liq.sec_liquidacion = Liquidacion.sec_liquidacion
               AND Datos_liq.cdg_datliq      = INTEGER(ENTRY(j,sel_codigos))
                   NO-LOCK NO-ERROR.
    
        IF AVAILABLE Datos_liq
        THEN DO:
             g-acumdlq [ j ] = g-acumdlq [ j ] + Datos_liq.valor.
             str_linea = str_linea + STRING(Datos_liq.valor,"ZZZZZZ9.99-") + " ".
        END.
        ELSE DO:
             str_linea = str_linea + "            ".
        END.

     END.   

     DISPLAY Empleado.nro_legajo
             Empleado.nombre
             Empleado.ult_liquidacion
             str_linea
             WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.        

     conta_empl = conta_empl + 1.

     GET NEXT qry_empleados.

  END.

  header_sry = SUBSTRING(header_sry,50). 
  DISPLAY "------" @ Empleado.nro_legajo
          "---------------------------------" @ Empleado.nombre
          " ----" @ Empleado.ult_liquidacion
          header_sry @ str_linea
          WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
    
  str_linea = "".
  DO j = 1 TO nt_cols:
     str_linea = str_linea + STRING(g-acumdlq [ j ],"ZZZZZZ9.99-") + " ".
  END.   
  DISPLAY " " @ Empleado.nro_legajo
          "Totales--->" @ Empleado.nombre
          conta_empl @ Empleado.ult_liquidacion
          str_linea
          WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.

{CODIMPRE.I}
