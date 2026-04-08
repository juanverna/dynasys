/*=========================================================================================*/
/*                EJECUTA EL ABM DE CLASIFICACION DE OBRAS CONTABLES                       */
/*=========================================================================================*/

   DEFINE VARIABLE   p-que_clase  AS CHARACTER.   
   DEFINE VARIABLE   puso_ok      AS LOGICAL.   

   RUN c-abmclaseobra.w ( OUTPUT p-que_clase, OUTPUT puso_ok ).
