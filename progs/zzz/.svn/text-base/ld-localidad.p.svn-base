/*=====================================================================================*/
/*                     CARGA MASIVA DE CABECERAS DE GRUPOS                             */
/*=====================================================================================*/

DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE V-CODGRUPO                AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-FEALTA                  AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-CODZONA                 AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-CODCOBR                 AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-CODPROM                 AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-CODPLAN                 AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE V-DIRECC                  AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE V-LOCALIDAD               AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE V-TELEFONO                AS CHARACTER FORMAT "X(12)". 
DEFINE VARIABLE V-OBSERVACION             AS CHARACTER FORMAT "X(27)". 
DEFINE VARIABLE V-OBRASOC                 AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-TECHOSINO               AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-SUCURSAL                AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-ENTRE-CALLE             AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE V-Y-CALLE                 AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE V-ESTADO                  AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-CANCAP                  AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE V-CALLE                   AS CHARACTER FORMAT "X(51)".        
DEFINE VARIABLE V-CASA                    AS CHARACTER FORMAT "X(4)".

DEFINE VARIABLE V-NOMBRE                  AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE V-FECHNAC                 AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-CARNET                  AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-SEXO                    AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-TIPDOCUM                AS CHARACTER FORMAT "X(3)".
DEFINE VARIABLE V-NRODOCUM                AS CHARACTER FORMAT "X(8)".

DEFINE VARIABLE V-PISO                    AS CHARACTER FORMAT "X(2)".        
DEFINE VARIABLE V-DEPARTAMENTO            AS CHARACTER FORMAT "X(2)".        
DEFINE VARIABLE kp                        AS INTEGER.
DEFINE VARIABLE c                         AS INTEGER.
DEFINE VARIABLE n-integrante              AS INTEGER.
DEFINE VARIABLE v-grupoarea               AS CHARACTER FORMAT "X(1)" INITIAL "G".
DEFINE VARIABLE v-aux_fecha               AS DATE.

DEFINE VARIABLE t-errores                 AS INTEGER.
DEFINE VARIABLE t-capitas                 AS INTEGER.
DEFINE VARIABLE t-grupos                  AS INTEGER.
DEFINE VARIABLE t-cuotas                  AS DECIMAL.

DEFINE VARIABLE V-AFILIADO                AS CHARACTER FORMAT "X(9)".        
DEFINE VARIABLE V-EMPRESA                 AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-NUMERO                  AS CHARACTER FORMAT "X(5)".        
DEFINE VARIABLE V-PREFIJO                 AS CHARACTER FORMAT "X(9)".        
DEFINE VARIABLE numeros                   AS CHARACTER INITIAL "0123456789".        

DEFINE VARIABLE det_titulo                AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE fecha_lis                 AS DATE.
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE TEMP-TABLE T-Grupofam              LIKE Grupofam.
DEFINE TEMP-TABLE T-Cliente               LIKE Cliente.
DEFINE TEMP-TABLE T-Grupo-domicilio       LIKE Grupo-domicilio.
DEFINE TEMP-TABLE T-Domicilio             LIKE Domicilio.
DEFINE TEMP-TABLE T-Afiliado              LIKE Afiliado.

DEFINE STREAM Grupos.
DEFINE STREAM Afiliados. 
 
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(32)"
  "Carga de Interface Cuota 80" AT 35
  "Página:" AT 83 PAGE-NUMBER FORMAT ">>9" AT 91
  SKIP
  fecha_lis
  "Grupos Familiares" AT 35
  hora_lis AT 83
  SKIP(1)
  "---------------------------------------------------------------------------------------------" SKIP
  "Código  Denominación                          Código   Cód.  Cód.   Cód.  Cant.    Importe   " SKIP
  "Grupo   Grupo Familiar/Area                     Plan  Cobr.  Zona  Prom. Capit.      Cuota   " SKIP
  "                                                                                             " SKIP
  "     Codigo de    Número Nombre                                  Número de                   " SKIP
  "     Afiliado     Integ. Afiliado                               Credencial                   " SKIP
  "---------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-grupo
    T-Grupofam.cdg_grupofam 
    T-Grupofam.nom_grupofam
    T-Grupofam.cdg_plan FORMAT "X(2)"
    SPACE(3)
    T-Grupofam.cdg_cobrador FORMAT "X(3)"
    SPACE(3)
    T-Grupofam.cdg_zonag FORMAT "X(4)"
    SPACE(3)
    T-Grupofam.cdg_promotor FORMAT "X(4)"
    SPACE(3)
    T-Grupofam.cant_capitas FORMAT ">>>9"
    Plan-capita.precio_neto
    WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-grupo USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-listado-afiliado
  SPACE(5)
  T-Afiliado.cdg_afiliado FORMAT "X(12)"
  T-Afiliado.num_integrante
  T-Afiliado.nom_afiliado
  T-Afiliado.num_carnet
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-afiliado USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-totales
    que_empresa NO-LABEL
    "Resumen de Carga de Interface de Grupos Familiares"   AT 40 
    fecha_lis AT 40 NO-LABEL hora_lis NO-LABEL
    SKIP(2)
    t-grupos   LABEL "Total de Grupos" COLON 35
    t-capitas  LABEL "Total de Capitas" COLON 35
    t-cuotas   LABEL "Total de Cuotas" COLON 35
    t-errores  LABEL "Total Sin Plan" COLON 35
    WITH FRAME frm-totales SIDE-LABELS STREAM-IO USE-TEXT WIDTH 96.
 
/*=====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                    */
/*=====================================================================================*/
 
SESSION:NUMERIC-FORMAT = "American".

UPDATE V-EMPRESA.

FIND Empresa WHERE Empresa.cdg_empresa = V-EMPRESA.

IF V-EMPRESA = "A"
THEN DO:
     INPUT STREAM Grupos    FROM "c:\desa\sic\db\interfazu\grcab".
END.
ELSE DO:
     INPUT STREAM Grupos    FROM "c:\desa\sic\db\interfroj\grcab".
END.

que_empresa = Empresa.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").


REPEAT:

    IMPORT STREAM Grupos UNFORMATTED linea.
    
    linea = REPLACE(linea,"¥","Ñ").
    linea = REPLACE(linea,"š","U").
    linea = REPLACE(linea,"¤","Ñ").

    RUN desarmar_grupo.
    RUN grabar_localidad. 

END.

INPUT STREAM Grupos CLOSE.

/*=====================================================================================*/
/*                           P R O C E D I M I E N T O S                               */
/*=====================================================================================*/

PROCEDURE desarmar_grupo:

/*
0---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8--|
179,999999200012121111222333344DDDDDDDDDDDDDDDDDDDDLLLLLLLLLLLLLLL000000000000OOOOOOOOOOOOOOOOOOOOOOOOOOO001N1EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEA         77                              
179,6003392000082301480519100RSNIGHTINGALE 109     VILLA TESEI    450-3125                               000NKSALINAS Y SANTA MONICA        A         2                                

*/

    V-CODGRUPO                = SUBSTRING(linea,5,6).
    V-FEALTA                  = SUBSTRING(linea,11,8).
    V-CODZONA                 = SUBSTRING(linea,19,4).
    V-CODCOBR                 = SUBSTRING(linea,23,3).
    V-CODPROM                 = SUBSTRING(linea,26,4).
    V-CODPLAN                 = SUBSTRING(linea,30,2).
    V-CALLE                   = SUBSTRING(linea,32,20).
    V-LOCALIDAD               = SUBSTRING(linea,52,15).
    V-TELEFONO                = SUBSTRING(linea,67,12). 
    V-OBSERVACION             = SUBSTRING(linea,79,27). 
    V-OBRASOC                 = SUBSTRING(linea,106,3).
    V-TECHOSINO               = SUBSTRING(linea,109,1).
    V-SUCURSAL                = SUBSTRING(linea,110,1).
    V-Y-CALLE                 = SUBSTRING(linea,111,30).
    V-ESTADO                  = SUBSTRING(linea,141,1).
    V-CANCAP                  = SUBSTRING(linea,148,4).

END PROCEDURE.

PROCEDURE mostrar_grupo:

    DISPLAY 
        V-CODGRUPO                
        V-FEALTA                  
        V-CODZONA                 
        V-CODCOBR                 
        V-CODPROM                 
        V-CODPLAN                 
        V-DIRECC                  
        V-LOCALIDAD               
        V-PREFIJO
        V-TELEFONO                
        V-OBSERVACION             
        V-OBRASOC                 
        V-TECHOSINO               
        V-SUCURSAL                
        V-CALLE 
        V-NUMERO            
        V-ENTRE-CALLE             
        V-Y-CALLE             
        V-ESTADO                  
        V-CANCAP                  
        WITH SIDE-LABELS 1 COLUMN 1 DOWN FRAME A USE-TEXT.

    DOWN WITH FRAME A.
    PAUSE.

END PROCEDURE.

PROCEDURE grabar_localidad:

/*  RUN MOSTRAR_GRUPO. */

    V-CODGRUPO = V-CODGRUPO + v-grupoarea.

    FIND Grupofam 
         WHERE Grupofam.cdg_empresa    = V-EMPRESA
           AND Grupofam.cdg_grupofam   = V-CODGRUPO
               EXCLUSIVE-LOCK.

    FIND FIRST Grupo-domicilio OF Grupofam
         WHERE Grupo-domicilio.cdg_tipodom     = "C"
               EXCLUSIVE-LOCK.
  
    Grupo-domicilio.cdg_localidad   = V-LOCALIDAD.

END PROCEDURE.   
