/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.

{vrshared.i "NEW"}
{WGLISTAR.I}
{findempresa.I}
DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE v-importe                 AS DECIMAL FORMAT ">,>>>,>>9.99"
                                             COLUMN-LABEL "Importe!Neto".

DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE tiplan                    AS INTEGER.

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Altas de Grupos Familiares por Promotor" AT 57
       "Página:" AT 154 PAGE-NUMBER FORMAT ">>9" AT 163
       SKIP  
       fecha_lis       
       hora_lis AT 154
       SKIP
       titulo_lst AT 57  
       SKIP(1)
       WITH WIDTH 190 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_empresa  COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Grupofam.cdg_promotor COLUMN-LABEL "Cod!Prom" FORMAT "X(4)"
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan        COLUMN-LABEL "Cod!Plan" FORMAT "X(4)"
       Grupofam.cant_capitas
       Grupofam.fecha_alta 
       Grupofam.tipo_compbte COLUMN-LABEL "Tip!Com"
       Grupofam.tipo_grupo   COLUMN-LABEL "G!A"
       Grupofam.num_sucursal COLUMN-LABEL "Cod!Suc" FORMAT "X(4)"
       Grupofam.cdg_estado   COLUMN-LABEL "Cod!Est"
       Grupofam.fecha_baja
       v-importe
       Grupo-domicilio.cdg_zonag COLUMN-LABEL "Cod!Zona" FORMAT "X(4)"
       Grupo-domicilio.calle 
       Grupo-domicilio.nropta 
       Grupo-domicilio.piso 
       Grupo-domicilio.depto
       WITH WIDTH 190 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO  NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("C:\SIC-TEMP\altasxpromotor.txt") PAGED.

titulo_lst = "Altas " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

FOR EACH Grupofam USE-INDEX por_promotor_baja
        WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
           AND CAN-DO (Usuario.lista_empresas,Grupofam.cdg_empresa)
            /*  Grupofam.cdg_empresa  = p-que_empresa */
          AND Grupofam.cdg_promotor >= p-des_vendedor
          AND Grupofam.cdg_promotor <= p-has_vendedor 
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BREAK BY Grupofam.cdg_promotor 
                            BY Grupofam.cdg_empresa 
                            BY Grupofam.cdg_estado 
                            WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.

    v-importe = 0.

    FIND FIRST Grupo-domicilio OF Grupofam WHERE Grupo-domicilio.cdg_tipodom = "C" NO-ERROR.

    IF FIRST-OF(Grupofam.cdg_promotor)
    THEN DO:
        /*
        FIND Vendedor WHERE Vendedor.cdg_vendedor = Grupofam.cdg_promotor NO-LOCK NO-ERROR.
        IF AVAILABLE Vendedor
           THEN titulo_det = Vendedor.cdg_vendedor + " - " + Vendedor.nombre.
           ELSE titulo_det = Grupofam.cdg_promotor + " - " + "?????".
        */   
    END.

    tiplan = IF INDEX("0123456789",SUBSTRING(Grupofam.cdg_plan,1,1)) <> 0 THEN 2 ELSE 1.

    IF Grupofam.tipo_grupo = "G"
    THEN DO:
        FIND FIRST Plan-capita OF Grupofam  
                   WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                         NO-LOCK NO-ERROR.

        IF AVAILABLE Plan-capita
        THEN DO:
             IF Plan-capita.precio_neto <> 0 
             THEN DO:
                  v-importe = ROUND(Plan-capita.precio_neto / 1.105,2 ).
                  g-cupones [ tiplan ] = g-cupones [ tiplan ] + 1.
                  g-pesos [ tiplan ]   = g-pesos [ tiplan ] + v-importe.
             END.     
        END.
        ELSE DO:
             v-importe = ?.
        END.                              
    END.        
    ELSE DO:
    
        IF Grupofam.importe_cuota <> 0
        THEN DO:
            v-importe = ROUND(Grupofam.importe_cuota / 1.105,2 ).
            a-pesos [ tiplan ] = a-pesos [ tiplan ] + v-importe.
             /*c-cap = c-cap + Grupofam.cant_capitas .*/
            a-cupones [ tiplan ] = a-cupones [ tiplan ] + 1.

        END.
    
    END.

    DISPLAY
            Grupofam.cdg_empresa 
            Grupofam.cdg_promotor
            Grupofam.cdg_grupofam  
            Grupofam.nom_grupofam 
            Grupofam.cdg_plan
            Grupofam.cant_capitas
            Grupofam.fecha_alta 
            Grupofam.tipo_compbte 
            Grupofam.tipo_grupo 
            Grupofam.num_sucursal 
            Grupofam.cdg_estado
            Grupofam.fecha_baja
            v-importe
            Grupo-domicilio.cdg_zonag WHEN AVAILABLE Grupo-domicilio
            Grupo-domicilio.calle     WHEN AVAILABLE Grupo-domicilio
            Grupo-domicilio.nropta    WHEN AVAILABLE Grupo-domicilio 
            Grupo-domicilio.piso      WHEN AVAILABLE Grupo-domicilio
            Grupo-domicilio.depto     WHEN AVAILABLE Grupo-domicilio
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.   

    IF LAST-OF(Grupofam.cdg_promotor)
    THEN DO:
        UNDERLINE
              Grupofam.cdg_empresa 
              Grupofam.cdg_promotor
              Grupofam.cdg_grupofam  
              Grupofam.nom_grupofam 
              Grupofam.cdg_plan
              Grupofam.cant_capitas
              Grupofam.fecha_alta 
              Grupofam.tipo_compbte 
              Grupofam.tipo_grupo 
              Grupofam.num_sucursal 
              Grupofam.cdg_estado
              Grupofam.fecha_baja
              v-importe
              Grupo-domicilio.cdg_zonag 
              Grupo-domicilio.calle 
              Grupo-domicilio.nropta 
              Grupo-domicilio.piso 
              Grupo-domicilio.depto
              WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
      
        DISPLAY "Total Grupos Blanco"    @ Grupofam.nom_grupofam
                    g-cupones [ 1 ] @ Grupofam.cdg_plan
                      g-pesos [ 1 ] @ v-importe
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
        DISPLAY "Total Grupos Dorado"    @ Grupofam.nom_grupofam
                    g-cupones [ 2 ] @ Grupofam.cdg_plan
                      g-pesos [ 2 ] @ v-importe
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        
        DISPLAY "      Areas  Blanco"    @ Grupofam.nom_grupofam
                    a-cupones [ 1 ] @ Grupofam.cdg_plan
                      a-pesos [ 1 ] @ v-importe
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        DISPLAY "      Areas  Dorado"    @ Grupofam.nom_grupofam
                    a-cupones [ 2 ] @ Grupofam.cdg_plan
                      a-pesos [ 2 ] @ v-importe
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
    
        UNDERLINE
              Grupofam.cdg_empresa 
              Grupofam.cdg_promotor
              Grupofam.cdg_grupofam  
              Grupofam.nom_grupofam 
              Grupofam.cdg_plan
              Grupofam.cant_capitas
              Grupofam.fecha_alta 
              Grupofam.tipo_compbte 
              Grupofam.tipo_grupo 
              Grupofam.num_sucursal 
              Grupofam.cdg_estado
              Grupofam.fecha_baja
              v-importe
              Grupo-domicilio.cdg_zonag 
              Grupo-domicilio.calle 
              Grupo-domicilio.nropta 
              Grupo-domicilio.piso 
              Grupo-domicilio.depto
              WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        DISPLAY a-pesos [ 1 ] + g-pesos [ 1 ] +
                a-pesos [ 2 ] + g-pesos [ 2 ] @ v-importe
                WITH FRAME frm-listado.
        DOWN 2 WITH FRAME frm-listado.          

        DO tiplan = 1 TO 2:
        
            t-pesos [ tiplan ]   = t-pesos [ tiplan ] + a-pesos [ tiplan ] + g-pesos [ tiplan ].
            t-cupones [ tiplan ] = t-cupones [ tiplan ] + a-cupones [ tiplan ] + g-cupones [ tiplan ].
        
            g-cupones [ tiplan ] = 0.
            g-pesos [ tiplan ]   = 0.
            a-cupones [ tiplan ] = 0.
            a-pesos [ tiplan ]   = 0.
        
        END.
    
    END.

END.       

UNDERLINE
      Grupofam.cdg_empresa 
      Grupofam.cdg_promotor
      Grupofam.cdg_grupofam  
      Grupofam.nom_grupofam 
      Grupofam.cdg_plan
      Grupofam.cant_capitas
      Grupofam.fecha_alta 
      Grupofam.tipo_compbte 
      Grupofam.tipo_grupo 
      Grupofam.num_sucursal 
      Grupofam.cdg_estado
      Grupofam.fecha_baja
      v-importe
      Grupo-domicilio.cdg_zonag 
      Grupo-domicilio.calle 
      Grupo-domicilio.nropta 
      Grupo-domicilio.piso 
      Grupo-domicilio.depto
      WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
  
DISPLAY "Total General Blanco"    @ Grupofam.nom_grupofam
            t-cupones [ 1 ] @ Grupofam.cdg_plan
              t-pesos [ 1 ] @ v-importe
        WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
DISPLAY "Total General Dorado"    @ Grupofam.nom_grupofam
            t-cupones [ 2 ] @ Grupofam.cdg_plan
              t-pesos [ 2 ] @ v-importe
        WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

UNDERLINE
      Grupofam.cdg_empresa 
      Grupofam.cdg_promotor
      Grupofam.cdg_grupofam  
      Grupofam.nom_grupofam 
      Grupofam.cdg_plan
      Grupofam.cant_capitas
      Grupofam.fecha_alta 
      Grupofam.tipo_compbte 
      Grupofam.tipo_grupo 
      Grupofam.num_sucursal 
      Grupofam.cdg_estado
      Grupofam.fecha_baja
      v-importe
      Grupo-domicilio.cdg_zonag 
      Grupo-domicilio.calle 
      Grupo-domicilio.nropta 
      Grupo-domicilio.piso 
      Grupo-domicilio.depto
      WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

DISPLAY "       Total General"        @ Grupofam.nom_grupofam
    t-cupones [ 1 ] + t-cupones [ 2 ] @ Grupofam.cdg_plan
    t-pesos [ 1 ] + t-pesos [ 2 ]     @ v-importe
            WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\altasxpromotor.txt",
                 INPUT 2 ).

