/*=================================================================================*/
/*               E D I T A   L O S   P E R I O D O S   F I S C A L E S             */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

CREATE WIDGET-POOL.

DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE que_ano     AS INTEGER.
DEFINE VARIABLE que_mes     AS INTEGER.
DEFINE VARIABLE pri_mes     AS INTEGER.

DEFINE VARIABLE que_linea      AS ROWID.
DEFINE VARIABLE ant_articulo   AS CHARACTER.
DEFINE VARIABLE que_ejercicio  AS INTEGER FORMAT "9999" LABEL "Ejercicio".

DEFINE VARIABLE n_linea AS INTEGER.
DEFINE QUERY qry_periodos FOR Periodo_fiscal.
DEFINE BROWSE brw_periodos QUERY qry_periodos
  DISPLAY Periodo_fiscal.ano
          Periodo_fiscal.mes
          Periodo_fiscal.dsc_periodo
          Periodo_fiscal.cerrado FORMAT "Si/No"
/* ENABLE Periodo_fiscal.dsc_periodo
          Periodo_fiscal.cerrado */
          WITH 12 DOWN SEPARATORS.

DEFINE BUTTON btn_cerrar
     LABEL "Cerrar":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_salir
     LABEL "Salir":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_listar
     LABEL "Listar":L 
     SIZE 10 BY 0.9 FONT 4.
          
FORM 
   SKIP
   que_ejercicio    
   btn_cerrar
   btn_listar
   btn_salir
   SKIP
   brw_periodos AT 2
   WITH FRAME frm-Periodo THREE-D CENTERED ROW 4 VIEW-AS DIALOG-BOX
        TITLE "Actualizacion de tabla de Periodos Fiscales" SIDE-LABELS.

/*=================================================================================*/
/*                                   T R I G G E R S                               */
/*=================================================================================*/


ON CHOOSE OF btn_listar IN FRAME frm-Periodo
DO:

  que_linea = ROWID(Periodo_fiscal).
  OUTPUT TO VALUE(dire_tmp + "edperfis.lst") PAGED.
  GET FIRST qry_periodos.
  DO WHILE AVAILABLE Periodo_fiscal:
     DISPLAY Periodo_fiscal.ano
             Periodo_fiscal.mes
             Periodo_fiscal.dsc_periodo
             Periodo_fiscal.cerrado FORMAT "Si/No"
             WITH FRAME aaa DOWN STREAM-IO USE-TEXT.
     DOWN WITH FRAME aaa.        
     GET NEXT qry_periodos.
  END.
  OUTPUT CLOSE.           
  RUN PROPRINT.P ( INPUT "edperfis.lst" ).
  REPOSITION qry_periodos TO ROWID que_linea.

END.   

ON VALUE-CHANGED OF brw_periodos IN FRAME frm-Periodo
DO:
  btn_cerrar:SENSITIVE IN FRAME frm-Periodo = NOT Periodo_fiscal.cerrado.
END.   

ON RETURN OF que_ejercicio IN FRAME frm-Periodo
DO:

  ASSIGN que_ejercicio.
  IF que_ejercicio < 1900 
  THEN DO: 
     que_ejercicio = que_ejercicio + 1900.
     DISPLAY que_ejercicio WITH FRAME frm-periodo.
  END.
     
  RUN ABRE_QUERY.
  IF NOT AVAILABLE Periodo_fiscal
  THEN DO:
     RUN CREAR_PERIODOS.
     RUN ABRE_QUERY.
  END.   
  APPLY "VALUE-CHANGED" TO brw_periodos.
  
END.     

ON CHOOSE OF btn_cerrar IN FRAME frm-Periodo
DO:

  DO TRANSACTION:
    FIND CURRENT Periodo_fiscal EXCLUSIVE-LOCK.
    Periodo_fiscal.cerrado = YES.
    FIND CURRENT Periodo_fiscal NO-LOCK.
    DISPLAY Periodo_fiscal.cerrado WITH BROWSE brw_periodos.
    btn_cerrar:SENSITIVE = NO.
  END.

END.         

/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O     */
/*=================================================================================*/

nom_menu = "CONTABILIDAD".
nom_funcion = "Actualización de Períodos Fiscales".

titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
CURRENT-WINDOW:TITLE = titulo_w.
SESSION:DATA-ENTRY-RETURN = YES.

VIEW FRAME frm-Periodo.
ENABLE ALL WITH FRAME frm-Periodo.
WAIT-FOR CHOOSE OF BTN_SALIR IN FRAME frm-periodo FOCUS que_ejercicio.

/*---------------------------------------------------------------------------------*/
/*                    PROCEDIMIENTOS  GENERALES                                    */
/*---------------------------------------------------------------------------------*/

PROCEDURE ABRE_QUERY:

   OPEN QUERY qry_periodos 
        FOR EACH Periodo_fiscal 
                 WHERE Periodo_fiscal.cdg_empresa = Empresa.cdg_empresa
                   AND Periodo_fiscal.ano_fiscal  = que_ejercicio 
                       NO-LOCK. 
   
END PROCEDURE.   

PROCEDURE PONER_SESION:

END PROCEDURE.

PROCEDURE CREAR_PERIODOS:

   que_ano = que_ejercicio. 

   RUN getparametro.p (  INPUT  "PRPERCON",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   pri_mes = v-valor_n. 
   que_mes = pri_mes - 1.

   DO TRANSACTION:
        DO j = 1 to 12:
           que_mes = que_mes + 1.
           IF que_mes > 12 
           THEN DO: 
              que_mes = que_mes - 12.
              que_ano = que_ano + 1.
           END.   
           FIND Nombre-Mes WHERE Nombre-Mes.mes = que_mes NO-LOCK.
           CREATE Periodo_fiscal.
           ASSIGN
                  Periodo_fiscal.cdg_empresa  = Empresa.cdg_empresa
                  Periodo_fiscal.ano_fiscal   = que_ejercicio
                  Periodo_fiscal.nro_periodo  = j
                  Periodo_fiscal.ano          = que_ano
                  Periodo_fiscal.mes          = que_mes
                  Periodo_fiscal.dsc_periodo  = Nombre-Mes.nom_mes + " " + STRING(que_ano,"9999")
                  Periodo_fiscal.cerrado      = NO.
        END.
   END.
   
END PROCEDURE.      
