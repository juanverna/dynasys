
DEFINE VAR sal AS CHAR NO-UNDO.
FIND fac_header WHERE prf_comprob = 3 AND nro_comprob = 2014 AND tip_comprob = "FA".
fac_header.fecha_impresion = ?.
/*RUN prfaa234eMR.p( "FA" ,3,2014,2014, "P", 1,output sal).
update sal FORMAT "X(50)".*/

