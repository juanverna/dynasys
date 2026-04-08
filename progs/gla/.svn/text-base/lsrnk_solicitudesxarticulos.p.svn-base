/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULOS                                  */
/*                  Ranking de Articulos por Solicitud de Retiro                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_articulo     AS CHARACTER.
DEFINE INPUT PARAMETER has_articulo     AS CHARACTER.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.

DEFINE TEMP-TABLE Rnk_articulo
   FIELD nro_articulo        LIKE Articulo.nro_articulo
   FIELD cantidad            AS INTEGER FORMAT ">>>>9"
   FIELD granel              AS DECIMAL FORMAT ">>>>9.99"
   INDEX por_articulo          IS PRIMARY nro_articulo ASCENDING
   INDEX por_cantidad cantidad DESCENDING.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE v-prf_comprob AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE v-nro_comprob AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-dsc_estado  AS CHARACTER FORMAT "X(20)".

DEFINE BUFFER B-Unidad FOR Unidad.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

/* DEFINE BUFFER B-Empleado FOR Empleado.  */

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Ranking de Artículos Considerando Solicitudes en Estados:" AT 40
    "Página:" AT 143 PAGE-NUMBER FORMAT "99999" AT 150
    SKIP
    fecha_lis
    "Remitido (RE), Pendiente de Retorno (PR), Cumplido (CU) y Finalizado (FI)" AT 40 hora_lis AT 143
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    "del artículo" AT 40
    des_articulo
    "al"
    has_articulo
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código        Descripción                           Cant Tot Unid. Gran Tot Unid.                                                                         " SKIP
  "Articulo      Artículo                              Artículo Med.  Artículo Gran.                                                                         " SKIP
  "                                                                                                                                                          " SKIP
  "     Cant Tot Unid.   Gran Tot Unid. Código Descripción             Nro Tipo        Prf      Nro Fecha    Fecha    Motivo                              Con" SKIP
  "    Solicitud Med.   Solicitud Gran. Estado Estado            Solicitud Comprob Comprob  Comprob Ingreso  Retiro   Retiro                              Reg" SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-art
    Articulo.cdg_articulo
    SPACE(2)
    Articulo.descripcion
    Rnk_Articulo.cantidad
    Unidad.abrevia
    Rnk_articulo.granel
    B-Unidad.abrevia
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado
    Sre_detalle.cantidad
    Unidad.abrevia
    Sre_detalle.granel
    B-Unidad.abrevia
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
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
          AND Sre_header.nro_area = Area.nro_area
          AND Sre_header.fecha_ingreso <= has_fecha
          AND Sre_header.fecha_ingreso >= des_fecha
          AND CAN-DO("RE,PR,CU,FI", Sre_header.cdg_estado),
          EACH Sre_detalle OF Sre_header,
          FIRST Articulo OF Sre_detalle  WHERE Articulo.cdg_articulo <= has_articulo
                                           AND Articulo.cdg_articulo >= des_articulo NO-LOCK:

                  FIND FIRST Rnk_articulo WHERE Rnk_articulo.nro_articulo = Sre_detalle.nro_articulo NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE Rnk_articulo THEN DO:
                      CREATE Rnk_articulo.
                      ASSIGN 
                          Rnk_articulo.nro_articulo = Sre_detalle.nro_articulo.

                  END.

                  ASSIGN
                      Rnk_articulo.cantidad = Rnk_articulo.cantidad + Sre_detalle.cantidad
                      Rnk_articulo.granel   = Rnk_articulo.granel + Sre_detalle.granel.

  END.

  FOR EACH Rnk_articulo,
      FIRST Articulo OF Rnk_articulo,
      FIRST Unidad OF Articulo,
      FIRST B-Unidad WHERE B-Unidad.cdg_umed = Articulo.cdg_ugranel
        BREAK BY Rnk_articulo.cantidad DESCENDING
              BY Rnk_articulo.granel   DESCENDING
              BY Articulo.cdg_articulo:

            VIEW FRAME frm-titulo.
    
            DISPLAY
                 Articulo.cdg_articulo           WHEN FIRST-OF(Articulo.cdg_articulo)
                 Articulo.descripcion            WHEN FIRST-OF(Articulo.cdg_articulo)
                 Rnk_articulo.cantidad           WHEN FIRST-OF(Articulo.cdg_articulo)
                 Unidad.abrevia                  WHEN FIRST-OF(Articulo.cdg_articulo)
                 Rnk_articulo.granel             WHEN FIRST-OF(Articulo.cdg_articulo)
                 B-Unidad.abrevia                WHEN FIRST-OF(Articulo.cdg_articulo)
                 WITH FRAME frm-listado-art.

            DOWN WITH FRAME frm-listado-art.


            FOR EACH Sre_detalle WHERE Sre_detalle.nro_articulo = Rnk_articulo.nro_articulo,
                    FIRST Sre_header OF Sre_detalle WHERE Sre_header.cdg_empresa = Empresa.cdg_empresa
                                                      AND Sre_header.nro_area = Area.nro_area
                                                      AND Sre_header.fecha_ingreso <= has_fecha
                                                      AND Sre_header.fecha_ingreso >= des_fecha
                                                      AND CAN-DO("RE,PR,CU,FI", Sre_header.cdg_estado),
                    FIRST Motivo_retiro OF Sre_header NO-LOCK
                                            BREAK BY Sre_detalle.cantidad
                                                  BY Sre_detalle.granel
                                                  BY Articulo.cdg_articulo
                                                  BY Sre_header.nro_solicitud
                                                  BY Sre_header.cdg_estado:

                            DISPLAY
                                 Sre_detalle.cantidad            WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Unidad.abrevia                  WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_detalle.granel              WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 B-Unidad.abrevia                WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_header.cdg_estado           WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_header.nro_solicitud        WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_header.fecha_ingreso        WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_header.fecha_retiro         WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Motivo_retiro.dsc_motivo_retiro WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 Sre_header.con_regreso          WHEN FIRST-OF(Sre_header.nro_solicitud)
                                 WITH FRAME frm-listado.
                
                           {case_motivo.i}
                    
                           {case_estado.i}

                           DOWN WITH FRAME frm-listado.

           END.

           DOWN 1 WITH FRAME frm-listado-art.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
