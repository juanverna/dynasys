/*=================================================================================*/
/*                  IMPRIME UN CONJUNTO DE ETIQUETAS PARA MAILING                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_vendedor LIKE Vendedor.cdg_vendedor.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

/*
{findempresa.i}
que_empresa = Empresa.nombre.
*/

FIND Vendedor WHERE Vendedor.cdg_vendedor = que_vendedor NO-LOCK.
v-filtro =  " Cliente.cdg_estado = 'A' AND Cliente.nro_vendedor = " + STRING(Vendedor.nro_vendedor).

/*/v-params = "p-empresa=" + Empresa.nombre + "~n".*/

RUN exreport.p (  INPUT  ".\etiquetas.prl",   /* Librería desde la que se ejecuta   */
                  INPUT  "ETIQUETAS",         /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                )   
