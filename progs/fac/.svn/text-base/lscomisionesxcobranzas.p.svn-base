/*=================================================================================*/
/*                  LIQUIDACION DE COMISIONES POR COBRANZAS                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo        LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo        LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha         AS DATE.
DEFINE INPUT PARAMETER has_fecha         AS DATE.
DEFINE INPUT PARAMETER que_moneda        LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER gen_asiento       AS LOGICAL.
DEFINE INPUT PARAMETER fecha_contable    AS DATE.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE t-fam-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-fam-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE d-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE v-prc_cobranzas          AS DECIMAL FORMAT ">>9.9999" DECIMALS 4.
DEFINE VARIABLE v-minimo_cobranzas       AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-desde_importe          AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE signo                    AS DECIMAL.

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!Comprobante".
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Liquidación de Comisiones por Cobranzas" AT 38
  "Página:" AT 135 PAGE-NUMBER FORMAT "9999" AT 142
  SKIP  
  fecha_lis
  "del" AT 38
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 135
  SKIP (1) 
  tit_vendedor AT 38
  SKIP(1)
  "-------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha      Identificación   Código   Razón                                          Importe        Importe                                       " SKIP
  "Operación  del comprobante  Cliente  Social                                       Facturado        Cobrado                                       " SKIP
  "-------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-familia
    SPACE(35) "---   "
    Familia_articulo.cdg_familia
    Familia_articulo.dsc_familia
    "   ---"
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-listado
    Fac_header.fecha
    que_comprobante
    Cliente.cdg_cliente
    Cliente.nom_cliente
    Fac_header.imp_total
    SPACE(2)
    Rec_detalle.importe
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    Fac_detalle.subtotal_neto
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

  FOR EACH Rec_header 
      WHERE Rec_header.cdg_empresa = Empresa.cdg_empresa
        AND Rec_header.nro_moneda = Moneda.nro_moneda
        AND Rec_header.fecha <= has_fecha
        AND Rec_header.fecha >= des_fecha
        AND Rec_header.tip_comprob BEGINS "R" /* Solo recibos, excluímos débitos y créditos */
        AND NOT Rec_header.anulado,
        EACH Rec_detalle OF Rec_header 
             WHERE Rec_detalle.tip_cancela BEGINS "F", /* Solo las facturas aplicadas */
               FIRST Fac_header         
                     WHERE Fac_header.cdg_empresa = Rec_header.cdg_empresa
                       AND Fac_header.tip_comprob = Rec_detalle.tip_cancela
                       AND Fac_header.prf_comprob = Rec_detalle.prf_cancela
                       AND Fac_header.nro_comprob = Rec_detalle.nro_cancela,
                       FIRST Vendedor OF Fac_header,        
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
       
       IF FIRST-OF(Familia_articulo.cdg_familia)
       THEN DO:       
            DISPLAY Familia_articulo.cdg_familia
                    Familia_articulo.dsc_familia
                    WITH FRAME frm-familia.
          /*DOWN WITH FRAME frm-familia.*/
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
                    Rec_detalle.importe
                    WITH FRAME frm-listado.
          /*DOWN WITH FRAME frm-listado. */

       END.

       IF Rec_detalle.importe = Fac_header.imp_total 
          THEN d-cobrado = Fac_detalle.subtotal_neto.
          ELSE d-cobrado = ROUND(Fac_detalle.subtotal_neto * Rec_detalle.importe / Fac_header.imp_total , 2).
       t-fam-importe-cobrado = t-fam-importe-cobrado + d-cobrado.

       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               Fac_detalle.subtotal_neto
               d-cobrado
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.
       
       IF LAST-OF(Familia_articulo.cdg_familia)
       THEN DO:

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
                        v-minimo_cobranzas     = Vendedor_escala.minimo_cobranzas
                        v-prc_cobranzas        = Vendedor_escala.prc_cobranzas
                        v-desde_importe        = Vendedor_escala.desde_importe
                        t-fam-comision-cobrado = v-minimo_cobranzas + 
                                                 ROUND( ( t-fam-importe-cobrado - v-desde_importe ) * v-prc_cobranzas / 100,2).
            END.
            ELSE DO:
                 ASSIGN
                        v-minimo_cobranzas     = 0
                        v-prc_cobranzas        = 0
                        v-desde_importe        = 0
                        t-fam-comision-cobrado = ?.
            END.

            UNDERLINE
                d-cobrado
                WITH FRAME frm-detalle.
            DISPLAY
                "Total " + Familia_articulo.dsc_familia @ Articulo.descripcion
                t-fam-importe-cobrado @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Escala aplicada "  @ Articulo.descripcion
                v-desde_importe     @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Comisión Básica "  @ Articulo.descripcion
                v-minimo_cobranzas  @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Alícuota Aplicada "    @ Articulo.descripcion
                v-prc_cobranzas         @ d-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Comisión" @ Articulo.descripcion
                t-fam-comision-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.
            
            ASSIGN
                t-ven-importe-cobrado  = t-ven-importe-cobrado + t-fam-importe-cobrado
                t-ven-comision-cobrado = t-ven-comision-cobrado + t-fam-comision-cobrado 
                t-fam-importe-cobrado  = 0.

       END.        

       IF LAST-OF(Vendedor.cdg_vendedor)
       THEN DO:

            UNDERLINE
                d-cobrado
                WITH FRAME frm-detalle.
            DISPLAY
                "Total " + Vendedor.nombre @ Articulo.descripcion
                t-ven-importe-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.

            DISPLAY
                "Total Comisiones del vendedor" @ Articulo.descripcion
                t-ven-comision-cobrado @ d-cobrado
                WITH FRAME frm-detalle.

            DOWN WITH FRAME frm-detalle.
            
            ASSIGN

                t-gen-importe-cobrado  = t-gen-importe-cobrado + t-ven-importe-cobrado
                t-ven-importe-cobrado  = 0

                t-gen-comision-cobrado = t-gen-comision-cobrado + t-ven-comision-cobrado 
                t-ven-comision-cobrado = 0.

            PAGE.

       END.        

  END.   

  UNDERLINE
        d-cobrado
        WITH FRAME frm-detalle.
  DISPLAY
        "Total General" @ Articulo.descripcion
        t-gen-importe-cobrado @ d-cobrado
        WITH FRAME frm-detalle.
    
  DOWN WITH FRAME frm-detalle.
    
  DISPLAY
        "Total Comisiones en general" @ Articulo.descripcion
        t-gen-comision-cobrado        @ d-cobrado
        WITH FRAME frm-detalle.
    
  DOWN WITH FRAME frm-detalle.
    
  OUTPUT CLOSE.

END PROCEDURE.  

