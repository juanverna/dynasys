/*=====================================================================================*/
/*                     CARGA MASIVA DE CABECERAS DE GRUPOS                             */
/*=====================================================================================*/

DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE V-CODGRUPO                AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-TIPOCOM                 AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE V-CONDIVA                 AS CHARACTER FORMAT "X(4)".

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
DEFINE VARIABLE sino                      AS LOGICAL.

DEFINE VARIABLE det_titulo                AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE fecha_lis                 AS DATE.
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE TEMP-TABLE T-Grupofam              LIKE Grupofam.
DEFINE TEMP-TABLE T-Cliente               LIKE Cliente.
DEFINE TEMP-TABLE T-Grupo-domicilio       LIKE Grupo-domicilio.
DEFINE TEMP-TABLE T-Domicilio             LIKE Domicilio.
DEFINE TEMP-TABLE T-Afiliado              LIKE Afiliado.
DEFINE TEMP-TABLE T-Pedido_credencial     LIKE Pedido_credencial.
DEFINE TEMP-TABLE T-Vendedor              LIKE Vendedor.
DEFINE TEMP-TABLE T-Cobrador              LIKE Cobrador.

DEFINE STREAM Grupos.
DEFINE STREAM Afiliados. 
 
/*=====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                    */
/*=====================================================================================*/
 
SESSION:NUMERIC-FORMAT = "American".

UPDATE V-EMPRESA.

FIND Empresa WHERE Empresa.cdg_empresa = V-EMPRESA.

IF V-EMPRESA = "A"
THEN DO:
     INPUT STREAM Grupos    FROM "c:\desa\sic\r3.0\db\interfazu\grcot".
END.
ELSE DO:
     INPUT STREAM Grupos    FROM "c:\desa\sic\r3.0\db\interfroj\grcot".
END.


REPEAT:

    IMPORT STREAM Grupos UNFORMATTED linea.
    
    linea = REPLACE(linea,"¥","Ñ").
    linea = REPLACE(linea,"š","U").
    linea = REPLACE(linea,"¤","Ñ").

    RUN desarmar_grupo.
    display v-codgrupo v-tipocom.

    FIND Grupofam WHERE Grupofam.cdg_grupofam = V-CODGRUPO + "A"
                    AND Grupofam.cdg_empresa  = V-EMPRESA
                        EXCLUSIVE-LOCK.
    Grupofam.tipo_compbte = V-TIPOCOM.

END.

INPUT STREAM Grupos CLOSE.


/*=====================================================================================*/
/*                           P R O C E D I M I E N T O S                               */
/*=====================================================================================*/


PROCEDURE desarmar_grupo:

/*
0---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8--|
42,239047                    R300000000000   

*/

    V-CODGRUPO                = SUBSTRING(linea,4,6).
    V-TIPOCOM                 = SUBSTRING(linea,30,1).
    V-CONDIVA                 = SUBSTRING(linea,31,1).

END PROCEDURE.
