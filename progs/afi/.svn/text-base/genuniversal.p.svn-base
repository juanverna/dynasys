/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-lista_empresas   AS CHARACTER.
DEFINE INPUT PARAMETER p-archivo          AS CHARACTER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE v-direccion               AS CHARACTER FORMAT "X(55)".
DEFINE VARIABLE v-des_fecha               AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-has_fecha               AS CHARACTER FORMAT "X(8)".

DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(156)".

DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE tiplan                    AS INTEGER.

DEFINE VARIABLE a-total                   AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-total                   AS INTEGER FORMAT ">>>>9".

DEFINE STREAM Exportacion.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Grupos Familiares con cobertura de Universal" AT 57
       "Página:" AT 130 PAGE-NUMBER FORMAT ">>9" AT 139
       SKIP  
       fecha_lis       
       hora_lis AT 130
       SKIP
       titulo_lst AT 57  
       SKIP(1)
       WITH WIDTH 190 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Afiliado.cdg_grupofam
       Afiliado.num_integrante FORMAT "999"
       Afiliado.nom_afiliado
       Grupofam.cdg_plan
       v-direccion   COLUMN-LABEL "Dirección!Domicilio"
       Grupo-domicilio.cdg_postal COLUMN-LABEL "Código!Postal"
       Cobertura_int.des_fecha FORMAT "99/99/9999"
       Cobertura_int.has_fecha FORMAT "99/99/9999"
       WITH WIDTH 190 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/


que_empresa = "".
DO j = 1 TO  NUM-ENTRIES(p-lista_empresas,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-lista_empresas,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-lista_empresas,",") THEN que_empresa = que_empresa + ",".
END.


/*{DIRPRINFILE.I}*/

OUTPUT STREAM Exportacion TO VALUE(p-archivo) PAGE-SIZE 0.
OUTPUT TO VALUE("c:\sic-temp\genuniversal.txt") PAGED.

OPEN QUERY q-cobertura 
     FOR EACH Cobertura_int 
        WHERE ( 
        ( Cobertura_int.des_fecha  >= p-desde_alta AND Cobertura_int.des_fecha  <= p-hasta_alta ) OR
        ( Cobertura_int.has_fecha  >= p-desde_alta AND Cobertura_int.has_fecha  <= p-hasta_alta ) OR
        ( Cobertura_int.des_fecha  <= p-desde_alta AND Cobertura_int.has_fecha  >= p-hasta_alta ) 
        ),
        FIRST Afiliado OF Cobertura_int WHERE LOOKUP(Afiliado.cdg_empresa,p-lista_empresas) <> 0
          AND Afiliado.cdg_estado = "A"
              NO-LOCK BY Afiliado.cdg_empresa
                      BY Afiliado.cdg_grupofam.
GET FIRST q-cobertura.
DO WHILE AVAILABLE Cobertura_int WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.

    FIND Grupofam OF Afiliado NO-LOCK.
    FIND FIRST Grupo-domicilio OF Grupofam WHERE Grupo-domicilio.cdg_tipodom = "C" NO-ERROR.
    FIND Provincia OF Grupo-domicilio.
       
    linea = "".

    v-direccion   = TRIM(Grupo-domicilio.calle) + " " +
                    TRIM(Grupo-domicilio.nropta) + " " +
                    TRIM(Grupo-domicilio.piso) + " " +
                    TRIM(Grupo-domicilio.depto) + "," +
                    TRIM(Grupo-domicilio.cdg_localidad) + "," +
                    TRIM(Provincia.nombre).

    v-des_fecha    = STRING(YEAR(Cobertura_int.des_fecha),"9999") + 
                     STRING(MONTH(Cobertura_int.des_fecha),"99") + 
                     STRING(DAY(Cobertura_int.des_fecha),"99").

    IF YEAR(Cobertura_int.has_fecha) < 2050
        THEN v-has_fecha    = STRING(YEAR(Cobertura_int.has_fecha),"9999") + 
                              STRING(MONTH(Cobertura_int.has_fecha),"99") + 
                              STRING(DAY(Cobertura_int.has_fecha),"99").
        ELSE v-has_fecha    = "99991231". 

    
    OVERLAY(linea,1,3)   = "054".
    OVERLAY(linea,4,20)  = Afiliado.cdg_grupofam.
    OVERLAY(linea,24,3)  = STRING(Afiliado.num_integrante,"999").
    OVERLAY(linea,27,50) = Afiliado.nom_afiliado.
    OVERLAY(linea,77,55) = v-direccion.
    OVERLAY(linea,132,8) = Grupo-domicilio.cdg_postal.
    OVERLAY(linea,140,8) = v-des_fecha.
    OVERLAY(linea,148,8) = v-has_fecha.
    OVERLAY(linea,156,1) = "0".
    
    PUT STREAM Exportacion linea SKIP.

    DISPLAY
        Afiliado.cdg_grupofam
        Afiliado.num_integrante FORMAT "999"
        Afiliado.nom_afiliado
        v-direccion
        Grupo-domicilio.cdg_postal
        Grupofam.cdg_plan            
        Cobertura_int.des_fecha
        Cobertura_int.has_fecha
        WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.   

    a-total = a-total + 1.

    GET NEXT q-cobertura.

END.       

UNDERLINE
      Afiliado.cdg_grupofam
      Afiliado.num_integrante
      Afiliado.nom_afiliado
      v-direccion
      Grupo-domicilio.cdg_postal
      Grupofam.cdg_plan            
      Cobertura_int.des_fecha
      Cobertura_int.has_fecha
      WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
  
DISPLAY "Total Afiliados" @ v-direccion
            a-total       @ Grupofam.cdg_plan
        WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

UNDERLINE
      Afiliado.cdg_grupofam
      Afiliado.num_integrante
      Afiliado.nom_afiliado
      v-direccion
      Grupo-domicilio.cdg_postal
      Grupofam.cdg_plan            
      Cobertura_int.des_fecha
      Cobertura_int.has_fecha
      WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\genuniversal.txt",
                 INPUT 2 ).

