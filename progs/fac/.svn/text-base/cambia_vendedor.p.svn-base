/*=========================================================================================*/
/*          REALIZA LA EMISION DEL LISTADO DE COMISIONES RESUMIDAS POR vendedor            */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-des_zona         LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER p-has_zona         LIKE Zona_geografica.cdg_zonag.

DEFINE VARIABLE j                         AS INTEGER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE n-has_vendedor            LIKE Vendedor.nro_vendedor.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Transferencia de vendedor y Zona" AT 77
       "Página:" AT 170 PAGE-NUMBER FORMAT ">>9" AT 178
       SKIP  
       fecha_lis       
       titulo_det AT 77
       hora_lis AT 170
       SKIP(1)
       WITH WIDTH 190 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Cliente.cdg_cliente COLUMN-LABEL "Código!Grupo"
       Cliente.nom_cliente COLUMN-LABEL "Nombre!Grupo"
       WITH WIDTH 256 DOWN FRAME frm-listado STREAM-IO.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

titulo_det  = "VENDEDORES:" + p-des_vendedor + "-" + p-has_vendedor + 
              "  ZONAS:" + p-des_zona + "-" + p-has_zona.

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("c:\sic-temp\cambiavendedor.txt") PAGE-SIZE 60.

FIND Vendedor 
     WHERE Vendedor.cdg_vendedor = p-has_vendedor NO-LOCK.
n-has_vendedor = Vendedor.nro_vendedor.

FIND Vendedor 
     WHERE Vendedor.cdg_vendedor = p-des_vendedor NO-LOCK.
     
FOR EACH Cliente OF Vendedor:

    IF CAN-FIND(FIRST Domicilio OF Cliente
                      WHERE Domicilio.cdg_zona <= p-has_zona
                        AND Domicilio.cdg_zona >= p-des_zona)
    THEN DO:
        VIEW FRAME frm-titulo.
    
        Cliente.nro_vendedor = n-has_vendedor.
        
        DISPLAY Cliente.cdg_cliente
                Cliente.nom_cliente
                WITH FRAME frm-listado.
                
        DOWN WITH FRAME frm-listado.
    END.

END.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cambiavendedor.txt",
                 INPUT 2 ).



