/*=================================================================================*/
/*           EMITE EL LISTADO DE TODOS LOS TELEFONOS DE UNA AGENDA                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-cdg_agenda AS CHARACTER.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE x-telefonos    AS   CHARACTER FORMAT "X(50)".

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       "Listado de Telefonos por Agenda" AT 47
       "Página:" AT 113 PAGE-NUMBER FORMAT ">9" AT 120 
       SKIP
       fecha_lis 
       titulo-2 AT 47 
       hora_lis AT 113
       SKIP(1)
       WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Persona.nombre       
       Persona.direccion 
       x-telefonos          COLUMN-LABEL "Números!Telefónicos"
       WITH WIDTH 232 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                        B L O Q U E   P R I N C I P A L                          */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Agenda WHERE Agenda.cdg_agenda = p-cdg_agenda NO-LOCK.
TITULO-2 = "Agenda:" + Agenda.dsc_agenda.

{dirprinfile.i}

FOR EACH Persona OF Agenda:
    
    VIEW FRAME frm-titulo.

    x-telefonos = "".
    FOR EACH Persona_telefono OF Persona:
        x-telefonos = x-telefonos + "," + Persona_telefono.telefono.
    END.
    x-telefonos = SUBSTRING(x-telefonos,2).
    DISPLAY Persona.nombre Persona.direccion x-telefonos
        WITH FRAME frm-listado .
END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida, 
                 INPUT 22).
