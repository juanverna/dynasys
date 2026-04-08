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

DEFINE {1} SHARED VARIABLE act_acc_concepto    AS ROWID. DEFINE {1} SHARED VARIABLE ult_acc_concepto   AS ROWID.
DEFINE {1} SHARED VARIABLE act_acc_dato        AS ROWID. DEFINE {1} SHARED VARIABLE ult_acc_dato       AS ROWID.
DEFINE {1} SHARED VARIABLE act_afjp            AS ROWID. DEFINE {1} SHARED VARIABLE ult_afjp           AS ROWID.
DEFINE {1} SHARED VARIABLE act_aliart          AS ROWID. DEFINE {1} SHARED VARIABLE ult_aliart         AS ROWID.
DEFINE {1} SHARED VARIABLE act_amd_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_amd_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_amd_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_amd_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_amp_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_amp_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_amp_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_amp_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_aps_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_aps_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_aps_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_aps_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_area            AS ROWID. DEFINE {1} SHARED VARIABLE ult_area           AS ROWID.
DEFINE {1} SHARED VARIABLE act_art             AS ROWID. DEFINE {1} SHARED VARIABLE ult_art            AS ROWID.
DEFINE {1} SHARED VARIABLE act_artdepos        AS ROWID. DEFINE {1} SHARED VARIABLE ult_artdepos       AS ROWID.
DEFINE {1} SHARED VARIABLE act_artic_prv       AS ROWID. DEFINE {1} SHARED VARIABLE ult_artic_prv      AS ROWID.
DEFINE {1} SHARED VARIABLE act_articulo        AS ROWID. DEFINE {1} SHARED VARIABLE ult_articulo       AS ROWID.
DEFINE {1} SHARED VARIABLE act_artim           AS ROWID. DEFINE {1} SHARED VARIABLE ult_artim          AS ROWID.
DEFINE {1} SHARED VARIABLE act_asn_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_asn_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_asn_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_asn_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_banco           AS ROWID. DEFINE {1} SHARED VARIABLE ult_banco          AS ROWID.
DEFINE {1} SHARED VARIABLE act_bduso           AS ROWID. DEFINE {1} SHARED VARIABLE ult_bduso          AS ROWID.
DEFINE {1} SHARED VARIABLE act_bonific         AS ROWID. DEFINE {1} SHARED VARIABLE ult_bonific        AS ROWID.
DEFINE {1} SHARED VARIABLE act_caj_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_caj_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_caj_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_caj_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_caj_imput       AS ROWID. DEFINE {1} SHARED VARIABLE ult_caj_imput      AS ROWID.
DEFINE {1} SHARED VARIABLE act_caja            AS ROWID. DEFINE {1} SHARED VARIABLE ult_caja           AS ROWID.
DEFINE {1} SHARED VARIABLE act_categ           AS ROWID. DEFINE {1} SHARED VARIABLE ult_categ          AS ROWID.
DEFINE {1} SHARED VARIABLE act_cctstk          AS ROWID. DEFINE {1} SHARED VARIABLE ult_cctstk         AS ROWID.
DEFINE {1} SHARED VARIABLE act_certgan         AS ROWID. DEFINE {1} SHARED VARIABLE ult_certgan        AS ROWID.
DEFINE {1} SHARED VARIABLE act_certibr         AS ROWID. DEFINE {1} SHARED VARIABLE ult_certibr        AS ROWID.
DEFINE {1} SHARED VARIABLE act_certiva         AS ROWID. DEFINE {1} SHARED VARIABLE ult_certiva        AS ROWID.
DEFINE {1} SHARED VARIABLE act_ciclo           AS ROWID. DEFINE {1} SHARED VARIABLE ult_ciclo          AS ROWID.
DEFINE {1} SHARED VARIABLE act_clase           AS ROWID. DEFINE {1} SHARED VARIABLE ult_clase          AS ROWID.
DEFINE {1} SHARED VARIABLE act_clibon          AS ROWID. DEFINE {1} SHARED VARIABLE ult_clibon         AS ROWID.
DEFINE {1} SHARED VARIABLE act_clibonxart      AS ROWID. DEFINE {1} SHARED VARIABLE ult_clibonxart     AS ROWID.
DEFINE {1} SHARED VARIABLE act_clicnd          AS ROWID. DEFINE {1} SHARED VARIABLE ult_clicnd         AS ROWID.
DEFINE {1} SHARED VARIABLE act_cliente         AS ROWID. DEFINE {1} SHARED VARIABLE ult_cliente        AS ROWID.
DEFINE {1} SHARED VARIABLE act_clpsp           AS ROWID. DEFINE {1} SHARED VARIABLE ult_clpsp          AS ROWID.
DEFINE {1} SHARED VARIABLE act_cnc_convenio    AS ROWID. DEFINE {1} SHARED VARIABLE ult_cnc_convenio   AS ROWID.
DEFINE {1} SHARED VARIABLE act_cnc_cuenta      AS ROWID. DEFINE {1} SHARED VARIABLE ult_cnc_cuenta     AS ROWID.
DEFINE {1} SHARED VARIABLE act_cnc_empleado    AS ROWID. DEFINE {1} SHARED VARIABLE ult_cnc_empleado   AS ROWID.
DEFINE {1} SHARED VARIABLE act_cnc_liquid      AS ROWID. DEFINE {1} SHARED VARIABLE ult_cnc_liquid     AS ROWID.
DEFINE {1} SHARED VARIABLE act_cnv_liquid      AS ROWID. DEFINE {1} SHARED VARIABLE ult_cnv_liquid     AS ROWID.
DEFINE {1} SHARED VARIABLE act_cndventa        AS ROWID. DEFINE {1} SHARED VARIABLE ult_cndventa       AS ROWID.
DEFINE {1} SHARED VARIABLE act_cobrador        AS ROWID. DEFINE {1} SHARED VARIABLE ult_cobrador       AS ROWID.
DEFINE {1} SHARED VARIABLE act_coefic          AS ROWID. DEFINE {1} SHARED VARIABLE ult_coefic         AS ROWID.
DEFINE {1} SHARED VARIABLE act_comprador       AS ROWID. DEFINE {1} SHARED VARIABLE ult_comprador      AS ROWID.
DEFINE {1} SHARED VARIABLE act_concepto        AS ROWID. DEFINE {1} SHARED VARIABLE ult_concepto       AS ROWID.
DEFINE {1} SHARED VARIABLE act_condiva         AS ROWID. DEFINE {1} SHARED VARIABLE ult_condiva        AS ROWID.
DEFINE {1} SHARED VARIABLE act_constante       AS ROWID. DEFINE {1} SHARED VARIABLE ult_constante      AS ROWID.
DEFINE {1} SHARED VARIABLE act_convenio        AS ROWID. DEFINE {1} SHARED VARIABLE ult_convenio       AS ROWID.
DEFINE {1} SHARED VARIABLE act_cpostal         AS ROWID. DEFINE {1} SHARED VARIABLE ult_cpostal        AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctacte          AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctacte         AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctacte_bco      AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctacte_bco     AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctacte_emp      AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctacte_emp     AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctacte_prv      AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctacte_prv     AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctapsp          AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctapsp         AS ROWID.
DEFINE {1} SHARED VARIABLE act_ctrl_impresora  AS ROWID. DEFINE {1} SHARED VARIABLE ult_ctrl_impresora AS ROWID.
DEFINE {1} SHARED VARIABLE act_cuenta          AS ROWID. DEFINE {1} SHARED VARIABLE ult_cuenta         AS ROWID.
DEFINE {1} SHARED VARIABLE act_cuenta_ban      AS ROWID. DEFINE {1} SHARED VARIABLE ult_cuenta_ban     AS ROWID.
DEFINE {1} SHARED VARIABLE act_cheque          AS ROWID. DEFINE {1} SHARED VARIABLE ult_cheque         AS ROWID.
DEFINE {1} SHARED VARIABLE act_chequera        AS ROWID. DEFINE {1} SHARED VARIABLE ult_chequera       AS ROWID.
DEFINE {1} SHARED VARIABLE act_datliq          AS ROWID. DEFINE {1} SHARED VARIABLE ult_datliq         AS ROWID.
DEFINE {1} SHARED VARIABLE act_deposito        AS ROWID. DEFINE {1} SHARED VARIABLE ult_deposito       AS ROWID.
DEFINE {1} SHARED VARIABLE act_destino         AS ROWID. DEFINE {1} SHARED VARIABLE ult_destino        AS ROWID.
DEFINE {1} SHARED VARIABLE act_dia_franco      AS ROWID. DEFINE {1} SHARED VARIABLE ult_dia_franco     AS ROWID.
DEFINE {1} SHARED VARIABLE act_dlqemp          AS ROWID. DEFINE {1} SHARED VARIABLE ult_dlqemp         AS ROWID.
DEFINE {1} SHARED VARIABLE act_domic           AS ROWID. DEFINE {1} SHARED VARIABLE ult_domic          AS ROWID.
DEFINE {1} SHARED VARIABLE act_domic_prv       AS ROWID. DEFINE {1} SHARED VARIABLE ult_domic_prv      AS ROWID.
DEFINE {1} SHARED VARIABLE act_ejercicio       AS ROWID. DEFINE {1} SHARED VARIABLE ult_ejercicio      AS ROWID.
DEFINE {1} SHARED VARIABLE act_emb_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_emb_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_emb_gasto       AS ROWID. DEFINE {1} SHARED VARIABLE ult_emb_gasto      AS ROWID.
DEFINE {1} SHARED VARIABLE act_emb_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_emb_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_empleado        AS ROWID. DEFINE {1} SHARED VARIABLE ult_empleado       AS ROWID.
DEFINE {1} SHARED VARIABLE act_empresa         AS ROWID. DEFINE {1} SHARED VARIABLE ult_empresa        AS ROWID.
DEFINE {1} SHARED VARIABLE act_entidad         AS ROWID. DEFINE {1} SHARED VARIABLE ult_entidad        AS ROWID.
DEFINE {1} SHARED VARIABLE act_ent_empleado    AS ROWID. DEFINE {1} SHARED VARIABLE ult_ent_empleado   AS ROWID.
DEFINE {1} SHARED VARIABLE act_entrega         AS ROWID. DEFINE {1} SHARED VARIABLE ult_entrega        AS ROWID.
DEFINE {1} SHARED VARIABLE act_escol           AS ROWID. DEFINE {1} SHARED VARIABLE ult_escol          AS ROWID.
DEFINE {1} SHARED VARIABLE act_espec           AS ROWID. DEFINE {1} SHARED VARIABLE ult_espec          AS ROWID.
DEFINE {1} SHARED VARIABLE act_est_civ         AS ROWID. DEFINE {1} SHARED VARIABLE ult_est_civ        AS ROWID.
DEFINE {1} SHARED VARIABLE act_est_liquid      AS ROWID. DEFINE {1} SHARED VARIABLE ult_est_liquid     AS ROWID.
DEFINE {1} SHARED VARIABLE act_est_ped         AS ROWID. DEFINE {1} SHARED VARIABLE ult_est_ped        AS ROWID.
DEFINE {1} SHARED VARIABLE act_estado          AS ROWID. DEFINE {1} SHARED VARIABLE ult_estado         AS ROWID.
DEFINE {1} SHARED VARIABLE act_estructura      AS ROWID. DEFINE {1} SHARED VARIABLE ult_estructura     AS ROWID.
DEFINE {1} SHARED VARIABLE act_extracto        AS ROWID. DEFINE {1} SHARED VARIABLE ult_extracto       AS ROWID.
DEFINE {1} SHARED VARIABLE act_fac_bonif       AS ROWID. DEFINE {1} SHARED VARIABLE ult_fac_bonif      AS ROWID.
DEFINE {1} SHARED VARIABLE act_fac_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_fac_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_fac_gasto       AS ROWID. DEFINE {1} SHARED VARIABLE ult_fac_gasto      AS ROWID.
DEFINE {1} SHARED VARIABLE act_fac_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_fac_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_famclie         AS ROWID. DEFINE {1} SHARED VARIABLE ult_famclie        AS ROWID.
DEFINE {1} SHARED VARIABLE act_familia         AS ROWID. DEFINE {1} SHARED VARIABLE ult_familia        AS ROWID.
DEFINE {1} SHARED VARIABLE act_familiar        AS ROWID. DEFINE {1} SHARED VARIABLE ult_familiar       AS ROWID.
DEFINE {1} SHARED VARIABLE act_famprove        AS ROWID. DEFINE {1} SHARED VARIABLE ult_famprove       AS ROWID.
DEFINE {1} SHARED VARIABLE act_fcomercial      AS ROWID. DEFINE {1} SHARED VARIABLE ult_fcomercial     AS ROWID.
DEFINE {1} SHARED VARIABLE act_fdt_bonif       AS ROWID. DEFINE {1} SHARED VARIABLE ult_fdt_bonif      AS ROWID.
DEFINE {1} SHARED VARIABLE act_feriado         AS ROWID. DEFINE {1} SHARED VARIABLE ult_feriado        AS ROWID.
DEFINE {1} SHARED VARIABLE act_fletero         AS ROWID. DEFINE {1} SHARED VARIABLE ult_fletero        AS ROWID.
DEFINE {1} SHARED VARIABLE act_forma           AS ROWID. DEFINE {1} SHARED VARIABLE ult_forma          AS ROWID.
DEFINE {1} SHARED VARIABLE act_fpr_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_fpr_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_fpr_gasto       AS ROWID. DEFINE {1} SHARED VARIABLE ult_fpr_gasto      AS ROWID.
DEFINE {1} SHARED VARIABLE act_fpr_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_fpr_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_funcion         AS ROWID. DEFINE {1} SHARED VARIABLE ult_funcion        AS ROWID.
DEFINE {1} SHARED VARIABLE act_gasto           AS ROWID. DEFINE {1} SHARED VARIABLE ult_gasto          AS ROWID.
DEFINE {1} SHARED VARIABLE act_grpbduso        AS ROWID. DEFINE {1} SHARED VARIABLE ult_grpbduso       AS ROWID.
DEFINE {1} SHARED VARIABLE act_grupoemp        AS ROWID. DEFINE {1} SHARED VARIABLE ult_grupoemp       AS ROWID.
DEFINE {1} SHARED VARIABLE act_grupo_francos   AS ROWID. DEFINE {1} SHARED VARIABLE ult_grupo_francos  AS ROWID.
DEFINE {1} SHARED VARIABLE act_horario         AS ROWID. DEFINE {1} SHARED VARIABLE ult_horario        AS ROWID.
DEFINE {1} SHARED VARIABLE act_imp_concepto    AS ROWID. DEFINE {1} SHARED VARIABLE ult_imp_concepto   AS ROWID.
DEFINE {1} SHARED VARIABLE act_imp_cond        AS ROWID. DEFINE {1} SHARED VARIABLE ult_imp_cond       AS ROWID.
DEFINE {1} SHARED VARIABLE act_impresora       AS ROWID. DEFINE {1} SHARED VARIABLE ult_impresora      AS ROWID.
DEFINE {1} SHARED VARIABLE act_impuesto        AS ROWID. DEFINE {1} SHARED VARIABLE ult_impuesto       AS ROWID.
DEFINE {1} SHARED VARIABLE act_imputacion      AS ROWID. DEFINE {1} SHARED VARIABLE ult_imputacion     AS ROWID.
DEFINE {1} SHARED VARIABLE act_liquidacion     AS ROWID. DEFINE {1} SHARED VARIABLE ult_liquidacion    AS ROWID.
DEFINE {1} SHARED VARIABLE act_lismail         AS ROWID. DEFINE {1} SHARED VARIABLE ult_lismail        AS ROWID.
DEFINE {1} SHARED VARIABLE act_list            AS ROWID. DEFINE {1} SHARED VARIABLE ult_list           AS ROWID.
DEFINE {1} SHARED VARIABLE act_lista           AS ROWID. DEFINE {1} SHARED VARIABLE ult_lista          AS ROWID.
DEFINE {1} SHARED VARIABLE act_lstcomision     AS ROWID. DEFINE {1} SHARED VARIABLE ult_lstcomision    AS ROWID.
DEFINE {1} SHARED VARIABLE act_marcacom        AS ROWID. DEFINE {1} SHARED VARIABLE ult_marcacom       AS ROWID.
DEFINE {1} SHARED VARIABLE act_mensaje         AS ROWID. DEFINE {1} SHARED VARIABLE ult_mensaje        AS ROWID.
DEFINE {1} SHARED VARIABLE act_moneda          AS ROWID. DEFINE {1} SHARED VARIABLE ult_moneda         AS ROWID.
DEFINE {1} SHARED VARIABLE act_movimiento      AS ROWID. DEFINE {1} SHARED VARIABLE ult_movimiento     AS ROWID.
DEFINE {1} SHARED VARIABLE act_mpl_sup         AS ROWID. DEFINE {1} SHARED VARIABLE ult_mpl_sup        AS ROWID.
DEFINE {1} SHARED VARIABLE act_nov_estado      AS ROWID. DEFINE {1} SHARED VARIABLE ult_nov_estado     AS ROWID.
DEFINE {1} SHARED VARIABLE act_novedad         AS ROWID. DEFINE {1} SHARED VARIABLE ult_novedad        AS ROWID.
DEFINE {1} SHARED VARIABLE act_novedad_ocm     AS ROWID. DEFINE {1} SHARED VARIABLE ult_novedad_ocm    AS ROWID.
DEFINE {1} SHARED VARIABLE act_obra            AS ROWID. DEFINE {1} SHARED VARIABLE ult_obra           AS ROWID.
DEFINE {1} SHARED VARIABLE act_obs_convenio    AS ROWID. DEFINE {1} SHARED VARIABLE ult_obs_convenio   AS ROWID.
DEFINE {1} SHARED VARIABLE act_oci_copias      AS ROWID. DEFINE {1} SHARED VARIABLE ult_oci_copias     AS ROWID.
DEFINE {1} SHARED VARIABLE act_oci_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_oci_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_oci_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_oci_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_oci_novedad     AS ROWID. DEFINE {1} SHARED VARIABLE ult_oci_novedad    AS ROWID.
DEFINE {1} SHARED VARIABLE act_ocm_copias      AS ROWID. DEFINE {1} SHARED VARIABLE ult_ocm_copias     AS ROWID.
DEFINE {1} SHARED VARIABLE act_ocm_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_ocm_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_ocm_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_ocm_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_ocm_novedad     AS ROWID. DEFINE {1} SHARED VARIABLE ult_ocm_novedad    AS ROWID.
DEFINE {1} SHARED VARIABLE act_opg_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_opg_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_opg_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_opg_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_otros           AS ROWID. DEFINE {1} SHARED VARIABLE ult_otros          AS ROWID.
DEFINE {1} SHARED VARIABLE act_pais            AS ROWID. DEFINE {1} SHARED VARIABLE ult_pais           AS ROWID.
DEFINE {1} SHARED VARIABLE act_parametro       AS ROWID. DEFINE {1} SHARED VARIABLE ult_parametro      AS ROWID.
DEFINE {1} SHARED VARIABLE act_parte           AS ROWID. DEFINE {1} SHARED VARIABLE ult_parte          AS ROWID.
DEFINE {1} SHARED VARIABLE act_partida         AS ROWID. DEFINE {1} SHARED VARIABLE ult_partida        AS ROWID.
DEFINE {1} SHARED VARIABLE act_partidepo       AS ROWID. DEFINE {1} SHARED VARIABLE ult_partidepo      AS ROWID.
DEFINE {1} SHARED VARIABLE act_ped_bonif       AS ROWID. DEFINE {1} SHARED VARIABLE ult_ped_bonif      AS ROWID.
DEFINE {1} SHARED VARIABLE act_ped_copias      AS ROWID. DEFINE {1} SHARED VARIABLE ult_ped_copias     AS ROWID.
DEFINE {1} SHARED VARIABLE act_ped_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_ped_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_ped_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_ped_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_planta          AS ROWID. DEFINE {1} SHARED VARIABLE ult_planta         AS ROWID.
DEFINE {1} SHARED VARIABLE act_plazo           AS ROWID. DEFINE {1} SHARED VARIABLE ult_plazo          AS ROWID.
DEFINE {1} SHARED VARIABLE act_precio          AS ROWID. DEFINE {1} SHARED VARIABLE ult_precio         AS ROWID.
DEFINE {1} SHARED VARIABLE act_prepaga         AS ROWID. DEFINE {1} SHARED VARIABLE ult_prepaga        AS ROWID.
DEFINE {1} SHARED VARIABLE act_proact          AS ROWID. DEFINE {1} SHARED VARIABLE ult_proact         AS ROWID.
DEFINE {1} SHARED VARIABLE act_procnd          AS ROWID. DEFINE {1} SHARED VARIABLE ult_procnd         AS ROWID.
DEFINE {1} SHARED VARIABLE act_programa        AS ROWID. DEFINE {1} SHARED VARIABLE ult_programa       AS ROWID.
DEFINE {1} SHARED VARIABLE act_proret          AS ROWID. DEFINE {1} SHARED VARIABLE ult_proret         AS ROWID.
DEFINE {1} SHARED VARIABLE act_proveedor       AS ROWID. DEFINE {1} SHARED VARIABLE ult_proveedor      AS ROWID.
DEFINE {1} SHARED VARIABLE act_provincia       AS ROWID. DEFINE {1} SHARED VARIABLE ult_provincia      AS ROWID.
DEFINE {1} SHARED VARIABLE act_rangan          AS ROWID. DEFINE {1} SHARED VARIABLE ult_rangan         AS ROWID.
DEFINE {1} SHARED VARIABLE act_ranibr          AS ROWID. DEFINE {1} SHARED VARIABLE ult_ranibr         AS ROWID.
DEFINE {1} SHARED VARIABLE act_raniva          AS ROWID. DEFINE {1} SHARED VARIABLE ult_raniva         AS ROWID.
DEFINE {1} SHARED VARIABLE act_rcb_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rcb_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rcb_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rcb_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_recorrido       AS ROWID. DEFINE {1} SHARED VARIABLE ult_recorrido      AS ROWID.
DEFINE {1} SHARED VARIABLE act_rec_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rec_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rec_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rec_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rem_bonif       AS ROWID. DEFINE {1} SHARED VARIABLE ult_rem_bonif      AS ROWID.
DEFINE {1} SHARED VARIABLE act_rem_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rem_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rem_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rem_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_retencion       AS ROWID. DEFINE {1} SHARED VARIABLE ult_retencion      AS ROWID.
DEFINE {1} SHARED VARIABLE act_rng_legajos     AS ROWID. DEFINE {1} SHARED VARIABLE ult_rng_legajos    AS ROWID.
DEFINE {1} SHARED VARIABLE act_rpr_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rpr_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rpr_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rpr_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rqs_copias      AS ROWID. DEFINE {1} SHARED VARIABLE ult_rqs_copias     AS ROWID.
DEFINE {1} SHARED VARIABLE act_rqs_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rqs_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rqs_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_rqs_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_rqs_novedad     AS ROWID. DEFINE {1} SHARED VARIABLE ult_rqs_novedad    AS ROWID.
DEFINE {1} SHARED VARIABLE act_rubro           AS ROWID. DEFINE {1} SHARED VARIABLE ult_rubro          AS ROWID.
DEFINE {1} SHARED VARIABLE act_seccion         AS ROWID. DEFINE {1} SHARED VARIABLE ult_seccion        AS ROWID.
DEFINE {1} SHARED VARIABLE act_secdepos        AS ROWID. DEFINE {1} SHARED VARIABLE ult_secdepos       AS ROWID.
DEFINE {1} SHARED VARIABLE act_sexo            AS ROWID. DEFINE {1} SHARED VARIABLE ult_sexo           AS ROWID.
DEFINE {1} SHARED VARIABLE act_sin_convenio    AS ROWID. DEFINE {1} SHARED VARIABLE ult_sin_convenio   AS ROWID.
DEFINE {1} SHARED VARIABLE act_sindicato       AS ROWID. DEFINE {1} SHARED VARIABLE ult_sindicato      AS ROWID.
DEFINE {1} SHARED VARIABLE act_solicitante     AS ROWID. DEFINE {1} SHARED VARIABLE ult_solicitante    AS ROWID.
DEFINE {1} SHARED VARIABLE act_sub_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_sub_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_subcondicion    AS ROWID. DEFINE {1} SHARED VARIABLE ult_subcondicion   AS ROWID.
DEFINE {1} SHARED VARIABLE act_suc_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_suc_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_sumador         AS ROWID. DEFINE {1} SHARED VARIABLE ult_sumador        AS ROWID.
DEFINE {1} SHARED VARIABLE act_sumapsp         AS ROWID. DEFINE {1} SHARED VARIABLE ult_sumapsp        AS ROWID.
DEFINE {1} SHARED VARIABLE act_sucursal        AS ROWID. DEFINE {1} SHARED VARIABLE ult_sucursal       AS ROWID.
DEFINE {1} SHARED VARIABLE act_tarea           AS ROWID. DEFINE {1} SHARED VARIABLE ult_tarea          AS ROWID.
DEFINE {1} SHARED VARIABLE act_tipactiv        AS ROWID. DEFINE {1} SHARED VARIABLE ult_tipactiv       AS ROWID.
DEFINE {1} SHARED VARIABLE act_tipfam          AS ROWID. DEFINE {1} SHARED VARIABLE ult_tipfam         AS ROWID.
DEFINE {1} SHARED VARIABLE act_tipliq          AS ROWID. DEFINE {1} SHARED VARIABLE ult_tipliq         AS ROWID.
DEFINE {1} SHARED VARIABLE act_tiprove         AS ROWID. DEFINE {1} SHARED VARIABLE ult_tiprove        AS ROWID.
DEFINE {1} SHARED VARIABLE act_tipoart         AS ROWID. DEFINE {1} SHARED VARIABLE ult_tipoart        AS ROWID.
DEFINE {1} SHARED VARIABLE act_totalizador     AS ROWID. DEFINE {1} SHARED VARIABLE ult_totalizador    AS ROWID.
DEFINE {1} SHARED VARIABLE act_totliq          AS ROWID. DEFINE {1} SHARED VARIABLE ult_totliq         AS ROWID.
DEFINE {1} SHARED VARIABLE act_unidad          AS ROWID. DEFINE {1} SHARED VARIABLE ult_unidad         AS ROWID.
DEFINE {1} SHARED VARIABLE act_usrfuncion      AS ROWID. DEFINE {1} SHARED VARIABLE ult_usrfuncion     AS ROWID.
DEFINE {1} SHARED VARIABLE act_usrprograma     AS ROWID. DEFINE {1} SHARED VARIABLE ult_usrprograma    AS ROWID.
DEFINE {1} SHARED VARIABLE act_usuario         AS ROWID. DEFINE {1} SHARED VARIABLE ult_usuario        AS ROWID.
DEFINE {1} SHARED VARIABLE act_valor           AS ROWID. DEFINE {1} SHARED VARIABLE ult_valor          AS ROWID.
DEFINE {1} SHARED VARIABLE act_vendedor        AS ROWID. DEFINE {1} SHARED VARIABLE ult_vendedor       AS ROWID.
DEFINE {1} SHARED VARIABLE act_vsa_detl        AS ROWID. DEFINE {1} SHARED VARIABLE ult_vsa_detl       AS ROWID.
DEFINE {1} SHARED VARIABLE act_vsa_head        AS ROWID. DEFINE {1} SHARED VARIABLE ult_vsa_head       AS ROWID.
DEFINE {1} SHARED VARIABLE act_zonag           AS ROWID. DEFINE {1} SHARED VARIABLE ult_zonag          AS ROWID.
DEFINE {1} SHARED VARIABLE act_zzz             AS ROWID. DEFINE {1} SHARED VARIABLE ult_zzz            AS ROWID.

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

/* -------------- Estados de cheques ----------------------------*/

{stcheques.i}

