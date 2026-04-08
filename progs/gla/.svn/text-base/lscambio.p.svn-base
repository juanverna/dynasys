/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_moneda AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_moneda     LIKE Moneda.cdg_moneda.
DEFINE VARIABLE que_descripcion     LIKE Moneda.descripcion.


DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP
       fecha_lis titulo-2 AT 28 hora_lis AT 70
       SKIP(1)
       que_moneda  AT 28
       que_descripcion
       SKIP(1)
       WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Cotizacion.fch_cotizacion
       Cotizacion.cambio
       Cotizacion.observacion
       WITH WIDTH 80 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Moneda WHERE ROWID(Moneda) = rid_moneda.

que_moneda = Moneda.cdg_moneda.
que_descripcion =  Moneda.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(DIRE_TMP + "lscambio.txt") PAGED PAGE-SIZE 72.
RUN LISTAR_COTIZACION.
OUTPUT CLOSE.

RUN PRINFILE.P ( INPUT DIRE_TMP + "lscambio.txt", INPUT port).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE LISTAR_COTIZACION:

   titulo-f = "Tabla de Cotizaciones".
   titulo-2 = STRING(des_fecha) +  " - " + STRING(has_fecha) + 
              " - " + Moneda.descripcion.
  
   FOR EACH Cotizacion OF Moneda 
       WHERE Cotizacion.fch_cotizacion >= des_fecha 
         AND Cotizacion.fch_cotizacion <= has_fecha
          BY Cotizacion.fch_cotizacion WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       DISPLAY   
            Cotizacion.fch_cotizacion
            Cotizacion.cambio
            Cotizacion.observacion
            WITH FRAME frm-listado.
              
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cotizacion.fch_cotizacion
           Cotizacion.cambio
           Cotizacion.observacion
           WITH FRAME frm-listado.
           
END PROCEDURE.   

{CODIMPRE.I}
 