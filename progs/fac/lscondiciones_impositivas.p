/*=======================================================================================================================*/
/*                                                                                                                       */
/*                                   LISTADO DE CONDICIONES IMPOSITIVA DE LA EMPRESA LOGUEADA                            */
/*                                                                                                                       */
/*=======================================================================================================================*/


DEFINE VARIABLE v-provincias AS CHARACTER EXTENT 3 FORMAT "X(32)" COLUMN-LABEL "Provincias de Aplicaciòn!de los Impuestos".
DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE k AS INTEGER.

{VRSHARED.I}
{dfvarimp.i}
{findempresa.i}
{dirprinfile.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Condiciones Impositivas" AT 72
    "Página:" AT 166 PAGE-NUMBER FORMAT ">>>9" AT 174
    SKIP
    fecha_lis
    hora_lis AT 176
    SKIP
    WITH WIDTH 260 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Condicion_impos.cdg_condiva   COLUMN-LABEL "Código!Condición"
    Condicion_impos.descripcion   COLUMN-LABEL "Descripción!Condición"
    Impuesto.cdg_impuesto         COLUMN-LABEL "Código!Impuesto"
    Impuesto.nombre               COLUMN-LABEL "Descripción!Impuesto"
    Familia_impositiva.cdg_familimpos COLUMN-LABEL "Código!Familia"
    Familia_impositiva.dsc_familimpos COLUMN-LABEL "Familia!Impositiva"
    Impuesto_condicion.fch_desde  FORMAT "99/99/9999"
    Impuesto_condicion.fch_hasta  FORMAT "99/99/9999"
    Impuesto_condicion.imp_minimo 
    Impuesto_condicion.tasa       COLUMN-LABEL "Tasa!Impositiva"
    Impuesto_condicion.valor_minimo
    v-provincias [ 1 ]
    WITH WIDTH 260 DOWN CENTERED STREAM-IO.

/*=======================================================================================================================*/
/*                                   LISTADO DE CONDICIONES IMPOSITIVA DE LA EMPRESA LOGUEADA                            */
/*=======================================================================================================================*/

que_empresa = Empresa.nombre.

FOR EACH Condicion_impos, 
    EACH Impuesto_condicion OF Condicion_impos WHERE Impuesto_condicion.cdg_empresa = Empresa.cdg_empresa,
    FIRST Impuesto OF Impuesto_condicion,
    FIRST Familia_impositiva OF Impuesto_condicion 
        BREAK BY Condicion_impos.cdg_condiva BY Impuesto.cdg_impuesto BY Impuesto_condicion.fch_desde
        WITH FRAME frm-listado:

    VIEW FRAME frm-titulo.

    k = 1.
    v-provincias = "".
    DO j = 1 TO NUM-ENTRIES(Impuesto_condicion.lista_provincias,","):
        FIND Provincia WHERE Provincia.cdg_provincia = ENTRY(j,Impuesto_condicion.lista_provincias,",") NO-LOCK.
        v-provincias [ k ] = v-provincias [ k ] + "," + TRIM(Provincia.sigla_prov).
        IF NUM-ENTRIES(v-provincias [ k ],",") = 9
        THEN DO:
            v-provincias [ k ] = SUBSTRING(v-provincias [ k ],2).
            k = k + 1.
        END.
    END.
    IF SUBSTRING(v-provincias [ 1 ],1,1) = "," THEN v-provincias [ 1 ] = SUBSTRING(v-provincias [ 1 ],2).

    DISPLAY Condicion_impos.cdg_condiva WHEN FIRST-OF(Condicion_impos.cdg_condiva)
            Condicion_impos.descripcion WHEN FIRST-OF(Condicion_impos.cdg_condiva)
            Impuesto.cdg_impuesto       WHEN FIRST-OF(Impuesto.cdg_impuesto)
            Impuesto.nombre             WHEN FIRST-OF(Impuesto.cdg_impuesto)
            Familia_impositiva.cdg_familimpos 
            Familia_impositiva.dsc_familimpos 
            Impuesto_condicion.fch_desde 
            Impuesto_condicion.fch_hasta 
            Impuesto_condicion.imp_minimo 
            Impuesto_condicion.tasa                                         
            Impuesto_condicion.valor_minimo
            v-provincias [ 1 ]
            WITH STREAM-IO WIDTH 260 FRAME frm-listado.
    
    IF v-provincias [ 2 ] <> ""
    THEN DO:
        DOWN WITH FRAME frm-listado.
        DISPLAY v-provincias [ 2 ] @ v-provincias [ 1 ]
                WITH STREAM-IO WIDTH 260 FRAME frm-listado.
    END.

    IF v-provincias [ 3 ] <> ""
    THEN DO:
        DOWN WITH FRAME frm-listado.
        DISPLAY v-provincias [ 3 ] @ v-provincias [ 1 ]
                WITH STREAM-IO WIDTH 260 FRAME frm-listado.
    END.


END.
OUTPUT CLOSE.                              

RUN veresult.w ( INPUT  arch_salida , INPUT 22 ).
