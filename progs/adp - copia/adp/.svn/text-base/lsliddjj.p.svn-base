/*============================================================================================*/
/*                     EMITE EL LISTADO DE LAS DECLARACIONES DE GANANCIAS                     */
/*============================================================================================*/

&GLOBAL-DEFINE TITULO            Retenciones 4a. Categoria
&GLOBAL-DEFINE TITULO-FRAME      Retenciones 4a. Categoria
&GLOBAL-DEFINE TITULO-WINDOW     Reportes de empleados
&GLOBAL-DEFINE ARCHIVO-SALIDA    lsfiddjj
&GLOBAL-DEFINE SETEAR-IMPRESORA  RUN PONE_CODIGO ( INPUT "CARTA,SET17CPI,HORIZONT" ).
    
DEFINE INPUT PARAMETER disp_out  AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

{DFVRNEMP.I }
{DFVARSEL.I }

DEFINE VARIABLE todos       AS LOGICAL.     
DEFINE VARIABLE j           AS INTEGER.     
DEFINE VARIABLE fecha_lis   AS DATE.     
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(40)" INITIAL "{&TITULO}".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  titulo_lst AT 60
  "Página:" AT 140 PAGE-NUMBER FORMAT ">9" AT 148
  SKIP  
  fecha_lis       
  titulo_det AT 60  
  hora_lis AT 140
  SKIP(1)
  WITH WIDTH 196 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
  Empleado.nro_legajo                COLUMN-LABEL "Total!Retenido"
  Empleado.nombre                    COLUMN-LABEL "Total!Retenido"
  Empleado.ult_liquidacion           COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.ano                  COLUMN-LABEL "Total!Retenido" 
  Empleado-ddjj.fch_desde            COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.fch_hasta            COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.a-favor-dgi          COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.a-favor-empi         COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.aportes              COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.conyuge              COLUMN-LABEL "Total!Retenido" 
  Empleado-ddjj.difer12              COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.difer34              COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.difer56              COLUMN-LABEL "Total!Retenido"   
  Empleado-ddjj.donaciones           COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.especial             COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.ganancias            COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.ganancias_netas      COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.ganancias_otras      COLUMN-LABEL "Total!Retenido" 
  Empleado-ddjj.hijos                COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.movilidad            COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.obrasoc              COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.otras                COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.otras-cargas         COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.promocion            COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.seguros              COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.sepelios             COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.total1               COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.total2               COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.total6               COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.total9               COLUMN-LABEL "Total!Retenido"
  Empleado-ddjj.total_impuesto       COLUMN-LABEL "Total!Retenido"     
  Empleado-ddjj.total_retenido       COLUMN-LABEL "Total!Retenido"
  WITH WIDTH 196 FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE LISTAR:
       
  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO VALUE(dire_tmp + "{&ARCHIVO-SALIDA}.txt") PAGED.

  {&SETEAR-IMPRESORA}
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                          BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                          BY Empleado.nombre.
  END.

  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado:
     VIEW FRAME frm-titulo.
     FIND Empleado-ddjj OF Empleado 
          WHERE Empleado-ddjj.sec_liquidacion = Empleado.ult_liquidacion NO-LOCK.
     DISPLAY 
          Empleado.nro_legajo
          Empleado.nombre
          Empleado.ult_liquidacion
          Empleado-ddjj.a-favor-dgi 
          Empleado-ddjj.a-favor-empi 
          Empleado-ddjj.ano 
          Empleado-ddjj.fch_desde 
          Empleado-ddjj.fch_hasta 
          Empleado-ddjj.aportes 
          Empleado-ddjj.conyuge 
          Empleado-ddjj.difer12 
          Empleado-ddjj.difer34 
          Empleado-ddjj.difer56 
          Empleado-ddjj.donaciones 
          Empleado-ddjj.especial 
          Empleado-ddjj.ganancias 
          Empleado-ddjj.ganancias_netas 
          Empleado-ddjj.ganancias_otras 
          Empleado-ddjj.hijos 
          Empleado-ddjj.movilidad 
          Empleado-ddjj.obrasoc 
          Empleado-ddjj.otras 
          Empleado-ddjj.otras-cargas 
          Empleado-ddjj.promocion 
          Empleado-ddjj.seguros 
          Empleado-ddjj.sepelios 
          Empleado-ddjj.total1 
          Empleado-ddjj.total2 
          Empleado-ddjj.total6 
          Empleado-ddjj.total9 
          Empleado-ddjj.total_impuesto 
          Empleado-ddjj.total_retenido 
          WITH FRAME frm-listado.
     GET NEXT qry_empleados.
  END.
  
  UNDERLINE 
          Empleado.nro_legajo
          Empleado.nombre
          Empleado.ult_liquidacion
          Empleado-ddjj.a-favor-dgi 
          Empleado-ddjj.a-favor-empi 
          Empleado-ddjj.ano 
          Empleado-ddjj.aportes 
          Empleado-ddjj.conyuge 
          Empleado-ddjj.difer12 
          Empleado-ddjj.difer34 
          Empleado-ddjj.difer56 
          Empleado-ddjj.donaciones 
          Empleado-ddjj.especial 
          Empleado-ddjj.fch_desde 
          Empleado-ddjj.fch_hasta 
          Empleado-ddjj.ganancias 
          Empleado-ddjj.ganancias_netas 
          Empleado-ddjj.ganancias_otras 
          Empleado-ddjj.hijos 
          Empleado-ddjj.movilidad 
          Empleado-ddjj.obrasoc 
          Empleado-ddjj.otras 
          Empleado-ddjj.otras-cargas 
          Empleado-ddjj.promocion 
          Empleado-ddjj.seguros 
          Empleado-ddjj.sepelios 
          Empleado-ddjj.total1 
          Empleado-ddjj.total2 
          Empleado-ddjj.total6 
          Empleado-ddjj.total9 
          Empleado-ddjj.total_impuesto 
          Empleado-ddjj.total_retenido 
          WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.


END PROCEDURE.  

{CODIMPRE.I}
