/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-has_cobrador     LIKE Cobrador.cdg_cobrador.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.
DEFINE INPUT PARAMETER p-mes_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-ano_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-fecha_emision    AS DATE.
DEFINE INPUT PARAMETER p-listar_grupos    AS LOGICAL.
DEFINE INPUT PARAMETER p-generar_cupones  AS LOGICAL.
DEFINE INPUT PARAMETER p-lista_tipos      AS CHARACTER.
DEFINE INPUT PARAMETER p-pto_venta        AS INTEGER.
DEFINE INPUT PARAMETER p-id_lote          AS CHARACTER.

DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL LABEL "Emitir".
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir factura".

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE VARIABLE pto_venta-org             LIKE Rec_header.prf_comprob.
DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE prox_docum                LIKE Parametro.cdg_parametro.

DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Detalle de Cupones por Cobrador" AT 37
       "Página:" AT 80 PAGE-NUMBER FORMAT ">>9" AT 88
       SKIP  
       fecha_lis       
       hora_lis AT 80
       SKIP
       titulo_det AT 37  
       SKIP(1)
       WITH WIDTH 135 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan
       Grupofam.cant_capitas
       v-tipo_compbte
       Plan-capita.precio_neto
       WITH WIDTH 135 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

FORM
       t-cupones LABEL "Total Cupones"  
       t-pesos   LABEL "Total Pesos"
       WITH WIDTH 135 DOWN FRAME frm-resumen USE-TEXT STREAM-IO SIDE-LABELS .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

{findempresa.i}

FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.

RUN carparam.p.

FIND Empresa WHERE Empresa.cdg_empresa = p-que_empresa NO-LOCK.
que_empresa = Empresa.nombre.

/*{DIRPRINFILE.I}*/

                              /* OJO!!!!!!!!!!!!!!!!!!!!!!!!*/

                                p-generar_cupones = NO.
                                
                              /*----------------------------*/  

OUTPUT TO VALUE("C:\SIC-TEMP\cuponessincargo.txt") PAGE-SIZE 84.

t-cupones = 0.
t-pesos   = 0.
a-cupones = 0.
a-pesos   = 0.
g-cupones = 0.
g-pesos   = 0.

FOR EACH Cobrador NO-LOCK
    WHERE Cobrador.cdg_cobrador >= p-des_cobrador
      AND Cobrador.cdg_cobrador <= p-has_cobrador 
          WITH FRAME frm-listado :

    VIEW FRAME frm-titulo.
    
    titulo_det = Cobrador.cdg_cobrador + " - " + Cobrador.nom_cobrador.

    FOR EACH Grupofam OF Cobrador 
        WHERE Grupofam.cdg_empresa  = p-que_empresa
          AND Grupofam.cdg_estado   = "A"
          AND (Grupofam.tipo_compbte = "R" 
               OR Grupofam.tipo_compbte = "F") 
          AND LOOKUP(Grupofam.tipo_grupo,p-lista_tipos,"|") <> 0
          AND Grupofam.fecha_alta   >= p-des_fecha
          AND Grupofam.fecha_alta   <= p-has_fecha
              NO-LOCK BREAK BY Grupofam.cdg_zona BY Grupofam.cdg_grupofam
              WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:
    
        v-tipo_compbte = Grupofam.tipo_compbte.
        IF Grupofam.tipo_compbte = "F" 
           THEN v-tipo_compbte = v-tipo_compbte + 
                    IF Grupofam.cdg_condiva = "C" THEN "B" ELSE "A".

        IF Grupofam.tipo_grupo = "G"
        THEN DO:
            FIND FIRST Plan-capita OF Grupofam  
                       WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                             NO-LOCK NO-ERROR.

            IF AVAILABLE Plan-capita
            THEN DO:
                 IF Plan-capita.precio_neto = 0 
                 THEN DO:
                      IF p-listar_grupos
                      THEN DO:
                            FIND FIRST Afiliado OF Grupofam /*WHERE Afiliado.titular NO-LOCK*/ NO-ERROR.
                            IF NOT AVAILABLE Afiliado THEN v-tipo_compbte = v-tipo_compbte + "+".
                            DISPLAY Grupofam.cdg_grupofam  
                                    Grupofam.nom_grupofam 
                                    Grupofam.cdg_plan
                                    Grupofam.cant_capitas
                                    Plan-capita.precio_neto
                                    v-tipo_compbte 
                                    WITH FRAME frm-listado.
                            DOWN WITH FRAME frm-listado.          
                      END.
                      g-cupones = g-cupones + 1.
                      g-pesos   = g-pesos + Plan-capita.precio_neto.
                 END.     
            END.
            ELSE DO:
                 RUN mostrar_error.
            END.                              
        END.        
        ELSE DO:
        
            IF Grupofam.importe_cuota = 0
            THEN DO:
                 IF p-listar_grupos
                 THEN DO:
                      FIND FIRST Afiliado OF Grupofam /*WHERE Afiliado.titular NO-LOCK*/ NO-ERROR.
                      IF NOT AVAILABLE Afiliado THEN v-tipo_compbte = v-tipo_compbte + "+".
                      DISPLAY Grupofam.cdg_grupofam  
                              Grupofam.nom_grupofam 
                              Grupofam.cant_capitas
                              Grupofam.importe_cuota @ Plan-capita.precio_neto
                              v-tipo_compbte 
                              WITH FRAME frm-listado.
                      DOWN WITH FRAME frm-listado.   
                 END.

                 a-pesos = a-pesos + Grupofam.importe_cuota.
                 /*c-cap = c-cap + Grupofam.cant_capitas .*/
                 a-cupones = a-cupones + 1.

            END.
        
        END.
    END.       
    
    UNDERLINE
          Grupofam.cdg_grupofam  
          Grupofam.nom_grupofam 
          Grupofam.cdg_plan
          Grupofam.cant_capitas
          Plan-capita.precio_neto
          v-tipo_compbte 
          WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.          
  
    DISPLAY "Total " + Cobrador.cdg_cobrador + " Grupos" 
                                      @ Grupofam.nom_grupofam
                            g-cupones @ Grupofam.cdg_plan
                              g-pesos @ Plan-capita.precio_neto
                              WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.          
    
    DISPLAY "          Areas" 
                      @ Grupofam.nom_grupofam
            a-cupones @ Grupofam.cdg_plan
            a-pesos @ Plan-capita.precio_neto
            WITH FRAME frm-listado.
    DOWN 2 WITH FRAME frm-listado.          

    t-pesos   = t-pesos + a-pesos + g-pesos.
    t-cupones = t-cupones + a-cupones + g-cupones.

    g-cupones = 0.
    g-pesos   = 0.
    a-cupones = 0.
    a-pesos   = 0.

/*    IF p-listar_grupos THEN PAGE.*/

END.

DISPLAY t-cupones
        t-pesos
        WITH FRAME frm-resumen.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cuponessincargo.txt",
                 INPUT 2 ).

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

PROCEDURE mostrar_error:

    PUT Grupofam.cdg_grupofam  " "
        Grupofam.nom_grupofam " "
        Grupofam.cdg_plan  " "
        Grupofam.cant_capitas SKIP. 

END PROCEDURE.

