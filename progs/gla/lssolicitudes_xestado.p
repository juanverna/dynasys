/*=================================================================================*/
/*                    LISTADO DE SOLICITUDES POR ESTADO                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_destinatario AS CHARACTER.
DEFINE INPUT PARAMETER has_destinatario AS CHARACTER.
DEFINE INPUT PARAMETER p-estado         AS CHARACTER.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.

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
    "Listado de Solicitudes Ordenadas por Estado" AT 40
    "Página:" AT 242 PAGE-NUMBER FORMAT "9999" AT 249
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 242
    "con estados" AT 40
    p-estado FORMAT "X(30)"
    "del destinatario" AT 40
    des_destinatario
    "al"
    has_destinatario
    SKIP (1) 
    WITH WIDTH 254 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Sre_header.cdg_estado            COLUMN-LABEL "Cdg!Estado"          FORMAT "X(02)"
    v-dsc_estado                     COLUMN-LABEL "Descripción!Estado"
    Destinatario.dsc_destinatario    COLUMN-LABEL "Nombre!Destinatario" FORMAT "X(25)"
    Sre_header.nro_solicitud         COLUMN-LABEL "Nro!Solicitud"
    v-tip_comprob                    COLUMN-LABEL "Tip!Comprob"
    v-prf_comprob                    COLUMN-LABEL "Prf!Comprob"
    v-nro_comprob                    COLUMN-LABEL "Nro!Comprob"
/*     Deposito.nombre                  COLUMN-LABEL "Nombre!Depósito"                    */
/*     Usuario.nombre                   COLUMN-LABEL "Nombre!Usuario"      FORMAT "X(25)" */
    Sre_header.fecha_ingreso  
    Sre_header.fecha_retiro
    Motivo_retiro.dsc_motivo_retiro  COLUMN-LABEL "Motivo!Retiro"       FORMAT "X(20)"
    Sre_header.con_regreso           COLUMN-LABEL "C/Re-!greso"
/*     Empleado.nombre                  COLUMN-LABEL "Nombre!Autorizante"  FORMAT "X(25)" */
/*     B-Empleado.nombre                COLUMN-LABEL "Nombre!Solicitante"  FORMAT "X(25)" */
    Articulo.cdg_articulo
    Articulo.descripcion             COLUMN-LABEL "Descripción!Artículo"
    Registrable.cdg_registrable
    Registrable.dsc_registrable                                         FORMAT "X(30)"
/*     Registrable.disponible           COLUMN-LABEL "Dispo-!nible"  */
    Regreso_solicitud.tip_comprob    COLUMN-LABEL "Regreso!Tipo"
    Regreso_solicitud.prf_comprob    COLUMN-LABEL "Regreso!Prefijo"
    Regreso_solicitud.nro_comprob    COLUMN-LABEL "Regreso!Número"
    WITH WIDTH 475 DOWN CENTERED USE-TEXT STREAM-IO.

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
          AND CAN-DO(p-estado, Sre_header.cdg_estado),
              /*FIRST Deposito OF Sre_header,*/
              /*FIRST Usuario OF Sre_header,*/
              FIRST Motivo_retiro OF Sre_header,
              /*FIRST Empleado WHERE Empleado.nro_empleado = Sre_header.nro_empleado_aut,*/
              /*FIRST B-Empleado WHERE B-Empleado.nro_empleado = Sre_header.nro_empleado_sol,*/
              FIRST Destinatario OF Sre_header WHERE Destinatario.cdg_destinatario <= has_destinatario
                                                 AND Destinatario.cdg_destinatario >= des_destinatario,
          EACH Sre_detalle OF Sre_header,
          FIRST Articulo OF Sre_detalle NO-LOCK
          BREAK BY Sre_header.cdg_estado
                BY Destinatario.cdg_destinatario
                BY Sre_header.nro_solicitud
                BY Sre_detalle.nro_linea:

        VIEW FRAME frm-titulo.

        DISPLAY
             Sre_header.cdg_estado           WHEN FIRST-OF(Sre_header.cdg_estado)
             Destinatario.dsc_destinatario   WHEN FIRST-OF(Destinatario.cdg_destinatario)
             Sre_header.nro_solicitud        WHEN FIRST-OF(Sre_header.nro_solicitud)
/*              Deposito.nombre                 WHEN FIRST-OF(Sre_header.nro_solicitud) */
/*              Usuario.nombre                  WHEN FIRST-OF(Sre_header.nro_solicitud) */
             Sre_header.fecha_ingreso        WHEN FIRST-OF(Sre_header.nro_solicitud)
             Sre_header.fecha_retiro         WHEN FIRST-OF(Sre_header.nro_solicitud)
             Motivo_retiro.dsc_motivo_retiro WHEN FIRST-OF(Sre_header.nro_solicitud)
             Sre_header.con_regreso          WHEN FIRST-OF(Sre_header.nro_solicitud)
/*              Empleado.nombre                 WHEN FIRST-OF(Sre_header.nro_solicitud) */
/*              B-Empleado.nombre               WHEN FIRST-OF(Sre_header.nro_solicitud) */
             Articulo.cdg_articulo           WHEN FIRST-OF(Sre_detalle.nro_linea)
             Articulo.descripcion            WHEN FIRST-OF(Sre_detalle.nro_linea) 
             WITH FRAME frm-listado.

       {case_motivo.i}

       {case_estado.i}

       IF Articulo.es_registrable THEN DO:

           FIND FIRST Registrable-solicitud OF Sre_detalle NO-LOCK NO-ERROR.
           IF AVAILABLE Registrable-solicitud 
           THEN DO:

               FOR EACH Registrable-solicitud OF Sre_detalle NO-LOCK:
    
                            FIND FIRST Registrable OF Registrable-solicitud NO-LOCK.
                            DISPLAY
                                 Registrable.cdg_registrable
                                 Registrable.dsc_registrable
/*                                  Registrable.disponible */
                                 WITH FRAME frm-listado.
    
                        DOWN WITH FRAME frm-listado.
               END.
           END.
           ELSE DOWN WITH FRAME frm-listado.
       END.
       ELSE DOWN WITH FRAME frm-listado.

       IF FIRST-OF(Sre_header.nro_solicitud)
       THEN DO:
           FOR EACH Regreso_solicitud OF Sre_header NO-LOCK:
               DISPLAY
                    Regreso_solicitud.tip_comprob
                    Regreso_solicitud.prf_comprob
                    Regreso_solicitud.nro_comprob
                    WITH FRAME frm-listado.

           DOWN WITH FRAME frm-listado.
           END.
       END.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
