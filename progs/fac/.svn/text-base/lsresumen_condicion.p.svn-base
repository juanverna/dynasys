/*=================================================================================*/
/*                       EMISION DE LISTADO DE IVA VENTAS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE. 
DEFINE INPUT PARAMETER has_fecha    AS DATE. 
DEFINE INPUT PARAMETER des_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE v-con_neto      LIKE Fac_header.imp_neto. 
DEFINE VARIABLE v-con_iva       LIKE Fac_header.imp_iva.  
DEFINE VARIABLE v-con_facturado LIKE Fac_header.imp_total.   

DEFINE VARIABLE v-tot_neto      LIKE Fac_header.imp_neto. 
DEFINE VARIABLE v-tot_iva       LIKE Fac_header.imp_iva.  
DEFINE VARIABLE v-tot_facturado LIKE Fac_header.imp_total.   

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Resumen de Ventas por Condicion Impositiva" AT 45
   "Página:" AT 99 PAGE-NUMBER FORMAT "9999" AT 106
   SKIP
   fecha_lis
   "Período" AT 45
   des_fecha " - " has_fecha
   hora_lis AT 99
   SKIP(2)
   WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM
   SPACE(20)
   Condicion_impos.descripcion
   v-con_neto
   v-con_iva
   v-con_facturado
   WITH FRAME a DOWN WIDTH 256 USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
  
  {findempresa.i}
  que_empresa = Empresa.nombre.
  
  {dirprinfile.i}

  IF lis_fecha
  THEN DO:
       fecha_lis = STRING(TODAY,"99/99/99").
       hora_lis = STRING(TIME,"HH:MM:SS").
  END.
  ELSE DO:
       fecha_lis = "".
       hora_lis = "".
  END.

  FOR EACH Fac_header
     WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
       AND Fac_header.fecha <= has_fecha
       AND Fac_header.fecha >= des_fecha
       AND CAN-DO(lista_tipos,Fac_header.tip_comprob)
       AND Fac_header.prf_comprob <= has_ptovta 
       AND Fac_header.prf_comprob >= des_ptovta NO-LOCK,
           FIRST Condicion_impos OF Fac_header NO-LOCK,
           FIRST Tipocomprobante OF Fac_header NO-LOCK
           BREAK BY Condicion_impos.cdg_condiva:

      VIEW FRAME frm-titulo.
      
      ASSIGN v-con_neto      = v-con_neto      + Tipocomprobante.signo * Fac_header.imp_neto
             v-con_iva       = v-con_iva       + Tipocomprobante.signo * Fac_header.imp_iva
             v-con_facturado = v-con_facturado + Tipocomprobante.signo * Fac_header.imp_total.

      IF LAST-OF(Condicion_impos.cdg_condiva)
      THEN DO:
          DISPLAY Condicion_impos.descripcion
                  v-con_neto
                  v-con_iva
                  v-con_facturado
                  WITH FRAME a.
          DOWN WITH FRAME a.

          ASSIGN v-tot_neto      = v-tot_neto      + v-con_neto     
                 v-tot_iva       = v-tot_iva       + v-con_iva      
                 v-tot_facturado = v-tot_facturado + v-con_facturado
                 v-con_neto      = 0   
                 v-con_iva       = 0
                 v-con_facturado = 0.
      END.

            
  END.
   
  UNDERLINE Condicion_impos.descripcion
          v-con_neto
          v-con_iva
          v-con_facturado
          WITH FRAME a.
  DOWN WITH FRAME a.

  DISPLAY "TOTAL" @ Condicion_impos.descripcion
            v-tot_neto      @ v-con_neto
            v-tot_iva       @ v-con_iva
            v-tot_facturado @ v-con_facturado
          WITH FRAME a.
  DOWN WITH FRAME a.


  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

END PROCEDURE.

