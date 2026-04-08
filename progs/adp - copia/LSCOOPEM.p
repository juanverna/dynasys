/*------------------------------------------------------------------------------------*/
/*                    Listado Novedades por empleado                                  */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{DFVRNEMP.I}

DEFINE INPUT PARAMETER cero_sino   AS LOGICAL.

DEFINE VARIABLE det_titulo  AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE mrd         AS INTEGER.
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE ver_empleado AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

       
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "Codigos por Empleado" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis
  hora_lis AT 68
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "Legajo   Apellido y Nombre" SKIP
  "         Concepto  Descripcion                                  Nro.Liq." SKIP
  "------------------------------------------------------------------------------"
  WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  SPACE(2)
  Empleado.nombre
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-listado-nov
  SPACE(12)
  Concepto.cdg_concepto
  Concepto.descripcion
  SPACE(12)
  Concepto_empleado.nro_de_liq
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-nov USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE LISTAR:

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  OUTPUT TO VALUE(dire_tmp + "lscoopem.txt") PAGED.

  FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                      AND Empleado.nro_legajo <= has_legajo
                      AND Empleado.cdg_estado = "AA"
                      AND ( CAN-FIND(FIRST Concepto_empleado OF Empleado) OR cero_sino )
                      BY Empleado.nro_legajo:

      VIEW FRAME frm-titulo.
      DISPLAY Empleado.nro_legajo
              Empleado.nombre
              WITH FRAME frm-listado-emp.
      DOWN WITH FRAME frm-listado-emp.        
              
      FOR EACH Concepto_empleado OF Empleado, Concepto OF Concepto_empleado:

          DISPLAY Concepto.cdg_concepto
                  Concepto.descripcion
                  Concepto_empleado.nro_de_liq
                  WITH FRAME frm-listado-nov.
          DOWN WITH FRAME frm-listado-nov.
      END.

      DOWN 1 WITH FRAME frm-listado-nov.

  END.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

{CODIMPRE.I}
