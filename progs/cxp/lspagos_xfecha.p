/*=================================================================================*/
/*         LISTADO DE PAGOS EFECTUADOS POR FECHA DE EMISION                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER que_moneda      LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE que_comprobante        AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE total_caja             AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_opago            AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_aplicado         AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE primera_fecha          AS LOGICAL.
DEFINE VARIABLE primera_opago          AS LOGICAL.
DEFINE VARIABLE ant_fecha              LIKE Opg_header.fecha.
DEFINE VARIABLE ant_comprob            LIKE Opg_header.nro_comprob.

DEFINE TEMP-TABLE Resumen
   FIELD cdg_rubro    LIKE Rubro.cdg_rubro
   FIELD importe      LIKE total_caja
   INDEX Resumen IS PRIMARY cdg_rubro ASCENDING.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Obligaciones Canceladas por Fecha" AT 43
  "Página:" AT 109 PAGE-NUMBER FORMAT ">>9" AT 117
  SKIP
  fecha_lis
  "del" AT 43
  des_fecha
  "al"
  has_fecha
  hora_lis AT 109
  SKIP
  "Importes en" AT 43
  desc_moneda NO-LABEL
  SKIP(1)
  WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  Opg_header.fecha               COLUMN-LABEL "Fecha!Emisión"
  Opg_header.nro_comprob         COLUMN-LABEL "Número!O/Pago" 
  Proveedor.cdg_proveedor        COLUMN-LABEL "Código!Proveedor"
  Proveedor.nombre               COLUMN-LABEL "Razón!Social"           FORMAT "X(40)" 
  Opg_header.imp_total           COLUMN-LABEL "Importe!Abonado"        FORMAT "->>,>>>,>>9.99" 
  que_comprobante                COLUMN-LABEL "Comprobante!Cancelado"  FORMAT "X(20)"
  Opg_detalle.importe            COLUMN-LABEL "Importe!Aplicado"
  WITH WIDTH 130 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO.

DEFINE FRAME frm-resumen
  SPACE(19)
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
  primera_opago = YES.
  total_aplicado = 0.
  total_opago    = 0.

  OPEN QUERY q-pagos
    FOR EACH Opg_header 
        WHERE Opg_header.cdg_empresa = Empresa.cdg_empresa
          AND Opg_header.fecha >= des_fecha
          AND Opg_header.fecha  <= has_fecha
          AND Opg_header.tip_comprob = "OP"
          AND NOT Opg_header.anulado,
              FIRST Proveedor OF Opg_header, 
              EACH Opg_detalle OUTER-JOIN OF Opg_header 
                   BY Opg_header.fecha BY Opg_header.nro_comprob.
  
  GET FIRST q-pagos.
  DO WHILE AVAILABLE Opg_header:                 
         
        VIEW FRAME frm-titulo.
        
        IF Proveedor.cdg_proveedor >= des_codigo AND Proveedor.cdg_proveedor <= has_codigo
        THEN DO:

            primera_fecha = ant_fecha   <> Opg_header.fecha.
            primera_opago = ant_comprob <> Opg_header.nro_comprob OR primera_fecha.

            IF primera_opago
            THEN DO:
                 total_opago = total_opago + Opg_header.imp_total.
                 FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion.
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

            IF AVAILABLE Opg_detalle
            THEN DO:
                 que_comprobante = Opg_detalle.tip_cancela + " " +
                                   STRING(Opg_detalle.prf_cancela,"9999") + " " + 
                                   STRING(Opg_detalle.nro_cancela,"99999999") + " " + 
                                   STRING(Opg_detalle.nro_vencimiento,"999").                               
                 total_aplicado  = total_aplicado + Opg_detalle.importe.
            END.
            ELSE DO:
                 que_comprobante = "----- A Cuenta -----".
            END.

            DISPLAY 
                Opg_header.fecha          WHEN primera_fecha
                Opg_header.nro_comprob    WHEN primera_opago
                Opg_header.imp_total      WHEN primera_opago
                Proveedor.cdg_proveedor   WHEN primera_opago
                Proveedor.nombre          WHEN primera_opago
                que_comprobante
                Opg_detalle.importe       WHEN AVAILABLE Opg_detalle
                WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.

            ant_fecha   = Opg_header.fecha.
            ant_comprob = Opg_header.nro_comprob.

        END.

        GET NEXT q-pagos.

  END.

  UNDERLINE 
        Opg_header.fecha 
        Opg_header.nro_comprob 
        Opg_header.imp_total 
        Proveedor.cdg_proveedor 
        Proveedor.nombre 
        que_comprobante
        Opg_detalle.importe 
        WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  
  DISPLAY "TOTAL ABONADO ------------------------->" @ Proveedor.nombre
          total_opago      @ Opg_header.imp_total
          total_aplicado   @ Opg_detalle.importe
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

