/*=================================================================================*/
/*           RECORRE LA CLASIFICACION DE depositoS Y ARMA EL BALANCE                 */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Listado NO-UNDO 
    FIELD que_codigo        AS CHARACTER FORMAT "X(30)" 
    FIELD que_nombre        AS CHARACTER FORMAT "X(50)" 
    FIELD linea             AS INTEGER 
    INDEX por_linea IS UNIQUE PRIMARY linea.

DEFINE INPUT PARAMETER que_clase                 AS ROWID.
DEFINE INPUT PARAMETER nivel                     AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER c-linea            AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Listado.

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE VARIABLE linea_total        AS INTEGER.

DEFINE BUFFER   Clase  FOR Clase_de_deposito.
DEFINE BUFFER Subclase FOR Clase_de_deposito.

DEFINE QUERY qry_clasificacion  FOR Subclase.
DEFINE QUERY qry_depositos      FOR deposito.

DEFINE VARIABLE que_subclase AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.

IF Clase.cdg_clase <> ?
THEN DO:
   que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
   RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
   DO TRANSACTION:
      c-linea = c-linea + 1.
      CREATE T-Listado.
      ASSIGN T-Listado.que_codigo        = v-esp + que_subclase
             T-Listado.que_nombre        = v-esp + Clase.nombre_subclase
             T-Listado.linea             = c-linea.

   END.
   nivel = nivel + 1.
END.   

RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */

IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase)
THEN DO: /* No es el último nivel. Seguimos profundizando */

   RUN ABRE_QUERY.
   GET FIRST qry_clasificacion.
   DO WHILE AVAILABLE Subclase:              

      linea_total = c-linea.

      RUN recorrer_clasificacion_depositos.p ( INPUT ROWID(Subclase) , 
                                               INPUT nivel,
                                               INPUT-OUTPUT c-linea,
                                               INPUT-OUTPUT TABLE T-Listado).

      /*             
      RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
      */
      
      GET NEXT qry_clasificacion.
   END.

END.
/*ELSE DO:*/

/*
RUN IDENTAR ( INPUT 1 + ( nivel + 1 ) * 3).  /* Las depositos se listan identadas
                                        respecto del nivel de clasifcacion */
*/
RUN abre_query_depositos.
GET FIRST qry_depositos.
DO WHILE AVAILABLE deposito:
        
    DO TRANSACTION:
       c-linea = c-linea + 1.
       CREATE T-Listado.
       ASSIGN T-Listado.que_codigo = v-esp + Deposito.cdg_deposito
              T-Listado.que_nombre = v-esp + Deposito.nombre
              T-Listado.linea      = c-linea.
    
    END.
    
    GET NEXT qry_depositos.
END.

/*END.*/

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE abre_query_depositos:

        OPEN QUERY qry_depositos 
             FOR EACH deposito 
                     WHERE deposito.cdg_subclase = Clase.cdg_subclase
                           BY deposito.cdg_deposito. 
                              
END PROCEDURE.

PROCEDURE IDENTAR:

    DEFINE INPUT PARAMETER i-columna AS INTEGER.
  
    v-esp = FILL(" ",i-columna).

END PROCEDURE.


