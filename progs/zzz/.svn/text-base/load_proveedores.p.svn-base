/*=====================================================================================*/
/*                     LECTURA Y CARGA DE INTERFACE DE AFILIADOS                       */
/*=====================================================================================*/

DEFINE VARIABLE linea1   AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE linea2   AS CHARACTER FORMAT "X(132)".

DEFINE VARIABLE V-CODIGO AS CHARACTER FORMAT "X(05)".
DEFINE VARIABLE V-NOMBRE AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE V-INGBRU AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE V-CUIT   AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE V-RGANAN AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-RIBRUT AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-CONDIV AS CHARACTER FORMAT "X(01)".
                                   
DEFINE VARIABLE V-DIRECC AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE V-LOCALI AS CHARACTER FORMAT "X(14)".
DEFINE VARIABLE V-TELEFO AS CHARACTER FORMAT "X(25)".

DEFINE VARIABLE V-CODPOS AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE numeros  AS CHARACTER INITIAL "0123456789".        

DEFINE VARIABLE c        AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE j        AS INTEGER FORMAT ">>>>>9".


DEFINE TEMP-TABLE T-Proveedor               LIKE Proveedor.
DEFINE TEMP-TABLE T-Domicilio_prv           LIKE Domicilio_prv.


/*=====================================================================================*/
/*                             BLOQUE PRINCIPAL                                        */
/*=====================================================================================*/

RUN borrar.
RUN lee_proveedores.
RUN bajar.


/*=====================================================================================*/
/*                               PROCEDIMIENTOS                                        */
/*=====================================================================================*/

/*
----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0----+----1----+----2----+----3
   P0304 PR       SOLUCIONES MAC S.A.       107904809       30 70795679 4             0,00 $    N N N S  001  I  PRP PRD
                  PARAGUAY 445 CAP.         T.4315.1919 FAX 4315.0952     ARREGLO MAC
*/

PROCEDURE lee_proveedores:

    ASSIGN c = 0.

    INPUT FROM "\\Servidor01\Dynasys\R3.5.1\Migracion\17411743".

    REPEAT:

        IMPORT UNFORMATTED linea1.

        IF INDEX(linea1,"L. BERKES") <> 0 
           OR INDEX(linea1,"L. BERKES") <> 0  
           OR INDEX(linea1,"CUENTAS CORRIENTES") <> 0  
           OR INDEX(linea1,"Codigo de Agrupacion:") <> 0  
           OR INDEX(linea1,"--------------------") <> 0  
           OR INDEX(linea1," CODIGO  COD.AGR. NOMBRE") <> 0  
        THEN DO:
           /* Nada, son titulos o la linea final*/
        END.
        ELSE DO:
            IMPORT UNFORMATTED linea2. /* No es un titulo, entonces es una linea UNO, importamos la otra */

            V-CODIGO = SUBSTRING(linea1,04,05).
            V-NOMBRE = SUBSTRING(linea1,19,25).
            V-INGBRU = SUBSTRING(linea1,45,14).
            V-CUIT   = SUBSTRING(linea1,61,15).
            V-RGANAN = SUBSTRING(linea1,97,01).
            V-RIBRUT = SUBSTRING(linea1,103,1).
            V-CONDIV = SUBSTRING(linea1,111,1).

            V-DIRECC = SUBSTRING(linea2,19,25).
            V-LOCALI = SUBSTRING(linea2,45,28).
            V-TELEFO = SUBSTRING(linea2,75,25).

            IF SUBSTRING(V-LOCALI,5,1) = "-"
                THEN ASSIGN V-CODPOS = SUBSTRING(V-LOCALI,1,4)
                            V-LOCALI = SUBSTRING(V-LOCALI,6).
                ELSE V-CODPOS = "".

            IF v-codigo BEGINS "P"
            THEN DO:

                c = c + 1.

                CREATE  T-Proveedor.
                ASSIGN  T-Proveedor.cdg_condiva            = IF V-CONDIV = "I" THEN 92 ELSE 98                       
                        T-Proveedor.cdg_famprove           = "001"                    
                        T-Proveedor.cdg_grupoemp           = "00"                     
                        T-Proveedor.cdg_pais               = 1                        
                        T-Proveedor.cdg_postal             = V-CODPOS                       
                        T-Proveedor.cdg_proveedor          = V-CODIGO                 
                        T-Proveedor.cdg_provincia          = "01"                     
                        T-Proveedor.cdg_tiporetibr         = "069"                    
                        T-Proveedor.cdg_tiporetiva         = "000"                    
                        T-Proveedor.cdg_tiporetsus         = "000"                    
                        T-Proveedor.cdg_tiprove            = ""                       
                        T-Proveedor.cdg_viapago            = ""                       
                        T-Proveedor.convenio_sino          = "N"                      
                        T-Proveedor.cuit                   = V-CUIT                   
                        T-Proveedor.cyorden_sino           = NO        
                        T-Proveedor.dfl_cndventa           = "00"      
                        T-Proveedor.dfl_lista              = 2         
                        T-Proveedor.direccion              = V-DIRECC  
                        T-Proveedor.entidades_validas      = "B"       
                        T-Proveedor.fecha_alta             = 01/01/2006               
                        T-Proveedor.fecha_baja             = ?       
                        T-Proveedor.lista_empresas         = "B"     
                        T-Proveedor.localidad              = V-LOCALI
                        T-Proveedor.nombre                 = V-NOMBRE
                        T-Proveedor.nom_fantasia           = V-NOMBRE                         
                        T-Proveedor.nro_comprador          = 1                         
                        T-Proveedor.nro_entidad            = 0
                        T-Proveedor.nro_proveedor          = c                         
                        T-Proveedor.numero_ibr             = V-INGBRU                 
                        T-Proveedor.orden_cheque           = V-NOMBRE
                        T-Proveedor.ret_ganancias          = YES
                        T-Proveedor.ret_ibrutos            = YES
                        T-Proveedor.ret_iva                = NO
                        T-Proveedor.ret_suss               = NO
                        T-Proveedor.telefonos              = V-TELEFO
                        T-Proveedor.ult_domicilio          = 1.

                CREATE  T-Domicilio_prv.
                BUFFER-COPY T-Proveedor TO T-Domicilio_prv
                    ASSIGN  T-Domicilio_prv.nro_domicilio  = 1
                            T-Domicilio_prv.telefono       = V-TELEFO.

            END.
        END.



    END.
    
END PROCEDURE.

PROCEDURE bajar:

    FOR EACH T-Proveedor:
        CREATE Proveedor.
        BUFFER-COPY T-Proveedor TO Proveedor.
    END.

    FOR EACH T-Domicilio_prv:
        CREATE Domicilio_prv.
        BUFFER-COPY T-Domicilio_prv TO Domicilio_prv.
    END.

    CURRENT-VALUE(proximo_proveedor) = c + 1.

END PROCEDURE.

PROCEDURE borrar:

    FOR EACH Proveedor:
        DELETE Proveedor.
    END.

    FOR EACH Domicilio_prv:
        DELETE Domicilio_prv.
    END.


END PROCEDURE.


PROCEDURE mostrar:

    DISPLAY V-CODIGO    COLON 15
            V-NOMBRE    COLON 15
            V-INGBRU    COLON 15
            V-CUIT      COLON 15
            V-RGANAN    COLON 15
            V-RIBRUT    COLON 15
            V-CONDIV    COLON 15
                    
            V-DIRECC    COLON 15
            V-LOCALI    COLON 15
            V-TELEFO    COLON 15

            WITH FRAME ff THREE-D SIDE-LABELS.


END PROCEDURE.

