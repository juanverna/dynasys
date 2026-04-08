DEFINE INPUT PARAMETER que_certificado AS ROWID.
DEFINE VARIABLE txt AS CHARACTER FORMAT "X(300)".

{VPERSINM.I}

DEFINE FRAME frm-certificado
       txt VIEW-AS EDITOR SIZE 70 BY 7
       WITH /*WIDTH 96*/ USE-TEXT VIEW-AS DIALOG-BOX
            NO-LABEL FONT 8.
       
FIND FIRST Empresa.
FIND Certificado_gan WHERE ROWID(Certificado_gan) = que_certificado NO-LOCK.
FIND Proveedor      OF Certificado_gan NO-LOCK.
FIND Tipo_actividad OF Certificado_gan NO-LOCK.

txt =  Empresa.nombre +
       " Ingreso a efectuar segun Declaracion Jurada correspondiente a " +
       STRING(Certificado_gan.fecha_deposito) + "de pesos " + 
       STRING(Certificado_gan.imp_retenido,">,>>>,>>9.99") +
       " en concepto de Retencion por " + Tipo_actividad.nom_tipactiv +
       " de pesos " + STRING(Certificado_gan.imp_pagado,">,>>>,>>9.99") +
       " pagados a " + Proveedor.nombre + 
       " inscripto en el Impuesto a las ganancias bajo el nro.:" + Proveedor.cuit +
       " con domicilio en " + Proveedor.direccion.


DISPLAY txt
       WITH FRAME frm-certificado.

PAUSE.

