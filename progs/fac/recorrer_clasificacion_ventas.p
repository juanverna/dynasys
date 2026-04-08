/*=================================================================================*/
/*           RECORRE LA CLASIFICACION DE ARTICULOS Y ARMA EL BALANCE               */
/*=================================================================================*/

{tmplistadoventas.i}

DEFINE INPUT PARAMETER  des_fecha                AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER  has_fecha                AS DATE LABEL "Hasta Fecha" INITIAL TODAY.
DEFINE INPUT PARAMETER  det_sino                 AS LOGICAL. 
DEFINE INPUT PARAMETER  cero_sino                AS LOGICAL.
DEFINE INPUT PARAMETER  p-cdg_moneda             AS CHARACTER.
DEFINE INPUT PARAMETER  p-ver_cotizacion         AS INTEGER.
DEFINE INPUT PARAMETER  p-fecha                  AS DATE.
DEFINE INPUT PARAMETER  p-filtro_atributos       AS CHARACTER.
DEFINE INPUT PARAMETER que_clase                 AS ROWID.
DEFINE INPUT PARAMETER nivel                     AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER c-linea            AS INTEGER.
DEFINE OUTPUT PARAMETER p-linea_total            AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Listado.

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE VARIABLE v-linea_subtotal   AS INTEGER.

DEFINE VARIABLE debugg_sino        AS LOGICAL INITIAL NO. 

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
/*MESSAGE Clase.cdg_claseart Clase.cdg_subclaseart VIEW-AS ALERT-BOX ERROR.*/

IF debugg_sino THEN MESSAGE "Entra con clase = " Clase.cdg_clase "Subclase = " Clase.cdg_subclase "nivel" nivel SKIP(1)
    "Vuelco de stack" SKIP(1)

        13 PROGRAM-NAME(13) SKIP
        12 PROGRAM-NAME(12) SKIP
        11 PROGRAM-NAME(11) SKIP
        10 PROGRAM-NAME(10) SKIP
        09 PROGRAM-NAME(09) SKIP
        08 PROGRAM-NAME(08) SKIP
        07 PROGRAM-NAME(07) SKIP
        06 PROGRAM-NAME(06) SKIP
        05 PROGRAM-NAME(05) SKIP
        04 PROGRAM-NAME(04) SKIP
        03 PROGRAM-NAME(03) SKIP
        02 PROGRAM-NAME(02) SKIP
        01 PROGRAM-NAME(01) SKIP

    VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "Recorrer Clasificacion Ventas".

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
      
       RUN recorrer_clasificacion_ventas.p ( INPUT des_fecha,
                                             INPUT has_fecha,
                                             INPUT det_sino,
                                             INPUT cero_sino,
                                             INPUT p-cdg_moneda,
                                             INPUT p-ver_cotizacion,
                                             INPUT p-fecha,
                                             INPUT p-filtro_atributos,
                                             INPUT ROWID(Subclase), 
                                             INPUT nivel,
                                             INPUT-OUTPUT c-linea,
                                             OUTPUT v-linea_subtotal,
                                             INPUT-OUTPUT TABLE T-Listado).

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

    RUN sumar_ventas.p (  INPUT Articulo.cdg_articulo,
                          INPUT des_fecha,
                          INPUT has_fecha,
                          INPUT det_sino,
                          INPUT cero_sino,
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
               T-Listado.l-tot_importe  = v-tot_importe.  

        FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
        T-Listado.l-cdg_umed    = Unidad.abrevia.
        FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
        T-Listado.l-cdg_ugranel = Unidad.abrevia.    

        FIND T-Listado WHERE T-Listado.linea = p-linea_total.
        ASSIGN T-Listado.l-tot_cantidad = T-Listado.l-tot_cantidad + v-tot_cantidad 
               T-Listado.l-tot_granel   = T-Listado.l-tot_granel   + v-tot_granel   
               T-Listado.l-tot_importe  = T-Listado.l-tot_importe  + v-tot_importe.  

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


