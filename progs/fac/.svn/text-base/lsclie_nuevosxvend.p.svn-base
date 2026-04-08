/*=================================================================================*/
/*                    VENTAS POR VENDEDOR/ZONA                                     */
/*=================================================================================*/

/*  RUN lsclie_nuevosxvend.p ( INPUT v-lista_empresas, */
/*                              INPUT des_vendedor,    */
/*                              INPUT has_vendedor,    */
/*                              INPUT des_fecha,       */
/*                              INPUT has_fecha,       */
/*                              INPUT YES              */


  
/*                 + " " + des_codigo + " <-> " + has_codigo. */




DEFINE INPUT PARAMETER v-lista_empresas    AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo          LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha           AS DATE.
DEFINE INPUT PARAMETER has_fecha           AS DATE.
DEFINE INPUT PARAMETER ver_detalle         AS  LOGICAL.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

DEFINE VARIABLE ant_zonag                  LIKE Zona_geografica.cdg_zonag.


/* DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.  */
/* DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.  */

DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
 que_sector = Area.cdg_area.

{WGLISTAR.I}
{VPERSINM.I}
{VRSHARED.I}
{DFVARIMP.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Nuevos Clientes por Vendedor/Zona" AT 55
  "Página:" AT 141 PAGE-NUMBER FORMAT ">>9" AT 149
  SKIP  
  fecha_lis
  "del" AT 55
  des_fecha
  "al"
  has_fecha
  hora_lis AT 141
  SKIP (1) 
  "Vendedor => "  
  tit_vendedor AT 13
  SKIP(1)
 "--------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
 "Código   Razón                          Fecha    Número          Cn  Nro      Dirección                 Localidad            Número de                  " SKIP
 "Cliente  Social                         Alta     C.U.I.T.        IVA Cob      de cobranza               de cobranza          Teléfono                   " SKIP
 "--------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado-cli
    Cliente.cdg_cliente                         COLUMN-LABEL "Código"     
    Cliente.nom_cliente         FORMAT "X(30)"  COLUMN-LABEL "Razón!Social"
    Cliente.fecha_alta
    Cliente.cuit                                COLUMN-LABEL "Cuit"
    Cliente.cdg_condiva                         COLUMN-LABEL "Cond!IVA"
    Domicilio.nro_domicilio                     COLUMN-LABEL "Nro!Domicilio"
    Domicilio.direccion         FORMAT "X(30)"  COLUMN-LABEL "Dirección"
    Domicilio.localidad         FORMAT "X(20)"  COLUMN-LABEL "Localidad"
    Domicilio.telefono          FORMAT "X(25)"
/*     Municipio.dsc_municipio     FORMAT "X(20)"  COLUMN-LABEL "Municipio" */
/*     Provincia.nombre            FORMAT "X(20)"  COLUMN-LABEL "Provincia" */
  WITH WIDTH 200 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  que_empresa = "Empresas:" + v-lista_empresas.

  {dirprinfile.i}
 
  OPEN QUERY qry_vendedor
    FOR EACH Vendedor NO-LOCK 
       WHERE Vendedor.cdg_vendedor >= des_codigo
         AND Vendedor.cdg_vendedor <= has_codigo
          BY Vendedor.cdg_vendedor.
  
  GET FIRST qry_vendedor.
  DO WHILE AVAILABLE Vendedor:
     RUN LISTAR.
     GET NEXT qry_vendedor.
  END.   
    
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).
END PROCEDURE.  


PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre. 
  ant_zonag = "".
  
  OPEN QUERY q_clientes 
       FOR EACH Cliente OF Vendedor NO-LOCK
            WHERE Cliente.fecha_alta >= des_fecha
              AND Cliente.fecha_alta <= has_fecha
              AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0,
                 FIRST Domicilio OF Cliente NO-LOCK
                 WHERE Domicilio.cdg_subclasezng >= des_codigo
                   AND Domicilio.cdg_subclasezng <= has_codigo
                       BY Domicilio.cdg_subclasezng 
                       BY Cliente.nom_cliente.

  GET FIRST q_clientes.       
  DO WHILE AVAILABLE Cliente:

         VIEW FRAME frm-titulo. 

            FIND Zona_geografica OF Domicilio NO-LOCK NO-ERROR.

            DISPLAY
                Cliente.cdg_cliente    
                Cliente.nom_cliente
                Cliente.fecha_alta
                Cliente.cuit           
                Cliente.cdg_condiva    
                Domicilio.nro_domicilio
                Domicilio.direccion    
                Domicilio.localidad
                Domicilio.telefono      

            WITH FRAME frm-listado-cli.
            DOWN WITH FRAME frm-listado-cli.

            ant_zonag = Domicilio.cdg_subclasezng.

        GET NEXT q_clientes.

  END.

   DOWN 1 WITH FRAME frm-listado-cli.  

   PAGE. 

END PROCEDURE.

 
