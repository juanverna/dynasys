/*=========================================================================================*/
/*                EJECUTA EL ABM DE CLASIFICACION DE ENTIDADES CONTABLES                   */
/*=========================================================================================*/

   DEFINE VARIABLE   p-que_clase  AS CHARACTER.   
   DEFINE VARIABLE   puso_ok      AS LOGICAL.   

   RUN c-abmclaseentidad.w ( OUTPUT p-que_clase, OUTPUT puso_ok ).
