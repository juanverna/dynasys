DEFINE INPUT PARAMETER que_certificado AS ROWID.                                 

{VRSHARED.I}
{VPERSINM.I}
{NOMMESES.I}

DEFINE VARIABLE que_mes       AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano       AS CHARACTER FORMAT "X(4)". 
DEFINE VARIABLE tot_neto      AS DECIMAL.
DEFINE VARIABLE tot_reten_iva AS DECIMAL.
DEFINE VARIABLE tot_iva       AS DECIMAL.
/* DEFINE VARIABLE f-titulo AS CHARACTER FORMAT "X(75)". */

FORM 
    "-----------------------------------------------------------------------------------------" SKIP(1)
    Empresa.nombre SKIP(1)
    "C.U.I.T.:" Empresa.cuit "                                   COMPROBANTE N§:" 
     Certificado_iva.nro_certifiva FORMAT "999,999"  AT 80                  SKIP
    "Inscripto Registro de Exportadores,"                                   SKIP
    "RG. 2667  Art. 12                                                "     SKIP(3)
    "                          Comprobante de Impuesto Ingresado - IVA"     SKIP(3)
    SPACE(20) Tipo_retiva.nom_retiva SKIP(4)
    "-----------------------------------------------------------------------------------------" SKIP(2)
    "Apellido y Nombre/Razón Social...: " Proveedor.nombre                                      SKIP
    "Domicilio........................: " Domicilio_prv.direccion                               SKIP
    "Localidad........................: " Domicilio_prv.localidad                               SKIP
    "Provincia........................: " Provincia.nombre "(" Domicilio_prv.cdg_postal ")"     SKIP
    "Nro. Inscripción CUIT/IVA........: " Proveedor.cuit                    SKIP (2)
    "-----------------------------------------------------------------------------------------" SKIP
    "                --- Importes expresados en Pesos ---"         SKIP(2)
    "  DOCUMENTO                NETO           IVA      RETENIDO"                             
  
  WITH FRAME frm-encabezado USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

FORM        
    Cert_iva-detalle.tip_comprob
    Cert_iva-detalle.prf_comprob
    Cert_iva-detalle.nro_comprob
    Cta_cte_prv.imp_neto
    Cta_cte_prv.imp_iva     
    Cert_iva-detalle.imp_retenido
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS. 

FORM 
   "    Consideramos que " Proveedor.nombre  "  se encuentra comprendido"
   SKIP(1)
   "    en el régimen especial previsto por la presente resolución  por"
   SKIP(1)
   "    no haberse recibido notificación en contrario."
   SKIP(5)
   "                                   " Empresa.nombre
   SKIP(3)
   "                                       Carlos Morini"
   SKIP
   "                                           Tesorero"
  WITH FRAME frm-pie USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

FIND Certificado_iva WHERE ROWID(Certificado_iva) = que_certificado EXCLUSIVE-LOCK.
FIND Empresa             OF Certificado_iva NO-LOCK.
FIND Proveedor           OF Certificado_iva NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor       NO-LOCK.
FIND Provincia           OF Domicilio_prv   NO-LOCK.
FIND Tipo_retiva         OF Certificado_iva NO-LOCK.
FIND Opg_header      WHERE Opg_header.nro_transaccion = Certificado_iva.nro_transaccion NO-LOCK.

que_mes = nom_mes [ MONTH(Certificado_iva.fecha_deposito) ].
que_ano = STRING(YEAR(Certificado_iva.fecha_deposito),"9999").

/*=================================================================================*/
/*                               EMISION                                           */
/*=================================================================================*/


OUTPUT TO VALUE(dire_tmp + "prctfiva.txt") PAGE-SIZE 72.


/*---------------------------------------------------------------------------------------*/
/*                                ENCABEZADO                                             */
/*---------------------------------------------------------------------------------------*/

   DISPLAY 
       /* que_mes que_ano  */
        Certificado_iva.nro_certifiva
        Tipo_retiva.nom_retiva
        Proveedor.nombre
        Proveedor.cuit
        Domicilio_prv.direccion
        Domicilio_prv.localidad 
        Domicilio_prv.cdg_postal
        Provincia.nombre
        Empresa.nombre
        Empresa.cuit
        WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------------*/
/*                                DETALLE                                                */
/*---------------------------------------------------------------------------------------*/

Tot_neto      = 0.
Tot_iva       = 0.                                           
Tot_reten_iva = 0.   

FOR EACH  Cert_iva-detalle OF Certificado_iva:

    DISPLAY
         Cert_iva-detalle.tip_comprob
         Cert_iva-detalle.prf_comprob
         Cert_iva-detalle.nro_comprob
         Cert_iva-detalle.imp_retenido 
         WITH FRAME frm-detalle.
    DOWN WITH FRAME frm-detalle.     
/*
    Tot_neto      = Tot_neto + Cta_cte_prv.imp_neto.
    Tot_iva       = Tot_iva  + Cta_cte_prv.imp_iva.                                           
    Tot_reten_iva = tot_reten_iva + Cert_iva-detalle.imp_retenido.   
*/

END.                                                                        
        
UNDERLINE
         Cta_cte_prv.imp_neto
         Cta_cte_prv.imp_iva
         Cert_iva-detalle.imp_retenido 
         WITH FRAME frm-detalle.
        
DISPLAY Certificado_iva.imp_pagado   @ Cta_cte_prv.imp_neto
        Certificado_iva.imp_retenido @ Cert_iva-detalle.imp_retenido 
        Tot_iva       @ Cta_cte_prv.imp_iva
        WITH FRAME Frm-detalle.



/*---------------------------------------------------------------------------------------*/
/*                                PIE DEL COMPROBANTE                                    */
/*---------------------------------------------------------------------------------------*/

   DISPLAY 
        Proveedor.nombre
        WITH FRAME frm-pie.

OUTPUT CLOSE.
RUN veresult.w ( INPUT dire_tmp + "prctfiva.txt", INPUT 8).

Certificado_iva.emitido = YES.

