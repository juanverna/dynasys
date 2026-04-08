/*=================================================================================*/
/*       Resumen de todos los renglones de factura que se hacen a mano alzada      */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha       AS DATE. 
DEFINE INPUT PARAMETER has_fecha       AS DATE. 

{parlocales.i}

DEFINE VARIABLE orgformato  AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

orgformato = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT = "American".

RUN getparametro.p (  INPUT  "DIROTFAC",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

OUTPUT TO VALUE(v-observacion + "\" + "facdetallada" + STRING(MONTH(has_fecha),"99") + STRING(YEAR(has_fecha) - 2000,"99") + ".txt" ) PAGE-SIZE 0.
PUT  "Cliente" ";"
     "R.Social" ";"
     "Articulo" ";"
     "Descripcion" ";"
     "Neto" ";"
     "Cuenta" ";"
     "Nombre" SKIP.

FOR EACH Fac_detalle, 
    FIRST Fac_header OF Fac_detalle 
          WHERE Fac_header.fecha <= has_fecha
            AND Fac_header.fecha >= des_fecha,
    FIRST Cliente OF Fac_header,
    FIRST Articulo OF Fac_detalle WHERE Articulo.extendida, 
    FIRST Familia_articulo OF Articulo, 
    FIRST Familia_cuenta OF Familia_articulo 
          WHERE Familia_cuenta.cdg_imputacion = Fac_header.cdg_imputacion, 
    FIRST Cuenta OF Familia_cuenta:

    PUT Cliente.cdg_cliente ";"
        Cliente.nom_cliente ";"
        Articulo.cdg_articulo ";"
        /*
        SUBSTRING(Fac_detalle.detallada,1,150) FORMAT "X(150)" ";"
        */
        Fac_detalle.detallada
        Fac_detalle.subtotal_neto FORMAT "->>>>>>>>9.99" ";"
        Cuenta.cdg_cuenta ";"
        Cuenta.nombre_cta SKIP.

END.
OUTPUT CLOSE.

SESSION:NUMERIC-FORMAT = orgformato.
