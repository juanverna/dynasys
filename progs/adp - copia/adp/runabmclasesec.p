/*=========================================================================================*/
/*                EJECUTA EL ABM DE CLASIFICACION DE ENTIDADES CONTABLES                   */
/*=========================================================================================*/

   DEFINE VARIABLE   p-que_clase  AS CHARACTER.   
   DEFINE VARIABLE   puso_ok      AS LOGICAL.   

   RUN c-abmclasesector.w ( INPUT 0, OUTPUT p-que_clase, OUTPUT puso_ok ).
