/*==========================================================================*/
/*      AJUSTA EL VALOR DEL COLOR DE GRIS DE LOS CAMPOS INHABILITADOS       */
/*==========================================================================*/

    DEFINE INPUT PARAMETER p-1 AS INTEGER.
    DEFINE INPUT PARAMETER p-2 AS INTEGER.
    DEFINE INPUT PARAMETER p-3 AS INTEGER.

/*==========================================================================*/
/*                               VARIABLES                                  */
/*==========================================================================*/

    {windows.i}
    
    DEFINE VARIABLE lpElements  AS MEMPTR.
    DEFINE VARIABLE lpRgb       AS MEMPTR.
    DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.

/*==========================================================================*/
/*                           BLOQUE PRINCIPAL                               */
/*==========================================================================*/
/*    
    SET-SIZE(lpElements)   = 4.   /* = sizeof(long)   */
    SET-SIZE(lpRgb)        = 4.
    PUT-LONG(lpElements,1) = 17.  /* = COLOR_GRAYTEXT */
    PUT-LONG(lpRgb,1)      = RGB-VALUE(p-1,p-2,p-3).
    
    RUN SetSysColors IN hpApi (1,          /* = number of elements */
                             GET-POINTER-VALUE(lpElements),
                             GET-POINTER-VALUE(lpRgb),
                             OUTPUT ReturnValue).
    
    SET-SIZE(lpElements) = 0.
    SET-SIZE(lpRgb)      = 0.
*/    
    
    
