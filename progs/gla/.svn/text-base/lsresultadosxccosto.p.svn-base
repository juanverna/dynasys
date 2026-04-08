/*=================================================================================*/
/*           IMPRIME UN CUADRO DE RESULTADOS DADO POR CENTRO DE COSTO              */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-cdg_cuadrores  LIKE Cuadro_resultados.cdg_cuadrores.
DEFINE INPUT PARAMETER p-que_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion    AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
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

{vrshared.i}
{wglistar.i}
{dfvarimp.i}

/*=================================================================================*/
/*                                 FRAMES                                          */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
    que_empresa
    tit_cuadro AT 46 
    "Página:" AT 96 PAGE-NUMBER FORMAT "ZZZ9" AT 103
    SKIP  
    fecha_lis   
    "Saldos al " AT 46
    p-que_fecha
    hora_lis AT 96
    SKIP
    tit_moneda AT 46
    SKIP(1)
    "----------------------------------------------------------------------------------------------------------" SKIP
    "Código   Descripción                         Centro                Total           Total           Saldo  " SKIP
    "Cuenta   Cuenta                              Costo               Débitos        Créditos           Final  " SKIP
    "----------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 160 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-item
    SPACE(45)
    Itemresultados.dsc_itemcuadro
    WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-movimiento
    Cuenta.cdg_cuenta
    Cuenta.nombre
    Entidad.cdg_entidad FORMAT "X(11)"
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

        FOR EACH Entidad WHERE CAN-DO(Entidad.lista_empresas,Empresa.cdg_empresa):
        
            v-debitos_ccosto  = 0.
            v-creditos_ccosto = 0.
            v-saldos_ccosto   = 0.

            FIND LAST Saldos_x_cuenta OF Cuenta 
                WHERE Saldos_x_cuenta.cdg_empresa = Empresa.cdg_empresa 
                  AND Saldos_x_cuenta.nro_entidad = Entidad.nro_entidad
                  AND Saldos_x_cuenta.nro_obra    = 0
                  AND Saldos_x_cuenta.fch_saldo  <= p-que_fecha
                  AND Saldos_x_cuenta.nro_moneda  = Moneda.nro_moneda
                  AND Saldos_x_cuenta.reexpresion = p-reexpresion
                      NO-LOCK NO-ERROR.

            IF AVAILABLE Saldos_x_cuenta
            THEN DO:
   
                v-debitos_ccosto  = v-debitos_ccosto +  Saldos_x_cuenta.tot_debitos.
                v-creditos_ccosto = v-creditos_ccosto + Saldos_x_cuenta.tot_creditos.
                v-saldos_ccosto   = v-saldos_ccosto + Saldos_x_cuenta.saldo_total.
                
            END.

            FOR EACH Obra WHERE CAN-DO(Obra.lista_empresas,Empresa.cdg_empresa):

                FIND LAST Saldos_x_cuenta OF Cuenta 
                    WHERE Saldos_x_cuenta.cdg_empresa = Empresa.cdg_empresa 
                      AND Saldos_x_cuenta.nro_entidad = Entidad.nro_entidad
                      AND Saldos_x_cuenta.nro_obra    = Obra.nro_obra
                      AND Saldos_x_cuenta.fch_saldo  <= p-que_fecha
                      AND Saldos_x_cuenta.nro_moneda  = Moneda.nro_moneda
                      AND Saldos_x_cuenta.reexpresion = p-reexpresion
                          NO-LOCK NO-ERROR.
        
                IF AVAILABLE Saldos_x_cuenta
                THEN DO:
       
                    v-debitos_ccosto  = v-debitos_ccosto +  Saldos_x_cuenta.tot_debitos.
                    v-creditos_ccosto = v-creditos_ccosto + Saldos_x_cuenta.tot_creditos.
                    v-saldos_ccosto   = v-saldos_ccosto + Saldos_x_cuenta.saldo_total.
                    
                END.
                
            END.       
              
            IF v-debitos_ccosto <> 0 
               OR v-creditos_ccosto <> 0
            THEN DO:
                DISPLAY Cuenta.cdg_cuenta     WHEN v-falta_cuenta
                        Cuenta.nombre_cta     WHEN v-falta_cuenta
                        Entidad.cdg_entidad 
                        v-debitos_ccosto  @ v-debitos_cuenta 
                        v-creditos_ccosto @ v-creditos_cuenta 
                        v-saldos_ccosto   @ v-saldos_cuenta
                        WITH FRAME frm-movimiento.
                DOWN WITH FRAME frm-movimiento.
                                
                v-debitos_cuenta = v-debitos_cuenta + v-debitos_ccosto.                
                v-creditos_cuenta = v-creditos_cuenta + v-creditos_ccosto.                
                v-falta_cuenta = NO.
                        
                v-kcosto = v-kcosto + 1.
            END.
        
        END.

        IF v-kcosto > 0
        THEN DO:
     
             v-saldos_cuenta = v-debitos_cuenta  - v-creditos_cuenta. 

             UNDERLINE 
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
            
             DISPLAY v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
                     
             DOWN 2 WITH FRAME frm-movimiento.        

        END.
        ELSE DO:
         
             DISPLAY Cuenta.cdg_cuenta     
                     Cuenta.nombre_cta     
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH FRAME frm-movimiento.
             UNDERLINE 
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
            
             DISPLAY v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
                    
             DOWN 2 WITH FRAME frm-movimiento.        
    
        END.

        v-debitos_item = v-debitos_item + v-debitos_cuenta.                
        v-creditos_item = v-creditos_item + v-creditos_cuenta.                
        
        IF LAST-OF(Itemresultados.cdg_itemcuadro)
        THEN DO:
     
             v-saldos_item = v-debitos_item  - v-creditos_item. 

             UNDERLINE 
                     Cuenta.cdg_cuenta  
                     Cuenta.nombre_cta  
                     Entidad.cdg_entidad 
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.
            
             DISPLAY "Total " + Itemresultados.dsc_itemcuadro @ Cuenta.nombre_cta 
                     v-debitos_item  @ v-debitos_cuenta 
                     v-creditos_item @ v-creditos_cuenta 
                     v-saldos_item   @ v-saldos_cuenta
                     WITH STREAM-IO FRAME frm-movimiento.

             UNDERLINE 
                     Cuenta.cdg_cuenta  
                     Cuenta.nombre_cta  
                     Entidad.cdg_entidad 
                     v-debitos_cuenta 
                     v-creditos_cuenta 
                     v-saldos_cuenta
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
            Cuenta.cdg_cuenta  
            Cuenta.nombre_cta  
            Entidad.cdg_entidad 
            v-debitos_cuenta 
            v-creditos_cuenta 
            v-saldos_cuenta
            WITH STREAM-IO FRAME frm-movimiento.
       
  DISPLAY "TOTAL GENERAL"     @ Cuenta.nombre_cta 
            v-debitos_cuadro  @ v-debitos_cuenta 
            v-creditos_cuadro @ v-creditos_cuenta 
            v-saldos_cuadro   @ v-saldos_cuenta
            WITH STREAM-IO FRAME frm-movimiento.
            
  UNDERLINE 
            Cuenta.cdg_cuenta  
            Cuenta.nombre_cta  
            Entidad.cdg_entidad 
            v-debitos_cuenta 
            v-creditos_cuenta 
            v-saldos_cuenta
            WITH STREAM-IO FRAME frm-movimiento.

  DOWN 2 WITH FRAME frm-movimiento.        
            
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
                   
END.  

