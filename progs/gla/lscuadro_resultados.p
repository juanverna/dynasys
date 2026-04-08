/*=================================================================================*/
/*                   IMPRIME EL MAYOR PARA UN RANGO DE CUENTAS                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-cdg_cuadrores  LIKE Cuadro_resultados.cdg_cuadrores.
DEFINE INPUT PARAMETER p-que_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion    AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

DEFINE VARIABLE v-debitos_ccosto       LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_ccosto      LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_ccosto        LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE v-debitos_cuenta       LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_cuenta      LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_cuenta        LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE v-debitos_item         LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_item        LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_item          LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE v-debitos_cuadro       LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_cuadro      LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_cuadro        LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE v-falta_cuenta         AS LOGICAL.
DEFINE VARIABLE v-kcosto               AS INTEGER.

DEFINE VARIABLE tit_cuadro             AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE tit_moneda             AS CHARACTER FORMAT "X(35)".

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}
{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    tit_cuadro AT 45 
    "Página:" AT 102 PAGE-NUMBER FORMAT "ZZZ9" AT 109
    SKIP  
    fecha_lis   
    "Saldos al " AT 45
    p-que_fecha
    hora_lis AT 135
    SKIP
    tit_moneda AT 45
    SKIP(1)
    "----------------------------------------------------------------------------------------------------------------" SKIP
    "Código   Descripción                         Centro   Código             Total           Total           Saldo  " SKIP
    "Cuenta   Cuenta                              Costo    Obra             Débitos        Créditos           Final  " SKIP
    "----------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 160 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-item
    SPACE(44)
    Itemresultados.dsc_itemcuadro
    WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-movimiento
    Cuenta.cdg_cuenta
    Cuenta.nombre
    Entidad.cdg_entidad
    Obra.cdg_obra
    v-debitos_cuenta 
    v-creditos_cuenta 
    v-saldos_cuenta
    WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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

  FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
  IF p-reexpresion 
     THEN tit_moneda = "REEXPRESADO EN " + Moneda.descripcion.
     ELSE tit_moneda = "MONEDA ORIGINAL " + Moneda.descripcion.

  FIND Cuadro_resultados WHERE Cuadro_resultados.cdg_cuadrores = p-cdg_cuadrores NO-LOCK. 
  tit_cuadro = Cuadro_resultados.cdg_cuadrores.

  {dirprinfile.i}

  v-debitos_cuenta  = 0.
  v-creditos_cuenta = 0.
  v-saldos_cuenta   = 0.
  
  FOR EACH Cuadro_item OF Cuadro_resultados, 
      FIRST Itemresultados OF Cuadro_item,
            EACH Item-cuenta OF Itemresultados, FIRST Cuenta OF Item-cuenta
                 BREAK BY Itemresultados.cdg_itemcuadro
                       BY Cuenta.cdg_cuenta:

        VIEW FRAME frm-titulo.

        IF FIRST-OF(Itemresultados.cdg_itemcuadro)
        THEN DO:
             DISPLAY Itemresultados.dsc_itemcuadro 
                     WITH FRAME frm-item.
             DOWN 2 WITH FRAME frm-item.
        END.

        v-debitos_cuenta  = 0.
        v-creditos_cuenta = 0.
        v-saldos_cuenta   = 0.
        v-falta_cuenta    = YES.
        v-kcosto          = 0.

        OPEN QUERY q-saldos
            FOR EACH Saldos_x_cuenta OF Cuenta 
                 WHERE Saldos_x_cuenta.cdg_empresa = Empresa.cdg_empresa 
                   AND Saldos_x_cuenta.fch_saldo   = p-que_fecha
                   AND Saldos_x_cuenta.nro_moneda  = Moneda.nro_moneda
                   AND Saldos_x_cuenta.reexpresion = p-reexpresion, FIRST Entidad OF Saldos_x_cuenta ,
                   FIRST Obra OUTER-JOIN OF Saldos_x_cuenta.

        GET FIRST q-saldos.
        DO WHILE AVAILABLE Saldos_x_cuenta:

            v-kcosto = v-kcosto + 1.
           
            v-debitos_ccosto  = Saldos_x_cuenta.tot_debitos.
            v-creditos_ccosto = Saldos_x_cuenta.tot_creditos.
            v-saldos_ccosto   = Saldos_x_cuenta.saldo_total.
      
            DISPLAY Cuenta.cdg_cuenta     WHEN v-falta_cuenta
                    Cuenta.nombre_cta     WHEN v-falta_cuenta
                    Entidad.cdg_entidad 
                    Obra.cdg_obra         WHEN AVAILABLE Obra
                    v-debitos_ccosto  @ v-debitos_cuenta 
                    v-creditos_ccosto @ v-creditos_cuenta 
                    v-saldos_ccosto  @ v-saldos_cuenta
                    WITH FRAME frm-movimiento.
            DOWN WITH FRAME frm-movimiento.
                            
            v-debitos_item = v-debitos_item + v-debitos_cuenta.                
            v-creditos_item = v-creditos_item + v-creditos_cuenta.                
            v-falta_cuenta = NO.
                    
            GET NEXT q-saldos.
                
        END.
        
        IF LAST-OF(Itemresultados.cdg_itemcuadro)
        THEN DO:
     
             v-saldos_item = v-debitos_item  - v-creditos_item. 

             UNDERLINE 
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
            
             DISPLAY "Total " + Itemresultados.dsc_itemcuadro @ Cuenta.nombre_cta 
                     v-debitos_item  @ v-debitos_cuenta 
                     v-creditos_item @ v-creditos_cuenta 
                     v-saldos_item   @ v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
                     
             DOWN 2 WITH FRAME frm-movimiento.        
                     
             v-debitos_cuadro = v-debitos_cuadro + v-debitos_item.                
             v-creditos_cuadro = v-creditos_cuadro + v-creditos_item.                
   
             v-debitos_item  = 0.
             v-creditos_item = 0.

        END.
    
  END.
  
  v-saldos_cuadro = v-debitos_cuadro  - v-creditos_cuadro. 
    
  UNDERLINE 
            v-debitos_cuenta 
            v-creditos_cuenta 
            v-saldos_cuenta
            WITH STREAM-IO FRAME frm-movimiento.
       
  DISPLAY "TOTAL GENERAL"     @ Cuenta.nombre_cta 
            v-debitos_cuadro  @ v-debitos_cuenta 
            v-creditos_cuadro @ v-creditos_cuenta 
            v-saldos_cuadro   @ v-saldos_cuenta
            WITH STREAM-IO FRAME frm-movimiento.
            
  DOWN 2 WITH FRAME frm-movimiento.        
            
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
                   
END.  

