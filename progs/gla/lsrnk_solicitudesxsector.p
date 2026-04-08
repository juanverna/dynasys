/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULOS                                  */
/*                  Ranking de Articulos por Solicitud de Retiro                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_sector AS CHARACTER.
DEFINE INPUT PARAMETER has_sector AS CHARACTER.
DEFINE INPUT PARAMETER p-estado   AS CHARACTER.
DEFINE INPUT PARAMETER des_fecha  AS DATE.
DEFINE INPUT PARAMETER has_fecha  AS DATE.

DEFINE TEMP-TABLE Rnk_sector
   FIELD nro_area        LIKE Area.nro_area
   FIELD cantidad            AS INTEGER FORMAT ">>>>9"
   INDEX por_sector          IS PRIMARY nro_area ASCENDING
   INDEX por_cantidad cantidad DESCENDING.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE v-prf_comprob AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE v-nro_comprob AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-dsc_estado  AS CHARACTER FORMAT "X(20)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

/* DEFINE BUFFER B-Empleado FOR Empleado.  */

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Ranking de Sectores con Detalle de Solicitudes" AT 40
    "Página:" AT 117 PAGE-NUMBER FORMAT "99999" AT 124
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 117
    "del Sector" AT 40
    des_sector
    "al"
    has_sector
    "con estados" AT 40
    p-estado FORMAT "X(30)"
  SKIP(1)

  "--------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Descripción                      Cant Tot                                                                            " SKIP
  "Sector     Sector                        Solicitudes                                                                            " SKIP
  "                                                                                                                                " SKIP
  "           Código Descripción             Nro Tipo        Prf      Nro Fecha    Fecha    Motivo                              Con" SKIP
  "           Estado Estado            Solicitud Comprob Comprob  Comprob Ingreso  Retiro   Retiro                              Reg" SKIP
  "--------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 185 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-des
    Area.cdg_area
    SPACE(3)
    Area.denominacion
    Rnk_sector.cantidad
  WITH WIDTH 185 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado
    SPACE(11)
    Sre_header.cdg_estado
    SPACE(5)
    v-dsc_estado
    Sre_header.nro_solicitud
    v-tip_comprob
    SPACE(9)
    v-prf_comprob
    v-nro_comprob           
    Sre_header.fecha_ingreso  
    Sre_header.fecha_retiro
    Motivo_retiro.dsc_motivo_retiro
    Sre_header.con_regreso
  WITH WIDTH 185 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
{findsector.i}

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  FOR EACH Sre_header 
        WHERE Sre_header.cdg_empresa = Empresa.cdg_empresa
          AND Sre_header.fecha_ingreso <= has_fecha
          AND Sre_header.fecha_ingreso >= des_fecha
          AND CAN-DO(p-estado, Sre_header.cdg_estado),
          FIRST Area OF Sre_header WHERE Area.cdg_area <= has_sector
                                     AND Area.cdg_area >= des_sector NO-LOCK:

                  FIND FIRST Rnk_sector WHERE Rnk_sector.nro_area = Sre_header.nro_area NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE Rnk_sector THEN DO:
                      CREATE Rnk_sector.
                      ASSIGN 
                          Rnk_sector.nro_area = Sre_header.nro_area.

                  END.

                  ASSIGN
                      Rnk_sector.cantidad = Rnk_sector.cantidad + 1.

  END.

  FOR EACH Rnk_sector,
        FIRST Area OF Rnk_sector
        BREAK BY Rnk_sector.cantidad DESCENDING
              BY Area.cdg_area:

            VIEW FRAME frm-titulo.
    
            DISPLAY
                 Area.cdg_area 
                 Area.denominacion 
                 Rnk_sector.cantidad     
                 WITH FRAME frm-listado-des.

            DOWN WITH FRAME frm-listado-des.


            FOR EACH Sre_header WHERE Sre_header.nro_area = Rnk_sector.nro_area
                                                      AND Sre_header.cdg_empresa = Empresa.cdg_empresa
                                                      AND Sre_header.fecha_ingreso <= has_fecha
                                                      AND Sre_header.fecha_ingreso >= des_fecha
                                                      AND CAN-DO(p-estado, Sre_header.cdg_estado),
                                FIRST Motivo_retiro OF Sre_header NO-LOCK
                                              BREAK BY Sre_header.cdg_estado
                                                    BY Sre_header.nro_solicitud:

                            DISPLAY
                                 Sre_header.cdg_estado WHEN FIRST-OF(Sre_header.cdg_estado)           
                                 Sre_header.nro_solicitud        
                                 Sre_header.fecha_ingreso        
                                 Sre_header.fecha_retiro         
                                 Motivo_retiro.dsc_motivo_retiro 
                                 Sre_header.con_regreso          
                                 WITH FRAME frm-listado.
                
                           {case_motivo.i}
                    
                           {case_estado.i}

                           DOWN WITH FRAME frm-listado.

           END.

           DOWN 1 WITH FRAME frm-listado-des.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
