/*=================================================================================*/
/*             CARGA INICIAL DE PARAMETROS DE UN DETERMINADO AMBIENTE              */
/*=================================================================================*/

DEFINE SHARED VARIABLE MAIN-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE SHARED VARIABLE titulo       AS CHARACTER INITIAL "Ingreso al sistema".
DEFINE SHARED VARIABLE NOM_SISTEMA  AS CHARACTER INITIAL "Solucion Integrada Computel".

   {VRSHARED.I}


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/


   FIND Parametro WHERE Parametro.cdg_empresa = ""
                    AND Parametro.cdg_parametro = "LISMODUL" 
                        NO-LOCK NO-ERROR.
   IF AVAILABLE Parametro
      THEN LISTA_MODULOS = Parametro.valor_c.
      ELSE MESSAGE "No se encuentra la lista de módulos LISMODUL"
                   VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE INSTALACION".

   FIND FIRST Base-ID NO-LOCK.

   RUN ARMA_TITULO.

/*=================================================================================*/
/*                              PROCEDIMIENTOS                                     */
/*=================================================================================*/
   
PROCEDURE ARMA_TITULO:

  titulo = NOM_SISTEMA + "  " + VERSION_SIC + " - " + 
            STRING(TODAY) + " - DB:" + Base-ID.label_base + " - " + PDBNAME("SIC").

END PROCEDURE.    
