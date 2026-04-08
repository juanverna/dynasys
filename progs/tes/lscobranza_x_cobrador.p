/*=================================================================================*/
/*   EMITE UN LISTADO CON TODAS LAS COBRANZAS REGISTRADAS EN UN RANGO DE FECHAS    */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas   AS CHARACTER.
DEFINE INPUT PARAMETER que_caja           LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_cobrador       LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_cobrador       LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER des_fecha          LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha          LIKE Caj_header.fecha.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VPERSINM.I}
{parlocales.i}
{dfvarimp.i}
                                        
DEFINE VARIABLE titulo_det   AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE titulo_cob   AS CHARACTER FORMAT "X(50)".

/*DEFINE VARIABLE que_fecha    AS CHARACTER.*/
DEFINE VARIABLE que_comprob  AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE ingreso      AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso       AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo        AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso   AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE lst_e        AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE lst_i        AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE dtl_rubro    LIKE Caj_detalle.observacion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Detalle de Cobranzas por Cobrador" AT 60 
  "Página:" AT 132 PAGE-NUMBER FORMAT ">9" AT 139
  SKIP  
  fecha_lis   
  "del" AT 60
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 132
  titulo_det AT 60
  SKIP
  titulo_cob AT 60
  SKIP(1)
  WITH WIDTH 260 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Rec_header.fecha_grab 
  Rec_header.tip_comprob
  Rec_header.prf_comprob
  Rec_header.nro_comprob
  Rec_header.fecha
  Cliente.cdg_cliente
  Cliente.nom_cliente
  Rec_header.imp_total
  Rubro.abrevia             COLUMN-LABEL "Con-!cepto"
  Caj_detalle.importe       COLUMN-LABEL "Importe!Rubro"
  dtl_rubro                 COLUMN-LABEL "Observaciones de!detalle del movimiento"
  WITH WIDTH 260 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
  titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + "Empresas:" + v-lista_empresas.

  saldo = 0.
  tot_ingreso = 0.
  tot_egreso  = 0.

  {dirprinfile.i}

  FOR EACH Rec_header 
     WHERE CAN-DO(v-lista_empresas,Rec_header.cdg_empresa)
       AND Rec_header.fecha_grab >= des_fecha
       AND Rec_header.fecha_grab <= has_fecha
       AND Rec_header.tip_comprob BEGINS "R"
       AND NOT Rec_header.anulado,
           FIRST Cobrador OF Rec_header
                  WHERE Cobrador.cdg_cobrador >= des_cobrador 
                    AND Cobrador.cdg_cobrador <= has_cobrador, 
           FIRST Usuario OF Rec_header,
           FIRST Cliente OF Rec_header,
                FIRST Caj_header 
                      WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion
                        AND Caj_header.cdg_caja = Caja.cdg_caja
                BY Cobrador.cdg_cobrador
                BY Rec_header.cdg_empresa
                BY Rec_header.fecha_grab 
                BY Rec_header.tip_comprob
                BY Rec_header.prf_comprob
                BY Rec_header.nro_comprob
                   WITH FRAME frm-listado:
     
      titulo_cob = Cobrador.cdg_cobrador + " " + Cobrador.nom_cobrador.

      VIEW FRAME frm-titulo.

      DISPLAY Rec_header.fecha_grab 
              Rec_header.tip_comprob
              Rec_header.prf_comprob
              Rec_header.nro_comprob
              Rec_header.fecha
              Cliente.cdg_cliente
              Cliente.nom_cliente
              Rec_header.imp_total
              WITH FRAME frm-listado.

      FOR EACH Caj_detalle OF Caj_header,
              EACH Rubro OF Caj_detalle BREAK BY Caj_detalle.nro_transaccion:
      
          RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT dtl_rubro ).

          DISPLAY Rubro.abrevia
                  Caj_detalle.importe 
                  dtl_rubro
                  WITH FRAME frm-listado.
                  
          DOWN WITH FRAME frm-listado.         
                  
      END.   
  END.
  
  UNDERLINE Caj_header.observacion 
            lst_i
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY "Totales del periodo"  @ Caj_header.observacion
          ingreso  @ lst_i
          WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.

  UNDERLINE Caj_header.observacion 
            lst_i
            WITH FRAME frm-listado STREAM-IO.  

          
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

