/*===========================================================================================*/
/*                        PRODUCE LA ANULACION DE UNA ORDEN DE PAGO                          */
/*===========================================================================================*/

DEFINE INPUT  PARAMETER rid_pedido      AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular    AS INTEGER.

/*===========================================================================================*/
/*                                        VARIABLES                                          */
/*===========================================================================================*/

{vrshared.i}

DEFINE VARIABLE equiv_granel            LIKE Ped_detalle.granel.

/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                      */
/*===========================================================================================*/

DO TRANSACTION:

     FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido EXCLUSIVE-LOCK.
     FIND Cliente OF Ped_header NO-LOCK.

     IF CAN-FIND(FIRST Remito-pedido OF Ped_header)
     THEN DO:
         RUN ponmensj.p ( INPUT "PEDI042" ).
         puede_anular = 1.
     END.
     ELSE DO:
         IF LOOKUP(Ped_header.cdg_estado,"CC,ZZ") = 0
         THEN DO:
            FOR EACH Ped_detalle OF Ped_header EXCLUSIVE-LOCK:
       
                IF LOOKUP(Ped_detalle.cdg_estado,"CC,ZZ") = 0
                THEN DO:
                   FOR EACH Ped_detalle_entr OF Ped_detalle EXCLUSIVE-LOCK:
                       IF LOOKUP(Ped_detalle_entr.cdg_estado,"CC,ZZ") = 0
                          THEN Ped_detalle_entr.cdg_estado = "ZZ".
                   END. 
                   Ped_detalle.cdg_estado = "ZZ".
                END.
       
            END.
            Ped_header.cdg_estado = "ZZ".
            Ped_header.anulado = YES.

            puede_anular = 0.
    
            RUN despachar_mails.

         END.
    
     END.

END.

/*===========================================================================================*/
/*                                     PROCEDIMIENTOS                                        */
/*===========================================================================================*/

PROCEDURE despachar_mails:

    DEFINE VARIABLE retCode    AS INT NO-UNDO.

    FOR EACH Copias_pedido WHERE Copias_pedido.nro_pedido = Ped_header.nro_pedido, Area OF Copias_pedido:
        
        RUN mail(    Area.reporte,
                    "Anulaciòn de Pedido Nro." + Ped_header.tip_comprob + "-"+ 
                                            STRING(Ped_header.prf_comprob,"9999") + "-" + 
                                            STRING(Ped_header.nro_comprob,"99999999"),
                    "Por favor, tome nota de la anulacion del pedido " + Ped_header.tip_comprob + "-"+ 
                                            STRING(Ped_header.prf_comprob,"9999") + "-" + 
                                            STRING(Ped_header.nro_comprob,"99999999") + " de fecha " +
                                            STRING(Ped_header.fecha,"99/99/9999") + " correspondiente a " + 
                                            Cliente.nom_cliente,
                    "",  		    /* files to send 	           */           
                    0,						/* show dialog window */
                    OUTPUT retCode).

          IF retCode <> 0 THEN MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".
    END.

END PROCEDURE.

PROCEDURE mail EXTERNAL "xpMail.dll":
    DEFINE INPUT  PARAMETER mailto		    AS CHAR.
    DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
    DEFINE INPUT  PARAMETER mailText		AS CHAR.
    DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
    DEFINE INPUT  PARAMETER mailDialog		AS LONG.
    DEFINE OUTPUT PARAMETER retCode		    AS LONG.
END.
