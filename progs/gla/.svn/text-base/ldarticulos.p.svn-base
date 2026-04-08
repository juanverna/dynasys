/*=====================================================================================*/
/*              CARGA MASIVA DE AREAS AZULES                                           */
/*=====================================================================================*/

DEFINE VARIABLE linea          AS CHARACTER FORMAT "X(132)".

DEFINE VARIABLE V-GRUPO         AS CHARACTER FORMAT "X(02)".
DEFINE VARIABLE V-ARTICULO      AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-TIPO          AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-CLASIF        AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-DESCRIPCION1  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE V-DESCRIPCION2  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE V-US-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-US-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-US-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UA-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UA-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-UA-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UC-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UC-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-UC-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-VIGENCIA      AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-INDIC-SUSPEN  AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-FEC-HAB-SUSP  AS CHARACTER FORMAT "X(08)".
DEFINE VARIABLE V-FEC-INGR      AS CHARACTER FORMAT "X(08)".
DEFINE VARIABLE V-FECHA-TRANSA  AS CHARACTER FORMAT "X(08)".
DEFINE VARIABLE V-HORA-TRANSA   AS CHARACTER FORMAT "X(08)".

DEFINE VARIABLE v-sector LIKE Area.cdg_area EXTENT 100.

DEFINE VARIABLE c                         AS INTEGER.
DEFINE VARIABLE n                         AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE na                        AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE ia                        AS INTEGER FORMAT ">>>>>9".
DEFINE STREAM Errores.

DEFINE TEMP-TABLE T-Articulo LIKE Articulo.

FORM n
     /*
     V-GRUPO         COLON 20 
     V-ARTICULO      COLON 20 
     V-TIPO          COLON 20 
     V-CLASIF        COLON 20 
     V-DESCRIPCION1  COLON 20 
     V-DESCRIPCION2  COLON 20 
     V-US-CONTENED   COLON 20 
     V-US-CANTIDAD   COLON 20 
     V-US-UN-MEDIDA  COLON 20 
     V-UA-CONTENED   COLON 20 
     V-UA-CANTIDAD   COLON 20 
     V-UA-UN-MEDIDA  COLON 20 
     V-UC-CONTENED   COLON 20 
     V-UC-CANTIDAD   COLON 20 
     V-UC-UN-MEDIDA  COLON 20 
     V-VIGENCIA      COLON 20 
     V-INDIC-SUSPEN  COLON 20 
     V-FEC-HAB-SUSP  COLON 20 
     V-FEC-INGR      COLON 20 
     V-FECHA-TRANSA  COLON 20 
     V-HORA-TRANSA   COLON 20 
     */
     WITH FRAME AA 1 DOWN FONT 2 SIDE-LABELS VIEW-AS DIALOG-BOX.

CREATE T-Articulo.
FIND FIRST Articulo.
BUFFER-COPY Articulo TO T-Articulo.

FOR EACH Area:
    na = na + 1.
    v-sector [ na ] = Area.cdg_area.
END.

INPUT FROM "C:\desa\v9\sic\r3.5\db\catalogo.txt".
OUTPUT STREAM Errores TO "C:\desa\v9\sic\r3.5\db\errores.txt".

/* salteo del primer encabezado */


REPEAT:
    n = n + 1.
    IMPORT UNFORMATTED linea. 
    RUN desarmar_registro.
    DISPLAY n

        /*
        V-GRUPO          
        V-ARTICULO       
        V-TIPO           
        V-CLASIF         
        V-DESCRIPCION1   
        V-DESCRIPCION2   
        V-US-CONTENED    
        V-US-CANTIDAD    
        V-US-UN-MEDIDA   
        V-UA-CONTENED    
        V-UA-CANTIDAD    
        V-UA-UN-MEDIDA   
        V-UC-CONTENED    
        V-UC-CANTIDAD    
        V-UC-UN-MEDIDA   
        V-VIGENCIA       
        V-INDIC-SUSPEN   
        V-FEC-HAB-SUSP   
        V-FEC-INGR       
        V-FECHA-TRANSA   
        V-HORA-TRANSA    
        */
        WITH FRAME AA.
    /*
    DOWN WITH FRAME aa.
    */

    CREATE Articulo.
    BUFFER-COPY T-Articulo TO Articulo
        ASSIGN 
            Articulo.cdg_articulo = V-GRUPO + "-" + V-ARTICULO + "-" + V-TIPO + V-CLASIF
            Articulo.descripcion  = V-DESCRIPCION1 + V-DESCRIPCION2 
            Articulo.cdg_umed     = V-US-UN-MEDIDA
            Articulo.cdg_ucompra  = V-UC-UN-MEDIDA
            Articulo.cdg_ugranel  = V-UA-UN-MEDIDA
            Articulo.cdg_estado   = IF V-INDIC-SUSPEN <> "N" THEN "B" ELSE ""
            Articulo.nro_articulo = NEXT-VALUE(proximo_articulo).
    RUN asignar_sectores.

END.


PROCEDURE desarmar_registro:

/*
N§Conv.Fecha Ing. Zona Cob.Prom Nombre            Domicilio        Localidad Telefono Cap.     Cuota Observacion  T.S.E.M   Fecha  
----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+----3--
203783 15/08/1997 0270 052 1197  CARDONE CARMELA  LANZANI 3756     CASTELAR  692-4665    1     51.90              N U B   27/10/1997
*/
    c = 1.
    V-GRUPO         = SUBSTRING(linea,c,02). c = c +  2.  
    V-ARTICULO      = SUBSTRING(linea,c,06). c = c +  6.        
    V-TIPO          = SUBSTRING(linea,c,01). c = c +  1.        
    V-CLASIF        = SUBSTRING(linea,c,01). c = c +  1.        
    V-DESCRIPCION1  = SUBSTRING(linea,c,40). c = c + 40.
    V-DESCRIPCION2  = SUBSTRING(linea,c,40). c = c + 40.
    V-US-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-US-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.        
    V-US-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.        
    V-UA-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-UA-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.        
    V-UA-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.        
    V-UC-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-UC-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.        
    V-UC-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.        
    V-VIGENCIA      = SUBSTRING(linea,c,01). c = c +  1.        
    V-INDIC-SUSPEN  = SUBSTRING(linea,c,01). c = c +  1.
    V-FEC-HAB-SUSP  = SUBSTRING(linea,c,08). c = c +  8.        
    V-FEC-INGR      = SUBSTRING(linea,c,08). c = c +  8.
    V-FECHA-TRANSA  = SUBSTRING(linea,c,08). c = c +  8.
    V-HORA-TRANSA   = SUBSTRING(linea,c,08). c = c +  8.

END PROCEDURE.

PROCEDURE asignar_sectores:

    DEFINE VARIABLE lista AS CHARACTER.
    DEFINE VARIABLE nsectores AS INTEGER.

    lista = "".

    nsectores = RANDOM(1,na).

    DO ia = 1 TO nsectores:
        lista = lista + "," + v-sector [ RANDOM(1,na) ].
    END.
    Articulo.lista_sectores = SUBSTRING(lista,2).

END PROCEDURE.
