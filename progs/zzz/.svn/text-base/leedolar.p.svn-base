DEFINE VARIABLE f AS DATE.
DEFINE VARIABLE c AS DECIMAL DECIMALS 4 FORMAT ">>>9.9999".

FIND Moneda WHERE cdg_moneda = "DO".
FOR EACH cotizacion OF moneda:
    DELETE cotizacion.
END.
INPUT FROM "c:\desa\v9\sic\r3.5.2\progs\zzz\dolar.txt".
REPEAT :
    IMPORT f c.
    DISPLAY f c WITH STREAM-IO.
    CREATE Cotizacion.
    ASSIGN Cotizacion.cambio = c
           Cotizacion.cdg_empresa = "F"
           Cotizacion.fch_cotizacion = f
           Cotizacion.nro_moneda = Moneda.nro_moneda.

END.
