/*impresion de recibos*/
DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE INPUT PARAMETER p-des_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-has_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-cdg_empresa LIKE empresa.cdg_empresa no-undo.
DEFINE INPUT PARAMETER treqot AS LOGICAL no-undo.
DEFINE OUTPUT PARAMETER xfile AS CHAR NO-UNDO.

DEF VAR i AS INT NO-UNDO.
DEF VAR j AS INT NO-UNDO.
j = 0.
/*se resuelven aqui las relaciones solo se pasaran a CR los datos que se necesitan*/
DEFINE TEMP-TABLE ttcupon NO-UNDO LIKE Fac_header
        FIELD    cdg_cliente LIKE Fac_header.codigo_cliente
        FIELD    ListaArticulos            AS CHAR FORMAT "X(20)".
DEFINE DATASET dset FOR ttcupon.


/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/

FOR EACH Fac_header 
    WHERE Fac_header.cdg_empresa  = p-cdg_empresa
      AND Fac_header.tip_comprob  = p-tip_comprob
      AND Fac_header.prf_comprob  = p-prf_comprob
      AND NOT anulado
      AND Fac_header.nro_comprob  <= p-has_nrocomp
      AND Fac_header.nro_comprob  >= p-des_nrocomp:
      
      IF ( fac_header.estado_2_impresion = "OT" AND treqot ) or
          ( p-has_nrocomp = p-des_nrocomp ) OR 
          ( fac_header.estado_2_impresion = "" AND NOT treqot ) OR ( p-has_nrocomp = p-des_nrocomp ) THEN DO:
          CREATE ttcupon.
          BUFFER-COPY Fac_header TO ttcupon.
          ASSIGN 
            ttcupon.cdg_administrador         =  Fac_header.cdg_administrador        
            ttcupon.cdg_cliente               =  Fac_header.codigo_cliente              
            ttcupon.cdg_postal                =  Fac_header.cdg_postal               
            ttcupon.direccion                 =  Fac_header.direccion                
            ttcupon.direccion_administrador   =  Fac_header.direccion_administrador  
            ttcupon.cuit                      =  Fac_header.cuit                     
            ttcupon.fecha                     =  Fac_header.fecha                    
            ttcupon.nombre                    =  Fac_header.nombre                   
            ttcupon.monto_letras              =  Fac_header.monto_letras             
            ttcupon.nom_Administrador         =  Fac_header.nom_Administrador.        
          FOR EACH fac_detalle OF fac_header, articulo OF fac_detalle:
              ASSIGN ttcupon.ListaArticulos = ttcupon.ListaArticulos + " " +  Articulo.cdg_tipoart.
          END.
      END.
END.
FOR EACH ttcupon BY ttcupon.direccion BY ttcupon.nro_comprob:
    FIND Fac_header WHERE 
          ttCupon.cdg_empresa   =           Fac_header.cdg_empresa  AND
          ttCupon.nro_comprob   =           Fac_header.nro_comprob  AND
          ttCupon.prf_comprob   =           Fac_header.prf_comprob  AND
          ttCupon.tip_comprob   =           Fac_header.tip_comprob EXCLUSIVE-LOCK.
    ASSIGN Fac_header.estado_2_impresion = "I".
    RELEASE Fac_header.
END.

xfile = SUBSTITUTE( '&1/cr-' + USERID("sic") + ".xml" , SESSION:TEMP-DIRECTORY ).
xfile = REPLACE(xfile,"/","\").

DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).
                                   


