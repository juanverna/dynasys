/*=================================================================================*/
/*              LISTADO DE VALORES X ALGUN CAMPO EN PARTICULAR                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER p-estados      AS CHARACTER.
DEFINE INPUT PARAMETER v-consolidado  AS LOGICAL.

/*=================================================================================*/
/*                      F R A M E S   Y   V A R I A B L E S                        */
/*=================================================================================*/

{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE hubo_cheque           AS LOGICAL.
DEFINE VARIABLE estados_pedidos       AS CHARACTER LABEL "Estados" FORMAT "X(25)".
DEFINE VARIABLE total                 LIKE Cheque.importe.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
        que_empresa 
        "{&TITULO-LS}" AT 65
        "Página:" AT 153 PAGE-NUMBER FORMAT ">9" AT 160
        SKIP  
        fecha_lis   
        "del" AT 65
        des_fecha
        "al" 
        has_fecha 
        hora_lis AT 160
        SKIP
        "Estados solicitados:" AT 65
        estados_pedidos
        SKIP(1)
        WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
        {&CORTE-FR}
        Cuenta_bancaria.cdg_empresa       COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
        {&CAMPOS-FR}
        total                   COLUMN-LABEL "Importe!Acumulado"
        Proveedor.cdg_proveedor     COLUMN-LABEL "Código!Proveedor"
        Proveedor.nombre        COLUMN-LABEL "Razón!Social"
        WITH WIDTH 180 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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

  {dirprinfile.i} 

  hubo_cheque = NO.
  FOR EACH  Cheque NO-LOCK
      WHERE {&CORTE-POR}  >= des_fecha 
        AND {&CORTE-POR}  <= has_fecha,
        FIRST Cuenta_bancaria OF Cheque
          WHERE (Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
          AND CAN-DO (Usuario.lista_empresas,Cuenta_bancaria.cdg_empresa)
      BREAK BY {&CORTE-POR}
      WITH FRAME frm-listado:
      
      VIEW FRAME frm-titulo.
      
      IF CAN-DO(estados_pedidos,STRING(Cheque.estado,"99"))
      THEN DO:
         FIND Proveedor OF Cheque NO-LOCK NO-ERROR.   
         IF Cheque.estado <> "A" THEN total = total + Cheque.importe.
         DISPLAY {&CORTE-POR}  /*WHEN FIRST-OF( {&CORTE-POR} ) OR NOT hubo_cheque*/
                 Cuenta_bancaria.cdg_empresa
                 {&CAMPOS-LS} 
                 total  WHEN Cheque.estado <> "A"
                 Proveedor.cdg_proveedor          WHEN AVAILABLE Proveedor
                 Proveedor.nombre          WHEN AVAILABLE Proveedor
                 WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
         hubo_cheque = YES.
      END.
            
  END.
  
  UNDERLINE   {&CORTE-POR}
              Cuenta_bancaria.cdg_empresa
              {&CAMPOS-LS} 
              total
              Proveedor.cdg_proveedor
              Proveedor.nombre       
              WITH FRAME frm-listado STREAM-IO.  

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
     
END PROCEDURE. 
