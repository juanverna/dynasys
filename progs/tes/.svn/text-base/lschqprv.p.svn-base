/*=================================================================================*/
/*                      C H E Q U E S   P O R   P R O V E E D O R                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha LIKE Caj_header.fecha.

{RANPROCH.I}

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE hubo_cheque    AS LOGICAL.
DEFINE VARIABLE tot_importes AS DECIMAL.
DEFINE VARIABLE fecha_fr  AS CHARACTER.
DEFINE VARIABLE hora_fr   AS CHARACTER.

DEFINE VARIABLE lest      AS INTEGER.
DEFINE VARIABLE Total AS DECIMAL.


{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Cheques por Proveedor / f.acreditacion" AT 52
  "Pagina:" AT 109 PAGE-NUMBER FORMAT ">9" AT 116
  SKIP  
  fecha_lis   
  "acredit. del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 109
  "Proveedores" AT 52
  des_codigo " - " 
  has_codigo
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
       Proveedor.cdg_proveedor
       Proveedor.nombre format "X(35)"
       Cheque.estado       
       Cuenta_bancaria.cdg_banco
       Cheque.numero_cheque   
       Cheque.cdg_caja     
       Cheque.fecha_salida
       Cheque.fecha_emision  
       Cheque.dias_clearing  
       Cheque.fecha_acredita 
       Cheque.importe 
       Total
       WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Cheques".
nom_menu = "CAJA".

{SETIMPRE.I}

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

PROCEDURE LISTAR:

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i &LIN-PAG=72}
  /*
  OUTPUT TO VALUE(dire_tmp + "lschqprv.txt") PAGED.
  */
 
  tot_importes = 0.

  {OPQRYPRV.I}
                     
  GET FIRST qry_proveedor.
  DO WHILE AVAILABLE Proveedor:

     FOR EACH Cheque NO-LOCK OF Proveedor 
              WHERE fecha_acredita  >= des_fecha 
                AND fecha_acredita  <= has_fecha,
                    Cuenta_bancaria OF Cheque  
                    BREAK BY Proveedor.cdg_proveedor BY fecha_acredita 
                    WITH FRAME frm-listado:
      
          VIEW FRAME frm-titulo.
          Total=Total + cheque.importe.      
          DISPLAY Proveedor.cdg_proveedor    WHEN FIRST-OF(Proveedor.cdg_proveedor)
                  Proveedor.nombre           WHEN FIRST-OF(Proveedor.cdg_proveedor)
                  Cheque.fecha_acredita      WHEN FIRST-OF(Cheque.fecha_acredita)
                  Cheque.estado       
                  Cuenta_bancaria.cdg_banco    
                  Cheque.numero_cheque   
                  Cheque.cdg_caja     
                  Cheque.fecha_salida
                  Cheque.fecha_emision  
                  Cheque.dias_clearing  
                  Cheque.fecha_acredita 
                  Cheque.importe 
                  Total
                  WITH FRAME frm-listado.

          tot_importes = tot_importes + Cheque.importe.
          
          DOWN WITH FRAME frm-listado.
      
          IF LAST-OF(Proveedor.cdg_proveedor)
          THEN DO:
             UNDERLINE Cheque.importe WITH FRAME frm-listado.
             DISPLAY tot_importes @ Cheque.importe WITH FRAME frm-listado. 
             DOWN 2 WITH FRAME frm-listado. 
             tot_importes = 0.
          END.   
     END.      
     
     GET NEXT qry_proveedor.
  END.
     
  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre     
            Cheque.fecha_acredita
            Cheque.estado       
            Cuenta_bancaria.cdg_banco    
            Cheque.numero_cheque   
            Cheque.cdg_caja     
            Cheque.fecha_salida
            Cheque.fecha_emision  
            Cheque.dias_clearing  
            Cheque.fecha_acredita 
            Cheque.importe 
            Total
            WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END.  

{CODIMPRE.I}
