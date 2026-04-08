/*=============================================================================*/
/*               EJECUTA EL MANTENIMIENTO DE CLASES DE ARTICULOS               */
/*=============================================================================*/

DEFINE VARIABLE p-que_clase  AS CHARACTER.   
DEFINE VARIABLE puso_ok      AS LOGICAL.   

RUN c-abmclasearticulo.w ( OUTPUT p-que_clase,
                           OUTPUT puso_ok ).
