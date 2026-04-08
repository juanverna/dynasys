/*=================================================================================*/
/*                MOVIMIENTOS DE SUBDIARIO ClienteES POR CUENTA                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta   LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta   LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER listar_hora  AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina   AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina   AS INTEGER.
DEFINE INPUT PARAMETER exportacion  AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE VARIABLE chr_cuenta   AS CHARACTER FORMAT "X(50)".

DEFINE VARIABLE fecha_lis    AS CHARACTER.
DEFINE VARIABLE hora_lis     AS CHARACTER.

DEFINE VARIABLE fecha_fr     AS CHARACTER.
DEFINE VARIABLE hora_fr      AS CHARACTER.

DEFINE VARIABLE v-debito         LIKE Asn_detalle.debito.
DEFINE VARIABLE v-credito        LIKE Asn_detalle.credito.
DEFINE VARIABLE v-saldo          LIKE Asn_detalle.debito LABEL "Saldo".

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
    Sub_header_inv.fecha       COLUMN-LABEL "Fecha!Movimto."
    Sub_detalle_inv.tip_comprob FORMAT "X(2)" COLUMN-LABEL "Tip.!Comp."
    Sub_detalle_inv.prf_comprob FORMAT ">>>9" COLUMN-LABEL "Pto.!Vta."
    Sub_detalle_inv.nro_comprob FORMAT ">>>>>>>9" COLUMN-LABEL "Número!Compbte."
    Entidad.cdg_entidad COLUMN-LABEL "Código!Entidad"
    Obra.cdg_obra       COLUMN-LABEL "Código!Obra"
    /*
    Cliente.cdg_cliente COLUMN-LABEL "Código!Refer."
    Cliente.nom_cliente COLUMN-LABEL "Descripcion!Referencia"
    */
    v-debito COLUMN-LABEL "Importe!Débito"
    v-credito COLUMN-LABEL "Importe!Crédito"
    v-saldo COLUMN-LABEL "Importe!Saldo"
    WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE LISTAR:

  IF listar_hora
  THEN DO:
     fecha_lis = STRING(TODAY).
     hora_lis = STRING(TIME,"HH:MM:SS").
  END.
  ELSE DO:   
     fecha_lis = " ".
     hora_lis = " ".
  END.

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  IF NOT exportacion 
     THEN OUTPUT TO VALUE (dire_tmp + "lssubctainv.txt") PAGED PAGE-SIZE VALUE(lin_pagina).
     ELSE OUTPUT TO VALUE (dire_tmp + "lssubctainv.txt").
      
  IF NOT exportacion THEN RUN PONE_CODIGO ( INPUT "SET17CPI,CARTA,SET8LPI" ).

  FOR EACH Cuenta 
      WHERE Cuenta.cdg_cuenta <= has_cuenta
        AND Cuenta.cdg_cuenta >= des_cuenta, EACH Sub_detalle_inv OF Cuenta,
                     FIRST Sub_header_inv 
                           WHERE Sub_header_inv.tip_comprob = Sub_detalle_inv.tip_comprob
                             AND Sub_header_inv.prf_comprob = Sub_detalle_inv.prf_comprob
                             AND Sub_header_inv.nro_comprob = Sub_detalle_inv.nro_comprob
                             AND Sub_header_inv.fecha >= des_fecha 
                             AND Sub_header_inv.fecha <= has_fecha
                             AND NOT Sub_header_inv.anulado /* ,
                                 FIRST Cliente OF Sub_header_inv */
                             BREAK BY Cuenta.cdg_cuenta BY Sub_header_inv.fecha:
           
        IF NOT exportacion THEN VIEW FRAME frm-titulo.

        chr_cuenta = Cuenta.cdg_cuenta + " - " + Cuenta.nombre_cta.

        v-debito = 0.
        v-credito = 0.
        IF Sub_detalle_inv.tipo = 1
           THEN v-debito  = Sub_detalle_inv.valor.
           ELSE v-credito = Sub_detalle_inv.valor.

        v-saldo = v-saldo + v-debito - v-credito.

        FIND Entidad OF Sub_detalle_inv NO-LOCK NO-ERROR.
        /*FIND Obra    OF Sub_detalle_inv NO-LOCK NO-ERROR.*/

        IF NOT exportacion 
        THEN DISPLAY    
                Sub_header_inv.fecha WHEN FIRST-OF(Sub_header_inv.fecha)
                Sub_detalle_inv.tip_comprob FORMAT "X(2)"
                Sub_detalle_inv.prf_comprob FORMAT ">>>9"
                Sub_detalle_inv.nro_comprob FORMAT ">>>>>>>9"
                Entidad.cdg_entidad WHEN AVAILABLE Entidad
                Obra.cdg_obra       WHEN AVAILABLE Obra 
                /*
                Cliente.cdg_cliente
                Cliente.nom_cliente
                */
                v-debito  WHEN v-debito  <> 0
                v-credito WHEN v-credito <> 0
                v-saldo
                WITH FRAME frm-movimiento.
        ELSE EXPORT    
                Cuenta.cdg_cuenta
                Cuenta.nombre_cta
                Sub_header_inv.fecha       
                Sub_detalle_inv.tip_comprob FORMAT "X(2)"
                Sub_detalle_inv.prf_comprob FORMAT ">>>9"
                Sub_detalle_inv.nro_comprob FORMAT ">>>>>>>9"
                ( IF AVAILABLE Entidad THEN Entidad.cdg_entidad ELSE "")
                ( IF AVAILABLE Obra THEN Obra.cdg_obra ELSE "" )
                /*
                Cliente.cdg_cliente
                Cliente.nom_cliente
                */
                v-debito
                v-credito
                v-saldo.
        
        IF NOT exportacion
        THEN DO:
                DOWN WITH FRAME frm-movimiento.        
                IF LAST-OF(Cuenta.cdg_cuenta) 
                THEN DO:
                        UNDERLINE 
                               Sub_header_inv.fecha       
                               Sub_detalle_inv.tip_comprob
                               Sub_detalle_inv.prf_comprob
                               Sub_detalle_inv.nro_comprob
                               Entidad.cdg_entidad
                               Obra.cdg_obra 
                               /*
                               Cliente.cdg_cliente
                               Cliente.nom_cliente
                               */
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
  END.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

{CODIMPRE.I}
 
