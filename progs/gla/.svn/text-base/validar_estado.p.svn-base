
DEFINE INPUT PARAMETER p-solicitud   LIKE sre_header.nro_solicitud.
DEFINE INPUT PARAMETER p-sector      LIKE Area.cdg_area.
DEFINE INPUT PARAMETER p-usuario     LIKE Usuario.nro_area.
DEFINE INPUT PARAMETER p-userid      LIKE Usuario.nro_usuario.


DEFINE VARIABLE hay_error     AS LOGICAL.
DEFINE VARIABLE v-reg         AS INTEGER.
DEFINE VARIABLE v-reg2        AS INTEGER.
DEFINE VARIABLE v-sector      AS INTEGER.
DEFINE VARIABLE v-usuario     AS INTEGER.

hay_error = NO.

FIND Sre_header WHERE Sre_header.nro_solicitud = p-solicitud.

v-reg = 0.

FOR EACH Sre_detalle OF Sre_header, Articulo OF Sre_detalle WHILE NOT hay_error:

    v-reg2 = v-reg2 + 1.  
                
    IF Articulo.es_registrable THEN DO:

            v-reg = 0.

            FOR EACH Registrable-solicitud OF Sre_detalle, Registrable OF Registrable-solicitud WHILE NOT hay_error:

                v-reg = v-reg + 1.

                IF Registrable.fch_baja < TODAY THEN DO:
                    hay_error = YES.
                    RUN PONMENSJ.P ( "SRET021" ).
                END.

                IF NOT Registrable.disponible THEN DO:
                    hay_error = YES.
                    RUN PONMENSJ.P ( "SRET026" ).
                END.
            END.

            IF v-reg <> Sre_detalle.cantidad THEN DO:
                hay_error = YES.
                RUN PONMENSJ.P ( "SRET022" ).   
            END.
    END.
END.

IF v-reg2 = 0 THEN DO:
    hay_error = YES.
    RUN PONMENSJ.P ( "SRET023" ).
END.


IF hay_error = NO THEN DO:

Sre_header.estado = "E".

        FIND Area WHERE cdg_area = p-sector.
        
        ASSIGN v-sector = Area.nro_area.    

/*         IF  v-sector = p-usuario THEN DO:       */
/*                                                 */
           Sre_header.cdg_estado = "IN".
           FOR EACH Sre_detalle OF Sre_header:
                 Sre_detalle.cdg_estado = "IN".
           END.
           RUN PONMENSJ.P ( "SRET024" ).
/*         END.                                   */
/*         ELSE DO :                              */
/*                                                */
/*            Sre_header.cdg_estado = "AA".       */
/*            FOR EACH Sre_detalle OF Sre_header: */
/*                 Sre_detalle.cdg_estado = "AA". */
/*            END.                                */
/*            RUN PONMENSJ.P ( "SRET025" ).       */
/*         END.                                   */

        FOR EACH Sre_detalle OF Sre_header, Articulo OF Sre_detalle:
        
            IF Articulo.es_registrable THEN DO:

                FOR EACH Registrable-solicitud OF Sre_detalle, Registrable OF Registrable-solicitud:
                      Registrable.disponible = NO.
                      CREATE Hst_estadoregis.
                      ASSIGN 
                          Hst_estadoregis.cdg_estadoregis = "00002"
                          Hst_estadoregis.fch_cambio      = TODAY
                          Hst_estadoregis.hms_cambio      = STRING(TIME,"HH:MM:SS")
                          Hst_estadoregis.hor_cambio      = TIME
                          Hst_estadoregis.nro_registrable = Registrable.nro_registrable
                          Hst_estadoregis.nro_usuario     = p-userid.
                END.
            END.
        END.

END.

