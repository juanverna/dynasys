/*====================================================================================*/
/*               LISTADO DE NOVEDADES DE UN DETERMINADO EMPLEADO                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER p-nro_legajo LIKE Empleado.nro_legajo.
DEFINE INPUT PARAMETER p-des_fecha  AS DATE.
DEFINE INPUT PARAMETER p-has_fecha  AS DATE.

/*====================================================================================*/
/*                                VARIABLES Y FRAMES                                  */
/*====================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE titulo_det AS CHARACTER FORMAT "X(45)".

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Ficha de Novedades por Empleado" AT 40
  "Pagina:" AT 101 PAGE-NUMBER FORMAT ">>9" AT 109
  SKIP
  fecha_lis
  titulo_det AT 40 
  hora_lis AT 101
  SKIP
  p-des_fecha AT 40
  " - " p-has_fecha
  SKIP(1)
  WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO NO-LABELS.

DEFINE FRAME frm-listado
  Parte_novedades.fecha   COLUMN-LABEL "Fecha!Novedad"
  Novedad.cdg_novedad     COLUMN-LABEL "Código!Novedad"
  Novedad.descripcion     COLUMN-LABEL "Descripción!Novedad"
  Parte_novedades.valor   COLUMN-LABEL "Valor!Novedad"
  Novedad.unidad          COLUMN-LABEL "Unidad!Medida"
  Destino.cdg_destino     COLUMN-LABEL "Código!Destino"
  Destino.nombre          COLUMN-LABEL "Descripción!Destino"
  WITH WIDTH 180 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                            P R O C E D I M I E N T O S                          */
/*=================================================================================*/

PROCEDURE listar:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  FIND Empleado WHERE Empleado.nro_legajo = p-nro_legajo NO-LOCK.
  titulo_det = STRING(Empleado.nro_legajo,"999999") + "-" + Empleado.nombre. 

  FOR EACH Parte_novedades OF Empleado NO-LOCK
      WHERE Parte_novedades.fecha >= p-des_fecha
        AND Parte_novedades.fecha <= p-has_fecha, 
      FIRST Novedad OF Parte_novedades NO-LOCK, 
      FIRST Destino OF Parte_novedades NO-LOCK
      BREAK BY Parte_novedades.fecha:

      VIEW FRAME frm-titulo.

      DISPLAY Parte_novedades.fecha WHEN FIRST-OF(Parte_novedades.fecha)
              Novedad.cdg_novedad
              Novedad.descripcion
              Parte_novedades.valor
              Novedad.unidad
              Destino.cdg_destino  
              Destino.nombre
              WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.

  END.

  UNDERLINE
          Parte_novedades.fecha
          Novedad.cdg_novedad
          Novedad.descripcion
          Parte_novedades.valor
          Novedad.unidad
          Destino.cdg_destino  
          Destino.nombre
          WITH FRAME frm-listado.


  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.  
