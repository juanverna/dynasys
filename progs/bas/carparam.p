/*=================================================================================*/
/*                CARGA DESDE LOS PARAMETROS LAS VARIABLES COMUNES                 */
/*=================================================================================*/

{VRSHARED.I}

    ASSIGN
       es_agretiva = NO
       es_agretibr = NO
       es_agretgan = NO
       es_agretsus = NO.

    {findempresa.i}

    {findparametro.i "COLWIFGC" "w-fg_c" "valor_n"}
    {findparametro.i "COLWIBGC" "w-bg_c" "valor_n"}
    {findparametro.i "COLFRFGC" "f-fg_c" "valor_n"}
    {findparametro.i "COLFRBGC" "f-bg_c" "valor_n"}
    {findparametro.i "COLDTFGC" "d-fg_c" "valor_n"}
    {findparametro.i "COLDTBGC" "d-bg_c" "valor_n"}
    {findparametro.i "COLBRFGC" "b-fg_c" "valor_n"}
    {findparametro.i "COLBRBGC" "b-bg_c" "valor_n"}
    {findparametro.i "COLHLFGC" "h-fg_c" "valor_n"}
    {findparametro.i "COLHLBGC" "h-bg_c" "valor_n"}
    {findparametro.i "COLTXFGC" "t-fg_c" "valor_n"}
    {findparametro.i "COLTXBGC" "t-bg_c" "valor_n"}
    {findparametro.i "COLFLFGC" "fg_c" "valor_n"}
    {findparametro.i "COLFLBGC" "bg_c" "valor_n"}
    {findparametro.i "COLFLFEC" "fe_c" "valor_n"}
    {findparametro.i "COLFLBEC" "be_c" "valor_n"}
    {findparametro.i "CSSONIDO" "sonido" "valor_l"}
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}
    {findparametro.i "SEGLISAD" "lista_admin" "valor_c"} 
    {findparametro.i "WRNASPRT" "war_asgprt" "valor_l"} 
    {findparametro.i "AGRETIVA" "es_agretiva" "valor_l"}
    {findparametro.i "AGRETIBR" "es_agretibr" "valor_l"}
    {findparametro.i "AGRETGAN" "es_agretgan" "valor_l"}
    {findparametro.i "AGRETSUS" "es_agretsus" "valor_l"}
    {findparametro.i "STDEBCLI" "str_debitan" "valor_c"}
   /* {findparametro.i "STDEBPRV" "str_debitan_prv" "valor_c"} */
    {findparametro.i "STDEBBCO" "str_debitan_bco" "valor_c"}
    {findparametro.i "STDEBINV" "str_debitan_inv" "valor_c"}

    RUN carciclo.p.
 
    RUN getptovta.p ( INPUT "FAC",
                      OUTPUT pto_venta ).
 
    RUN getsucursal.p ( OUTPUT sucursal-id ).

    RUN cargar_debitan.p ( INPUT "Ventas", OUTPUT str_debitan ). 
