/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER que_empresa  LIKE Empresa.cdg_empresa.
DEFINE INPUT PARAMETER des_cobrador LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_cobrador LIKE Cobrador.cdg_cobrador.

{vrshared.i "NEW"}

DEFINE VARIABLE c         AS DECIMAL FORMAT ">>>,>>9.99".
DEFINE VARIABLE c-cap     AS INTEGER FORMAT ">>>,>>9".
DEFINE VARIABLE c-n       AS INTEGER FORMAT ">>>,>>9".

DEFINE VARIABLE t         AS DECIMAL FORMAT ">>>,>>9.99".
DEFINE VARIABLE t-cap     AS INTEGER FORMAT ">>>,>>9".
DEFINE VARIABLE t-n       AS INTEGER FORMAT ">>>,>>9".

DEFINE VARIABLE chr_error AS CHARACTER INITIAL "SIN PLAN".


DEFINE BUFFER B-Fac_detalle FOR Fac_detalle.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Prefacturacion" AT 27
  "Pagina:" AT 88 PAGE-NUMBER FORMAT ">>9" AT 96
  SKIP  /*
  fecha_lis
  "Importes en" AT 27
  desc_moneda NO-LABEL  
  hora_lis AT 68 */
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


FORM
    Grupofam.cdg_cobrador
    Grupofam.cdg_grupofam 
    Grupofam.cdg_plan 
    Grupofam.nom_grupofam
    Grupofam.cant_capitas 
    Plan-capita.precio_neto 
    chr_error
    WITH FRAME frm-facturacion STREAM-IO FONT 2 USE-TEXT WIDTH 132 DOWN.



/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

OUTPUT TO "d:\desa\sic\r3.0\pruebafac.txt" PAGE-SIZE 66.

FOR EACH Grupofam 
    WHERE Grupofam.cdg_empresa = que_empresa
      AND Grupofam.cdg_estado = "A"
/*      AND Grupofam.tipo_compbte = "R"*/
      AND Grupofam.tipo_grupo = "G"
      AND Grupofam.cdg_cobrador >= des_cobrador
      AND Grupofam.cdg_cobrador <= has_cobrador
          EXCLUSIVE-LOCK BREAK BY Grupofam.cdg_cobrador BY Grupofam.cdg_zona BY Grupofam.cdg_grupofam:

    VIEW FRAME frm-titulo.

    FIND FIRST Plan-capita OF Grupofam  
               WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                     NO-LOCK NO-ERROR.
    DISPLAY Grupofam.cdg_cobrador WHEN FIRST-OF(Grupofam.cdg_cobrador)
            Grupofam.cdg_grupofam 
            Grupofam.cdg_plan 
            Grupofam.nom_grupofam
            Grupofam.cant_capitas 
            Plan-capita.precio_neto WHEN AVAILABLE Plan-capita
            chr_error WHEN NOT AVAILABLE Plan-capita
            WITH FRAME frm-facturacion.

    DOWN WITH FRAME frm-facturacion.        

    IF AVAILABLE Plan-capita 
       THEN c = c + Plan-capita.precio_neto.
    c-cap = c-cap + Grupofam.cant_capitas .
    c-n = c-n + 1.
    
    IF LAST-OF(Grupofam.cdg_cobrador)
    THEN DO:

         UNDERLINE 
                Grupofam.cdg_cobrador WHEN FIRST-OF(Grupofam.cdg_cobrador)
                Grupofam.cdg_grupofam 
                Grupofam.cdg_plan 
                Grupofam.nom_grupofam
                Grupofam.cant_capitas 
                Plan-capita.precio_neto WHEN AVAILABLE Plan-capita
                chr_error WHEN NOT AVAILABLE Plan-capita
                WITH FRAME frm-facturacion.

         DOWN WITH FRAME frm-facturacion.        
         DISPLAY c-n   @ Grupofam.cdg_plan
                 c-cap @ Grupofam.cant_capitas 
                 c @ Plan-capita.precio_neto
                 WITH FRAME frm-facturacion.
         DOWN 2  WITH FRAME frm-facturacion.        
      
         t = t + c.
         t-cap = t-cap + c-cap.
         t-n = t-n + c-n.
         
         c = 0.
         c-cap = 0.
         c-n = 0. 
    END.
  
  
END.       

UNDERLINE 
       Grupofam.cdg_cobrador 
       Grupofam.cdg_grupofam 
       Grupofam.cdg_plan 
       Grupofam.nom_grupofam
       Grupofam.cant_capitas 
       Plan-capita.precio_neto
       chr_error
       WITH FRAME frm-facturacion.

DOWN WITH FRAME frm-facturacion.        
DISPLAY t-n   @ Grupofam.cdg_plan
        t-cap @ Grupofam.cant_capitas 
        t     @ Plan-capita.precio_neto
        WITH FRAME frm-facturacion.
DOWN 2  WITH FRAME frm-facturacion.        
 

/*
    CASE Grupofam.tipo:

        WHEN "A" 
        THEN DO:
             prox_docum = "PFA".
             v-tip_comprob = "FA".
        END.     

        WHEN "B" 
        THEN DO:
             prox_docum = "PFB".
             v-tip_comprob = "FB".
        END.     

        WHEN "R"
        THEN DO:
             prox_docum = "PFC".
             v-tip_comprob = "FC".
        END.     

    END CASE.
*/
