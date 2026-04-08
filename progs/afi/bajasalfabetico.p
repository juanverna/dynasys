/*=========================================================================================*/
/*            EMITE EL LISTADO DE BAJAS ORDENADO ALFABETICAMENTE                           */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-desde_baja       AS DATE.
DEFINE INPUT PARAMETER p-hasta_baja       AS DATE.
DEFINE INPUT PARAMETER p-lista_tipos      AS CHARACTER.

/*=========================================================================================*/
/*                                         VARIABLES                                       */
/*=========================================================================================*/

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE v-debito                  LIKE Cta_cte.debito.
DEFINE VARIABLE v-credito                  LIKE Cta_cte.credito.

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE v-importe                 AS DECIMAL FORMAT ">>,>>9.99"
                                             COLUMN-LABEL "Importe!Cuota".
DEFINE VARIABLE v-saldo                   AS DECIMAL FORMAT "->>,>>9.99"
                                             COLUMN-LABEL "Importe!Deuda".
DEFINE VARIABLE raya                      AS CHARACTER FORMAT "X(20)"
                                             COLUMN-LABEL "Observaciones!Telemarketing".
DEFINE VARIABLE v-domicilio               AS CHARACTER FORMAT "X(30)"
                                             COLUMN-LABEL "Domicilio!de cobranza".
DEFINE VARIABLE v-localidad               AS CHARACTER FORMAT "X(20)"
                                             COLUMN-LABEL "Localidad y!Código Postal".
DEFINE VARIABLE v-telefono                AS CHARACTER FORMAT "X(15)"
                                             COLUMN-LABEL "Teléfono!del domicilio".

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE t-grupos                  AS INTEGER.
DEFINE VARIABLE t-pesos                   AS DECIMAL.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Bajas de Grupos Familiares Alfabético" AT 80
       "Página:" AT 174 PAGE-NUMBER FORMAT ">>9" AT 182
       SKIP  
       fecha_lis       
       titulo_det AT 80  
       hora_lis AT 174
       SKIP
       titulo_lst AT 80  
       SKIP(1)
       WITH WIDTH 256 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_empresa  COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan     COLUMN-LABEL "Cod!Plan" FORMAT "X(4)"
       Grupofam.cant_capitas COLUMN-LABEL "Cant!Cap." FORMAT ">>>>9"
       Grupofam.fecha_alta   COLUMN-LABEL "Fecha!Alta" 
       Grupofam.num_sucursal COLUMN-LABEL "Cod!Suc" FORMAT "X(4)"
       Grupofam.fecha_baja   COLUMN-LABEL "Fecha!Baja"
       Grupofam.cdg_motbaja  COLUMN-LABEL "Mot!Baja" 
       v-domicilio
       v-localidad 
       v-telefono  
       v-importe
       v-saldo
       raya
       WITH WIDTH 256 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

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

OUTPUT TO VALUE("C:\SIC-TEMP\bajasalfabetico.txt") PAGED.

titulo_det = "Bajas " + STRING(p-desde_baja,"99/99/99") + " al " + STRING(p-hasta_baja,"99/99/99").
titulo_lst = "Altas " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").
raya = FILL("-",256).

t-grupos = 0.
t-pesos  = 0.

FOR EACH Grupofam USE-INDEX por_promotor_baja
        WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
          AND Grupofam.cdg_estado   = "B"
          AND LOOKUP(Grupofam.tipo_grupo,p-lista_tipos,"|") <> 0
          AND Grupofam.fecha_baja   >= p-desde_baja
          AND Grupofam.fecha_baja   <= p-hasta_baja
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BY Grupofam.cdg_empresa 
                      BY Grupofam.nom_grupofam 
                      WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.

    v-saldo = 0.
    FIND Cliente OF Grupofam NO-LOCK NO-ERROR.
    IF AVAILABLE Cliente
    THEN DO:
        FOR EACH Cta_cte NO-LOCK OF Cliente BY Cta_cte.fecha_emision:
    
            v-saldo  = v-saldo + Cta_cte.debito - Cta_cte.credito.
    
        END. /* De recorrer la cuenta corriente */
    END.

    RUN valuar_cuota.p ( INPUT ROWID(Grupofam),
                         OUTPUT v-importe ).

    FIND FIRST Grupo-domicilio OF Grupofam WHERE Grupo-domicilio.cdg_tipodom = "C" NO-LOCK.

    v-domicilio = Grupo-domicilio.calle + " " + Grupo-domicilio.nropta + " " +
                  Grupo-domicilio.piso  + " " + Grupo-domicilio.depto  + " " +
                  Grupo-domicilio.casa.

    v-localidad = Grupo-domicilio.cdg_localidad + " " + 
                  Grupo-domicilio.cdg_postal.

    v-telefono  = Grupo-domicilio.prefijotel + "-" + Grupo-domicilio.telefono.

    DISPLAY
            Grupofam.cdg_empresa  
            Grupofam.cdg_grupofam  
            Grupofam.nom_grupofam 
            Grupofam.cdg_plan     
            Grupofam.cant_capitas
            Grupofam.fecha_alta 
            Grupofam.num_sucursal 
            Grupofam.fecha_baja   
            Grupofam.cdg_motbaja   
            v-domicilio
            v-localidad
            v-telefono
            v-importe
            v-saldo
            raya
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.   
    
    t-grupos = t-grupos + 1.
    t-pesos  = t-pesos + v-importe.
   
END.       


UNDERLINE
    Grupofam.cdg_empresa  
    Grupofam.cdg_grupofam  
    Grupofam.nom_grupofam 
    Grupofam.cdg_plan     
    Grupofam.cant_capitas
    Grupofam.fecha_alta 
    Grupofam.num_sucursal 
    Grupofam.fecha_baja   
    Grupofam.cdg_motbaja   
    v-domicilio
    v-localidad
    v-telefono
    v-importe
    v-saldo
    raya
    WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.   
DISPLAY "Total Bajas" @ Grupofam.nom_grupofam 
        t-grupos      @ Grupofam.cdg_plan     
        t-pesos       @ v-importe     
        WITH FRAME frm-listado.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\bajasalfabetico.txt",
                 INPUT 2 ).

