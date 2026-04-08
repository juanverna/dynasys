DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  AS ROWID.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

DEFINE VARIABLE chr_des_fecha AS CHARACTER.
DEFINE VARIABLE chr_has_fecha AS CHARACTER.


DEFINE VARIABLE Total AS DECIMAL.
DEFINE VARIABLE Fechadesde AS DATE.
DEFINE VARIABLE Fecha_emi  AS DATE.
DEFINE VARIABLE Fechahasta AS DATE.
DEFINE VARIABLE Vendedor LIKE Vendedor.cdg_vendedor.
DEFINE VARIABLE Nombre-vendedor AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE espacios        AS CHARACTER FORMAT "X(29)".
DEFINE VARIABLE Impor AS DECIMAL.


{WGLISTAR.I}

DEFINE FRAME frm-cabecera HEADER
  que_empresa 
  SKIP
  "Listado de cobranza" AT 41
  SKIP
  "Desde el "
  fechadesde
  "Hasta el " 
  fechahasta
  skip
  "Vendedor:"
  vendedor
  " - "  Nombre-vendedor
  SKIP(1)
WITH WIDTH 100 FRAME frm-cabecera TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    rec_header.fecha label "Fecha"
    rec_header.tip_comprob label "Tipo"
    rec_header.nro_comprob label "Numero"
    cliente.cdg_cliente label "Cod.Cliente"
    cliente.nom_cliente FORMAT "X(24)" label "Razon Social"
    rec_header.imp_total label "Total"
WITH WIDTH 100 DOWN CENTERED FRAME frm-listado  USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detlistado
    espacios 
    fecha_emi  LABEL "Comprobantes"  
    rec_detalle.tip_cancela NO-LABEL 
    rec_detalle.prf_cancela  FORMAT 9999  NO-LABEL 
    rec_detalle.nro_cancela  NO-LABEL 
    rec_detalle.importe      NO-LABEL 
WITH WIDTH 100 DOWN CENTERED FRAME frm-detlistado USE-TEXT STREAM-IO NO-LABEL.


RUN rbfecha.p ( INPUT des_fecha, OUTPUT chr_des_fecha ).
RUN rbfecha.p ( INPUT has_fecha, OUTPUT chr_has_fecha ).
FIND Moneda WHERE ROWID(Moneda) = que_moneda NO-LOCK.
FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

do with frame frm-listado:
    {SETIMPRE.I}
    PAUSE 0.
    mensaje = "    Procesando ...".        
    DISPLAY mensaje WITH FRAME frm-espere.
    OUTPUT TO VALUE (dire_tmp + "lscobro.txt") PAGED PAGE-SIZE 72.
    
    fechadesde=des_fecha.
    fechahasta=has_fecha.
    Vendedor=des_codigo.
    
    find first vendedor where vendedor.cdg_vendedor = Vendedor.
    nombre-vendedor = vendedor.nombre.
    view frame frm-cabecera.
    
    
    for each cliente of vendedor BREAK BY cliente.cdg_cliente:
        FOR EACH rec_header of cliente:
           IF rec_header.fecha >= fechadesde
              and   rec_header.fecha <= fechahasta
              and   anulado = NO
              and   (tip_comprob = "RA" or tip_comprob = "RB")
              and   rec_header.imp_total > 0 
              THEN DO:              
                    display rec_header.fecha rec_header.tip_comprob rec_header.nro_comprob cliente.cdg_cliente cliente.nom_cliente format "x(24)" rec_header.imp_total with frame frm-listado.
                    down with frame frm-listado.
                    for each rec_detalle of rec_header: 
                        impor = rec_detalle.importe - rec_detalle.descuento.
                        FOR EACH cta_cte WHERE rec_detalle.nro_cancela = cta_cte.nro_comprob
                                           AND rec_detalle.prf_cancela = cta_cte.prf_comprob
                                           AND rec_detalle.tip_cancela = cta_cte.tip_comprob
                                           AND Cta_cte.cdg_empresa = Empresa.cdg_empresa:
                                                  fecha_emi = cta_cte.fecha_emision.
                        END.
                        display 
                             espacios
                             fecha_emi
                             rec_detalle.tip_cancela
                             rec_detalle.prf_cancela
                             rec_detalle.nro_cancela
                             impor @ rec_detalle.importe with frame frm-detlistado.
                             down with frame frm-detlistado.
                    end.
                    Total=Total + rec_header.imp_total.
              END.
        END.
    end.
    down with frame frm-listado.
    underline  rec_header.imp_total.
    down with frame frm-listado.
    display total @ rec_header.imp_total.
    
end.
output close.
