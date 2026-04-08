/*=================================================================================*/
/*                     LISTADO DE EQUIVALENCIA DE CUENTAS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER has_ctapsp   LIKE Ctapsp.cdg_ctapsp.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE fecha_fr     AS CHARACTER.
DEFINE VARIABLE hora_fr      AS CHARACTER.
DEFINE VARIABLE transpor     AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes      AS DATE.

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE s_deb-pres LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Deudor!Presupestado".
DEFINE VARIABLE s_crd-pres LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Acreedor!Presupestado".
DEFINE VARIABLE s_deb-real LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Deudor!Real".
DEFINE VARIABLE s_crd-real LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Acreedor!Real".
DEFINE VARIABLE prc_desvio AS DECIMAL FORMAT "->>>>>9.99" COLUMN-LABEL "   %!Desvío".

DEFINE VARIABLE acm_debitos  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Aps_detalle.credito LABEL "Acum.creditos".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Equivalencia entre Cuentas Presupuestarias y Reales" AT 38 
  "Pagina:" AT 93 PAGE-NUMBER FORMAT "ZZZ9" AT 100
  SKIP  
  fecha_lis   
  hora_lis AT 93
  SKIP(1)
  WITH WIDTH 132 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Ctapsp.cdg_ctapsp COLUMN-LABEL "Código!Sumariza"
  Ctapsp.nombre     COLUMN-LABEL "Descripción!Sumariza"
  Cuenta.cdg_cuenta COLUMN-LABEL "Código!Cuenta"
  Cuenta.nombre_cta COLUMN-LABEL "Descripción!Cuenta"
  WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:


  {dirprinfile.i} 
   
  FOR EACH Ctapsp 
      WHERE Ctapsp.cdg_ctapsp <= has_ctapsp
        AND Ctapsp.cdg_ctapsp >= des_ctapsp NO-LOCK:
        
      VIEW FRAME frm-titulo.

      DISPLAY  Ctapsp.cdg_ctapsp
               Ctapsp.nombre
               WITH FRAME frm-movimiento.

      FOR EACH  Ctapsp-cuenta OF Ctapsp, FIRST Cuenta OF Ctapsp-cuenta:

          DISPLAY  Cuenta.cdg_cuenta
                   Cuenta.nombre_cta
                   WITH FRAME frm-movimiento.
          DOWN WITH FRAME frm-movimiento.

      END.
     
      DOWN WITH FRAME frm-movimiento.

  END.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

