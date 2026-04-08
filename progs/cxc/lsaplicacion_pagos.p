/*=================================================================================*/
/*           LISTADO DE DERECHOS PENDIENTES POR FECHA DE VENCIMIENTO               */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas  AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER que_moneda        LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER des_fecha         AS DATE.
DEFINE INPUT PARAMETER has_fecha         AS DATE.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE que_cancelado          AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_recibo             AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE total_caja             AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_recibo           AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_aplicado         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE primera_fecha          AS LOGICAL.
DEFINE VARIABLE primer_recibo          AS LOGICAL.
DEFINE VARIABLE ant_fecha              LIKE Rec_header.fecha.
DEFINE VARIABLE ant_comprob            LIKE que_recibo.

DEFINE TEMP-TABLE Resumen
   FIELD cdg_rubro    LIKE Rubro.cdg_rubro
   FIELD importe      LIKE total_caja
   INDEX Resumen IS PRIMARY cdg_rubro ASCENDING.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Aplicacion de Cobranzas por Fecha " AT 53
  "Página:" AT 132 PAGE-NUMBER FORMAT ">>9" AT 140
  SKIP
  fecha_lis
  "del" AT 53
  des_fecha
  "al"
  has_fecha
  hora_lis AT 132
  SKIP
  "Importes en" AT 53
  desc_moneda NO-LABEL
  SKIP(1)
  WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  Rec_header.fecha               COLUMN-LABEL "Fecha!Emisión"
  que_recibo                     COLUMN-LABEL "Identificación!del Recibo" 
  Cliente.cdg_cliente            COLUMN-LABEL "Código!Cliente"
  Cliente.nom_cliente            COLUMN-LABEL "Razón!Social"
  Cliente.cuit                   COLUMN-LABEL "C.U.I.T."
  Rec_header.imp_total           COLUMN-LABEL "Importe!Cobrado"        FORMAT "->>,>>>,>>9.99" 
  que_cancelado                  COLUMN-LABEL "Comprobante!Cancelado"  FORMAT "X(20)"
  Aplicacion_pagos.importe            COLUMN-LABEL "Importe!Aplicado"
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO.

DEFINE FRAME frm-resumen
  SPACE(28)
  Resumen.cdg_rubro COLUMN-LABEL "Código!Rubro" FORMAT ">>>>>>>9"
  Rubro.nombre      COLUMN-LABEL "Denominación!Rubro" FORMAT "X(40)" 
  Resumen.importe   COLUMN-LABEL "Total!Movimientos"
  WITH WIDTH 100 DOWN CENTERED FRAME frm-resumen USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = Moneda.descripcion.
     
  {findempresa.i}
  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  FOR EACH Rubro BY Rubro.cdg_rubro:
      CREATE Resumen.
      Resumen.cdg_rubro   = Rubro.cdg_rubro.
      Resumen.importe = 0.
  END.             

  RUN LISTAR.
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

PROCEDURE LISTAR:

  ant_comprob = ?.
  ant_fecha = ?.
  primera_fecha = YES.
  primer_recibo = YES.
  total_recibo = 0.
  total_aplicado = 0.
  
  OPEN QUERY q-cobros
    FOR EACH Rec_header 
        WHERE CAN-DO(v-lista_empresas,Rec_header.cdg_empresa)
          AND Rec_header.fecha >= des_fecha
          AND Rec_header.fecha  <= has_fecha
          AND Rec_header.tip_comprob BEGINS "R"
          AND NOT Rec_header.anulado,
              FIRST Cliente OF Rec_header
                     WHERE Cliente.cdg_cliente >= des_codigo AND Cliente.cdg_cliente <= has_codigo, 
              EACH Aplicacion_pagos OUTER-JOIN OF Rec_header 
                   BY Rec_header.cdg_empresa
                   BY Rec_header.fecha 
                   BY Rec_header.tip_comprob
                   BY Rec_header.prf_comprob
                   BY Rec_header.nro_comprob.
  
  GET FIRST q-cobros.
  DO WHILE AVAILABLE Rec_header:                 
         
        VIEW FRAME frm-titulo.
        
        que_recibo =   Rec_header.tip_comprob + " " +
               STRING(Rec_header.prf_comprob,"9999") + " " + 
               STRING(Rec_header.nro_comprob,"99999999").                               

        primera_fecha = ant_fecha <> Rec_header.fecha.
        primer_recibo = ant_comprob <> que_recibo /*OR primera_fecha*/.

        IF primer_recibo  
        THEN DO:
             total_recibo = total_recibo + Rec_header.imp_total. 
             FIND Caj_header WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion.
             FOR EACH Caj_detalle OF Caj_header:
 
                 FIND Resumen WHERE Resumen.cdg_rubro = Caj_detalle.cdg_rubro NO-LOCK NO-ERROR.
                 IF NOT AVAILABLE Resumen
                 THEN DO:
                      CREATE Resumen.
                      ASSIGN Resumen.cdg_rubro = Caj_detalle.cdg_rubro.
                 END.

                 Resumen.importe = Resumen.importe  + Caj_detalle.importe.

             END.
        END.
        
        IF AVAILABLE Aplicacion_pagos
        THEN DO:
             que_cancelado =  Aplicacion_pagos.tip_cancela + " " +
                              STRING(Aplicacion_pagos.prf_cancela,"9999") + " " + 
                              STRING(Aplicacion_pagos.nro_cancela,"99999999") + " " + 
                              STRING(Aplicacion_pagos.nro_vencimiento,"999").                               
             total_aplicado = total_aplicado + Aplicacion_pagos.importe.                                      
        END.
        ELSE DO:
             que_cancelado =  "----- A Cuenta -----".
        END.     

        DISPLAY 
            Rec_header.fecha          WHEN primera_fecha
            que_recibo                WHEN primer_recibo
            Rec_header.imp_total      WHEN primer_recibo
            Cliente.cdg_cliente       WHEN primer_recibo
            Cliente.nom_cliente       WHEN primer_recibo
            Cliente.cuit              WHEN primer_recibo
            que_cancelado
            Aplicacion_pagos.importe       WHEN AVAILABLE Aplicacion_pagos

            WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.

        ant_fecha   = Rec_header.fecha.
        ant_comprob = que_recibo.

        GET NEXT q-cobros.

  END.

  UNDERLINE 
        Rec_header.fecha 
        que_recibo 
        Rec_header.imp_total 
        Cliente.cdg_cliente 
        Cliente.nom_cliente 
        Cliente.cuit
        que_cancelado
        Aplicacion_pagos.importe 
        WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  
  DISPLAY "TOTAL COBRADO ------------------------->" @ Cliente.nom_cliente
          total_recibo     @ Rec_header.imp_total
          total_aplicado   @ Aplicacion_pagos.importe
        WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.

  PAGE.  

  total_caja = 0.
  FOR EACH Resumen WHERE Resumen.importe <> 0, FIRST Rubro OF Resumen NO-LOCK:
      DISPLAY 
          Resumen.cdg_rubro 
          Rubro.nombre 
          Resumen.importe
          WITH FRAME frm-resumen.
      DOWN WITH FRAME frm-resumen.
      total_caja = total_caja + Resumen.importe.
  END.
  
  UNDERLINE
       Resumen.cdg_rubro 
       Rubro.nombre 
       Resumen.importe
       WITH FRAME frm-resumen.
  
  DISPLAY 
       "TOTAL MOVIMIENTOS DE CAJA" @ Rubro.nombre
       total_caja @ Resumen.importe
       WITH FRAME frm-resumen.
  DOWN WITH FRAME frm-resumen.
  
END PROCEDURE.

