/*=================================================================================*/
/*                      C H E Q U E S   P O R   P R O V E E D O R                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Caj_header.fecha.

{RANPROCH.I}

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE hubo_cheque    AS LOGICAL.

DEFINE VARIABLE estados_pedidos  AS CHARACTER LABEL "Estados" FORMAT "X(20)".
DEFINE VARIABLE estados_posibles AS CHARACTER INITIAL "00,01,02,03,04".

DEFINE VARIABLE tot_importes AS DECIMAL.
DEFINE VARIABLE fecha_fr  AS CHARACTER.
DEFINE VARIABLE hora_fr   AS CHARACTER.

DEFINE VARIABLE lest      AS INTEGER.
DEFINE VARIABLE Total AS DECIMAL.


{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Valores por Proveedor / f.acreditacion" AT 52
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
       Valor.fecha_acredita 
       Valor.cdg_banco    
       Valor.numero_cheque   
       Valor.cdg_caja     
       Valor.fecha_salida
       Valor.fecha_recepcion
       Valor.fecha_emision  
       Valor.dias_clearing  
       Valor.importe 
       Total
       WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Valores".
nom_menu = "CAJA".

{SETIMPRE.I}

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  /*  
  OUTPUT TO VALUE(dire_tmp + "lsvalprv.txt") PAGED.
  */
  
  {dirprinfile.i}
 
  tot_importes = 0.

  {OPQRYPRV.I}
                     
  GET FIRST qry_Proveedor.
  DO WHILE AVAILABLE Proveedor:

     FOR EACH Valor NO-LOCK OF Proveedor 
              WHERE fecha_acredita  >= des_fecha 
                AND fecha_acredita  <= has_fecha
          BREAK BY Proveedor.cdg_Proveedor BY fecha_acredita WITH FRAME frm-listado:
      
          VIEW FRAME frm-titulo.
          Total=Total + valor.importe.
          DISPLAY Proveedor.cdg_Proveedor    WHEN FIRST-OF(Proveedor.cdg_Proveedor)
                  Proveedor.nombre           WHEN FIRST-OF(Proveedor.cdg_Proveedor)
                  Valor.fecha_acredita       WHEN FIRST-OF(Valor.fecha_acredita)
                  Valor.cdg_banco    
                  Valor.numero_cheque   
                  Valor.cdg_caja     
                  Valor.fecha_salida
                  Valor.fecha_recepcion
                  Valor.fecha_emision  
                  Valor.dias_clearing  
                  Valor.importe 
                  Total
                  WITH FRAME frm-listado.

          tot_importes = tot_importes + Valor.importe.
          
          DOWN WITH FRAME frm-listado.
      
          IF LAST-OF(Proveedor.cdg_Proveedor)
          THEN DO:
             UNDERLINE Valor.importe WITH FRAME frm-listado.
             DISPLAY tot_importes @ Valor.importe WITH FRAME frm-listado. 
             DOWN 2 WITH FRAME frm-listado. 
             tot_importes = 0.
          END.   
     END.      
     
     GET NEXT qry_Proveedor.
  END.
     
  
  UNDERLINE Proveedor.cdg_Proveedor
            Proveedor.nombre     
            Valor.fecha_acredita
            Valor.cdg_banco    
            Valor.numero_cheque   
            Valor.cdg_caja     
            Valor.fecha_salida
            Valor.fecha_recepcion
            Valor.fecha_emision  
            Valor.dias_clearing  
            Valor.importe 
            Total
            WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

{CODIMPRE.I}
