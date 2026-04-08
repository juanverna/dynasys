/*=================================================================================*/
/*           LISTADO DE DERECHOS PENDIENTES POR FECHA DE VENCIMIENTO               */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa       AS CHARACTER.
DEFINE INPUT PARAMETER p-que_ptovta        AS INTEGER.
DEFINE INPUT PARAMETER p-des_numero        AS INTEGER.
DEFINE INPUT PARAMETER p-has_numero        AS INTEGER.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE rango_recibos          AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE que_recibo             AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE total_caja             AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_recibo           AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_aplicado         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE j                      AS INTEGER.
DEFINE VARIABLE ant_fecha              LIKE Rec_header.fecha.
DEFINE VARIABLE ant_comprob            LIKE Rec_header.nro_comprob.

DEFINE TEMP-TABLE Resumen
   FIELD cdg_rubro    LIKE Rubro.cdg_rubro
   FIELD importe      LIKE total_caja
   INDEX Resumen IS PRIMARY cdg_rubro ASCENDING.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Control de Recibos por Número Correlativo " AT 53
  "Página:" AT 117 PAGE-NUMBER FORMAT ">>9" AT 125
  SKIP
  fecha_lis
  rango_recibos AT 53
  hora_lis AT 117
  SKIP
  SKIP(1)
  WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  que_recibo                     COLUMN-LABEL "Identificación!del Recibo"   
  Rec_header.fecha               COLUMN-LABEL "Fecha!Emisión"
  Cliente.cdg_cliente            COLUMN-LABEL "Código!Cliente"
  Cliente.nom_cliente            COLUMN-LABEL "Razón!Social"
  Rec_header.imp_total           COLUMN-LABEL "Importe!Cobrado"        FORMAT "->>,>>>,>>9.99" 
  Cobrador.cdg_cobrador          COLUMN-LABEL "Código!Cobrador"
  Cobrador.nom_cobrador          COLUMN-LABEL "Nombre!Cobrador"
  WITH WIDTH 190 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO.

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

  FIND Empresa WHERE Empresa.cdg_empresa = p-que_empresa NO-LOCK.
  que_empresa = Empresa.nombre.
  rango_recibos = "Rango " + STRING(p-que_ptovta,"9999") + "-" + 
                  STRING(p-des_numero,"99999999") + ":" + STRING(p-has_numero,"99999999").
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
  total_recibo = 0.
  total_aplicado = 0.
  
  OPEN QUERY q-cobros
    FOR EACH Rec_header 
        WHERE Rec_header.cdg_empresa = p-que_empresa
          AND Rec_header.prf_comprob = p-que_ptovta
          AND Rec_header.nro_comprob >= p-des_numero
          AND Rec_header.nro_comprob  <= p-has_numero
          AND Rec_header.tip_comprob BEGINS "R"
                   BY Rec_header.cdg_empresa
                   BY Rec_header.tip_comprob
                   BY Rec_header.prf_comprob
                   BY Rec_header.nro_comprob. 
  
  GET FIRST q-cobros.
  DO WHILE AVAILABLE Rec_header:                 
         
    VIEW FRAME frm-titulo.

    IF ant_comprob + 1 <> Rec_header.nro_comprob
    THEN DO:
         DO j = ant_comprob + 1 TO Rec_header.nro_comprob - 1:
             que_recibo =   "RX" + " " +
                            STRING(p-que_ptovta,"9999") + " " + 
                            STRING(j,"99999999").                               
             
             DISPLAY 
                 que_recibo                
                 "*** FALTANTE ***" @ Cliente.nom_cliente       
                 WITH FRAME frm-listado-mov.
             DOWN WITH FRAME frm-listado-mov.         
         END.
    END.

    que_recibo =   Rec_header.tip_comprob + " " +
                   STRING(Rec_header.prf_comprob,"9999") + " " + 
                   STRING(Rec_header.nro_comprob,"99999999").                               
     
    IF NOT Rec_header.anulado
    THEN DO:
        total_recibo = total_recibo + Rec_header.imp_total. 
        FIND Cliente OF Rec_header NO-LOCK.
        FIND Cobrador OF Rec_header NO-LOCK.
        FIND Caj_header WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK NO-ERROR.

        IF AVAILABLE Caj_header
        THEN DO:
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

        DISPLAY 
             que_recibo                
             Rec_header.fecha          
             Rec_header.imp_total      
             Cliente.cdg_cliente       
             Cliente.nom_cliente       
             Cobrador.cdg_cobrador
             Cobrador.nom_cobrador
             WITH FRAME frm-listado-mov.
    
        
    END.
    ELSE DO:
        DISPLAY 
            que_recibo                
            "-- ANULADO --" @ Cliente.nom_cliente       
            WITH FRAME frm-listado-mov.

    END.
    
    DOWN WITH FRAME frm-listado-mov.

    ant_comprob = Rec_header.nro_comprob.

    GET NEXT q-cobros.

  END.

  UNDERLINE 
        que_recibo                
        Rec_header.fecha          
        Rec_header.imp_total      
        Cliente.cdg_cliente       
        Cliente.nom_cliente       
        Cobrador.cdg_cobrador
        Cobrador.nom_cobrador
        WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  
  DISPLAY "TOTAL COBRADO ------------------------->" @ Cliente.nom_cliente
          total_recibo     @ Rec_header.imp_total
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

