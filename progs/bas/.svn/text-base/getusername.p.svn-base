/*=============================================================================*/
/*     DEVUELVE EL USUARIO DEL SISTEMA OPERATIVO EN UNA SESION DE WINDOWS      */
/*=============================================================================*/

DEFINE OUTPUT PARAMETER p-usuario-so AS CHARACTER.

/*-----------------------------------------------------------------------------*/
/*                         VARIABLES Y FUNCIONES                               */
/*-----------------------------------------------------------------------------*/

{windows.i}
 
DEFINE VARIABLE NAME AS CHARACTER NO-UNDO.

/*-----------------------------------------------------------------------------*/
/*                                  PROCESO                                    */
/*-----------------------------------------------------------------------------*/

RUN WinUserName(OUTPUT p-usuario-so).
 
/*-----------------------------------------------------------------------------*/
/*                              PROCEDIMIENTOS                                 */
/*-----------------------------------------------------------------------------*/

PROCEDURE WinUserName :

   DEFINE OUTPUT PARAMETER p-nombre AS CHARACTER.
 
   DEFINE VARIABLE nr AS INTEGER NO-UNDO INITIAL 100.
   DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.
   p-nombre = FILL(" ", nr).
   RUN GetUserName{&A} IN hpApi (INPUT-OUTPUT p-nombre,
                                 INPUT-OUTPUT nr,
                                 OUTPUT ReturnValue).
END PROCEDURE.
