/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_asiento  AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }

DEFINE VARIABLE que_empresa   LIKE Empresa.nombre.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

FIND Amd_header WHERE ROWID(Amd_header) = act_asiento EXCLUSIVE-LOCK.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

v-filtro =  "Amd_header.tip_comprob = '"     + Amd_header.tip_comprob +
            "' AND Amd_header.nro_comprob = '" + Amd_header.nro_comprob + "'".

v-params = "p-empresa=" + Empresa.nombre + "~n".

RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */
                  INPUT  "Asiento Modelo",    /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                )   
