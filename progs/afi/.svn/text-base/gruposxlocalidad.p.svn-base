/*=========================================================================================*/
/*              REALIZA LA EMISION DEL LISTADO DE GRUPOS POR ZONA GEOGRAFICA               */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_estado       LIKE Grupofam.cdg_estado.
DEFINE INPUT PARAMETER p-des_localidad    LIKE Localidad.cdg_localidad.
DEFINE INPUT PARAMETER p-has_localidad    LIKE Localidad.cdg_localidad.
DEFINE INPUT PARAMETER p-des_empresa      LIKE Empresa.cdg_empresa.
DEFINE INPUT PARAMETER p-has_empresa      LIKE Empresa.cdg_empresa.
DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.

/*=========================================================================================*/
/*                                     VARIABLES Y FRAMES                                  */
/*=========================================================================================*/

{vrshared.i "NEW"}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE titulo_lis                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".

DEFINE VARIABLE que_archivo               AS CHARACTER.
DEFINE VARIABLE p_printed                 AS LOGICAL.

DEFINE VARIABLE v-importe                 LIKE Grupofam.importe_cuota.
DEFINE VARIABLE pto_venta-org             LIKE Rec_header.prf_comprob.
DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE prox_docum                LIKE Parametro.cdg_parametro.

DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-grupofames              AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-grupofames              AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-grupofames              AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE z-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE z-grupofames              AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Socios por Localidad" AT 77
       "Página:" AT 181 PAGE-NUMBER FORMAT ">>9" AT 189
       SKIP  
       fecha_lis       
       titulo_lis AT 77
       hora_lis AT 181
       SKIP
       titulo_det AT 77  
       SKIP(1)
       WITH WIDTH 256 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
    
FORM
       Grupofam.cdg_empresa           COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Grupofam.cdg_grupofam 
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan              COLUMN-LABEL "Código!Plan"
       v-importe               FORMAT "->>>,>>9.99"
       Grupo-domicilio.calle          COLUMN-LABEL "Nombre!calle"
       Grupo-domicilio.nropta         COLUMN-LABEL "Nu-!mero"  FORMAT "X(6)"
       Grupo-domicilio.piso           COLUMN-LABEL "Pi-!so"    FORMAT "X(4)"
       Grupo-domicilio.depto          COLUMN-LABEL "Dep!to"    FORMAT "X(4)"
       Grupo-domicilio.casa           COLUMN-LABEL "Ca-!sa" 
       Grupo-domicilio.prefijotel     COLUMN-LABEL "Pre-!fijo"  FORMAT "X(5)"
       Grupo-domicilio.telefono       COLUMN-LABEL "Nu-!mero"  FORMAT "X(8)"
       Grupofam.fecha_alta            COLUMN-LABEL "Fecha!Alta"
       Grupofam.cdg_promotor          COLUMN-LABEL "Código!Promotor"
       Grupofam.fecha_baja            COLUMN-LABEL "Fecha!Baja"
       Grupofam.cdg_motbaja           COLUMN-LABEL "Mo-!tivo"
       WITH WIDTH 256 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

FORM
       t-Grupofames LABEL "Total Grupos"  
       t-pesos   LABEL "Total Pesos"
       WITH WIDTH 135 DOWN FRAME frm-resumen USE-TEXT STREAM-IO SIDE-LABELS .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
FOR EACH Empresa 
    WHERE Empresa.cdg_empresa <= p-has_empresa
      AND Empresa.cdg_empresa >= p-des_empresa:
     que_empresa =  que_empresa + "," +  Empresa.cdg_empresa.
END.
que_empresa = SUBSTRING(que_empresa,2).
que_empresa = "Empresas: " + que_empresa.

/*{DIRPRINFILE.I}*/

fecha_lis = STRING(TODAY,"99/99/99").
hora_lis = STRING(TIME,"HH:MM:SS").
titulo_lis  = ( IF p-que_estado = "B" THEN "Bajas " ELSE "Activos " ) + 
                 "Altas del " + STRING(p-des_fecha,"99/99/99") + " al " + STRING(p-has_fecha,"99/99/99").

que_archivo = "c:\sic-temp\gruposxlocalidad.txt".

OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

t-Grupofames = 0.
t-pesos   = 0.

FOR EACH Localidad NO-LOCK
    WHERE Localidad.cdg_localidad >= p-des_localidad
      AND Localidad.cdg_localidad <= p-has_localidad 
          BREAK BY Localidad.cdg_localidad
          WITH FRAME frm-listado:

        VIEW FRAME frm-titulo.
        
        titulo_det = Localidad.cdg_localidad + " - " + Localidad.dsc_localidad.

        z-grupofames = 0.
        z-pesos = 0.
    
        OPEN QUERY q_grupos
            FOR EACH Grupo-domicilio NO-LOCK OF Localidad 
                WHERE Grupo-domicilio.cdg_estado = p-que_estado
                  AND Grupo-domicilio.cdg_empresa >= p-des_empresa
                  AND Grupo-domicilio.cdg_empresa <= p-has_empresa
                  AND Grupo-domicilio.cdg_tipodom = "C",
                  FIRST Grupofam OF Grupo-domicilio
                        WHERE Grupofam.fecha_alta   >= p-des_fecha
                          AND Grupofam.fecha_alta   <= p-has_fecha
                              BY Grupofam.cdg_empresa
                              BY Grupofam.cdg_grupofam.

        GET FIRST q_grupos.
        DO WHILE AVAILABLE Grupo-domicilio WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:
        
            RUN valuar_cuota.p ( INPUT ROWID(Grupofam), OUTPUT v-importe ).

            DISPLAY
                Grupofam.cdg_empresa 
                Grupofam.cdg_grupofam 
                Grupofam.nom_grupofam 
                Grupofam.cdg_plan    
                v-importe            
                Grupo-domicilio.calle       
                Grupo-domicilio.nropta      
                Grupo-domicilio.piso        
                Grupo-domicilio.depto       
                Grupo-domicilio.casa         
                Grupo-domicilio.prefijotel   
                Grupo-domicilio.telefono     
                Grupofam.fecha_alta          
                Grupofam.cdg_promotor
                Grupofam.fecha_baja          
                Grupofam.cdg_motbaja         
                WITH FRAME frm-listado USE-TEXT STREAM-IO DOWN.
                
            DOWN WITH FRAME frm-listado.
            
            z-pesos      = z-pesos      + v-importe.
            z-grupofames = z-grupofames + 1.

            GET NEXT q_grupos.

        END.
    
        UNDERLINE
            Grupofam.cdg_empresa 
            Grupofam.cdg_grupofam 
            Grupofam.nom_grupofam 
            Grupofam.cdg_plan    
            v-importe            
            Grupo-domicilio.calle       
            Grupo-domicilio.nropta      
            Grupo-domicilio.piso        
            Grupo-domicilio.depto       
            Grupo-domicilio.casa         
            Grupo-domicilio.prefijotel   
            Grupo-domicilio.telefono     
            Grupofam.fecha_alta          
            Grupofam.cdg_promotor
            Grupofam.fecha_baja          
            Grupofam.cdg_motbaja         
            WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
        
        DISPLAY "Total Localidad " + Localidad.cdg_localidad @ Grupofam.nom_grupofam
            z-Grupofames @ Grupofam.cdg_plan
                 z-pesos @ v-importe
                 WITH FRAME frm-listado.
        
        t-grupofames = t-grupofames + z-grupofames.
        t-pesos = t-pesos + z-pesos.
        
        z-grupofames = 0.
        z-pesos = 0.
    
        DOWN 2 WITH FRAME frm-listado. 
        IF NOT LAST(Localidad.cdg_localidad) THEN PAGE.         

END.

UNDERLINE
    Grupofam.cdg_empresa 
    Grupofam.cdg_grupofam 
    Grupofam.nom_grupofam 
    Grupofam.cdg_plan    
    v-importe            
    Grupo-domicilio.calle       
    Grupo-domicilio.nropta      
    Grupo-domicilio.piso        
    Grupo-domicilio.depto       
    Grupo-domicilio.casa         
    Grupo-domicilio.prefijotel   
    Grupo-domicilio.telefono     
    Grupofam.fecha_alta          
    Grupofam.fecha_baja          
    Grupofam.cdg_motbaja         
    WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
  
DISPLAY "Total General " @ Grupofam.nom_grupofam
            t-Grupofames @ Grupofam.cdg_grupofam
                 t-pesos @ v-importe
                         WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT que_archivo,
                 INPUT 2 ).

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

