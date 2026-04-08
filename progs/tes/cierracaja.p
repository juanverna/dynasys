/*=================================================================================*/
/*                      Cierre de caja                              */
/*=================================================================================*/
/*crea un milestone en la caja para efectuar el cierre en el dia de la fecha NOW*/
{calculareicaja.i}
    {findempresa.i}
DEFINE INPUT PARAMETER pcaja LIKE acumulado_caja.cdg_caja.

DEFINE VAR te AS DECIMAL FORMAT ">>>>>>>>>>>>.99" NO-UNDO.
DEFINE VAR ti AS DECIMAL  FORMAT ">>>>>>>>>>>>.99" NO-UNDO.
DEFINE VAR hora AS INT NO-UNDO.
DEFINE VAR dia AS DATE NO-UNDO.

DEFINE BUFFER bacumulado_caja FOR acumulado_caja.
dia = TODAY.
hora = INT( replace( string( time,"HH:MM" ),":","" )) .

RUN calcular_EI( pcaja, dia,hora,
    FALSE,empresa.cdg_empresa,OUTPUT te, OUTPUT ti ).
   CREATE acumulado_caja.
   ASSIGN 
       acumulado_caja.ano = YEAR(NOW)
       acumulado_caja.cdg_caja = pcaja 
       acumulado_caja.cdg_empresa = empresa.cdg_empresa
       acumulado_caja.cdg_rubro = 0
       acumulado_caja.Cerrado = TRUE
       acumulado_caja.FechaA = NOW
       acumulado_caja.mes = MONTH(NOW)
       acumulado_caja.tot_egresos = te
       acumulado_caja.tot_ingresos = ti.
RUN calcular_EIRUBRO( pcaja, 1, dia,hora,
    FALSE,empresa.cdg_empresa,OUTPUT te, OUTPUT ti ).
   CREATE acumulado_caja.
   ASSIGN 
       acumulado_caja.ano = YEAR(NOW)
       acumulado_caja.cdg_caja = pcaja 
       acumulado_caja.cdg_empresa = empresa.cdg_empresa
       acumulado_caja.cdg_rubro = 1
       acumulado_caja.Cerrado = TRUE
       acumulado_caja.FechaA = NOW
       acumulado_caja.mes = MONTH(NOW)
       acumulado_caja.tot_egresos = te
       acumulado_caja.tot_ingresos = ti.
    
    
