/*=====================================================================================*/
/*                     LECTURA Y CARGA DE INTERFACE DE AFILIADOS                       */
/*=====================================================================================*/

DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(132)".
DEFINE VARIABLE V-ESTADO                  AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE V-CODIGO                  AS CHARACTER FORMAT "X(6)".
DEFINE VARIABLE V-NOMBRE                  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE V-TIPOART                 AS CHARACTER FORMAT "X(13)".

DEFINE VARIABLE numeros                   AS CHARACTER INITIAL "0123456789".        

DEFINE VARIABLE c                         AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE j                         AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE c-tipoart                 AS INTEGER.

DEFINE TEMP-TABLE T-Articulo               LIKE Articulo.
DEFINE TEMP-TABLE T-Tipo_articulo               LIKE Tipo_Articulo.
DEFINE TEMP-TABLE T-Partida             LIKE Partida.

/*=====================================================================================*/
/*                             BLOQUE PRINCIPAL                                        */
/*=====================================================================================*/

RUN borrar.
RUN lee_articulos.
RUN bajar.

/*=====================================================================================*/
/*                               PROCEDIMIENTOS                                        */
/*=====================================================================================*/

PROCEDURE lee_articulos:

    ASSIGN c = 0
           c-tipoart = 0.

    INPUT FROM "\\Servidor01\Dynasys\R3.5.1\Migracion\17061768-2.csv".

    IMPORT UNFORMATTED linea. /* Salteo los titulos */

    REPEAT:

        ASSIGN V-CODIGO     = ""
               V-NOMBRE     = ""
               V-TIPOART    = "".
    
        IMPORT UNFORMATTED linea.

        j = 1.

      /*IF j <= NUM-ENTRIES(linea,";") THEN V-ESTADO     = ENTRY(j,linea,";"). j = j + 1. */
        IF j <= NUM-ENTRIES(linea,";") THEN V-CODIGO     = ENTRY(j,linea,";"). j = j + 1. 
        IF j <= NUM-ENTRIES(linea,";") THEN V-NOMBRE     = ENTRY(j,linea,";"). j = j + 1. 
        IF j <= NUM-ENTRIES(linea,";") THEN V-TIPOART    = ENTRY(j,linea,";"). j = j + 1. 

        FIND T-Tipo_articulo WHERE T-Tipo_articulo.cdg_tipoart = V-TIPOART NO-ERROR.
        IF NOT AVAILABLE T-Tipo_articulo
        THEN DO:
            
            CREATE T-Tipo_articulo.
            ASSIGN c-tipoart = c-tipoart + 1
                   T-Tipo_articulo.cdg_tipoart = V-TIPOART
                   T-Tipo_articulo.dsc_tipoart = V-TIPOART.
        END.

      /*RUN mostrar. */

        c = c + 1.

        CREATE  T-Articulo.
        ASSIGN  T-Articulo.a_granel         = NO                     
                T-Articulo.cdg_articulo     = V-CODIGO               
                T-Articulo.cdg_envases      = "000"                  
                T-Articulo.cdg_estado       = ""                     
                T-Articulo.cdg_grupoabasto  = ""                     
                T-Articulo.cdg_linea        = 0                      
                T-Articulo.cdg_marcacom     = "NA"                     
                T-Articulo.cdg_subclase     = ""                     
                T-Articulo.cdg_tipoart      = T-Tipo_articulo.cdg_tipoart                  
                T-Articulo.cdg_ucompra      = "Kg"                   
                T-Articulo.cdg_ugranel      = "Kg"                   
                T-Articulo.cdg_umed         = "Kg"                   
                T-Articulo.compras_sino     = NO                     
                T-Articulo.cyorden_sino     = NO                     
                T-Articulo.descripcion      = V-NOMBRE               
                T-Articulo.es_kit           = NO                     
                T-Articulo.es_registrable   = NO                     
                T-Articulo.extendida        = YES                    
                T-Articulo.fecha_alta       = TODAY                  
                T-Articulo.fecha_grab       = TODAY                  
                T-Articulo.hay_marca        = NO                     
                T-Articulo.hay_partida      = NO                     
                T-Articulo.hora_grab        = TIME                   
                T-Articulo.importado        = NO                     
                T-Articulo.inventario_sino  = YES                    
                T-Articulo.lista_empresas   = "B"                    
                T-Articulo.lista_sectores   = "B"                    
                T-Articulo.metodo_costeo    = "P"                    
                T-Articulo.nro_articulo     = c                      
                T-Articulo.nro_familia      = 1
                T-Articulo.nro_familimpos   = 1                      
                T-Articulo.nro_suprarticulo = 0                      
                T-Articulo.produccion_sino  = YES                    
                T-Articulo.stock_sino       = YES                    
                T-Articulo.sumaneto         = 1                      
                T-Articulo.ult_partida      = 1                      
                T-Articulo.unidades_sino    = YES                    
                T-Articulo.ventas_sino      = YES.                   
                                                                    
        CREATE T-Partida.
        ASSIGN T-Partida.nro_articulo       = T-Articulo.nro_Articulo
               T-Partida.nro_partida        = 1
               T-Partida.cdg_partida        = ""
               T-Partida.cdg_empresa        = "B".

    END.
    
END PROCEDURE.

PROCEDURE bajar:

    FOR EACH T-Articulo:
        CREATE Articulo.
        BUFFER-COPY T-Articulo TO Articulo.
    END.

    FOR EACH T-Partida:
        CREATE Partida.
        BUFFER-COPY T-Partida TO Partida.
    END.

    FOR EACH T-Tipo_articulo:
        CREATE Tipo_articulo.
        BUFFER-COPY T-Tipo_articulo TO Tipo_articulo.
    END.

    CURRENT-VALUE(proximo_articulo) = c + 1.
    CURRENT-VALUE(proxima_familia) = 1.

END PROCEDURE.

PROCEDURE borrar:

    FOR EACH Articulo:
        DELETE Articulo.
    END.

    FOR EACH Partida:
        DELETE Partida.
    END.

    FOR EACH Tipo_articulo:
        DELETE Tipo_articulo.
    END.

    FOR EACH Articulo-deposito:
        DELETE Articulo-deposito.
    END.

END PROCEDURE.


PROCEDURE mostrar:

    DISPLAY V-CODIGO                  COLON 15
            V-NOMBRE                  COLON 15
            V-TIPOART                 COLON 15
            WITH FRAME ff THREE-D SIDE-LABELS.

END PROCEDURE.

