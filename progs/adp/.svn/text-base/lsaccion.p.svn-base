/*=================================================================================*/
/*                        LISTADO DE LA ACCION DE LAS NOVEDADES                    */
/*=================================================================================*/

DEFINE INPUT PARAMETER disp_out  AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

&SCOPED-DEFINE TABLA              Novedad   
&SCOPED-DEFINE CODIGO             cdg_novedad
&SCOPED-DEFINE NOMBRE             descripcion

{DFVRANGO.I}

DEFINE VARIABLE str_estados    AS   CHARACTER FORMAT "X(30)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.

DEFINE BUFFER Dato_concepto FOR Tit_dat_liquid.
DEFINE BUFFER Dato_dato     FOR Tit_dat_liquid.

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       "Accion de las novedades" AT 40
       "Pagina:" AT 85 PAGE-NUMBER FORMAT ">>9" AT 92 
       SKIP
       fecha_lis hora_lis AT 85
       SKIP(1)
       "---------------------------------------------------------------------------------------------" SKIP
       "Cd. Descripcion               st estados                                                     " SKIP
       "    <-------------- Accion sobre Conceptos ----------------->    <-- Accion sobre datos ---->" SKIP
       "    <  Abrevia  Op  L. Dato de liq.      V.min.        V.max>    <  Abrevia  Op V     V.Fijo>" SKIP
       "---------------------------------------------------------------------------------------------" SKIP
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.

FORM 
    Novedad.cdg_novedad
    Novedad.descripcion
    Novedad.cdg_estado
    str_estados
    WITH WIDTH 96 DOWN FRAME frm-entidad USE-TEXT STREAM-IO NO-LABEL.

FORM 
    SPACE(3)
    Concepto.cdg_concepto
    Concepto.abrevia
    Accion_concepto.op_concepto
    Accion_concepto.cant_liq 
    Dato_concepto.cdg_datliq 
    Dato_concepto.abrevia
    Accion_concepto.desde_valor 
    Accion_concepto.hasta_valor 
    SPACE(4)
    Dato_dato.cdg_datliq 
    Dato_dato.abrevia
    Accion_dato.op_dato 
    Accion_dato.op_valor 
    Accion_dato.valor_fijo
    WITH WIDTH 96 DOWN FRAME frm-acciones USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                                  BLOQUE PRINCIPAL                               */
/*=================================================================================*/

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(dire_tmp + "lsaccion.txt") PAGE-SIZE 72.

IF ver_por = 1
THEN DO:
   OPEN QUERY qry_listado 
   FOR EACH Novedad WHERE Novedad.cdg_novedad >= des_codigo
                       AND Novedad.cdg_novedad <= has_codigo
                        BY Novedad.cdg_novedad.
END.
ELSE DO:
   OPEN QUERY qry_listado
   FOR EACH Novedad WHERE Novedad.descripcion >= des_nombre
                       AND Novedad.descripcion <= has_nombre
                        BY Novedad.descripcion.
END.

GET FIRST qry_listado.
DO WHILE AVAILABLE Novedad:     

    VIEW FRAME frm-titulo.

    str_estados = "".
    FOR EACH Novedad_estado OF Novedad NO-LOCK:
        str_estados = str_estados + Novedad_estado.cdg_estado + ",".
    END.
    str_estados = SUBSTRING(str_estados,1,LENGTH(str_estados) - 1).    

    DISPLAY 
           Novedad.cdg_novedad
           Novedad.descripcion
           Novedad.cdg_estado
           str_estados
           WITH FRAME frm-entidad.    

    OPEN QUERY qry_datos 
         FOR EACH Accion_dato OF Novedad, FIRST Dato_dato OF Accion_dato.
    OPEN QUERY qry_conceptos 
         FOR EACH Accion_concepto OF Novedad, FIRST Concepto OF Accion_concepto.         

    GET FIRST qry_datos.
    GET FIRST qry_conceptos.
    DO WHILE AVAILABLE Accion_dato OR AVAILABLE Accion_concepto:
    
       IF AVAILABLE Accion_concepto THEN FIND Dato_concepto OF Accion_concepto NO-ERROR.

       DISPLAY 
           Concepto.cdg_concepto        WHEN AVAILABLE Accion_concepto
           Concepto.abrevia             WHEN AVAILABLE Accion_concepto
           Accion_concepto.op_concepto  WHEN AVAILABLE Accion_concepto
           Accion_concepto.cant_liq     WHEN AVAILABLE Accion_concepto
           Dato_concepto.cdg_datliq     WHEN AVAILABLE Accion_concepto AND AVAILABLE Dato_concepto
           Dato_concepto.abrevia        WHEN AVAILABLE Accion_concepto AND AVAILABLE Dato_concepto
           Accion_concepto.desde_valor  WHEN AVAILABLE Accion_concepto AND AVAILABLE Dato_concepto
           Accion_concepto.hasta_valor  WHEN AVAILABLE Accion_concepto AND AVAILABLE Dato_concepto
           Dato_dato.cdg_datliq         WHEN AVAILABLE Accion_dato
           Dato_dato.abrevia            WHEN AVAILABLE Accion_dato
           Accion_dato.op_dato          WHEN AVAILABLE Accion_dato
           Accion_dato.op_valor         WHEN AVAILABLE Accion_dato
           Accion_dato.valor_fijo       WHEN AVAILABLE Accion_dato
           WITH FRAME frm-acciones.

       DOWN   WITH FRAME frm-acciones.

       GET NEXT qry_datos.
       GET NEXT qry_conceptos.
       
    END.
    
    DOWN WITH FRAME frm-entidad.
    GET NEXT qry_listado.   

END.           
    
OUTPUT CLOSE.    

IF disp_out <> "A" THEN RUN PROPRINT.P ( INPUT dire_tmp + "lsaccion.txt").



