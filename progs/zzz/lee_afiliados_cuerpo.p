/*=========================================================================================*/
/*                IMPORTA EL ARCHIVO DE AFILIADOS Y AREAS PROTEGIDAS                       */
/*=========================================================================================*/

DEFINE VARIABLE linea                 AS CHARACTER FORMAT "X(132)".

DEFINE VARIABLE v-NroConvenio         AS CHARACTER /* INTEGER */.
DEFINE VARIABLE v-NroSocio            AS CHARACTER /* INTEGER */.
DEFINE VARIABLE v-NroInt              AS CHARACTER /* Short */.
DEFINE VARIABLE v-Apellido            AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE v-Nombre              AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE v-TipoDoc             AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE v-NroDocumento        AS CHARACTER /* INTEGER */.
DEFINE VARIABLE v-Sexo                AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-FechaNacimiento     AS CHARACTER /* INTEGER */.
DEFINE VARIABLE v-EstadoCivil         AS CHARACTER.
DEFINE VARIABLE v-Fumador             AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Cardiaco            AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Hipertenso          AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Asmatico            AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Diabetico           AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Obeso               AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Antibiotico         AS CHARACTER /* Byte */.
DEFINE VARIABLE v-Analgesico          AS CHARACTER /* Byte */.
DEFINE VARIABLE v-ObraSocial          AS CHARACTER /* String(30) */.
DEFINE VARIABLE v-FechaBaja           AS CHARACTER /* Long */.
DEFINE VARIABLE v-Motivo              AS CHARACTER /* Short */.

DEFINE VARIABLE c                     AS INTEGER .

DEFINE VARIABLE V-EMPRESA             AS CHARACTER INITIAL "C".

DEFINE TEMP-TABLE T-Afiliado          LIKE Afiliado.

DEFINE STREAM Errores.

FORM 
    v-NroConvenio         COLON 30 
    v-NroSocio            COLON 30 
    v-NroInt              COLON 30 
    v-Apellido            COLON 30 
    v-Nombre              COLON 30 
    v-TipoDoc             COLON 30 
    v-NroDocumento        COLON 30 
    v-Sexo                COLON 30 
    v-FechaNacimiento     COLON 30 
    v-EstadoCivil         COLON 30
    v-Fumador             COLON 30
    v-Cardiaco            COLON 30
    v-Hipertenso          COLON 30
    v-Asmatico            COLON 30
    v-Diabetico           COLON 30
    v-Obeso               COLON 30
    v-Antibiotico         COLON 30
    v-Analgesico          COLON 30
    v-ObraSocial          COLON 30
    v-FechaBaja           COLON 30
    v-Motivo              COLON 30
    WITH FRAME A 1 DOWN FONT 2 SIDE-LABELS VIEW-AS DIALOG-BOX WIDTH 118 USE-TEXT.

SESSION:IMMEDIATE-DISPLAY = YES.
SESSION:DATE-FORMAT = "MDY".

/*RUN mensaje_padron_ucrem.p ( OUTPUT sino ).*/


IF TRUE
THEN DO:    

    INPUT FROM "c:\time\cmdintegra.txt".
    OUTPUT STREAM Errores TO "c:\time\cmdintegra.err".
    
    REPEAT /*WHILE c < 500 */:
    
        IMPORT UNFORMATTED linea.
    
        PAUSE 0 BEFORE-HIDE.
        c = c + 1.
    
        /*IF c < 25000 THEN NEXT.*/

        RUN desarmar_registro.
        DISPLAY C WITH 1 DOWN USE-TEXT.
/*      RUN mostrar. */
/*      RUN planchar_datos.*/
        IF INTEGER(v-NroConvenio)  = 0 OR INTEGER(v-NroConvenio)  = 9027 THEN RUN crear_registro.
    END.   
    
    MESSAGE "TERMINO LA CARGA DEL PADRON" VIEW-AS ALERT-BOX MESSAGE TITLE "POR FIN!!!".

END.

RUN bajar_datos.

    MESSAGE "TERMINO LA GRABACION!!!!" VIEW-AS ALERT-BOX MESSAGE TITLE "POR FIN!!!".


/*=========================================================================================*/
/*                                    PROCEDIMIENTOS                                       */
/*=========================================================================================*/

PROCEDURE bajar_datos:

  FOR EACH T-Afiliado:
      CREATE Afiliado.
      BUFFER-COPY T-Afiliado TO Afiliado.
  END.

END PROCEDURE.

PROCEDURE crear_registro:

    CREATE T-Afiliado.
    ASSIGN T-Afiliado.barrio_emr      = ""
           T-Afiliado.calle_emr       = ""
           T-Afiliado.casa_emr        = ""
           T-Afiliado.cdg_afiliado    = STRING(INTEGER(v-NroSocio),"999999") + "-" + STRING(INTEGER(v-Nroint),"9999")
           T-Afiliado.cdg_empresa     = V-EMPRESA
           T-Afiliado.cdg_estado      = "A"
           T-Afiliado.cdg_grupofam    = STRING(INTEGER(v-NroSocio),"999999")
           T-Afiliado.cdg_localidad   = ""
           T-Afiliado.cdg_postal      = ""
           T-Afiliado.cdg_plan        = ""
           T-Afiliado.cdg_provincia   = ""
           T-Afiliado.depto_emr       = ""
           T-Afiliado.entre1_emr      = ""
           T-Afiliado.entre2_emr      = ""
           T-Afiliado.fecha_alta      = TODAY
           T-Afiliado.monoblk_emr     = ""
           T-Afiliado.nom_afiliado    = v-Apellido + " " + v-Nombre
           T-Afiliado.num_carnet      = ""
           T-Afiliado.nropta_emr      = ""
           T-Afiliado.nro_afiliado    = NEXT-VALUE(proximo_afiliado)
           T-Afiliado.num_integrante  = INTEGER(v-Nroint)
           T-Afiliado.observacion     = ""
           T-Afiliado.piso_emr        = ""
           T-Afiliado.prefijotel_emr  = ""
           T-Afiliado.refer_emr       = ""
           T-Afiliado.sexo            = IF v-Sexo = "Maculino" THEN "M" ELSE "F"
           T-Afiliado.telefono_emr    = "". 

    RUN asignar_fecha ( INPUT v-FechaBaja,            OUTPUT T-Afiliado.fecha_baja ).
    RUN asignar_fecha ( INPUT v-FechaNacimiento,      OUTPUT T-Afiliado.fecha_nac ).

END PROCEDURE.

PROCEDURE mostrar:

    DISPLAY         
        v-NroConvenio          
        v-NroSocio             
        v-NroInt               
        v-Apellido             
        v-Nombre               
        v-TipoDoc              
        v-NroDocumento         
        v-Sexo                 
        v-FechaNacimiento      
        v-EstadoCivil         
        v-Fumador             
        v-Cardiaco            
        v-Hipertenso          
        v-Asmatico            
        v-Diabetico           
        v-Obeso               
        v-Antibiotico         
        v-Analgesico          
        v-ObraSocial          
        v-FechaBaja           
        v-Motivo              
        WITH FRAME A.

    DOWN WITH FRAME A.
    PAUSE.


END PROCEDURE.
 
PROCEDURE desarmar_registro:
 
    DEFINE VARIABLE k AS INTEGER.
    DEFINE VARIABLE j AS INTEGER.
    DEFINE VARIABLE n AS INTEGER.

    ASSIGN
        v-NroConvenio         = ? 
        v-NroSocio            = ? 
        v-NroInt              = ? 
        v-Apellido            = ? 
        v-Nombre              = ? 
        v-TipoDoc             = ? 
        v-NroDocumento        = ? 
        v-Sexo                = ? 
        v-FechaNacimiento     = ? 
        v-EstadoCivil         = ?
        v-Fumador             = ?
        v-Cardiaco            = ?
        v-Hipertenso          = ?
        v-Asmatico            = ?
        v-Diabetico           = ?
        v-Obeso               = ?
        v-Antibiotico         = ?
        v-Analgesico          = ?
        v-ObraSocial          = ?
        v-FechaBaja           = ?
        v-Motivo              = ?.

    n = NUM-ENTRIES(linea,',').

    k = 1.
    IF k <= n THEN v-NroConvenio         = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-NroSocio            = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-NroInt              = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-Apellido            = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-Nombre              = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-TipoDoc             = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-NroDocumento        = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-Sexo                = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-FechaNacimiento     = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1. 
    IF k <= n THEN v-EstadoCivil         = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Fumador             = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Cardiaco            = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Hipertenso          = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Asmatico            = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Diabetico           = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Obeso               = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Antibiotico         = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Analgesico          = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-ObraSocial          = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-FechaBaja           = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.
    IF k <= n THEN v-Motivo              = REPLACE(ENTRY(k,linea,','),'"',''). k = k + 1.

END PROCEDURE.

PROCEDURE asignar_fecha:

    DEFINE INPUT PARAMETER  i-fecha      AS CHARACTER.
    DEFINE OUTPUT PARAMETER o-fecha      AS DATE.

    DEFINE VARIABLE v-aux_fecha          AS DATE.
    
    /*----------------------------------------------------
    v-aux_fecha = DATE(SUBSTRING(i-fecha,7,2) + "/" + 
                       SUBSTRING(i-fecha,5,2) + "/" + 
                       SUBSTRING(i-fecha,1,4)) NO-ERROR.
    ------------------------------------------------------*/

    v-aux_fecha = DATE(i-fecha) NO-ERROR.

    o-fecha = IF ERROR-STATUS:ERROR THEN ? ELSE v-aux_fecha.


END PROCEDURE.
