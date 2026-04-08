/*=========================================================================================*/
/*              REALIZA LA EMISION DEL LISTADO DE GRUPOS POR ZONA GEOGRAFICA               */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_zonag        LIKE Zona_cobranza.cdg_zonag.
DEFINE INPUT PARAMETER p-has_zonag        LIKE Zona_cobranza.cdg_zonag.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.

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
       "Socios Activos por Zona Geográfica" AT 77
       "Página:" AT 173 PAGE-NUMBER FORMAT ">>9" AT 181
       SKIP  
       fecha_lis       
       titulo_lis AT 77
       hora_lis AT 173
       SKIP
       titulo_det AT 77  
       SKIP(1)
       WITH WIDTH 256 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
    
FORM
       Grupofam.cdg_empresa    COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Grupofam.cdg_grupofam 
       Grupofam.nom_grupofam 
       Grupofam.fecha_alta     COLUMN-LABEL "Fecha!Alta"
       Grupofam.cdg_plan       COLUMN-LABEL "Código!Plan"
       v-importe               FORMAT "->>>,>>9.99"
       Grupo-domicilio.num_domicilio COLUMN-LABEL "Nro!dom" FORMAT ">>9"
       Grupo-domicilio.cdg_tipodom   COLUMN-LABEL "Tip!dom"  FORMAT "X(1)"
       Grupo-domicilio.calle 
       Grupo-domicilio.nropta   COLUMN-LABEL "Nu-!mero"  FORMAT "X(5)"
       Grupo-domicilio.piso     COLUMN-LABEL "Pi-!so"    FORMAT "X(4)"
       Grupo-domicilio.depto    COLUMN-LABEL "Dep!to"    FORMAT "X(4)"
       Grupo-domicilio.casa     
       Grupo-domicilio.cdg_localidad 
       Grupo-domicilio.cdg_postal 
       Grupo-domicilio.prefijotel COLUMN-LABEL "Pre-!fijo"  FORMAT "X(5)"
       Grupo-domicilio.telefono   COLUMN-LABEL "Nu-!mero"  FORMAT "X(8)"
       Grupo-domicilio.refer COLUMN-LABEL "Referencia!Domicilio"
       WITH WIDTH 256 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

FORM
       t-Grupofames LABEL "Total Grupos"  
       t-pesos   LABEL "Total Pesos"
       WITH WIDTH 135 DOWN FRAME frm-resumen USE-TEXT STREAM-IO SIDE-LABELS .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

/*{DIRPRINFILE.I}*/

fecha_lis = STRING(TODAY,"99/99/99").
hora_lis = STRING(TIME,"HH:MM:SS").
titulo_lis  = "Emision del " + STRING(p-des_fecha,"99/99/99") + 
              " al " + 
              STRING(p-has_fecha,"99/99/99").

que_archivo = "c:\sic-temp\gruposxzona.txt".

OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

t-Grupofames = 0.
t-pesos   = 0.

FOR EACH Zona_cobranza NO-LOCK
    WHERE Zona_cobranza.cdg_zonag >= p-des_zonag
      AND Zona_cobranza.cdg_zonag <= p-has_zonag 
          WITH FRAME frm-listado :

        VIEW FRAME frm-titulo.
        
        titulo_det = Zona_cobranza.cdg_zonag + " - " + Zona_cobranza.dsc_zonag.

        z-grupofames = 0.
        z-pesos = 0.
    
        FOR EACH Grupofam NO-LOCK OF Zona_cobranza 
            WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
              AND Grupofam.fecha_alta   >= p-des_fecha
              AND Grupofam.fecha_alta   <= p-has_fecha
              AND Grupofam.cdg_estado = "A"
                  BREAK BY Grupofam.cdg_empresa 
                        BY Grupofam.cdg_zona
                  WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:
        
            VIEW FRAME frm-titulo.
        
            IF Grupofam.tipo_compbte = "R" OR 
               Grupofam.tipo_compbte = "F"
               THEN RUN buscar_importe.
               ELSE v-importe = 0.


            FIND FIRST Grupo-domicilio NO-LOCK OF Grupofam 
                 WHERE Grupo-domicilio.cdg_tipodom = "C" NO-ERROR.


            RUN buscar_importe.

            DISPLAY
                Grupofam.cdg_empresa   /*WHEN FIRST-OF(Grupofam.cdg_empresa)*/
                Grupofam.cdg_grupofam 
                Grupofam.nom_grupofam 
                Grupofam.fecha_alta 
                v-importe
                Grupofam.cdg_plan
                Grupo-domicilio.num_domicilio     WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.cdg_tipodom       WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.calle             WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.nropta            WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.piso              WHEN AVAILABLE Grupo-domicilio 
                Grupo-domicilio.depto             WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.casa              WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.cdg_localidad     WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.cdg_postal        WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.prefijotel        WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.telefono          WHEN AVAILABLE Grupo-domicilio
                Grupo-domicilio.refer             WHEN AVAILABLE Grupo-domicilio
                WITH FRAME frm-listado USE-TEXT STREAM-IO DOWN.
                
            DOWN WITH FRAME frm-listado.
            
            z-pesos      = z-pesos      + v-importe.
            z-grupofames = z-grupofames + 1.

        END.
    
        UNDERLINE
            Grupofam.cdg_empresa   
            Grupofam.cdg_grupofam 
            Grupofam.nom_grupofam 
            Grupofam.fecha_alta 
            v-importe
            Grupofam.cdg_plan
            Grupo-domicilio.num_domicilio 
            Grupo-domicilio.cdg_tipodom 
            Grupo-domicilio.calle 
            Grupo-domicilio.nropta 
            Grupo-domicilio.piso 
            Grupo-domicilio.depto 
            Grupo-domicilio.casa 
            Grupo-domicilio.cdg_localidad 
            Grupo-domicilio.cdg_postal 
            Grupo-domicilio.prefijotel 
            Grupo-domicilio.telefono 
            Grupo-domicilio.refer
            WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
        
        DISPLAY "Total Zona " + Grupo-domicilio.cdg_zonag @ Grupofam.nom_grupofam
            z-Grupofames @ Grupofam.cdg_grupofam
                 z-pesos @ v-importe
                 WITH FRAME frm-listado.
        
        t-grupofames = t-grupofames + z-grupofames.
        t-pesos = t-pesos + z-pesos.
        
        z-grupofames = 0.
        z-pesos = 0.
    
        DOWN 2 WITH FRAME frm-listado.          

END.

UNDERLINE
    Grupofam.cdg_empresa   
    Grupofam.cdg_grupofam 
    Grupofam.nom_grupofam 
    Grupofam.fecha_alta 
    v-importe
    Grupofam.cdg_plan
    Grupo-domicilio.num_domicilio 
    Grupo-domicilio.cdg_tipodom 
    Grupo-domicilio.calle 
    Grupo-domicilio.nropta 
    Grupo-domicilio.piso 
    Grupo-domicilio.depto 
    Grupo-domicilio.casa 
    Grupo-domicilio.cdg_localidad 
    Grupo-domicilio.cdg_postal 
    Grupo-domicilio.prefijotel 
    Grupo-domicilio.telefono 
    Grupo-domicilio.refer
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

PROCEDURE buscar_importe:

    IF Grupofam.tipo_grupo = "G"
    THEN DO:

        FIND FIRST Plan-capita OF Grupofam  
                   WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                         NO-LOCK NO-ERROR.

        IF AVAILABLE Plan-capita
        THEN DO:
             v-importe = Plan-capita.precio_neto.
        END.
        ELSE DO:
             v-importe = ?.
        END.                              

    END.        
    ELSE DO:
        v-importe = Grupofam.importe_cuota.       
    END.

END PROCEDURE.
