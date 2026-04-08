/*=================================================================================*/
/*           RECORRE LA CLASIFICACION DE CUENTAS Y ARMA EL BALANCE                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_clase                 AS ROWID.
DEFINE INPUT PARAMETER nivel                     AS INTEGER.
DEFINE INPUT PARAMETER p-cdg_empresa             AS CHARACTER.
DEFINE INPUT PARAMETER p-cdg_nombalance          AS CHARACTER.

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE SHARED VARIABLE c-linea     AS INTEGER.
DEFINE VARIABLE linea_total        AS INTEGER.

{VRSHARED.I}
{VPERSINM.I}

/*{SHTSUMYS.I}*/

DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
DEFINE BUFFER Subclase FOR Clase_de_cuenta.

DEFINE QUERY qry_clasificacion  FOR Subclase.
DEFINE QUERY qry_cuentas        FOR Libro-cuenta,Cuenta.

{SHVSUMYS.I}

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
      CREATE Lst_sumysal.
      ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
             Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
             Lst_sumysal.que_codigo        = v-esp + que_subclase
             Lst_sumysal.que_nombre        = v-esp + Clase.nombre_subclase
             Lst_sumysal.linea             = c-linea.

   END.
   nivel = nivel + 1.
END.   

RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */

IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                             AND Subclase.cdg_clase = Clase.cdg_subclase)
THEN DO: /* No es el último nivel. Seguimos profundizando */

   RUN ABRE_QUERY.
   GET FIRST qry_clasificacion.
   DO WHILE AVAILABLE Subclase:              

      linea_total = c-linea.

      RUN recorrer_estructura.p ( INPUT ROWID(Subclase) , 
                                  INPUT nivel,
                                  INPUT p-cdg_empresa,
                                  INPUT p-cdg_nombalance).

      /*             
      RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
      */
      
      GET NEXT qry_clasificacion.
   END.

END.
/*ELSE DO:*/

/*
RUN IDENTAR ( INPUT 1 + ( nivel + 1 ) * 3).  /* Las cuentas se listan identadas
                                        respecto del nivel de clasifcacion */
*/
RUN ABRE_QUERY_CUENTAS.
GET FIRST qry_cuentas.
DO WHILE AVAILABLE Cuenta:
        
    DO TRANSACTION:
       c-linea = c-linea + 1.
       CREATE Lst_sumysal.
       ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
              Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
              Lst_sumysal.que_codigo        = v-esp + Cuenta.cdg_cuenta
              Lst_sumysal.que_nombre        = v-esp + Cuenta.nombre_cta
              Lst_sumysal.linea             = c-linea
              Cuenta.esta_restringida       = NO.

    
    END.
    
    GET NEXT qry_cuentas.
END.

/*END.*/

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                 AND Subclase.cdg_clase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE ABRE_QUERY_CUENTAS:

        OPEN QUERY qry_cuentas 
             FOR EACH Libro-cuenta 
                     WHERE Libro-cuenta.cdg_librocontable = Clase.cdg_librocontable
                       AND Libro-cuenta.cdg_subclase = Clase.cdg_subclase
                       AND Libro-cuenta.cdg_empresa  = p-cdg_empresa,
                           FIRST Cuenta OF Libro-cuenta BY Cuenta.cdg_cuenta. 
                              
END PROCEDURE.

PROCEDURE IDENTAR:

    DEFINE INPUT PARAMETER i-columna AS INTEGER.
  
    v-esp = FILL(" ",i-columna).

END PROCEDURE.


