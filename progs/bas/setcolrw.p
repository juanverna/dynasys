/*===================================================================================*/

&GLOBAL-DEFINE ID-PROG        FACTUR
&GLOBAL-DEFINE MSG1           "F2=Grabar  Esc=Cancelar  F5=Cta.Cte.            "
&GLOBAL-DEFINE MSG2           "F7=Altas   F8=Cambios    F9=Fecha    F10=Anular "
&GLOBAL-DEFINE TABLAS-DETALLE Fac_detalle, Articulo
&GLOBAL-DEFINE DISPLAY-BRW    Fac_detalle.nro_linea COLUMN-LABEL "# " ~
                              Articulo.cdg_articulo FORMAT "999999" COLUMN-LABEL "Codigo" ~
                              Articulo.descripcion FORMAT "X(25)" ~
                              Fac_detalle.cantidad COLUMN-LABEL "Cant." ~
                              Fac_detalle.granel   ~
                              Fac_detalle.precio
&GLOBAL-DEFINE TITULO-BRW     Articulos a facturar
&GLOBAL-DEFINE TABLA_PPAL     Cliente
&GLOBAL-DEFINE CD_TABLA_PPAL  cdg_cliente
&GLOBAL-DEFINE TABLA_SLAVE    Articulo
&GLOBAL-DEFINE CD_TABLA_SLAVE cdg_articulo
&GLOBAL-DEFINE TABLA_HEADER   Fac_header
&GLOBAL-DEFINE OBSERVACION    leyenda
&GLOBAL-DEFINE TITULO-OBS     Leyenda de facturacion
&GLOBAL-DEFINE ACT_REG_HEAD   act_fac_head
&GLOBAL-DEFINE ULT_REG_HEAD   ult_fac_head
&GLOBAL-DEFINE TABLA_DETALLE  Fac_detalle
&GLOBAL-DEFINE ACT_REG_DETL   act_fac_detl
&GLOBAL-DEFINE ULT_REG_DETL   ult_fac_detl
&GLOBAL-DEFINE ACTDTDOC       ACTDTFAC
&GLOBAL-DEFINE ASIGNA_DETALLE Fac_detalle.precio = Articulo.precio
&GLOBAL-DEFINE ACTSLAVE       ACTARTIC
&GLOBAL-DEFINE ACT_REG_SLAVE  act_articulo
&GLOBAL-DEFINE ULT_REG_SLAVE  ult_articulo
&GLOBAL-DEFINE VACIO          ""
&GLOBAL-DEFINE NOM_FUNCION    Ingreso de facturas
&GLOBAL-DEFINE NOM_MENU       FACTURACION
&GLOBAL-DEFINE INIT_CICLO     act_cliente  = ?. ~
                              ult_cliente  = ?. ~
                              act_articulo = ?. ~
                              ult_articulo = ?
&GLOBAL-DEFINE ASIGNA_RECORD  Fac_header.cdg_usuario = Usuario.cdg_usuari ~
                              Fac_header.fecha       = TODAY ~
                              Fac_header.tip_comprob = "TXC" ~
                              Fac_header.nro_comprob = NEXT-VALUE(proxima_transaccion) ~
                              Fac_header.cdg_moneda  = Moneda.cdg_moneda ~
                              Fac_header.cambio      = Moneda.cambio  ~
                              Fac_header.origen      = "M"

&GLOBAL-DEFINE INIT-DSP       Fac_header.cta_cte ~
                              Fac_header.fecha   

&GLOBAL-DEFINE INIT-ENA       Cliente.cdg_cliente     ~
                              Cnd_venta.cdg_cndventa  ~
                              Vendedor.cdg_vendedor   ~
                              Fac_header.bonif1       ~
                              Fac_header.bonif2       ~
                              Fac_header.bonif3       ~
                              Fac_header.cta_cte

&GLOBAL-DEFINE PROXIMO        "PROXNFA" + Cnd_iva.tipo_factura
&GLOBAL-DEFINE EMITIR         EMIFACTU
&GLOBAL-DEFINE TIP_COMPROB    v-tip_comprob

/*===================================================================================*/

DEFINE VARIABLE cliobsdc      AS INTEGER.
DEFINE VARIABLE ccoobsdc      AS INTEGER.

DEFINE BUTTON BTN_GRABAR
     LABEL "&Grabar":L 
     SIZE 10 BY 0.9 FONT 10.
     
DEFINE BUTTON BTN_CANCEL
     LABEL "Ca&ncelar":L 
     SIZE 10 BY 0.9 FONT 10.

DEFINE BUTTON BTN_OBSERV
     LABEL "&Observ":L 
     SIZE 10 BY 0.9 FONT 10.

&IF DEFINED(OBSERVACION)
&THEN

FORM        
   {&TABLA_HEADER}.{&OBSERVACION} NO-LABEL FGCOLOR 14 BGCOLOR 3 
                                        VIEW-AS EDITOR SIZE 70 BY 4
   btn_GRABAR AT 1
   btn_CANCEL
   WITH FRAME frm-observaciones TITLE "{&TITULO-OBS}"
   VIEW-AS DIALOG-BOX FGCOLOR 14 BGCOLOR 3 CENTERED FONT 9. 


ON ESC OF FRAME frm-observaciones
DO:
   APPLY "CHOOSE" TO btn_cancel IN FRAME frm-observaciones.
   RETURN NO-APPLY.
END.

ON CHOOSE OF btn_GRABAR IN FRAME frm-observaciones
DO:
   ASSIGN {&TABLA_HEADER}.{&OBSERVACION}.
   APPLY "U1" TO FRAME frm-observaciones.
END.

ON CHOOSE OF btn_CANCEL IN FRAME frm-observaciones
DO:
   APPLY "U1" TO FRAME frm-observaciones.
END.

&ENDIF  /*--------------- de las observaciones del TABLA_HEADER  -----------------*/


FIND Parametro "CLIOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

FRAME frm-observaciones:WIDTH  = ccoobsdc + 1.5.
FRAME frm-observaciones:HEIGHT = cliobsdc + 2.2.

{&TABLA_HEADER}.{&OBSERVACION}:WIDTH  = ccoobsdc.
{&TABLA_HEADER}.{&OBSERVACION}:HEIGHT = cliobsdc.

btn_CANCEL:COLUMN IN FRAME frm-observaciones = FRAME frm-observaciones:WIDTH  - btn_CANCEL:WIDTH - 0.5.
btn_CANCEL:ROW    IN FRAME frm-observaciones = FRAME frm-observaciones:HEIGHT - btn_CANCEL:HEIGHT - 0.2.
btn_GRABAR:ROW    IN FRAME frm-observaciones = FRAME frm-observaciones:HEIGHT - btn_CANCEL:HEIGHT - 0.2.

find first fac_header.
view frame frm-observaciones.
enable all with frame FRM-observaciones.
wait-for choose of btn_grabar in frame frm-observaciones.
