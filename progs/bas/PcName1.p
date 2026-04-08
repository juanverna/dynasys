/*==========================================================================================*/
/*            RECUPERA EL NOMBRE DE LA PC EN LA QUE ESTA CORRIENDO EL SISTEMA               */
/*==========================================================================================*/

DEFINE OUTPUT PARAMETER cPcName     as char format "x(16)"      NO-UNDO.



/*==========================================================================================*/
/*                                       VARIABLES                                          */
/*==========================================================================================*/

DEFINE VARIABLE  b  AS INTEGER INITIAL 16 NO-UNDO.
DEFINE VARIABLE  c  AS INTEGER            NO-UNDO.
DEFINE VARIABLE  d  AS MEMPTR             NO-UNDO.

/*==========================================================================================*/
/*                                       PROCESO                                            */
/*==========================================================================================*/

SET-SIZE(d) = 16.
RUN GetComputerNameA (OUTPUT d,
                      INPUT-OUTPUT b,
                      OUTPUT c).
                    
IF c = 1
    THEN ASSIGN cPcName = GET-STRING(d,1).

/*==========================================================================================*/
/*                                  PROCEDIMIENTOS INTERNOS                                 */
/*==========================================================================================*/

PROCEDURE GetComputerNameA external "kernel32.dll".
  DEFINE OUTPUT PARAMETER d AS MEMPTR.
  DEFINE INPUT-OUTPUT PARAMETER b AS LONG.
  DEFINE RETURN PARAMETER c AS SHORT.
end procedure.  



