/*=======================================================================================*/
/*           PROGRAMA: GENERACION INTERFACES SICORE                                      */
/*           AUTOR:    EVANGELINA OTARAN                                                 */
/*           FECHA:    JUNIO 2003                                                        */
/*=======================================================================================*/

DEFINE INPUT PARAMETER des_fecha AS DATE. 
DEFINE INPUT PARAMETER has_fecha AS DATE. 

{VRSHARED.I "NEW"}

DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo      AS CHARACTER FORMAT "x(45)".
DEFINE VARIABLE que_archivo  AS CHARACTER FORMAT "x(45)".
DEFINE VARIABLE base         LIKE Fac_header.imp_neto.
DEFINE VARIABLE cc           AS INTEGER INITIAL 0.

DEFINE TEMP-TABLE SICORE
FIELD  clave-1            AS CHARACTER FORMAT "X(12)"
FIELD  clave-2            AS CHARACTER FORMAT "X(12)"
FIELD  clave-3            AS CHARACTER FORMAT "X(16)"
FIELD  codigo             AS INTEGER FORMAT "99"
FIELD  fecha_e            AS DATE FORMAT "99/99/9999"
FIELD  numero             AS CHARACTER FORMAT "X(12)"
FIELD  importe            AS DECIMAL FORMAT "9999999999999.99"
FIELD  c_impuesto         AS INTEGER FORMAT "999"
FIELD  c_regimen          AS INTEGER FORMAT "999"
FIELD  c_operacion        AS INTEGER FORMAT "9"
FIELD  base               AS DECIMAL FORMAT "99999999999.99"
FIELD  fecha_p            AS DATE FORMAT "99/99/9999"
FIELD  c_condicion        AS INTEGER FORMAT "99"
FIELD  importe_p          AS DECIMAL FORMAT "99999999999.99"
FIELD  porcentaje         AS DECIMAL FORMAT "999999"  
FIELD  fecha_b            AS DATE FORMAT "99/99/9999"
FIELD  tip_docum          AS INTEGER FORMAT "99"
FIELD  nro_docum          AS CHARACTER FORMAT "X(20)"
FIELD  nro_certif         AS INTEGER FORMAT "99999999999.99"
FIELD  nom_ordenante      AS CHARACTER FORMAT "X(30)" 
FIELD  acrecentamiento    AS INTEGER FORMAT "9"     
FIELD  cuit_pais          AS CHARACTER FORMAT "X(11)"      
FIELD  cuit_ordenante     AS CHARACTER FORMAT "X(11)".


DEFINE TEMP-TABLE SUJETO
FIELD  nro_docum          AS CHARACTER FORMAT "X(11)"
FIELD  nombre             AS CHARACTER FORMAT "X(20)"
FIELD  domicilio          AS CHARACTER FORMAT "X(20)"
FIELD  localidad          AS CHARACTER FORMAT "X(20)"
FIELD  provincia          AS CHARACTER FORMAT "99"
FIELD  c_postal           AS INTEGER FORMAT "99999999"
FIELD  tip_docum          AS INTEGER FORMAT "99"
INDEX SUJETO IS PRIMARY tip_docum nro_docum ASCENDING.

{findempresa.i}

RUN getparametro.p (  INPUT  "DIROTPCP",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
dire_tmp = v-observacion.

DO TRANSACTION:
    RUN GENERA.
    RUN BAJA.
END.

/* __________________________________________________________________________________________________________*/
/*                                                                                                           */
/*                                           procedimientos                                                  */
/* __________________________________________________________________________________________________________*/

PROCEDURE GENERA:

   FOR EACH Fac_header WHERE Fac_header.fecha >= des_fecha
                          AND Fac_header.fecha <= has_fecha
                          AND Fac_header.cdg_empresa = Empresa.cdg_empresa,
       FIRST Tipocomprobante OF Fac_header WHERE NOT Tipocomprobante.es_interno:

      base = 0.
          
      FIND Cliente OF Fac_header.
      FIND Domicilio OF Cliente WHERE Domicilio.nro_domicilio = Fac_header.nro_domicilio NO-ERROR.
      FIND Provincia OF Domicilio NO-ERROR.
      FIND Pais OF Domicilio.
      FIND Condicion_impos OF Cliente.

      FIND Comprob_afip OF Fac_header NO-ERROR.

      FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto 
           WHERE NOT Impuesto.es_iva AND Impuesto.nivel = 0:

           IF Fac_header.tip_comprob BEGINS "C"
           THEN base = Fac_header_impuesto.importe.
           ELSE base = Fac_header.imp_neto.

           cc = cc + 1.

           FIND FIRST Cliente_excencion OF Cliente 
               WHERE Cliente_excencion.cdg_empresa = Fac_header.cdg_empresa
                 AND Cliente_excencion.cdg_impuesto = Fac_header_impuesto.cdg_impuesto
                 AND Cliente_excencion.fch_desde <= Fac_header.fecha
                 AND Cliente_excencion.fch_hasta >= Fac_header.fecha
                     NO-ERROR.
               
           CREATE SICORE.
           ASSIGN SICORE.clave-1           = Cliente.cdg_cliente + "-" + string(Fac_header.nro_domicilio, "9999") + " " 
                  SICORE.clave-2           = string(Condicion_impos.cdg_condiva, "99") + "-" + STRING(Fac_header.nro_comprob, "99999999") + SUBSTRING(Fac_header.tip_comprob,2,1) 
                  SICORE.clave-3           = "9999" + "-" + STRING(YEAR(Fac_header.fecha), "9999") + "-" +  STRING(cc, "999999") 
                  SICORE.fecha_e           = Fac_header.fecha 
                  SICORE.numero            = string(Fac_header.prf_comprob, "9999") + string(Fac_header.nro_comprob, "99999999") 
                  SICORE.importe           = Fac_header.imp_total
                  SICORE.c_impuesto        = 767 
                  SICORE.c_regimen         = 493
                  SICORE.c_operacion       = 2 
                  SICORE.base              = base 
                  SICORE.fecha_p           = Fac_header.fecha 
                  SICORE.c_condicion       = Cliente.cdg_condiva 
                  SICORE.importe_p         = Fac_header_impuesto.importe 
                  SICORE.porcentaje        = IF AVAILABLE Cliente_excencion THEN Cliente_excencion.prc_excencion ELSE 0
                  SICORE.fecha_b           = IF AVAILABLE Cliente_excencion THEN Cliente_excencion.fch_boletin ELSE ?
                  SICORE.tip_docum         = 80  
                  SICORE.nro_docum         = Cliente.cuit
                  SICORE.nro_certif        = 0
                  SICORE.nom_ordenante     = "" 
                  SICORE.acrecentamiento   = 0     
                  SICORE.cuit_pais         = "" 
                  SICORE.cuit_ordenante    = "".

           CASE SUBSTRING(Fac_header.tip_comprob,1,1):
                  WHEN "F" THEN SICORE.codigo = 1.  
                  WHEN "D" THEN SICORE.codigo = 4.  
                  WHEN "C" THEN SICORE.codigo = 3.  
                  WHEN "R" THEN SICORE.codigo = 2.  
                  OTHERWISE SICORE.codigo = 5.  
           END CASE.
                  
           FIND SUJETO WHERE SUJETO.tip_docum = SICORE.tip_docum 
                         AND SUJETO.nro_docum = SICORE.nro_docum  NO-ERROR.
           IF NOT AVAILABLE SUJETO
           THEN DO:
                FIND Provincia WHERE Cliente.cdg_provincia = Provincia.cdg_provincia NO-ERROR.
                CREATE SUJETO.
                ASSIGN SUJETO.tip_docum = SICORE.tip_docum 
                       SUJETO.nro_docum = SICORE.nro_docum  
                       SUJETO.nombre    = Cliente.nom_cliente 
                       SUJETO.domicilio = Cliente.direccion    
                       SUJETO.localidad = Cliente.localidad     
                       SUJETO.provincia = Provincia.codigo_afip  
                       SUJETO.c_postal  = INTEGER(Cliente.cdg_postal).
           END.
          
      END.
   END.
END PROCEDURE.

PROCEDURE BAJA:
archivo = dire_tmp + "\imbm" + STRING(MONTH(has_fecha),"99") + SUBSTRING(STRING(YEAR(has_fecha)),3,2) + ".mrp".


OUTPUT TO VALUE(archivo).

FOR EACH SICORE:
    EXPORT DELIMITER " " SICORE.
END.

OUTPUT CLOSE.

archivo = dire_tmp + "\imbd" + STRING(MONTH(has_fecha),"99") + SUBSTRING(STRING(YEAR(has_fecha)),3,2) + ".mrp".

OUTPUT TO VALUE(archivo).

FOR EACH SUJETO:
    EXPORT DELIMITER " " SUJETO.
END.

OUTPUT CLOSE.

END PROCEDURE.




