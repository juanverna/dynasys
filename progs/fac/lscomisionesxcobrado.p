/*=================================================================================*/
/*                    LIQUIDACION DE COMISIONES POR VENTAS                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.cdg_moneda.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE t-fam-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-fam-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-ven-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-gen-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-fam-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-fam-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-ven-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-gen-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE i-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE d-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE d-vendido                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Facturado".
DEFINE VARIABLE v-prc_ventas             AS DECIMAL FORMAT ">>9.9999" DECIMALS 4.
DEFINE VARIABLE v-prc_cobranzas          AS DECIMAL FORMAT ">>9.9999" DECIMALS 4.
DEFINE VARIABLE v-minimo_ventas          AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-minimo_cobranzas       AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE signo                    AS DECIMAL.

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!Comprobante".
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Liquidación de Comisiones por Ventas" AT 40
  "Página:" AT 140 PAGE-NUMBER FORMAT "9999" AT 147
  SKIP  
  fecha_lis
  "del" AT 40
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 140
  SKIP (1) 
  tit_vendedor AT 40
  SKIP(1)
  "------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha      Identificación   Código   Razón                                           Importe        Importe  Observaciones                            " SKIP
  "Operación  del comprobante  Cliente  Social                                          Vendido        Cobrado  del movimiento                           " SKIP
  "------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-familia
    SPACE(35) "---   "
    Familia_articulo.cdg_familia
    Familia_articulo.dsc_familia
    "   ---"
    SKIP(1)
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-listado
    Fac_header.fecha
    que_comprobante
    Cliente.cdg_cliente
    Cliente.nom_cliente
    SPACE(2)
    Fac_header.imp_total
    i-cobrado
    Fac_header.leyenda_cc
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    d-vendido
    d-cobrado
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = "en " + Moneda.descripcion.
  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  FOR EACH Vendedor 
      WHERE Vendedor.cdg_vendedor <= has_codigo
        AND Vendedor.cdg_vendedor >= des_codigo,
        EACH Fac_header OF Vendedor 
             WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
               AND Fac_header.nro_moneda = Moneda.nro_moneda
               AND Fac_header.fecha <= has_fecha
               AND Fac_header.fecha >= des_fecha
               AND NOT Fac_header.anulado,
               EACH Fac_detalle OF Fac_header,
               FIRST Articulo OF Fac_detalle,
               FIRST Familia_articulo OF Articulo
               BREAK BY Vendedor.cdg_vendedor
                     BY Familia_articulo.cdg_familia
                     BY Fac_header.fecha
                     BY Fac_header.tip_comprob
                     BY Fac_header.prf_comprob
                     BY Fac_header.nro_comprob:

       tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre.
       VIEW FRAME frm-titulo.
       
       d-cobrado = 0.
       IF FIRST-OF(Fac_header.nro_comprob)
       THEN DO:
            i-cobrado = 0.
            FOR EACH Rec_detalle 
                WHERE Rec_detalle.cdg_emprecancela = Fac_header.cdg_empresa 
                  AND Rec_detalle.tip_cancela      = Fac_header.tip_comprob 
                  AND Rec_detalle.prf_cancela      = Fac_header.prf_comprob 
                  AND Rec_detalle.nro_cancela      = Fac_header.nro_comprob,
                  FIRST Rec_header OF Rec_detalle:
                  
                  IF Rec_header.tip_comprob BEGINS "R" THEN i-cobrado = i-cobrado + Rec_detalle.importe.
     
            END. 
            signo = IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0 THEN 1 ELSE -1. /* Cambiamos signo de NC */
       END.
         
       d-vendido   = Fac_detalle.subtotal_neto * signo.
       d-cobrado   = IF i-cobrado = Fac_header.imp_total 
                        THEN d-vendido 
                        ELSE ROUND(d-vendido * i-cobrado / Fac_header.imp_total, 2 ). 

       t-fam-importe-vendido = t-fam-importe-vendido + d-vendido.
       t-fam-importe-cobrado = t-fam-importe-cobrado + d-cobrado.

       IF FIRST-OF(Familia_articulo.cdg_familia)
       THEN DO:       
            DISPLAY Familia_articulo.cdg_familia
                    Familia_articulo.dsc_familia
                    WITH FRAME frm-familia.
            DOWN WITH FRAME frm-familia.
       END.


       IF FIRST-OF(Fac_header.nro_comprob)
       THEN DO:
            FIND Cliente OF Fac_header NO-LOCK.
            que_comprobante = Fac_header.tip_comprob + " " + 
                              STRING(Fac_header.prf_comprob,"9999") + " " +
                              STRING(Fac_header.nro_comprob,"99999999").
            DISPLAY Fac_header.fecha             WHEN FIRST-OF(Fac_header.fecha)
                    que_comprobante              
                    Cliente.cdg_cliente          
                    Cliente.nom_cliente          
                    Fac_header.imp_total
                    i-cobrado WHEN i-cobrado <> 0
                    Fac_header.leyenda_cc        
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.

       END.

       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               d-vendido
               d-cobrado WHEN d-cobrado <> 0
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.
       
       IF LAST-OF(Familia_articulo.cdg_familia)
       THEN DO:

            FIND FIRST Vendedor_escala OF Vendedor
                 WHERE Vendedor_escala.cdg_empresa    = Fac_header.cdg_empresa 
                   AND Vendedor_escala.nro_familia    = Familia_articulo.nro_familia
                   AND Vendedor_escala.desde_fecha    <= has_fecha
                   AND Vendedor_escala.hasta_fecha    >= des_fecha
                   AND Vendedor_escala.desde_importe  <= t-fam-importe-vendido
                   AND Vendedor_escala.hasta_importe  >= t-fam-importe-vendido
                       NO-LOCK NO-ERROR.
            
            IF AVAILABLE Vendedor_escala
            THEN DO:
                 ASSIGN
                        t-fam-comision-vendido = Vendedor_escala.minimo_ventas + 
                                                 ROUND( ( t-fam-importe-vendido - Vendedor_escala.minimo_ventas ) * Vendedor_escala.prc_ventas / 100,2)
                        v-prc_ventas           = Vendedor_escala.prc_ventas
                        v-minimo_ventas        = Vendedor_escala.minimo_ventas.
        
            END.
            ELSE DO:
                 ASSIGN
                        t-fam-comision-vendido = ?
                        v-prc_ventas           = 0
                        v-minimo_ventas        = 0.
        
            END.

            FIND FIRST Vendedor_escala OF Vendedor
                 WHERE Vendedor_escala.cdg_empresa    = Fac_header.cdg_empresa 
                   AND Vendedor_escala.nro_familia    = Familia_articulo.nro_familia
                   AND Vendedor_escala.desde_fecha    <= has_fecha
                   AND Vendedor_escala.hasta_fecha    >= des_fecha
                   AND Vendedor_escala.desde_importe  <= t-fam-importe-cobrado
                   AND Vendedor_escala.hasta_importe  >= t-fam-importe-cobrado
                       NO-LOCK NO-ERROR.
            
            IF AVAILABLE Vendedor_escala
            THEN DO:
                 ASSIGN
                        t-fam-comision-cobrado = Vendedor_escala.minimo_cobranzas +
                                                 ROUND( ( t-fam-importe-cobrado - Vendedor_escala.minimo_cobranzas ) * Vendedor_escala.prc_cobranzas / 100,2)
                        v-prc_cobranzas        = Vendedor_escala.prc_cobranzas
                        v-minimo_cobranzas     = Vendedor_escala.minimo_cobranzas.
        
            END.
            ELSE DO:
                 ASSIGN
                        t-fam-comision-cobrado = ?
                        v-prc_cobranzas        = 0
                        v-minimo_cobranzas     = 0.
        
            END.

            UNDERLINE
                d-vendido
                d-cobrado
                WITH FRAME frm-detalle.
            DISPLAY
                "Total " + Familia_articulo.dsc_familia @ Articulo.descripcion
                t-fam-importe-vendido @ d-vendido
                t-fam-importe-cobrado @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Minimos de la escala " @ Articulo.descripcion
                v-minimo_ventas         @ d-vendido
                v-minimo_cobranzas      @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Alícuotas Aplicadas "  @ Articulo.descripcion
                v-prc_ventas            @ d-vendido
                v-prc_cobranzas         @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Comisiones" @ Articulo.descripcion
                t-fam-comision-vendido @ d-vendido
                t-fam-comision-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.
            
            ASSIGN
                t-ven-importe-vendido  = t-ven-importe-vendido + t-fam-importe-vendido
                t-ven-importe-cobrado  = t-ven-importe-cobrado + t-fam-importe-cobrado
                t-ven-comision-vendido = t-ven-comision-vendido + t-fam-comision-vendido 
                t-ven-comision-cobrado = t-ven-comision-cobrado + t-fam-comision-cobrado
                t-fam-importe-vendido  = 0
                t-fam-importe-cobrado  = 0.

       END.        

       IF LAST-OF(Vendedor.cdg_vendedor)
       THEN DO:
            UNDERLINE
                d-vendido
                d-cobrado
                WITH FRAME frm-detalle.
            DISPLAY
                "Total " + Vendedor.nombre @ Articulo.descripcion
                t-ven-importe-vendido @ d-vendido
                t-ven-importe-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Total Comisiones del vendedor" @ Articulo.descripcion
                t-ven-comision-vendido @ d-vendido
                t-ven-comision-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.
            
            ASSIGN

                t-gen-importe-vendido = t-gen-importe-vendido + t-ven-importe-vendido
                t-gen-importe-cobrado = t-gen-importe-cobrado + t-ven-importe-cobrado
                t-ven-importe-vendido  = 0
                t-ven-importe-cobrado  = 0

                t-gen-comision-vendido = t-gen-comision-vendido + t-ven-comision-vendido 
                t-gen-comision-cobrado = t-gen-comision-cobrado + t-ven-comision-cobrado
                t-ven-comision-vendido = 0
                t-ven-comision-cobrado = 0.
            PAGE.

       END.        

  END.   

  UNDERLINE
        d-vendido
        d-cobrado
        WITH FRAME frm-detalle.
  DISPLAY
        "Total General" @ Articulo.descripcion
        t-gen-importe-vendido @ d-vendido
        t-gen-importe-cobrado @ d-cobrado
        WITH FRAME frm-detalle.
    
  DOWN WITH FRAME frm-detalle.
    
  DISPLAY
        "Total Comisiones en general" @ Articulo.descripcion
        t-gen-comision-vendido @ d-vendido
        t-gen-comision-cobrado @ d-cobrado
        WITH FRAME frm-detalle.
    
  DOWN WITH FRAME frm-detalle.
    
  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE hallar_comision:

    DEFINE INPUT PARAMETER   p-importe AS DECIMAL.
    DEFINE OUTPUT PARAMETER  p-minimio-ventas AS DECIMAL.
    DEFINE OUTPUT PARAMETER  p-prc-ventastasa    AS DECIMAL.

    FIND FIRST Vendedor_escala OF Vendedor
         WHERE Vendedor_escala.cdg_empresa    = Fac_header.cdg_empresa 
           AND Vendedor_escala.nro_familia    = Familia_articulo.nro_familia
           AND Vendedor_escala.desde_fecha    <= has_fecha
           AND Vendedor_escala.hasta_fecha    >= des_fecha
           AND Vendedor_escala.desde_importe  <= p-importe
           AND Vendedor_escala.hasta_importe  >= p-importe
               NO-LOCK NO-ERROR.
    
    IF AVAILABLE Vendedor_escala
    THEN DO:
         ASSIGN
                t-fam-comision-vendido = Vendedor_escala.minimo_ventas + 
                                         ROUND( ( t-fam-importe-vendido - Vendedor_escala.minimo_ventas ) * Vendedor_escala.prc_ventas / 100,2)
                t-fam-comision-cobrado = Vendedor_escala.minimo_cobranzas +
                                         ROUND( ( t-fam-importe-cobrado - Vendedor_escala.minimo_cobranzas ) * Vendedor_escala.prc_cobranzas / 100,2)
                v-prc_ventas           = Vendedor_escala.prc_ventas
                v-prc_cobranzas        = Vendedor_escala.prc_cobranzas
                v-minimo_ventas        = Vendedor_escala.minimo_ventas
                v-minimo_cobranzas     = Vendedor_escala.minimo_cobranzas.

    END.
    ELSE DO:
         ASSIGN
                t-fam-comision-vendido = ?
                t-fam-comision-cobrado = ?
                v-prc_ventas           = 0
                v-prc_cobranzas        = 0
                v-minimo_ventas        = 0
                v-minimo_cobranzas     = 0.

    END.

END PROCEDURE.
