/*==========================================================================================  
   EJECUTA abmclasecue.p
  ==========================================================================================*/
  
DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   
  
RUN  c-abmclasecuenta.p ( OUTPUT p-que_clase, OUTPUT puso_ok). 
  
  
