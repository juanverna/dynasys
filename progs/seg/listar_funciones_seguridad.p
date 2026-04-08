/*====================================================================================*/
/*                                 FRAMES                                             */
/*====================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Funciones por Usuario" AT 40
    "Página:" AT 86 PAGE-NUMBER FORMAT ">>9" AT 93
    SKIP
    fecha_lis
    hora_lis AT 86
    SKIP(1)
    WITH WIDTH 120 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
    Usuario.cdg_usuario         COLUMN-LABEL "Código!Usuario"
    Usuario.nombre              COLUMN-LABEL "Nombre!Usuario"
    User_empresa.cdg_empresa    COLUMN-LABEL "Código!Empresa"
    User_empresa.rige_desde     COLUMN-LABEL "Rige!Desde"
    User_empresa.rige_hasta     COLUMN-LABEL "Rige!Hasta"
    Area.cdg_area               COLUMN-LABEL "Código!Sector"
    Funcion.cdg_funcion         COLUMN-LABEL "Código!Función"
    Funcion.denominacion        COLUMN-LABEL "Nombre!Función"
    WITH WIDTH 120 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  FOR EACH Usuario, EACH User_empresa OF Usuario, FIRST Area OF User_empresa,
    EACH Usuario_funcion OF Usuario 
    WHERE Usuario_funcion.cdg_empresa = User_empresa.cdg_empresa, FIRST Funcion OF Usuario_funcion
    BREAK BY Usuario.cdg_usuario BY User_empresa.cdg_empresa:

      VIEW FRAME frm-titulo.

      DISPLAY Usuario.cdg_usuario         WHEN FIRST-OF(Usuario.cdg_usuario)
              Usuario.nombre              WHEN FIRST-OF(Usuario.cdg_usuario)
              User_empresa.cdg_empresa    WHEN FIRST-OF(User_empresa.cdg_empresa)
              User_empresa.rige_desde     WHEN FIRST-OF(User_empresa.cdg_empresa)
              User_empresa.rige_hasta     WHEN FIRST-OF(User_empresa.cdg_empresa)
              Area.cdg_area               WHEN FIRST-OF(User_empresa.cdg_empresa)
              Funcion.cdg_funcion
              Funcion.denominacion
              WITH STREAM-IO WIDTH 190 FRAME frm-listado DOWN.
      DOWN WITH FRAME frm-listado.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.
