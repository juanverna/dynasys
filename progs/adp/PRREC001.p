/*=================================================================================*/
/*                    I M P R E S I O N   D E   R E C I B O S                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo AS ROWID.

{VRSHARED.I}

DEFINE SHARED VARIABLE ver_antes    AS INTEGER.
DEFINE SHARED VARIABLE uldep_banco  AS CHARACTER FORMAT "X(12)" LABEL "Banco".
DEFINE SHARED VARIABLE uldep_period AS CHARACTER FORMAT "X(8)"  LABEL "Per¡odo".
DEFINE SHARED VARIABLE uldep_fecha  AS CHARACTER FORMAT "X(8)"  LABEL "Fecha".
DEFINE SHARED VARIABLE abonado      AS CHARACTER FORMAT "X(12)" LABEL "Per. Abonado".
DEFINE SHARED VARIABLE cuando       AS CHARACTER FORMAT "X(15)".

{NOMMESES.I}

DEFINE VARIABLE donde       AS CHARACTER FORMAT "X(35)".


DEFINE VARIABLE son_pesos    AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE lis_h LIKE Rcb_detalle.importe COLUMN-LABEL "Haberes".
DEFINE VARIABLE lis_r LIKE Rcb_detalle.importe COLUMN-LABEL "Retenciones".

DEFINE VARIABLE tot_h LIKE Rcb_detalle.importe COLUMN-LABEL "Haberes".
DEFINE VARIABLE tot_r LIKE Rcb_detalle.importe COLUMN-LABEL "Retenciones".

FORM
  Empresa.nombre            AT 5  
  Empleado.nro_cuil         AT 60
  SKIP
  Empresa.direccion         AT 5
  SKIP
  Empresa.cuit              AT 5
  Rcb_header.nro_recibo     AT 60
  SKIP(2)
  Empleado.nombre           AT 5
  Empleado.cdg_seccion      
  SPACE(2)
  Empleado.nro_legajo 
  SPACE(2)
  Categoria.descripcion
  SKIP(1)
  uldep_banco              AT 5
  uldep_period
  SPACE(3)
  uldep_fecha
  SPACE(3)
  Empleado.fecha_ingreso
  SPACE(3)
  Rcb_header.basico
  SKIP(1)
  abonado AT 5 
  donde
  WITH FRAME frm-encabezado NO-LABELS
       STREAM-IO USE-TEXT TOP-ONLY PAGE-TOP.
       
FORM 
  Concepto.cdg_concepto 
  Concepto.descripcion
  Rcb_detalle.unidades FORMAT "ZZ9.99"
  lis_h
  lis_r
  WITH DOWN NO-UNDERLINE STREAM-IO USE-TEXT FRAME frm-detalle.            

FORM
  SKIP(1)
  son_pesos
  Rcb_header.a_pagar  AT 63
  Rcb_header.remunerativo  AT 63 
  SKIP(2)
  WITH FRAME frm-pie STREAM-IO USE-TEXT
       NO-LABELS PAGE-BOTTOM.
       
/*=================================================================================*/
/*       C O M I E N Z O   E L   P R O C E S O   D E   I M P R E S I O N           */
/*=================================================================================*/

{SETIMPRE.I}

OUTPUT TO VALUE(dire_tmp + "prrec001.txt") PAGE-SIZE 35.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.

FIND Rcb_header WHERE ROWID(Rcb_header) = act_recibo EXCLUSIVE-LOCK NO-ERROR.
FIND Liquidacion OF Rcb_header NO-LOCK.
FIND Empleado  OF Rcb_header NO-LOCK.
/*FIND Sector    WHERE Sector.cdg_sector = Empleado.cdg_sector NO-LOCK.*/
FIND Categoria OF Empleado NO-LOCK.

/*
cuando = STRING(DAY(Rcb_header.fecha),">9") + 
         " de " + 
         nom_mes [ MONTH(Rcb_header.fecha) ] +
         " de " + 
         STRING(YEAR(Rcb_header.fecha),"9999").
*/

donde    = "Buenos Aires, " + cuando.

RUN TOLETRAS.P ( INPUT Rcb_header.a_pagar, OUTPUT son_pesos ).

DISPLAY Empresa.nombre
        Empleado.nro_cuil
        Empresa.direccion
        Empresa.cuit           
        Rcb_header.nro_recibo  
        Empleado.nombre         
        Empleado.cdg_seccion       
        Empleado.nro_legajo 
        Categoria.descripcion
        uldep_banco
        uldep_period
        uldep_fecha
        Empleado.fecha_ingreso
        Rcb_header.basico         
        abonado
        donde 
        WITH FRAME frm-encabezado.

FOR EACH Rcb_detalle OF Rcb_header 
    WHERE Rcb_detalle.importe <> 0, 
          Concepto OF Rcb_detalle 
          BY Concepto.cdg_concepto:

  VIEW FRAME frm-pie.

  IF LOOKUP(Concepto.haber_retenc,"H,R") <> 0
  THEN DO:

       lis_h = Rcb_detalle.importe.
       lis_r = Rcb_detalle.importe.

       DISPLAY Concepto.cdg_concepto 
               Concepto.descripcion
               Rcb_detalle.unidades FORMAT "ZZ9.99" WHEN Rcb_detalle.unidades <> 0
               lis_h WHEN Concepto.haber_retenc = "H" 
               lis_r WHEN Concepto.haber_retenc = "R"
               WITH FRAME frm-detalle.

       DOWN    WITH FRAME frm-detalle.

       IF Concepto.haber_retenc = "H" 
          THEN tot_h = tot_h + Rcb_detalle.importe.
          ELSE tot_r = tot_r + Rcb_detalle.importe.

  END.
  
END.          

UNDERLINE 
          lis_h
          lis_r
          WITH FRAME frm-detalle.

DISPLAY
          tot_h @ lis_h
          tot_r @ lis_r
          WITH FRAME frm-detalle.


DISPLAY
     Rcb_header.a_pagar
     Rcb_header.remunerativo
     son_pesos
     WITH FRAME frm-pie.

OUTPUT CLOSE.

{VERANTES.I "prrec001.txt"}

{CODIMPRE.I}
