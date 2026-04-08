/*=====================================================================================*/
/*                     LECTURA Y CARGA DE INTERFACE DE AFILIADOS                       */
/*=====================================================================================*/

DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE V-CODGRUPO                AS CHARACTER FORMAT "X(6)".
DEFINE VARIABLE V-FEALTA                  AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-CODZONA                 AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-CODCOBR                 AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-CODPROM                 AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-CODPLAN                 AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE V-DIRECC                  AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE V-NUMERO                  AS CHARACTER FORMAT "X(5)".        
DEFINE VARIABLE V-NUM-CARNET              AS CHARACTER FORMAT "X(15)".        
DEFINE VARIABLE V-PISO                    AS CHARACTER FORMAT "X(2)".        
DEFINE VARIABLE V-DEPARTAMENTO            AS CHARACTER FORMAT "X(2)".        
DEFINE VARIABLE V-LOCALIDAD               AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE V-TELEFONO                AS CHARACTER FORMAT "X(12)". 
DEFINE VARIABLE V-PREFIJO                 AS CHARACTER FORMAT "X(9)".        
DEFINE VARIABLE V-OBSERVACION             AS CHARACTER FORMAT "X(27)". 
DEFINE VARIABLE V-OBRASOC                 AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-TECHOSINO               AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-SUCURSAL                AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-ENTRECALLES             AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE V-ESTADO                  AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-CANCAP                  AS CHARACTER FORMAT "X(4)".

DEFINE VARIABLE V-NOMBRE                  AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE V-FENACIM                 AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-CARNET                  AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-SEXO                    AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-TIPODOC                 AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-NRODOC                  AS CHARACTER FORMAT "X(8)".

DEFINE VARIABLE V-OBSERLARGA              AS CHARACTER FORMAT "X(78)".

DEFINE VARIABLE V-CONDIVA                 AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-TIPCOMR                 AS CHARACTER FORMAT "X(1)".

DEFINE VARIABLE V-NROTARJ                 AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE V-FEVENTAR                AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-TIPCOMPR                AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-CUIT                    AS CHARACTER FORMAT "X(11)".

DEFINE VARIABLE V-NROINT                  AS CHARACTER FORMAT "X(6)".

DEFINE VARIABLE V-ENTRE1                  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE V-ENTRE2                  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE V-CASA                    AS CHARACTER FORMAT "X(4)".

DEFINE VARIABLE numeros                   AS CHARACTER INITIAL "0123456789".        
DEFINE VARIABLE V-AFILIADO                AS CHARACTER FORMAT "X(9)".        

DEFINE VARIABLE c                         AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE kp                        AS INTEGER.
DEFINE VARIABLE n-integrante              AS INTEGER.
DEFINE VARIABLE n-grupo                   AS INTEGER.
DEFINE VARIABLE n-grupoant                AS INTEGER.

DEFINE TEMP-TABLE T-Grupofam              LIKE Grupofam.
DEFINE TEMP-TABLE T-Afiliado              LIKE Afiliado.
DEFINE TEMP-TABLE T-Grupo-domicilio       LIKE Grupo-domicilio.

RUN lee_cabeceras_grupos.
RUN lee_detalle_grupos.
RUN lee_observaciones_grupos.
RUN lee_tarjetas_grupos.

RUN lee_cabeceras_areas.
RUN lee_integrantes_areas.
RUN lee_observaciones_areas.
RUN lee_tarjetas_areas.

PROCEDURE lee_cabeceras_grupos:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grcab".

    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,5,6).
        V-FEALTA                  = SUBSTRING(linea,11,8).
        V-CODZONA                 = SUBSTRING(linea,19,4).
        V-CODCOBR                 = SUBSTRING(linea,23,3).
        V-CODPROM                 = SUBSTRING(linea,26,4).
        V-CODPLAN                 = SUBSTRING(linea,30,2).
        V-DIRECC                  = SUBSTRING(linea,32,20).
        V-LOCALIDAD               = SUBSTRING(linea,52,15).
        V-TELEFONO                = SUBSTRING(linea,67,12). 
        V-OBSERVACION             = SUBSTRING(linea,79,27). 
        V-OBRASOC                 = SUBSTRING(linea,106,3).
        V-TECHOSINO               = SUBSTRING(linea,109,1).
        V-SUCURSAL                = SUBSTRING(linea,110,1).
        V-ENTRECALLES             = SUBSTRING(linea,111,30).
        V-ESTADO                  = SUBSTRING(linea,141,1).
        V-CANCAP                  = SUBSTRING(linea,148,4).
    
        V-CODGRUPO = "A" + V-CODGRUPO + "G".
        CREATE T-Grupofam.
        ASSIGN T-Grupofam.cdg_empresa  = "A"
               T-Grupofam.cdg_grupofam = V-CODGRUPO
               T-Grupofam.cdg_zona     = V-CODZONA
               T-Grupofam.cdg_cobrador = V-CODCOBR
               T-Grupofam.cdg_promotor = V-CODPROM
               T-Grupofam.cdg_plan     = V-CODPLAN
               T-Grupofam.obscorta     = V-OBSERVACION
               T-Grupofam.techo        = V-TECHOSINO = "S"
               T-Grupofam.tipo_grupo   = "G"
               T-Grupofam.num_sucursal = V-SUCURSAL
               T-Grupofam.cdg_estado   = V-ESTADO
               T-Grupofam.cant_capitas = INTEGER(V-CANCAP)
               T-Grupofam.cdg_obrasoc  = V-OBRASOC.

        RUN planchar_domicilio.

        CREATE T-Grupo-domicilio.
        ASSIGN T-Grupo-domicilio.cdg_grupofam  = V-CODGRUPO
               T-Grupo-domicilio.cdg_tipodom   = "C"
               T-Grupo-domicilio.calle         = V-DIRECC 
               T-Grupo-domicilio.nropta        = V-NUMERO 
               T-Grupo-domicilio.entre1        = V-ENTRE1
               T-Grupo-domicilio.entre2        = V-ENTRE2
               T-Grupo-domicilio.cdg_localidad = V-LOCALIDAD
               T-Grupo-domicilio.prefijotel    = V-PREFIJO
               T-Grupo-domicilio.telefono      = V-TELEFONO.
    END.

END PROCEDURE.

PROCEDURE lee_detalle_grupos:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grdet".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-NOMBRE                  = SUBSTRING(linea,10,25).
        V-FENACIM                 = SUBSTRING(linea,35,8).
        V-CARNET                  = SUBSTRING(linea,43,8).
        V-SEXO                    = SUBSTRING(linea,51,1).
        V-TIPODOC                 = SUBSTRING(linea,52,3).
        V-NRODOC                  = SUBSTRING(linea,55,8).
    
        V-CODGRUPO = "A" + V-CODGRUPO + "G".
        FIND T-Grupofam WHERE T-Grupofam.cdg_grupofam = V-CODGRUPO.

        CREATE T-Afiliado.
        ASSIGN T-Afiliado.cdg_grupofam  = V-CODGRUPO
               T-Afiliado.nom_afiliado  = V-NOMBRE
               T-Afiliado.sexo          = V-SEXO
               T-Afiliado.num_carnet    = V-CARNET
               T-Afiliado.fecha_nac     = DATE(V-FENACIM)
               T-Afiliado.num_documento = V-TIPODOC + " " + V-NRODOC.
               
    END.

END PROCEDURE.

PROCEDURE lee_observaciones_grupos:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grobs".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-OBSERLARGA             = SUBSTRING(linea,10,78).
    
        DISPLAY 
            V-CODGRUPO 
            V-OBSERLARGA  FORMAT "X(50)"
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.

PROCEDURE lee_tarjetas_grupos:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grcat".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-NROTARJ                 = SUBSTRING(linea,10,16).
        V-FEVENTAR                = SUBSTRING(linea,26,4).
        V-TIPCOMPR                = SUBSTRING(linea,30,1).
        V-CONDIVA                 = SUBSTRING(linea,31,1).
        V-CUIT                    = SUBSTRING(linea,32,11).
    
        DISPLAY 
            V-CODGRUPO 
            V-NROTARJ  
            V-FEVENTAR 
            V-TIPCOMPR 
            V-CONDIVA  
            V-CUIT     
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.


PROCEDURE lee_cabeceras_areas:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grcon".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,5,6).
        V-FEALTA                  = SUBSTRING(linea,11,8).
        V-CODZONA                 = SUBSTRING(linea,19,4).
        V-CODCOBR                 = SUBSTRING(linea,23,3).
        V-CODPROM                 = SUBSTRING(linea,26,4).
        V-NOMBRE                  = SUBSTRING(linea,30,25).
        V-DIRECC                  = SUBSTRING(linea,55,20).
        V-LOCALIDAD               = SUBSTRING(linea,80,15).
        V-TELEFONO                = SUBSTRING(linea,95,10). 
        V-OBSERVACION             = SUBSTRING(linea,105,20). 
        V-TECHOSINO               = SUBSTRING(linea,125,1).
        V-CONDIVA                 = SUBSTRING(linea,126,1).
        V-TIPCOMR                 = SUBSTRING(linea,127,1).
        V-ESTADO                  = SUBSTRING(linea,128,1).
        V-CANCAP                  = SUBSTRING(linea,138,4).
    
        DISPLAY 
            V-CODGRUPO            
            V-FEALTA              
            V-CODZONA             
            V-CODCOBR             
            V-CODPROM             
            V-NOMBRE              
            V-DIRECC              
            V-LOCALIDAD           
            V-TELEFONO            
            V-OBSERVACION         
            V-TECHOSINO           
            V-CONDIVA             
            V-TIPCOMR             
            V-ESTADO              
            V-CANCAP              
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.

PROCEDURE lee_integrantes_areas:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grint".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-NROINT                  = SUBSTRING(linea,10,6).
        V-NOMBRE                  = SUBSTRING(linea,16,25).
        V-FENACIM                 = SUBSTRING(linea,41,8).
        V-CARNET                  = SUBSTRING(linea,43,8).
    
        DISPLAY 
            V-CODGRUPO  
            V-NROINT
            V-NOMBRE    
            V-FENACIM   
            V-CARNET    
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.

PROCEDURE lee_observaciones_areas:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\groba".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-OBSERVACION             = SUBSTRING(linea,10,78).
    
        DISPLAY 
            V-CODGRUPO 
            V-OBSERVACION  
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.

PROCEDURE lee_tarjetas_areas:

    INPUT FROM "d:\desa\sic\r3.0\db\interfazu\grcot".
    
    REPEAT:
    
        IMPORT UNFORMATTED linea.
        V-CODGRUPO                = SUBSTRING(linea,4,6).
        V-NROTARJ                 = SUBSTRING(linea,10,16).
        V-FEVENTAR                = SUBSTRING(linea,26,4).
        V-TIPCOMPR                = SUBSTRING(linea,30,1).
        V-CONDIVA                 = SUBSTRING(linea,31,1).
        V-CUIT                    = SUBSTRING(linea,32,11).
    
        DISPLAY 
            V-CODGRUPO 
            V-NROTARJ  
            V-FEVENTAR 
            V-TIPCOMPR 
            V-CONDIVA  
            V-CUIT     
            WITH SIDE-LABELS 1 COLUMN 1 DOWN.
    
    END.

END PROCEDURE.


PROCEDURE planchar_datos:

    IF INDEX(V-ENTRECALLES," Y ") <> 0
    THEN RUN dividir_calle ( INPUT V-ENTRECALLES, 
                             INPUT INDEX(V-ENTRECALLES," Y "), 
                             OUTPUT V-ENTRE1,
                             OUTPUT V-ENTRE2).
    ELSE  IF INDEX(V-ENTRECALLES," E ") <> 0
    THEN RUN dividir_calle ( INPUT V-ENTRECALLES, 
                             INPUT INDEX(V-ENTRECALLES," Y "), 
                             OUTPUT V-ENTRE1,
                             OUTPUT V-ENTRE2).

    V-ENTRE2 = TRIM(V-ENTRE2).
    IF SUBSTRING(V-ENTRE2,1,2) = "Y " THEN V-ENTRE2 = SUBSTRING(V-ENTRE2,3).

    IF NUM-ENTRIES(V-TELEFONO,"-") = 2 
    THEN  ASSIGN
                  V-PREFIJO = ENTRY(1,V-TELEFONO,"-")
                  V-TELEFONO = ENTRY(2,V-TELEFONO,"-").
    ELSE     IF NUM-ENTRIES(V-TELEFONO," ") >= 2 
             THEN  ASSIGN
                          V-PREFIJO = ENTRY(1,V-TELEFONO," ")
                          V-TELEFONO = ENTRY(2,V-TELEFONO," ").
             ELSE V-PREFIJO = "".
             
    IF LENGTH(V-PREFIJO) = 3 AND SUBSTRING(V-PREFIJO,1,1) <> "0"
       THEN V-PREFIJO = "4" + V-PREFIJO.

    V-DIRECC = TRIM(V-DIRECC). 

    IF V-DIRECC <> ""
    THEN DO:
      
        RUN separar_departamento.
              
        IF INDEX(numeros,SUBSTRING(V-DIRECC,LENGTH(V-DIRECC),1)) <> 0
           THEN RUN separar_numero.
  
    END.
   
END PROCEDURE.

PROCEDURE separar_numero:

    DEFINE VARIABLE pu AS INTEGER.

    pu = LENGTH(V-DIRECC).
    DO WHILE INDEX(numeros,SUBSTRING(V-DIRECC,pu,1)) <> 0:
       pu = pu - 1.
    END.
    
    V-NUMERO = SUBSTRING(V-DIRECC,pu + 1).
    V-DIRECC  = SUBSTRING(V-DIRECC,1,pu).

END PROCEDURE.


PROCEDURE dividir_calle:

    DEFINE INPUT   PARAMETER calle   AS CHARACTER.
    DEFINE INPUT   PARAMETER p       AS INTEGER. 
    DEFINE OUTPUT  PARAMETER entre1  AS CHARACTER. 
    DEFINE OUTPUT  PARAMETER entre2  AS CHARACTER. 

    entre1 = SUBSTRING(calle,1, p - 1).
    entre2 = SUBSTRING(calle, p + 3).

END PROCEDURE.

PROCEDURE separar_departamento:

    DEFINE VARIABLE abrevia AS CHARACTER INITIAL "DTO.,DPTO.,DTO,DPTO".
    DEFINE VARIABLE j       AS INTEGER.

    DO j = 1 TO 4:
        kp = INDEX(V-DIRECC,ENTRY(j,abrevia)).
        IF kp > 1 
        THEN DO:
             V-DEPARTAMENTO = TRIM(SUBSTRING(V-DIRECC,kp + LENGTH(abrevia))).
             V-DIRECC        = TRIM(SUBSTRING(V-DIRECC,1,kp - 1)).
             RETURN.
        END.
    END.

    kp = INDEX(V-DIRECC,"CASA").
    IF kp > 1 
    THEN DO:
         V-CASA  = TRIM(SUBSTRING(V-DIRECC,kp)).
         V-DIRECC = TRIM(SUBSTRING(V-DIRECC,1,kp - 1)).
         RETURN.
    END.

    kp = INDEX(V-DIRECC,"FONDO").
    IF kp > 1 
    THEN DO:
         V-CASA  = TRIM(SUBSTRING(V-DIRECC,kp)).
         V-DIRECC = TRIM(SUBSTRING(V-DIRECC,1,kp - 1)).
         RETURN.
    END.

    kp = INDEX(V-DIRECC,"PISO").
    IF kp <> 0 
    THEN DO:
         V-PISO  = TRIM(SUBSTRING(V-DIRECC,kp + 4)).
         V-DIRECC = TRIM(SUBSTRING(V-DIRECC,1,kp - 1)).
         RETURN.
    END.
     

END PROCEDURE.
