/*=================================================================================*/
/*           RECORRE LA CLASIFICACION DE ARTICULOS Y ARMA EL BALANCE               */
/*=================================================================================*/

{tmplistadoventasprf.i}
{findempresa.i}
    
DEFINE INPUT PARAMETER  des_fecha                AS DATE LABEL "Desde Fecha" NO-UNDO.
DEFINE INPUT PARAMETER  has_fecha                AS DATE LABEL "Hasta Fecha" INITIAL TODAY NO-UNDO.
DEFINE INPUT PARAMETER  prfs                     AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER  p-cdg_moneda             AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER  p-ver_cotizacion         AS INTEGER NO-UNDO.
DEFINE INPUT PARAMETER  p-fecha                  AS DATE NO-UNDO.
DEFINE INPUT PARAMETER  p-filtro_atributos       AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER que_clase                 AS ROWID NO-UNDO.
DEFINE INPUT PARAMETER nivel                     AS INTEGER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER c-linea            AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER p-linea_total            AS INTEGER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Listado.

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE VARIABLE v-linea_subtotal   AS INTEGER.

DEFINE BUFFER Clase                FOR Clase_de_articulo.
DEFINE BUFFER Subclase             FOR Clase_de_articulo.
DEFINE BUFFER T-Subtotal           FOR T-Listado.

DEFINE QUERY qry_clasificacion     FOR Subclase.
DEFINE QUERY qry_articulos         FOR Articulo.

DEFINE VARIABLE que_subclase       AS CHARACTER.

DEFINE STREAM salida.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.

IF Clase.cdg_clase <> ?
THEN DO:    
    que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
   RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */

   c-linea = c-linea + 1.
   CREATE T-Listado.
   ASSIGN T-Listado.que_padre         = Clase.cdg_clase
          T-Listado.que_codigo        = Clase.cdg_subclase
          T-Listado.que_nombre        = Clase.nombre_subclase
          T-Listado.l-nivel           = nivel
          T-Listado.linea             = c-linea.

   p-linea_total = c-linea.

   nivel = nivel + 1.
END.   

RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */

IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase)
THEN DO: /* No es el último nivel. Seguimos profundizando */

   RUN abre_query_clasificacion.
   GET FIRST qry_clasificacion.
   DO WHILE AVAILABLE Subclase:              
      
       RUN recorrer_clasificacion_ventasprf.p ( INPUT des_fecha,
                                             INPUT has_fecha,
                                             INPUT prfs,
                                             INPUT p-cdg_moneda,
                                             INPUT p-ver_cotizacion,
                                             INPUT p-fecha,
                                             INPUT p-filtro_atributos,
                                             INPUT ROWID(Subclase), 
                                             INPUT nivel,
                                             INPUT-OUTPUT c-linea,
                                             OUTPUT v-linea_subtotal,
                                             INPUT-OUTPUT TABLE T-Listado BY-REFERENCE ).

       FIND T-Listado WHERE T-Listado.linea = p-linea_total.
       FIND T-Subtotal WHERE T-Subtotal.linea = v-linea_subtotal.
       ASSIGN T-Listado.l-tot_cantidad = T-Listado.l-tot_cantidad + T-Subtotal.l-tot_cantidad 
              T-Listado.l-tot_granel   = T-Listado.l-tot_granel   + T-Subtotal.l-tot_granel   
              T-Listado.l-tot_importe  = T-Listado.l-tot_importe  + T-Subtotal.l-tot_importe.  
                    
       GET NEXT qry_clasificacion.

   END.

END.

/* Vemos si en este nivel hay articulos asociados. Esto permite */
/* tener articulo y subclase asociados a la misma clase         */

RUN abre_query_articulos.
GET FIRST qry_articulos.
DO WHILE AVAILABLE Articulo:
    
    DEFINE VARIABLE v-tot_cantidad       LIKE T-Listado.l-tot_cantidad. 
    DEFINE VARIABLE v-tot_granel         LIKE T-Listado.l-tot_granel.   
    DEFINE VARIABLE v-tot_importe        LIKE T-Listado.l-tot_importe.  
    FOR EACH  Punto-venta WHERE Punto-venta.cdg_empresa = empresa.cdg_empresa:
        IF NOT can-do(prfs, string(Punto-venta.cdg_puntovta,"9999") ) THEN NEXT.
        RUN sumar_ventasprf.p (  
                              INPUT Articulo.cdg_articulo,
                              INPUT des_fecha,
                              INPUT has_fecha,
                              INPUT Punto-venta.cdg_puntovta,
                              INPUT p-cdg_moneda,
                              INPUT p-ver_cotizacion,
                              INPUT p-fecha,
                              INPUT p-filtro_atributos,
                              OUTPUT v-tot_cantidad,
                              OUTPUT v-tot_granel,
                              OUTPUT v-tot_importe).      
    
        IF v-tot_cantidad <> 0 OR
           v-tot_granel <> 0 OR
           v-tot_importe <> 0 OR TRUE
        THEN DO:
            c-linea = c-linea + 1.
    
            CREATE T-Listado.
            ASSIGN T-Listado.que_padre      = Articulo.cdg_subclase
                   T-Listado.que_codigo     = Articulo.cdg_articulo
                   T-Listado.que_nombre     = Articulo.descripcion
                   T-Listado.l-nivel        = nivel
                   T-Listado.linea          = c-linea
                   T-Listado.l-tot_cantidad = v-tot_cantidad 
                   T-Listado.l-tot_granel   = v-tot_granel   
                   T-Listado.l-tot_importe  = v-tot_importe
                   T-Listado.cdg_puntovta   = punto-venta.cdg_puntovta.  
    
            FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
            T-Listado.l-cdg_umed    = Unidad.abrevia.
            FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
            T-Listado.l-cdg_ugranel = Unidad.abrevia.    
    
            FIND T-Listado WHERE T-Listado.linea = p-linea_total.
            ASSIGN T-Listado.l-tot_cantidad = T-Listado.l-tot_cantidad + v-tot_cantidad 
                   T-Listado.l-tot_granel   = T-Listado.l-tot_granel   + v-tot_granel   
                   T-Listado.l-tot_importe  = T-Listado.l-tot_importe  + v-tot_importe.  
    
        END.
    END.
    GET NEXT qry_Articulos.
END.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE abre_query_clasificacion:

    OPEN QUERY qry_clasificacion 
        FOR EACH Subclase 
            WHERE Subclase.cdg_clase = Clase.cdg_subclase NO-LOCK. 

END PROCEDURE.

PROCEDURE abre_query_articulos:

    OPEN QUERY qry_Articulos 
        FOR EACH Articulo 
           WHERE Articulo.cdg_subclase = Clase.cdg_subclase NO-LOCK
              BY Articulo.cdg_articulo . 
                              
END PROCEDURE.

PROCEDURE IDENTAR:

    DEFINE INPUT PARAMETER i-columna AS INTEGER.
  
    v-esp = FILL(" ",i-columna).

END PROCEDURE.


