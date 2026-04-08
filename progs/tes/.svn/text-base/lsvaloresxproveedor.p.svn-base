/*=================================================================================*/
/*                      F R A M E S   Y   P A R A M E T R O S                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER ver_por        AS INTEGER.
DEFINE INPUT PARAMETER des_codigo     LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo     LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_nombre     LIKE Proveedor.nombre.
DEFINE INPUT PARAMETER has_nombre     LIKE Proveedor.nombre.
DEFINE INPUT PARAMETER des_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER p-estados      AS CHARACTER.
DEFINE INPUT PARAMETER v-consolidado  AS LOGICAL.

DEFINE VARIABLE por_cod               AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom               AS INTEGER INITIAL 0.
DEFINE VARIABLE hubo_cheque           AS LOGICAL.
DEFINE VARIABLE estados_pedidos       AS CHARACTER LABEL "Estados" FORMAT "X(20)".
DEFINE VARIABLE tot_importes          AS DECIMAL.
DEFINE VARIABLE total                 AS DECIMAL.

{parlocales.i}
{dfvarimp.i}
{WGLISTAR.I}

DEFINE QUERY qry_proveedor FOR Proveedor.

DEFINE FRAME frm-titulo HEADER
      que_empresa
      "Valores por Proveedor y Fecha Acreditación" AT 52
      "Página:" AT 109 PAGE-NUMBER FORMAT ">9" AT 116
      SKIP  
      fecha_lis   
      "acredit. del" AT 52
      des_fecha
      "al" 
      has_fecha 
      hora_lis AT 109
      "Proveedors" AT 52
      des_codigo " - " 
      has_codigo
      SKIP(1)
      WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
      Proveedor.cdg_proveedor    COLUMN-LABEL "Código!Proveedor"
      Proveedor.nombre           COLUMN-LABEL "Razón!Social"
      Valor.cdg_empresa          COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
      Valor.estado               COLUMN-LABEL "Es-!tado"
      Valor.cdg_banco            COLUMN-LABEL "Código!Banco"
      Valor.numero_cheque        COLUMN-LABEL "Cheque!Número"
      Valor.cdg_caja             COLUMN-LABEL "Código!Caja"
      Valor.fecha_recepcion      COLUMN-LABEL "Fecha!Ingreso"
      Valor.fecha_emision        COLUMN-LABEL "Fecha!Emisión"
      Valor.dias_clearing        COLUMN-LABEL "Días!Clearing"
      Valor.fecha_acredita       COLUMN-LABEL "Fecha!Acredita"
      Valor.importe              COLUMN-LABEL "Importeo!Cheque" 
      Total                      COLUMN-LABEL "Importe!Acumulado"
      WITH WIDTH 160 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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

  estados_pedidos = p-estados.

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  {dirprinfile.i}
  
  tot_importes = 0.

  {OPQRYPRV.I}
                     
  GET FIRST qry_proveedor.
  DO WHILE AVAILABLE Proveedor:

     FOR EACH Valor NO-LOCK OF Proveedor 
         WHERE ( Valor.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
           AND CAN-DO (Usuario.lista_empresas,Valor.cdg_empresa)
           AND Valor.fecha_acredita  >= des_fecha 
           AND Valor.fecha_acredita  <= has_fecha
           AND CAN-DO(estados_pedidos,STRING(Valor.estado,"99"))
          BREAK BY Proveedor.cdg_proveedor BY Valor.fecha_acredita WITH FRAME frm-listado:
      
          VIEW FRAME frm-titulo.
          total = total + Valor.importe.
          DISPLAY Proveedor.cdg_proveedor    WHEN FIRST-OF(Proveedor.cdg_proveedor)
                  Proveedor.nombre         WHEN FIRST-OF(Proveedor.cdg_proveedor)
                  Valor.cdg_empresa
                  Valor.fecha_acredita  WHEN FIRST-OF(Valor.fecha_acredita)
                  Valor.estado       
                  Valor.cdg_banco    
                  Valor.numero_cheque   
                  Valor.cdg_caja     
                  Valor.fecha_recepcion
                  Valor.fecha_emision  
                  Valor.dias_clearing  
                  Valor.fecha_acredita 
                  Valor.importe 
                  Total
                  WITH FRAME frm-listado.

          tot_importes = tot_importes + Valor.importe.
          
          DOWN WITH FRAME frm-listado.
      
          IF LAST-OF(Proveedor.cdg_proveedor)
          THEN DO:
             UNDERLINE Valor.importe WITH FRAME frm-listado.
             DISPLAY tot_importes @ Valor.importe WITH FRAME frm-listado. 
             DOWN 2 WITH FRAME frm-listado. 
             tot_importes = 0.
          END.   
     END.      
     
     GET NEXT qry_proveedor.
  END.
     
  
  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre     
            Valor.cdg_empresa
            Valor.fecha_acredita
            Valor.estado       
            Valor.cdg_banco    
            Valor.numero_cheque   
            Valor.cdg_caja     
            Valor.fecha_recepcion
            Valor.fecha_emision  
            Valor.dias_clearing  
            Valor.fecha_acredita 
            Valor.importe 
            Total
            WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END.  


