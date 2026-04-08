/*=================================================================================*/
/*                                                                                 */
/*              CARGA UN CODIGO DE NOVEDAD DESDE LOS PARAMETROS                    */
/*                                                                                 */
/*=================================================================================*/

  DEFINE INPUT  PARAMETER que_parametro LIKE Parametro.cdg_parametro.
  DEFINE OUTPUT PARAMETER que_codigo    LIKE Novedad.cdg_novedad.
  DEFINE OUTPUT PARAMETER que_nombre    LIKE Novedad.descripcion.

  FIND Parametro WHERE Parametro.cdg_parametro = que_parametro NO-LOCK NO-ERROR.
  IF AVAILABLE Parametro
  THEN DO:
     FIND Novedad WHERE Novedad.cdg_novedad = Parametro.valor_n NO-LOCK.
     ASSIGN que_codigo = Novedad.cdg_novedad
            que_nombre = Novedad.descripcion.
  END.
  ELSE DO:
     ASSIGN que_codigo = 0
            que_nombre = "".
  END.