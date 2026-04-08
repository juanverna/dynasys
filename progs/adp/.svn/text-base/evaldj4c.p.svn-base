/*=================================================================================*/
/*                                                                                 */
/*        EVALUA UNA DECLARACION DE GANANCIAS Y CALCULA EL TOTAL A RETENER         */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_ddjj AS ROWID.

FIND Empleado-ddjj WHERE ROWID(Empleado-ddjj) = rid_ddjj EXCLUSIVE-LOCK.

Empleado-ddjj.total1 = Empleado-ddjj.ganancias +
                       Empleado-ddjj.ganancias_otras. 

Empleado-ddjj.total2 = Empleado-ddjj.aportes   +
                       Empleado-ddjj.obrasoc   +
                       Empleado-ddjj.seguros   +
                       Empleado-ddjj.sepelios  +
                       Empleado-ddjj.movilidad +
                       Empleado-ddjj.otras.

Empleado-ddjj.difer12 = Empleado-ddjj.total1 - Empleado-ddjj.total2.
Empleado-ddjj.difer34 = Empleado-ddjj.difer12 - Empleado-ddjj.donaciones. 
Empleado-ddjj.total6  = Empleado-ddjj.especial     +
                        Empleado-ddjj.no-imponible +
                        Empleado-ddjj.conyuge      +
                        Empleado-ddjj.hijos        +
                        Empleado-ddjj.otras-cargas.

Empleado-ddjj.difer56 = Empleado-ddjj.difer34 - Empleado-ddjj.total6.
Empleado-ddjj.ganancias_netas = Empleado-ddjj.difer56.

RUN VALUA4CT.P ( INPUT Empleado-ddjj.ganancias_netas , 
                 INPUT MONTH(Empleado-ddjj.fch_hasta),
                 OUTPUT Empleado-ddjj.total_impuesto ). /* Halla el impuesto en base a la ganancia imponible */

Empleado-ddjj.total9 = Empleado-ddjj.total_retenido + Empleado-ddjj.promocion.

IF Empleado-ddjj.total_impuesto > Empleado-ddjj.total9
   THEN ASSIGN Empleado-ddjj.a-favor-dgi  = Empleado-ddjj.total_impuesto - Empleado-ddjj.total9
               Empleado-ddjj.a-favor-empi = 0.
   ELSE ASSIGN Empleado-ddjj.a-favor-dgi  = 0
               Empleado-ddjj.a-favor-empi = Empleado-ddjj.total9 - Empleado-ddjj.total_impuesto.
