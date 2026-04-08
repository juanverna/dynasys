/*=========================================================================================*/
/*                EJECUTA EL ABM DE CLASIFICACION DE CUENTAS CONTABLES                     */
/*=========================================================================================*/

   DEFINE VARIABLE   p-que_clase  AS CHARACTER.   
   DEFINE VARIABLE   puso_ok      AS LOGICAL.   

   RUN c-abmclasezonag.w ( OUTPUT p-que_clase, OUTPUT puso_ok ).
