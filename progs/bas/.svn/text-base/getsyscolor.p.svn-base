/*==========================================================================*/
/*           DEVUELVE EL COLOR DE GRIS DE LOS CAMPOS INHABILITADOS          */
/*==========================================================================*/

DEFINE OUTPUT PARAMETER rgbGrayText AS INTEGER NO-UNDO.

{windows.i}
  
RUN GetSysColor IN hpApi (17, /* = COLOR_GRAYTEXT */
                            OUTPUT rgbGrayText).
  
