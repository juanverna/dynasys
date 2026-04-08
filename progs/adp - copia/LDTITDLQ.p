DEFINE VARIABLE WS-ADL-CODIGO         AS INTEGER.
DEFINE VARIABLE WS-ADL-NOMBRE         AS CHARACTER.  
DEFINE VARIABLE WS-ADL-ABREVD         AS CHARACTER.
DEFINE VARIABLE WS-ADL-TIPOVR         AS INTEGER.
DEFINE VARIABLE WS-ADL-RESETC         AS INTEGER.

FOR EACH  Tit_dat_liquid:
  DELETE Tit_dat_liquid.
END.

INPUT FROM "TITDATLQ.TXT".

REPEAT:

  IMPORT DELIMITER ","
         WS-ADL-CODIGO
         WS-ADL-NOMBRE
         WS-ADL-ABREVD
         WS-ADL-TIPOVR
         WS-ADL-RESETC.

  CREATE Tit_dat_liquid.
  ASSIGN                 
        Tit_dat_liquid.abreviatura = WS-ADL-ABREVD
        Tit_dat_liquid.cdg_datliq  = WS-ADL-CODIGO
        Tit_dat_liquid.descripcion = WS-ADL-NOMBRE
        Tit_dat_liquid.reset       = ( WS-ADL-RESETC = 1 ).
        
         
END.          