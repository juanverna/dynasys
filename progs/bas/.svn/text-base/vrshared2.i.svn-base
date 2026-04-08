/* ----------------------- Control del entorno ---------------------------------*/

DEFINE {1} SHARED VARIABLE w-fg_c        AS INTEGER INITIAL 0.
DEFINE {1} SHARED VARIABLE w-bg_c        AS INTEGER INITIAL 8.
DEFINE {1} SHARED VARIABLE f-fg_c        AS INTEGER INITIAL 0.
DEFINE {1} SHARED VARIABLE f-bg_c        AS INTEGER INITIAL 8.
DEFINE {1} SHARED VARIABLE d-fg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE d-bg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE b-fg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE b-bg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE fg_c          AS INTEGER INITIAL 0.
DEFINE {1} SHARED VARIABLE fe_c          AS INTEGER INITIAL 1.
DEFINE {1} SHARED VARIABLE bg_c          AS INTEGER INITIAL 8.
DEFINE {1} SHARED VARIABLE be_c          AS INTEGER INITIAL 15.
DEFINE {1} SHARED VARIABLE h-fg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE h-bg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE t-fg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE t-bg_c        AS INTEGER.
DEFINE {1} SHARED VARIABLE SIGLA_SIC     AS CHARACTER.

DEFINE {1} SHARED VARIABLE sonido        AS LOGICAL.
DEFINE {1} SHARED VARIABLE war_asgprt    AS LOGICAL.
DEFINE {1} SHARED VARIABLE dire_tmp      AS CHARACTER.
DEFINE {1} SHARED VARIABLE lista_admin   AS CHARACTER INITIAL "ADMIN".
DEFINE {1} SHARED VARIABLE SUBSISTEMA    AS CHARACTER.
DEFINE {1} SHARED VARIABLE exit_mens     AS INTEGER.
DEFINE {1} SHARED VARIABLE VERSION_SIC   AS CHARACTER.
DEFINE {1} SHARED VARIABLE LISTA_MODULOS AS CHARACTER INITIAL 
           "ABA,ADP,BAS,COM,CPS,CXC,CXP,DSP,EXP,FAC,GLA,IMP,INV,OXC,OXP,PRD,SEG,TES,UTL,VND".
DEFINE {1} SHARED VARIABLE entidad_logon AS INTEGER.
DEFINE {1} SHARED VARIABLE cod_aut       AS INTEGER.
DEFINE {1} SHARED VARIABLE pto_venta     AS INTEGER NO-UNDO.
DEFINE {1} SHARED VARIABLE sucursal-id   AS CHARACTER NO-UNDO.

DEFINE {1} SHARED VARIABLE es_agretiva   AS LOGICAL.
DEFINE {1} SHARED VARIABLE es_agretibr   AS LOGICAL.
DEFINE {1} SHARED VARIABLE es_agretgan   AS LOGICAL.
DEFINE {1} SHARED VARIABLE es_agretsus   AS LOGICAL.

/* -------------- Registro actual en uso ------------------------------*/

DEFINE VARIABLE act_acc_concepto   AS ROWID.  DEFINE VARIABLE ult_acc_concepto   AS ROWID.
DEFINE VARIABLE act_acc_dato       AS ROWID.  DEFINE VARIABLE ult_acc_dato       AS ROWID.
DEFINE VARIABLE act_afjp           AS ROWID.  DEFINE VARIABLE ult_afjp           AS ROWID.
DEFINE VARIABLE act_aliart         AS ROWID.  DEFINE VARIABLE ult_aliart         AS ROWID.
DEFINE VARIABLE act_amd_detl       AS ROWID.  DEFINE VARIABLE ult_amd_detl       AS ROWID.
DEFINE VARIABLE act_amd_head       AS ROWID.  DEFINE VARIABLE ult_amd_head       AS ROWID.
DEFINE VARIABLE act_amp_detl       AS ROWID.  DEFINE VARIABLE ult_amp_detl       AS ROWID.
DEFINE VARIABLE act_amp_head       AS ROWID.  DEFINE VARIABLE ult_amp_head       AS ROWID.
DEFINE VARIABLE act_aps_detl       AS ROWID.  DEFINE VARIABLE ult_aps_detl       AS ROWID.
DEFINE VARIABLE act_aps_head       AS ROWID.  DEFINE VARIABLE ult_aps_head       AS ROWID.
DEFINE VARIABLE act_area           AS ROWID.  DEFINE VARIABLE ult_area           AS ROWID.
DEFINE VARIABLE act_art            AS ROWID.  DEFINE VARIABLE ult_art            AS ROWID.
DEFINE VARIABLE act_artdepos       AS ROWID.  DEFINE VARIABLE ult_artdepos       AS ROWID.
DEFINE VARIABLE act_artic_prv      AS ROWID.  DEFINE VARIABLE ult_artic_prv      AS ROWID.
DEFINE VARIABLE act_articulo       AS ROWID.  DEFINE VARIABLE ult_articulo       AS ROWID.
DEFINE VARIABLE act_artim          AS ROWID.  DEFINE VARIABLE ult_artim          AS ROWID.
DEFINE VARIABLE act_asn_detl       AS ROWID.  DEFINE VARIABLE ult_asn_detl       AS ROWID.
DEFINE VARIABLE act_asn_head       AS ROWID.  DEFINE VARIABLE ult_asn_head       AS ROWID.
DEFINE VARIABLE act_banco          AS ROWID.  DEFINE VARIABLE ult_banco          AS ROWID.
DEFINE VARIABLE act_bduso          AS ROWID.  DEFINE VARIABLE ult_bduso          AS ROWID.
DEFINE VARIABLE act_bonific        AS ROWID.  DEFINE VARIABLE ult_bonific        AS ROWID.
DEFINE VARIABLE act_caj_detl       AS ROWID.  DEFINE VARIABLE ult_caj_detl       AS ROWID.
DEFINE VARIABLE act_caj_head       AS ROWID.  DEFINE VARIABLE ult_caj_head       AS ROWID.
DEFINE VARIABLE act_caj_imput      AS ROWID.  DEFINE VARIABLE ult_caj_imput      AS ROWID.
DEFINE VARIABLE act_caja           AS ROWID.  DEFINE VARIABLE ult_caja           AS ROWID.
DEFINE VARIABLE act_categ          AS ROWID.  DEFINE VARIABLE ult_categ          AS ROWID.
DEFINE VARIABLE act_cctstk         AS ROWID.  DEFINE VARIABLE ult_cctstk         AS ROWID.
DEFINE VARIABLE act_certgan        AS ROWID.  DEFINE VARIABLE ult_certgan        AS ROWID.
DEFINE VARIABLE act_certibr        AS ROWID.  DEFINE VARIABLE ult_certibr        AS ROWID.
DEFINE VARIABLE act_certiva        AS ROWID.  DEFINE VARIABLE ult_certiva        AS ROWID.
DEFINE VARIABLE act_ciclo          AS ROWID.  DEFINE VARIABLE ult_ciclo          AS ROWID.
DEFINE VARIABLE act_clase          AS ROWID.  DEFINE VARIABLE ult_clase          AS ROWID.
DEFINE VARIABLE act_clibon         AS ROWID.  DEFINE VARIABLE ult_clibon         AS ROWID.
DEFINE VARIABLE act_clibonxart     AS ROWID.  DEFINE VARIABLE ult_clibonxart     AS ROWID.
DEFINE VARIABLE act_clicnd         AS ROWID.  DEFINE VARIABLE ult_clicnd         AS ROWID.
DEFINE VARIABLE act_cliente        AS ROWID.  DEFINE VARIABLE ult_cliente        AS ROWID.
DEFINE VARIABLE act_clpsp          AS ROWID.  DEFINE VARIABLE ult_clpsp          AS ROWID.
DEFINE VARIABLE act_cnc_convenio   AS ROWID.  DEFINE VARIABLE ult_cnc_convenio   AS ROWID.
DEFINE VARIABLE act_cnc_cuenta     AS ROWID.  DEFINE VARIABLE ult_cnc_cuenta     AS ROWID.
DEFINE VARIABLE act_cnc_empleado   AS ROWID.  DEFINE VARIABLE ult_cnc_empleado   AS ROWID.
DEFINE VARIABLE act_cnc_liquid     AS ROWID.  DEFINE VARIABLE ult_cnc_liquid     AS ROWID.
DEFINE VARIABLE act_cnv_liquid     AS ROWID.  DEFINE VARIABLE ult_cnv_liquid     AS ROWID.
DEFINE VARIABLE act_cndventa       AS ROWID.  DEFINE VARIABLE ult_cndventa       AS ROWID.
DEFINE VARIABLE act_cobrador       AS ROWID.  DEFINE VARIABLE ult_cobrador       AS ROWID.
DEFINE VARIABLE act_coefic         AS ROWID.  DEFINE VARIABLE ult_coefic         AS ROWID.
DEFINE VARIABLE act_comprador      AS ROWID.  DEFINE VARIABLE ult_comprador      AS ROWID.
DEFINE VARIABLE act_concepto       AS ROWID.  DEFINE VARIABLE ult_concepto       AS ROWID.
DEFINE VARIABLE act_condiva        AS ROWID.  DEFINE VARIABLE ult_condiva        AS ROWID.
DEFINE VARIABLE act_constante      AS ROWID.  DEFINE VARIABLE ult_constante      AS ROWID.
DEFINE VARIABLE act_convenio       AS ROWID.  DEFINE VARIABLE ult_convenio       AS ROWID.
DEFINE VARIABLE act_cpostal        AS ROWID.  DEFINE VARIABLE ult_cpostal        AS ROWID.
DEFINE VARIABLE act_ctacte         AS ROWID.  DEFINE VARIABLE ult_ctacte         AS ROWID.
DEFINE VARIABLE act_ctacte_bco     AS ROWID.  DEFINE VARIABLE ult_ctacte_bco     AS ROWID.
DEFINE VARIABLE act_ctacte_emp     AS ROWID.  DEFINE VARIABLE ult_ctacte_emp     AS ROWID.
DEFINE VARIABLE act_ctacte_prv     AS ROWID.  DEFINE VARIABLE ult_ctacte_prv     AS ROWID.
DEFINE VARIABLE act_ctapsp         AS ROWID.  DEFINE VARIABLE ult_ctapsp         AS ROWID.
DEFINE VARIABLE act_ctrl_impresora AS ROWID.  DEFINE VARIABLE ult_ctrl_impresora AS ROWID.
DEFINE VARIABLE act_cuenta         AS ROWID.  DEFINE VARIABLE ult_cuenta         AS ROWID.
DEFINE VARIABLE act_cuenta_ban     AS ROWID.  DEFINE VARIABLE ult_cuenta_ban     AS ROWID.
DEFINE VARIABLE act_cheque         AS ROWID.  DEFINE VARIABLE ult_cheque         AS ROWID.
DEFINE VARIABLE act_chequera       AS ROWID.  DEFINE VARIABLE ult_chequera       AS ROWID.
DEFINE VARIABLE act_datliq         AS ROWID.  DEFINE VARIABLE ult_datliq         AS ROWID.
DEFINE VARIABLE act_deposito       AS ROWID.  DEFINE VARIABLE ult_deposito       AS ROWID.
DEFINE VARIABLE act_destino        AS ROWID.  DEFINE VARIABLE ult_destino        AS ROWID.
DEFINE VARIABLE act_dia_franco     AS ROWID.  DEFINE VARIABLE ult_dia_franco     AS ROWID.
DEFINE VARIABLE act_dlqemp         AS ROWID.  DEFINE VARIABLE ult_dlqemp         AS ROWID.
DEFINE VARIABLE act_domic          AS ROWID.  DEFINE VARIABLE ult_domic          AS ROWID.
DEFINE VARIABLE act_domic_prv      AS ROWID.  DEFINE VARIABLE ult_domic_prv      AS ROWID.
DEFINE VARIABLE act_ejercicio      AS ROWID.  DEFINE VARIABLE ult_ejercicio      AS ROWID.
DEFINE VARIABLE act_emb_detl       AS ROWID.  DEFINE VARIABLE ult_emb_detl       AS ROWID.
DEFINE VARIABLE act_emb_gasto      AS ROWID.  DEFINE VARIABLE ult_emb_gasto      AS ROWID.
DEFINE VARIABLE act_emb_head       AS ROWID.  DEFINE VARIABLE ult_emb_head       AS ROWID.
DEFINE VARIABLE act_empleado       AS ROWID.  DEFINE VARIABLE ult_empleado       AS ROWID.
DEFINE VARIABLE act_empresa        AS ROWID.  DEFINE VARIABLE ult_empresa        AS ROWID.
DEFINE VARIABLE act_entidad        AS ROWID.  DEFINE VARIABLE ult_entidad        AS ROWID.
DEFINE VARIABLE act_ent_empleado   AS ROWID.  DEFINE VARIABLE ult_ent_empleado   AS ROWID.
DEFINE VARIABLE act_entrega        AS ROWID.  DEFINE VARIABLE ult_entrega        AS ROWID.
DEFINE VARIABLE act_escol          AS ROWID.  DEFINE VARIABLE ult_escol          AS ROWID.
DEFINE VARIABLE act_espec          AS ROWID.  DEFINE VARIABLE ult_espec          AS ROWID.
DEFINE VARIABLE act_est_civ        AS ROWID.  DEFINE VARIABLE ult_est_civ        AS ROWID.
DEFINE VARIABLE act_est_liquid     AS ROWID.  DEFINE VARIABLE ult_est_liquid     AS ROWID.
DEFINE VARIABLE act_est_ped        AS ROWID.  DEFINE VARIABLE ult_est_ped        AS ROWID.
DEFINE VARIABLE act_estado         AS ROWID.  DEFINE VARIABLE ult_estado         AS ROWID.
DEFINE VARIABLE act_estructura     AS ROWID.  DEFINE VARIABLE ult_estructura     AS ROWID.
DEFINE VARIABLE act_extracto       AS ROWID.  DEFINE VARIABLE ult_extracto       AS ROWID.
DEFINE VARIABLE act_fac_bonif      AS ROWID.  DEFINE VARIABLE ult_fac_bonif      AS ROWID.
DEFINE VARIABLE act_fac_detl       AS ROWID.  DEFINE VARIABLE ult_fac_detl       AS ROWID.
DEFINE VARIABLE act_fac_gasto      AS ROWID.  DEFINE VARIABLE ult_fac_gasto      AS ROWID.
DEFINE VARIABLE act_fac_head       AS ROWID.  DEFINE VARIABLE ult_fac_head       AS ROWID.
DEFINE VARIABLE act_famclie        AS ROWID.  DEFINE VARIABLE ult_famclie        AS ROWID.
DEFINE VARIABLE act_familia        AS ROWID.  DEFINE VARIABLE ult_familia        AS ROWID.
DEFINE VARIABLE act_familiar       AS ROWID.  DEFINE VARIABLE ult_familiar       AS ROWID.
DEFINE VARIABLE act_famprove       AS ROWID.  DEFINE VARIABLE ult_famprove       AS ROWID.
DEFINE VARIABLE act_fcomercial     AS ROWID.  DEFINE VARIABLE ult_fcomercial     AS ROWID.
DEFINE VARIABLE act_fdt_bonif      AS ROWID.  DEFINE VARIABLE ult_fdt_bonif      AS ROWID.
DEFINE VARIABLE act_feriado        AS ROWID.  DEFINE VARIABLE ult_feriado        AS ROWID.
DEFINE VARIABLE act_fletero        AS ROWID.  DEFINE VARIABLE ult_fletero        AS ROWID.
DEFINE VARIABLE act_forma          AS ROWID.  DEFINE VARIABLE ult_forma          AS ROWID.
DEFINE VARIABLE act_fpr_detl       AS ROWID.  DEFINE VARIABLE ult_fpr_detl       AS ROWID.
DEFINE VARIABLE act_fpr_gasto      AS ROWID.  DEFINE VARIABLE ult_fpr_gasto      AS ROWID.
DEFINE VARIABLE act_fpr_head       AS ROWID.  DEFINE VARIABLE ult_fpr_head       AS ROWID.
DEFINE VARIABLE act_funcion        AS ROWID.  DEFINE VARIABLE ult_funcion        AS ROWID.
DEFINE VARIABLE act_gasto          AS ROWID.  DEFINE VARIABLE ult_gasto          AS ROWID.
DEFINE VARIABLE act_grpbduso       AS ROWID.  DEFINE VARIABLE ult_grpbduso       AS ROWID.
DEFINE VARIABLE act_grupoemp       AS ROWID.  DEFINE VARIABLE ult_grupoemp       AS ROWID.
DEFINE VARIABLE act_grupo_francos  AS ROWID.  DEFINE VARIABLE ult_grupo_francos  AS ROWID.
DEFINE VARIABLE act_horario        AS ROWID.  DEFINE VARIABLE ult_horario        AS ROWID.
DEFINE VARIABLE act_imp_concepto   AS ROWID.  DEFINE VARIABLE ult_imp_concepto   AS ROWID.
DEFINE VARIABLE act_imp_cond       AS ROWID.  DEFINE VARIABLE ult_imp_cond       AS ROWID.
DEFINE VARIABLE act_impresora      AS ROWID.  DEFINE VARIABLE ult_impresora      AS ROWID.
DEFINE VARIABLE act_impuesto       AS ROWID.  DEFINE VARIABLE ult_impuesto       AS ROWID.
DEFINE VARIABLE act_imputacion     AS ROWID.  DEFINE VARIABLE ult_imputacion     AS ROWID.
DEFINE VARIABLE act_liquidacion    AS ROWID.  DEFINE VARIABLE ult_liquidacion    AS ROWID.
DEFINE VARIABLE act_lismail        AS ROWID.  DEFINE VARIABLE ult_lismail        AS ROWID.
DEFINE VARIABLE act_list           AS ROWID.  DEFINE VARIABLE ult_list           AS ROWID.
DEFINE VARIABLE act_lista          AS ROWID.  DEFINE VARIABLE ult_lista          AS ROWID.
DEFINE VARIABLE act_lstcomision    AS ROWID.  DEFINE VARIABLE ult_lstcomision    AS ROWID.
DEFINE VARIABLE act_marcacom       AS ROWID.  DEFINE VARIABLE ult_marcacom       AS ROWID.
DEFINE VARIABLE act_mensaje        AS ROWID.  DEFINE VARIABLE ult_mensaje        AS ROWID.
DEFINE VARIABLE act_moneda         AS ROWID.  DEFINE VARIABLE ult_moneda         AS ROWID.
DEFINE VARIABLE act_movimiento     AS ROWID.  DEFINE VARIABLE ult_movimiento     AS ROWID.
DEFINE VARIABLE act_mpl_sup        AS ROWID.  DEFINE VARIABLE ult_mpl_sup        AS ROWID.
DEFINE VARIABLE act_nov_estado     AS ROWID.  DEFINE VARIABLE ult_nov_estado     AS ROWID.
DEFINE VARIABLE act_novedad        AS ROWID.  DEFINE VARIABLE ult_novedad        AS ROWID.
DEFINE VARIABLE act_novedad_ocm    AS ROWID.  DEFINE VARIABLE ult_novedad_ocm    AS ROWID.
DEFINE VARIABLE act_obra           AS ROWID.  DEFINE VARIABLE ult_obra           AS ROWID.
DEFINE VARIABLE act_obs_convenio   AS ROWID.  DEFINE VARIABLE ult_obs_convenio   AS ROWID.
DEFINE VARIABLE act_oci_copias     AS ROWID.  DEFINE VARIABLE ult_oci_copias     AS ROWID.
DEFINE VARIABLE act_oci_detl       AS ROWID.  DEFINE VARIABLE ult_oci_detl       AS ROWID.
DEFINE VARIABLE act_oci_head       AS ROWID.  DEFINE VARIABLE ult_oci_head       AS ROWID.
DEFINE VARIABLE act_oci_novedad    AS ROWID.  DEFINE VARIABLE ult_oci_novedad    AS ROWID.
DEFINE VARIABLE act_ocm_copias     AS ROWID.  DEFINE VARIABLE ult_ocm_copias     AS ROWID.
DEFINE VARIABLE act_ocm_detl       AS ROWID.  DEFINE VARIABLE ult_ocm_detl       AS ROWID.
DEFINE VARIABLE act_ocm_head       AS ROWID.  DEFINE VARIABLE ult_ocm_head       AS ROWID.
DEFINE VARIABLE act_ocm_novedad    AS ROWID.  DEFINE VARIABLE ult_ocm_novedad    AS ROWID.
DEFINE VARIABLE act_opg_detl       AS ROWID.  DEFINE VARIABLE ult_opg_detl       AS ROWID.
DEFINE VARIABLE act_opg_head       AS ROWID.  DEFINE VARIABLE ult_opg_head       AS ROWID.
DEFINE VARIABLE act_otros          AS ROWID.  DEFINE VARIABLE ult_otros          AS ROWID.
DEFINE VARIABLE act_pais           AS ROWID.  DEFINE VARIABLE ult_pais           AS ROWID.
DEFINE VARIABLE act_parametro      AS ROWID.  DEFINE VARIABLE ult_parametro      AS ROWID.
DEFINE VARIABLE act_parte          AS ROWID.  DEFINE VARIABLE ult_parte          AS ROWID.
DEFINE VARIABLE act_partida        AS ROWID.  DEFINE VARIABLE ult_partida        AS ROWID.
DEFINE VARIABLE act_partidepo      AS ROWID.  DEFINE VARIABLE ult_partidepo      AS ROWID.
DEFINE VARIABLE act_ped_bonif      AS ROWID.  DEFINE VARIABLE ult_ped_bonif      AS ROWID.
DEFINE VARIABLE act_ped_copias     AS ROWID.  DEFINE VARIABLE ult_ped_copias     AS ROWID.
DEFINE VARIABLE act_ped_detl       AS ROWID.  DEFINE VARIABLE ult_ped_detl       AS ROWID.
DEFINE VARIABLE act_ped_head       AS ROWID.  DEFINE VARIABLE ult_ped_head       AS ROWID.
DEFINE VARIABLE act_planta         AS ROWID.  DEFINE VARIABLE ult_planta         AS ROWID.
DEFINE VARIABLE act_plazo          AS ROWID.  DEFINE VARIABLE ult_plazo          AS ROWID.
DEFINE VARIABLE act_precio         AS ROWID.  DEFINE VARIABLE ult_precio         AS ROWID.
DEFINE VARIABLE act_prepaga        AS ROWID.  DEFINE VARIABLE ult_prepaga        AS ROWID.
DEFINE VARIABLE act_proact         AS ROWID.  DEFINE VARIABLE ult_proact         AS ROWID.
DEFINE VARIABLE act_procnd         AS ROWID.  DEFINE VARIABLE ult_procnd         AS ROWID.
DEFINE VARIABLE act_programa       AS ROWID.  DEFINE VARIABLE ult_programa       AS ROWID.
DEFINE VARIABLE act_proret         AS ROWID.  DEFINE VARIABLE ult_proret         AS ROWID.
DEFINE VARIABLE act_proveedor      AS ROWID.  DEFINE VARIABLE ult_proveedor      AS ROWID.
DEFINE VARIABLE act_provincia      AS ROWID.  DEFINE VARIABLE ult_provincia      AS ROWID.
DEFINE VARIABLE act_rangan         AS ROWID.  DEFINE VARIABLE ult_rangan         AS ROWID.
DEFINE VARIABLE act_ranibr         AS ROWID.  DEFINE VARIABLE ult_ranibr         AS ROWID.
DEFINE VARIABLE act_raniva         AS ROWID.  DEFINE VARIABLE ult_raniva         AS ROWID.
DEFINE VARIABLE act_rcb_detl       AS ROWID.  DEFINE VARIABLE ult_rcb_detl       AS ROWID.
DEFINE VARIABLE act_rcb_head       AS ROWID.  DEFINE VARIABLE ult_rcb_head       AS ROWID.
DEFINE VARIABLE act_recorrido      AS ROWID.  DEFINE VARIABLE ult_recorrido      AS ROWID.
DEFINE VARIABLE act_rec_detl       AS ROWID.  DEFINE VARIABLE ult_rec_detl       AS ROWID.
DEFINE VARIABLE act_rec_head       AS ROWID.  DEFINE VARIABLE ult_rec_head       AS ROWID.
DEFINE VARIABLE act_rem_bonif      AS ROWID.  DEFINE VARIABLE ult_rem_bonif      AS ROWID.
DEFINE VARIABLE act_rem_detl       AS ROWID.  DEFINE VARIABLE ult_rem_detl       AS ROWID.
DEFINE VARIABLE act_rem_head       AS ROWID.  DEFINE VARIABLE ult_rem_head       AS ROWID.
DEFINE VARIABLE act_retencion      AS ROWID.  DEFINE VARIABLE ult_retencion      AS ROWID.
DEFINE VARIABLE act_rng_legajos    AS ROWID.  DEFINE VARIABLE ult_rng_legajos    AS ROWID.
DEFINE VARIABLE act_rpr_detl       AS ROWID.  DEFINE VARIABLE ult_rpr_detl       AS ROWID.
DEFINE VARIABLE act_rpr_head       AS ROWID.  DEFINE VARIABLE ult_rpr_head       AS ROWID.
DEFINE VARIABLE act_rqs_copias     AS ROWID.  DEFINE VARIABLE ult_rqs_copias     AS ROWID.
DEFINE VARIABLE act_rqs_detl       AS ROWID.  DEFINE VARIABLE ult_rqs_detl       AS ROWID.
DEFINE VARIABLE act_rqs_head       AS ROWID.  DEFINE VARIABLE ult_rqs_head       AS ROWID.
DEFINE VARIABLE act_rqs_novedad    AS ROWID.  DEFINE VARIABLE ult_rqs_novedad    AS ROWID.
DEFINE VARIABLE act_rubro          AS ROWID.  DEFINE VARIABLE ult_rubro          AS ROWID.
DEFINE VARIABLE act_seccion        AS ROWID.  DEFINE VARIABLE ult_seccion        AS ROWID.
DEFINE VARIABLE act_secdepos       AS ROWID.  DEFINE VARIABLE ult_secdepos       AS ROWID.
DEFINE VARIABLE act_sexo           AS ROWID.  DEFINE VARIABLE ult_sexo           AS ROWID.
DEFINE VARIABLE act_sin_convenio   AS ROWID.  DEFINE VARIABLE ult_sin_convenio   AS ROWID.
DEFINE VARIABLE act_sindicato      AS ROWID.  DEFINE VARIABLE ult_sindicato      AS ROWID.
DEFINE VARIABLE act_solicitante    AS ROWID.  DEFINE VARIABLE ult_solicitante    AS ROWID.
DEFINE VARIABLE act_sub_head       AS ROWID.  DEFINE VARIABLE ult_sub_head       AS ROWID.
DEFINE VARIABLE act_subcondicion   AS ROWID.  DEFINE VARIABLE ult_subcondicion   AS ROWID.
DEFINE VARIABLE act_suc_head       AS ROWID.  DEFINE VARIABLE ult_suc_head       AS ROWID.
DEFINE VARIABLE act_sumador        AS ROWID.  DEFINE VARIABLE ult_sumador        AS ROWID.
DEFINE VARIABLE act_sumapsp        AS ROWID.  DEFINE VARIABLE ult_sumapsp        AS ROWID.
DEFINE VARIABLE act_sucursal       AS ROWID.  DEFINE VARIABLE ult_sucursal       AS ROWID.
DEFINE VARIABLE act_tarea          AS ROWID.  DEFINE VARIABLE ult_tarea          AS ROWID.
DEFINE VARIABLE act_tipactiv       AS ROWID.  DEFINE VARIABLE ult_tipactiv       AS ROWID.
DEFINE VARIABLE act_tipfam         AS ROWID.  DEFINE VARIABLE ult_tipfam         AS ROWID.
DEFINE VARIABLE act_tipliq         AS ROWID.  DEFINE VARIABLE ult_tipliq         AS ROWID.
DEFINE VARIABLE act_tiprove        AS ROWID.  DEFINE VARIABLE ult_tiprove        AS ROWID.
DEFINE VARIABLE act_tipoart        AS ROWID.  DEFINE VARIABLE ult_tipoart        AS ROWID.
DEFINE VARIABLE act_totalizador    AS ROWID.  DEFINE VARIABLE ult_totalizador    AS ROWID.
DEFINE VARIABLE act_totliq         AS ROWID.  DEFINE VARIABLE ult_totliq         AS ROWID.
DEFINE VARIABLE act_unidad         AS ROWID.  DEFINE VARIABLE ult_unidad         AS ROWID.
DEFINE VARIABLE act_usrfuncion     AS ROWID.  DEFINE VARIABLE ult_usrfuncion     AS ROWID.
DEFINE VARIABLE act_usrprograma    AS ROWID.  DEFINE VARIABLE ult_usrprograma    AS ROWID.
DEFINE VARIABLE act_usuario        AS ROWID.  DEFINE VARIABLE ult_usuario        AS ROWID.
DEFINE VARIABLE act_valor          AS ROWID.  DEFINE VARIABLE ult_valor          AS ROWID.
DEFINE VARIABLE act_vendedor       AS ROWID.  DEFINE VARIABLE ult_vendedor       AS ROWID.
DEFINE VARIABLE act_vsa_detl       AS ROWID.  DEFINE VARIABLE ult_vsa_detl       AS ROWID.
DEFINE VARIABLE act_vsa_head       AS ROWID.  DEFINE VARIABLE ult_vsa_head       AS ROWID.
DEFINE VARIABLE act_zonag          AS ROWID.  DEFINE VARIABLE ult_zonag          AS ROWID.
DEFINE VARIABLE act_zzz            AS ROWID.  DEFINE VARIABLE ult_zzz            AS ROWID.

/* --------- Uso general en todos los programas, pero locales a ellos ----------- */

DEFINE VARIABLE aux_ROWID       AS ROWID.
DEFINE VARIABLE ant_ROWID       AS ROWID NO-UNDO.

DEFINE VARIABLE sino_salir      AS LOGICAL.
DEFINE VARIABLE sino_cancel     AS LOGICAL.
DEFINE VARIABLE sino_grabar     AS LOGICAL.
DEFINE VARIABLE hay_error       AS LOGICAL.
DEFINE VARIABLE hubo_error      AS LOGICAL.
DEFINE VARIABLE sino            AS LOGICAL.
DEFINE VARIABLE como_fue        AS LOGICAL.
DEFINE VARIABLE no_aplicar      AS LOGICAL. /* Flag para NO-APPLY DEFL.RESP. en triggers */

DEFINE VARIABLE nom_funcion     AS CHARACTER.
DEFINE VARIABLE nom_menu        AS CHARACTER.
DEFINE VARIABLE titulo_w        AS CHARACTER.


DEFINE VARIABLE modo_mant       AS INTEGER.
DEFINE VARIABLE dumy_intg       AS INTEGER.
DEFINE VARIABLE dumy_char       AS CHARACTER.
DEFINE VARIABLE dumy_logl       AS LOGICAL.

DEFINE VARIABLE port            AS CHARACTER INITIAL "LPT1".

/* -------------- Parametros Locales ------------------------------*/

{parlocales.i}

/* -------------- Tipos de comprobantes que debitan ---------------*/

{strdebitan.i}

/* -------------- Estados de cheques prropios y de terceros -------*/

{stcheques.i}
