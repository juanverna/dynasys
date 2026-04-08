/*=========================================================================================================*/
/*       DEFINICION DE TABLAS TEMPORARIAS Y VARIABLES PARA GENERACION DE ASIENTOS DESDE LOS MODULOS        */
/*=========================================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD nro_cuenta                     LIKE Cuenta.nro_cuenta
   FIELD nro_entidad                    LIKE Entidad.nro_entidad
   FIELD nro_obra                       LIKE Obra.nro_obra
   FIELD nro_moneda                     LIKE Moneda.nro_moneda
   FIELD codigo_dbcr                    AS INTEGER
   FIELD debitos                        AS DECIMAL FORMAT "->,>>>,>>>,>>9.99"
   FIELD creditos                       AS DECIMAL FORMAT "->,>>>,>>>,>>9.99"
   FIELD debitos_pen                    AS DECIMAL FORMAT "->,>>>,>>>,>>9.99"
   FIELD creditos_pen                   AS DECIMAL FORMAT "->,>>>,>>>,>>9.99"
   INDEX por_cuenta IS UNIQUE nro_cuenta nro_entidad nro_obra nro_moneda ASCENDING.

DEFINE TEMP-TABLE T-Asn_header          LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_totales         LIKE Asn_totales.
DEFINE TEMP-TABLE T-Asn_detalle         LIKE Asn_detalle.

DEFINE BUFFER     T-Reexpresion         FOR T-Asn_detalle.

DEFINE BUFFER     B-T-Asn_header        FOR T-Asn_header.
DEFINE BUFFER     B-T-Asn_totales       FOR T-Asn_totales.
DEFINE BUFFER     B-T-Asn_detalle       FOR T-Asn_detalle.

DEFINE VARIABLE tgn_debitos_tot         AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_tot        AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tgn_debitos_pen         AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_pen        AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE lst_c_tot               AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_tot               AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Debitos".
DEFINE VARIABLE lst_c_pen               AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_pen               AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Debitos".
DEFINE VARIABLE lst_c_tot-c             AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_tot-c             AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Debitos".
DEFINE VARIABLE lst_c_pen-c             AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_pen-c             AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Debitos".

DEFINE VARIABLE m-creditos              LIKE Asn_totales.tot_creditos LABEL "Acum.creditos".
DEFINE VARIABLE m-debitos               LIKE Asn_totales.tot_debitos  LABEL "Acum.debitos".

DEFINE VARIABLE n-asiento               AS INTEGER.
DEFINE VARIABLE v-pc_name               AS CHARACTER.
DEFINE VARIABLE titulo_moneda           AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE v-moneda_expresion      LIKE Moneda.nro_moneda.

DEFINE VARIABLE titulo_det              AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE que_comprobante         AS CHARACTER FORMAT "X(18)".

DEFINE VARIABLE n-asiento-0             AS INTEGER INITIAL 1.
DEFINE VARIABLE n-asiento-1             AS INTEGER INITIAL 9999999.
