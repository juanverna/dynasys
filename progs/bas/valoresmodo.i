/*===================================================================*/
/*     VALORES POSIBLES DEL MODO DE LLAMADA DE LAS TRANSACCIONES     */
/*===================================================================*/

DEFINE VARIABLE MD_ALTA       AS INTEGER INITIAL 0.  /* Alta de comprobantes */
DEFINE VARIABLE MD_MULTIPLE   AS INTEGER INITIAL 1.  /* Consulta desde la interface */
DEFINE VARIABLE MD_DEFINIDA   AS INTEGER INITIAL 2.  /* Consulta desde otro programa */
DEFINE VARIABLE MD_RELACION   AS INTEGER INITIAL 3.  /* Modificacion desde otro programa */
DEFINE VARIABLE MD_READONLY   AS INTEGER INITIAL 4.  /* Acceso de solo lectura en comprobantes modificables */
DEFINE VARIABLE MD_CAMBIO     AS INTEGER INITIAL 5.  /* Modificacion desde la interface */
DEFINE VARIABLE MD_GENERADO   AS INTEGER INITIAL 6.  /* Alta generado en otro programa */
DEFINE VARIABLE MD_ANULACION  AS INTEGER INITIAL 7.  /* Anulacion desde la interface */ 
DEFINE VARIABLE MD_EMISION    AS INTEGER INITIAL 8.  /* Confirmacion desde la interface */ 
DEFINE VARIABLE MD_BONIFICS   AS INTEGER INITIAL 51. /* Solo editar bonificaciones */ 
