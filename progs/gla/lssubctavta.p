/*=================================================================================*/
/*                MOVIMIENTOS DE SUBDIARIO ClienteES POR CUENTA                    */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta   LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta   LIKE Cuenta.cdg_cuenta.

/*=================================================================================*/
/*                                 VARIABLES Y FRAMES                              */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i }

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE chr_cuenta   AS CHARACTER FORMAT "X(50)".

DEFINE VARIABLE v-debito         LIKE Asn_detalle.debito.
DEFINE VARIABLE v-credito        LIKE Asn_detalle.credito.
DEFINE VARIABLE v-saldo          LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Comprobante".

DEFINE STREAM Exportacion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  SKIP
  que_empresa
  "Movimientos de Subdiario por Cuenta" AT 52 
  "Página:" AT 132 PAGE-NUMBER FORMAT "ZZZ9" AT 139
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 132
  SKIP(1)
  chr_cuenta AT 52
  SKIP(1)
  WITH WIDTH 160 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
    Sub_header_vta.fecha       COLUMN-LABEL "Fecha!Movimto."
    que_comprobante     COLUMN-LABEL "Identificación!del Comprobante"
    Entidad.cdg_entidad COLUMN-LABEL "Código!Entidad"
    Obra.cdg_obra       COLUMN-LABEL "Código!Obra"
    Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
    Sub_header_vta.nombre COLUMN-LABEL "Razón!Social"
    v-debito COLUMN-LABEL "Importe!Débito"
    v-credito COLUMN-LABEL "Importe!Crédito"
    v-saldo COLUMN-LABEL "Importe!Saldo"
    WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE LISTAR:

  fecha_lis = STRING(TODAY).
  hora_lis = STRING(TIME,"HH:MM:SS").

 {dirprinfile.i} 

 OUTPUT STREAM Exportacion TO VALUE(REPLACE(arch_salida,"txt","csv")).

 FOR EACH Sub_detalle_vta, 
      FIRST Cuenta OF Sub_detalle_vta 
         WHERE Cuenta.cdg_cuenta <= has_cuenta
           AND Cuenta.cdg_cuenta >= des_cuenta,
                     FIRST Sub_header_vta 
                           WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa
                             AND Sub_header_vta.tip_comprob = Sub_detalle_vta.tip_comprob
                             AND Sub_header_vta.prf_comprob = Sub_detalle_vta.prf_comprob
                             AND Sub_header_vta.nro_comprob = Sub_detalle_vta.nro_comprob
                             AND Sub_header_vta.fecha >= des_fecha 
                             AND Sub_header_vta.fecha <= has_fecha
                             AND NOT Sub_header_vta.anulado /* ,
                                 FIRST Cliente OF Sub_header_vta */
                             BREAK BY Cuenta.cdg_cuenta BY Sub_header_vta.fecha:
           
        VIEW FRAME frm-titulo.

        chr_cuenta = Cuenta.cdg_cuenta + " - " + Cuenta.nombre_cta.

        v-debito = 0.
        v-credito = 0.
        FIND Tipocomprobante OF Sub_header_vta NO-LOCK.
        IF Tipocomprobante.debita
           THEN v-debito  = Sub_detalle_vta.valor.
           ELSE v-credito = Sub_detalle_vta.valor.

        v-saldo = v-saldo + v-debito - v-credito.

        FIND Entidad OF Sub_detalle_vta NO-LOCK NO-ERROR.
        FIND Cliente WHERE Cliente.nom_cliente = Sub_header_vta.nombre  NO-LOCK NO-ERROR.
        /*FIND Obra    OF Sub_detalle_vta NO-LOCK NO-ERROR.*/

        que_comprobante = Sub_header_vta.tip_comprob + " " +
                          STRING(Sub_header_vta.prf_comprob,"9999") + " " + 
                          STRING(Sub_header_vta.nro_comprob,"99999999").

        DISPLAY    
                Sub_header_vta.fecha       
                que_comprobante
                Entidad.cdg_entidad WHEN AVAILABLE Entidad
                Obra.cdg_obra       WHEN AVAILABLE Obra 
                Cliente.cdg_cliente WHEN AVAILABLE Cliente
                Sub_header_vta.nombre
                v-debito  WHEN v-debito  <> 0
                v-credito WHEN v-credito <> 0
                v-saldo
                WITH FRAME frm-movimiento.
        EXPORT STREAM Exportacion
                Cuenta.cdg_cuenta
                Cuenta.nombre_cta
                Sub_header_vta.fecha       
                que_comprobante
                ( IF AVAILABLE Entidad THEN Entidad.cdg_entidad ELSE "")
                ( IF AVAILABLE Obra THEN Obra.cdg_obra ELSE "" )
                Sub_header_vta.nombre
                v-debito
                v-credito
                v-saldo.
        
        DOWN WITH FRAME frm-movimiento.        
        IF LAST-OF(Cuenta.cdg_cuenta) 
        THEN DO:
                UNDERLINE 
                       Sub_header_vta.fecha       
                       que_comprobante
                       Entidad.cdg_entidad
                       Obra.cdg_obra 
                       Cliente.cdg_cliente
                       Sub_header_vta.nombre
                       v-debito
                       v-credito
                       v-saldo
                       WITH FRAME frm-movimiento.  
                DISPLAY 
                       v-saldo
                       WITH FRAME frm-movimiento.  

                v-saldo = 0.
                IF NOT LAST(Cuenta.cdg_cuenta) THEN PAGE.    
        END.    
             
  END.

  OUTPUT CLOSE.
  OUTPUT STREAM Exportacion CLOSE.

  RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.  


 
