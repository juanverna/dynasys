DEFINE FRAME F-Main
     Empleado-ddjj.ganancias COLON 20
     Empleado-ddjj.aportes COLON 50
     Empleado-ddjj.obrasoc COLON 50 
     Empleado-ddjj.ganancias_otras COLON 20 
     Empleado-ddjj.seguros COLON 50 
     Empleado-ddjj.total1 COLON 20 
     Empleado-ddjj.sepelios COLON 50 
     Empleado-ddjj.movilidad COLON 50 
     Empleado-ddjj.otras COLON 50 
     Empleado-ddjj.difer12 COLON 20 
     Empleado-ddjj.total2 COLON 50 
     Empleado-ddjj.difer34 COLON 20 
     Empleado-ddjj.donaciones COLON 50 
     Empleado-ddjj.especial COLON 50 
     Empleado-ddjj.no-imponible COLON 50 
     Empleado-ddjj.conyuge COLON 50 
     Empleado-ddjj.hijos COLON 50 
     Empleado-ddjj.otras-cargas COLON 50 
     Empleado-ddjj.ganancias_netas COLON 20 
     Empleado-ddjj.total6 COLON 50 
     Empleado-ddjj.total_impuesto COLON 20 
     Empleado-ddjj.total_retenido COLON 50 
     Empleado-ddjj.promocion COLON 50 
     Empleado-ddjj.a-favor-dgi COLON 20 
     Empleado-ddjj.a-favor-empi COLON 50 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE STREAM-IO 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

OUTPUT TO "A" PAGED.

FIND LAST Empleado-ddjj.
DISPLAY 
     Empleado-ddjj.ganancias
     Empleado-ddjj.aportes
     Empleado-ddjj.obrasoc
     Empleado-ddjj.ganancias_otras
     Empleado-ddjj.seguros
     Empleado-ddjj.total1
     Empleado-ddjj.sepelios
     Empleado-ddjj.movilidad
     Empleado-ddjj.otras
     Empleado-ddjj.difer12
     Empleado-ddjj.total2
     Empleado-ddjj.difer34
     Empleado-ddjj.donaciones
     Empleado-ddjj.especial
     Empleado-ddjj.no-imponible
     Empleado-ddjj.conyuge
     Empleado-ddjj.hijos
     Empleado-ddjj.otras-cargas
     Empleado-ddjj.ganancias_netas
     Empleado-ddjj.total6
     Empleado-ddjj.total_impuesto
     Empleado-ddjj.total_retenido
     Empleado-ddjj.promocion
     Empleado-ddjj.a-favor-dgi 
     Empleado-ddjj.a-favor-empi
     WITH FRAME F-Main.
