/*==================================================================================*/
/*          REVISA EL SUBDIARIO DE VENTAS Y CREA LAS RELACIONES QUE FALTAN          */
/*          ENTRE LAS CUENTAS Y LAS COLUMNAS                                        */
/*==================================================================================*/

DEFINE VARIABLE v-cdg_empresa AS CHARACTER INITIAL "P".

UPDATE v-cdg_empresa.

FOR EACH Sub_detalle_vta WHERE Sub_detalle_vta.cdg_empresa = v-cdg_empresa:

    FIND Columna_cuenta WHERE Columna_cuenta.nro_cuenta = Sub_detalle_vta.nro_cuenta
                          AND Columna_cuenta.cdg_reporte = "IVA" 
                          AND Columna_cuenta.cdg_empresa = v-cdg_empresa
                          NO-ERROR.
                          
    IF NOT AVAILABLE Columna_cuenta 
    THEN DO:
      FIND Cuenta OF Sub_detalle_vta.
      DISPLAY Cuenta.cdg_cuenta Cuenta.nombre_cta.
      CREATE Columna_cuenta.
      ASSIGN Columna_cuenta.cdg_reporte = "IVA"
             Columna_cuenta.nro_columna = 1
             Columna_cuenta.nro_cuenta = Cuenta.nro_cuenta
             Columna_cuenta.cdg_empresa = v-cdg_empresa.
    END.
    
END.  
