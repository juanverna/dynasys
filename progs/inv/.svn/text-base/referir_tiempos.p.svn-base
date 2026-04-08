/* ======================================================================================== */
/*              Referimos todas las indicaciones de tiempo a la medianoche del              */
/*              dia de referencia para facilitar las comparaciones.                          */
/* ======================================================================================== */

    DEFINE INPUT  PARAMETER r-fecha    AS DATE.       /* Fecha a convertir                 */
    DEFINE INPUT  PARAMETER r-hms      AS CHARACTER.  /* Hora a convertir                  */
    DEFINE OUTPUT PARAMETER r-segundos AS INTEGER.    /* Segundos resultantes              */

    {fecorigen.i} 
                                 /* convertimos la hora a segundos */

    RUN PASASEGS.P ( INPUT r-hms, OUTPUT r-segundos ).
                 

                       /* agregamos los dias, a 86400 segundos por dia */
                       
    r-segundos = r-segundos + ( r-fecha - fec-origen) * 86400.
    
