/*=================================================================================*/
/*                EMITE EL LISTADO DE ARTICULOS POR FAMILIA DE COMPRA              */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codart  LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart  LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_codfam  LIKE Familia_articulo.cdg_familia. 
DEFINE INPUT PARAMETER has_codfam  LIKE Familia_articulo.cdg_familia. 

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{WGLISTAR.I}
{dfvarimp.i }

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Artículos por Cuenta Contable de Compras" AT 77
  "Página:" AT 175 PAGE-NUMBER FORMAT ">>>9" AT 182
  SKIP
  fecha_lis
  hora_lis AT 175
  SKIP(1)
  WITH WIDTH 250 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
   Cuenta.cdg_cuenta             COLUMN-LABEL "Código!Cuenta"
   Cuenta.nombre_cta             COLUMN-LABEL "Descripción!Cuenta"
   Imputacion.cdg_imputacion     COLUMN-LABEL "Código!Imputacion"
   Imputacion.dsc_imputacion     COLUMN-LABEL "Descripción!Imputacion"
   Familia_articulo.cdg_familia  COLUMN-LABEL "Código!Familia"
   Familia_articulo.dsc_familia  COLUMN-LABEL "Descripción!Familia"
   Articulo.cdg_articulo         COLUMN-LABEL "Código!Artículo"
   Articulo.descripcion          COLUMN-LABEL "Descripción!Artículo"
   WITH WIDTH 260 FRAME frm-linea USE-TEXT STREAM-IO DOWN.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  FOR EACH Familia_articulo
            WHERE Familia_articulo.cdg_familia >= des_codfam
              AND Familia_articulo.cdg_familia <= has_codfam,
      EACH Articulo OF Familia_articulo 
                    WHERE Articulo.cdg_articulo >= des_codart
                      AND Articulo.cdg_articulo <= has_codart
                      AND Articulo.compras_sino,
                          EACH Familia_cuenta OF Familia_articulo, 
                          FIRST Cuenta OF Familia_cuenta,
                          FIRST Imputacion OF Familia_cuenta
                          BREAK BY Cuenta.cdg_cuenta
                                BY Imputacion.cdg_imputacion
                                BY Familia_articulo.cdg_familia
                                BY Articulo.cdg_articulo:

      VIEW FRAME frm-titulo.

      DISPLAY 
              Cuenta.cdg_cuenta              WHEN FIRST-OF(Cuenta.cdg_cuenta)
              Cuenta.nombre_cta              WHEN FIRST-OF(Cuenta.cdg_cuenta)
              Imputacion.cdg_imputacion      WHEN FIRST-OF(Imputacion.cdg_imputacion)
              Imputacion.dsc_imputacion      WHEN FIRST-OF(Imputacion.cdg_imputacion)
              Familia_articulo.cdg_familia   WHEN FIRST-OF(Familia_articulo.cdg_familia)
              Familia_articulo.dsc_familia   WHEN FIRST-OF(Familia_articulo.cdg_familia)
              Articulo.cdg_articulo
              Articulo.descripcion 
              WITH FRAME frm-linea.
              
      DOWN WITH FRAME frm-linea.        
     

  END.                

  UNDERLINE Cuenta.cdg_cuenta
            Cuenta.nombre_cta
            Imputacion.cdg_imputacion      
            Imputacion.dsc_imputacion      
            Familia_articulo.cdg_familia
            Familia_articulo.dsc_familia
            Articulo.cdg_articulo
            Articulo.descripcion
            WITH FRAME frm-linea.
            

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).


END PROCEDURE.

