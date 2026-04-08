output to printer.
FOR EACH Vendedor:
  display cdg_vendedor nombre
     CAN-FIND(FIRST Acum_ventas WHERE Acum_ventas.nro_vendedor = Vendedor.nro_vendedor) COLUMN-LABEL "Acum!Vtas"
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_vendedor = Vendedor.nro_vendedor)         COLUMN-LABEL "Cta!Cte"
     CAN-FIND(FIRST Fac_header WHERE Fac_header.nro_vendedor = Vendedor.nro_vendedor)   COLUMN-LABEL "Fac!Tur"
     CAN-FIND(FIRST Ped_header WHERE Ped_header.nro_vendedor = Vendedor.nro_vendedor)   COLUMN-LABEL "Pe-!did"
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_vendedor = Vendedor.nro_vendedor)   COLUMN-LABEL "Re-!cib" 
     CAN-FIND(FIRST Rem_header WHERE Rem_header.nro_vendedor = Vendedor.nro_vendedor)   COLUMN-LABEL "Re-!mit"
     WITH STREAM-IO.
