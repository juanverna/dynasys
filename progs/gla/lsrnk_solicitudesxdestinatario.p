/*====================================================================================*/
/*                        ESTADISTICAS POR DESTINATARIOS                              */
/*                  Ranking de Destinatarios por Solicitud de Retiro                  */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_destinatario AS CHARACTER.
DEFINE INPUT PARAMETER has_destinatario AS CHARACTER.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.

DEFINE TEMP-TABLE Rnk_destinatario
   FIELD nro_destinatario        LIKE Destinatario.nro_destinatario
   FIELD cantidad            AS INTEGER FORMAT ">>>>9"
   INDEX por_destinatario          IS PRIMARY nro_destinatario ASCENDING
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
    "Ranking de Destinatario Considerando Solicitudes en Estados:" AT 40
    "Página:" AT 162 PAGE-NUMBER FORMAT "99999" AT 169
    SKIP
    fecha_lis
    "Remitido (RE), Pendiente de Retorno (PR), Cumplido (CU) y Finalizado (FI)" AT 40 hora_lis AT 162
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    "del destinatario" AT 40
    des_destinatario
    "al"
    has_destinatario
  SKIP(1)

  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Descripción                      Cant Tot                                                                                                                         " SKIP
  "Destinario Destinario                    Solicitudes                                                                                                                         " SKIP
  "                                                                                                                                                                             " SKIP
  "           Código Descripción             Nro Tipo        Prf      Nro Fecha    Fecha    Motivo                              Con Cdg Area Dsc Area                           " SKIP
  "           Estado Estado            Solicitud Comprob Comprob  Comprob Ingreso  Retiro   Retiro                              Reg Solicit  Solicitante                        " SKIP
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 185 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-des
    Destinatario.cdg_destinatario
    SPACE(3)
    Destinatario.dsc_destinatario
    Rnk_destinatario.cantidad
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
    Area.cdg_area
    Area.denominacion
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
          AND Sre_header.nro_area = Area.nro_area
          AND Sre_header.fecha_ingreso <= has_fecha
          AND Sre_header.fecha_ingreso >= des_fecha
          AND CAN-DO("RE,PR,CU,FI", Sre_header.cdg_estado),
          FIRST Destinatario OF Sre_header WHERE Destinatario.cdg_destinatario <= has_destinatario
                                             AND Destinatario.cdg_destinatario >= des_destinatario NO-LOCK:

                  FIND FIRST Rnk_destinatario WHERE Rnk_destinatario.nro_destinatario = Sre_header.nro_destinatario NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE Rnk_destinatario THEN DO:
                      CREATE Rnk_destinatario.
                      ASSIGN 
                          Rnk_destinatario.nro_destinatario = Sre_header.nro_destinatario.

                  END.

                  ASSIGN
                      Rnk_destinatario.cantidad = Rnk_destinatario.cantidad + 1.

  END.

  FOR EACH Rnk_destinatario,
        FIRST Destinatario OF Rnk_destinatario
        BREAK BY Rnk_destinatario.cantidad DESCENDING
              BY Destinatario.cdg_destinatario:

            VIEW FRAME frm-titulo.
    
            DISPLAY
                 Destinatario.cdg_destinatario 
                 Destinatario.dsc_destinatario 
                 Rnk_destinatario.cantidad     
                 WITH FRAME frm-listado-des.

            DOWN WITH FRAME frm-listado-des.


            FOR EACH Sre_header WHERE Sre_header.nro_destinatario = Rnk_destinatario.nro_destinatario
                                                      AND Sre_header.cdg_empresa = Empresa.cdg_empresa
                                                      AND Sre_header.nro_area = Area.nro_area
                                                      AND Sre_header.fecha_ingreso <= has_fecha
                                                      AND Sre_header.fecha_ingreso >= des_fecha
                                                      AND CAN-DO("RE,PR,CU,FI", Sre_header.cdg_estado),
                                FIRST Motivo_retiro OF Sre_header,
                                FIRST Area WHERE Sre_header.nro_area_sol = Area.nro_area NO-LOCK
                                              BREAK BY Sre_header.nro_solicitud
                                                    BY Sre_header.cdg_estado:

                            DISPLAY
                                 Sre_header.cdg_estado           
                                 Sre_header.nro_solicitud        
                                 Sre_header.fecha_ingreso        
                                 Sre_header.fecha_retiro         
                                 Motivo_retiro.dsc_motivo_retiro 
                                 Sre_header.con_regreso          
                                 Area.cdg_area                   
                                 Area.denominacion               
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
