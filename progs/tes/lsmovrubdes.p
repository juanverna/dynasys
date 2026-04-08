/*=================================================================================*/
/*                      MOVIMIENTOS POR RUBRO DE CAJA ENTRE FECHAS                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja             LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha            LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha            LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER des_rubro            LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER has_rubro            LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER xfile                AS CHAR.

/*=================================================================================*/
/*                       VARIABLES, BUFFERS Y TABLAS TEMPORARIAS                   */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}
{wglistar.i}

DEFINE VARIABLE nom_rubro           LIKE Rubro.nombre.
DEFINE VARIABLE nom_caja            LIKE Caja.nombre.
DEFINE VARIABLE pri_movi            AS LOGICAL.
DEFINE VARIABLE pri_fech            AS LOGICAL.

DEFINE BUFFER B-Rubro FOR Rubro.
{tt2xls.i}
/*{dirtempfile.i} */
/*=================================================================================*/
/*                                TEMP                                           */
/*=================================================================================*/

DEFINE TEMP-TABLE lis
    FIELD cdg_caja LIKE  Caja.cdg_caja
    FIELD cdg_rubro LIKE  Rubro.cdg_rubro 
    FIELD abrevia LIKE Rubro.abrevia
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD hat LIKE cliente.hat
    FIELD nom_cliente LIKE Cliente.nom_cliente
    FIELD importe AS DECIMAL
    INDEX lis cdg_caja cdg_rubro cdg_cliente.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
    
   FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
 
   FOR EACH Rubro WHERE Rubro.cdg_rubro <= has_rubro
                     AND Rubro.cdg_rubro >= des_rubro
                     BREAK BY Rubro.cdg_rubro:
       FOR EACH  Caj_detalle OF Rubro, FIRST Caj_header OF Caj_detalle
          WHERE  Caj_header.cdg_empresa = Empresa.cdg_empresa 
            AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
            AND   Caj_header.cdg_caja = Caja.cdg_caja 
            AND   Caj_header.fecha >= des_fecha 
            AND   Caj_header.fecha <= has_fecha
            AND   caj_header.estado <> "A"
            BY Caj_header.nro_cliente
                  BY caj_detalle.cdg_rubro :
           find cliente OF caj_header NO-LOCK.
           FIND lis WHERE lis.cdg_cliente = cliente.cdg_cliente AND
                          lis.cdg_rubro = caj_detalle.cdg_rubro AND
                          lis.cdg_caja = caj_header.cdg_caja NO-ERROR.
           IF NOT AVAILABLE lis THEN DO:
               CREATE lis.
               ASSIGN lis.cdg_cliente = cliente.cdg_cliente
                      lis.nom_cliente = cliente.nom_cliente
                      lis.hat = cliente.hat
                      lis.abrevia = Rubro.abrevia
                      lis.cdg_rubro = caj_detalle.cdg_rubro
                      lis.cdg_caja = caj_header.cdg_caja.
           END.
           IF Caj_header.tipo_mov = "I" 
              THEN DO:
                  lis.importe = lis.importe + Caj_detalle.importe.
              END.
              ELSE DO:
                  lis.importe = lis.importe - Caj_detalle.importe.
              END.
       END.
   END.
   RUN pTT2XLS                                                               
          ( INPUT TEMP-TABLE lis:DEFAULT-BUFFER-HANDLE,                        
            INPUT xfile,                                                
            INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ).  
  
