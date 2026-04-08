/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_empresa   LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-cdg_sigla-sic LIKE Cierre_diario.cdg_sigla-sic.
DEFINE INPUT  PARAMETER p-fch_cierre    LIKE Cierre_diario.fch_cierre.
DEFINE OUTPUT PARAMETER p-cierre_ok     AS INTEGER.

/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

CASE p-cdg_sigla-sic:

    WHEN "ABA" THEN RUN ver_cierre_aba.p  ( INPUT p-cdg_empresa,
                                            INPUT p-fch_cierre,
                                            OUTPUT p-cierre_ok ).

    WHEN "ADP" THEN RUN ver_cierre_adp.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,
                                            OUTPUT p-cierre_ok ).

    WHEN "AFI" THEN RUN ver_cierre_afi.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,
                                            OUTPUT p-cierre_ok ).

    WHEN "BDU" THEN RUN ver_cierre_bdu.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,
                                            OUTPUT p-cierre_ok ).

    WHEN "CMX" THEN RUN ver_cierre_cmx.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "COM" THEN RUN ver_cierre_com.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "CPS" THEN RUN ver_cierre_cps.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "CXC" THEN RUN ver_cierre_cxc.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "CXP" THEN RUN ver_cierre_cxp.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "DSP" THEN RUN ver_cierre_dsp.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,
                                            OUTPUT p-cierre_ok ).

    WHEN "FAC" THEN RUN ver_cierre_fac.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "GLA" THEN RUN ver_cierre_gla.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "IMP" THEN RUN ver_cierre_imp.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "INV" THEN RUN ver_cierre_inv.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "PRD" THEN RUN ver_cierre_inv.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "RGV" THEN RUN ver_cierre_rgv.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "TES" THEN RUN ver_cierre_tes.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

    WHEN "UTL" THEN RUN ver_cierre_utl.p  ( INPUT p-cdg_empresa,   
                                            INPUT p-fch_cierre,    
                                            OUTPUT p-cierre_ok ).

END CASE.

/*==============================================================================================*/
/*                     PROCEDIMIENTOS DE VERIFICACION PROPIAMENTE DICHOS                        */
/*==============================================================================================*/

