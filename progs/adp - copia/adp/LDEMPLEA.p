DEFINE VARIABLE WS-MPL-LEGAJO         AS INTEGER.
DEFINE VARIABLE WS-MPL-NOMBRE         AS CHARACTER.
DEFINE VARIABLE WS-MPL-STATUS         AS CHARACTER.
DEFINE VARIABLE WS-MPL-DIRECC         AS CHARACTER.
DEFINE VARIABLE WS-MPL-CODPOS         AS CHARACTER.
DEFINE VARIABLE WS-MPL-LOCALD         AS CHARACTER.
DEFINE VARIABLE WS-MPL-PRVCIA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-TELEFN         AS CHARACTER.
DEFINE VARIABLE WS-MPL-CDZONA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-TIPDOC         AS CHARACTER.
DEFINE VARIABLE WS-MPL-NUMDOC         AS INTEGER.
DEFINE VARIABLE WS-MPL-CIEMIT         AS CHARACTER.
DEFINE VARIABLE WS-MPL-CIDNRO         AS INTEGER.
DEFINE VARIABLE WS-MPL-ESTCIV         AS CHARACTER.
DEFINE VARIABLE WS-MPL-FECHNA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-LUGNAC         AS CHARACTER.
DEFINE VARIABLE WS-MPL-NACDAD         AS CHARACTER.
DEFINE VARIABLE WS-MPL-FECHIN         AS CHARACTER.
DEFINE VARIABLE WS-MPL-FECHBA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-FECHCA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-CATEGR         AS INTEGER.
DEFINE VARIABLE WS-MPL-ESPECL         AS CHARACTER.
DEFINE VARIABLE WS-MPL-SECTRA         AS CHARACTER.
DEFINE VARIABLE WS-MPL-NPADRE         AS CHARACTER.
DEFINE VARIABLE WS-MPL-NMADRE         AS CHARACTER.
DEFINE VARIABLE WS-MPL-SINNRO         AS INTEGER.
DEFINE VARIABLE WS-MPL-OBSNRO         AS INTEGER.
DEFINE VARIABLE WS-MPL-JUBNRO         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLPA         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLCA         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLGU         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLZA         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLSO         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLGN         AS INTEGER.
DEFINE VARIABLE WS-MPL-TALLOT         AS INTEGER.
DEFINE VARIABLE WS-MPL-SEXO           AS CHARACTER.
DEFINE VARIABLE WS-MPL-PISO           AS CHARACTER.
DEFINE VARIABLE WS-MPL-DEPART         AS CHARACTER.
DEFINE VARIABLE WS-MPL-NUMPUE         AS INTEGER.
DEFINE VARIABLE WS-MPL-CARSER         AS INTEGER.
DEFINE VARIABLE WS-MPL-TOTBRU         AS INTEGER.
DEFINE VARIABLE WS-MPL-CUIL           AS CHARACTER.

INPUT FROM "EMPLEADO.TXT".

FIND FIRST Especializacion.
FIND FIRST C_Postal.                       
FIND FIRST Estado_Civil.

REPEAT:

   IMPORT DELIMITER ","

           WS-MPL-LEGAJO
           WS-MPL-NOMBRE
           WS-MPL-STATUS
           WS-MPL-DIRECC
           WS-MPL-CODPOS
           WS-MPL-LOCALD
           WS-MPL-PRVCIA
           WS-MPL-TELEFN
           WS-MPL-CDZONA
           WS-MPL-TIPDOC
           WS-MPL-NUMDOC
           WS-MPL-CIEMIT
           WS-MPL-CIDNRO
           WS-MPL-ESTCIV
           WS-MPL-FECHCA
           WS-MPL-FECHNA
           WS-MPL-LUGNAC
           WS-MPL-NACDAD
           WS-MPL-FECHIN
           WS-MPL-FECHBA
           WS-MPL-CATEGR
           WS-MPL-ESPECL
           WS-MPL-SECTRA
           WS-MPL-NPADRE
           WS-MPL-NMADRE
           WS-MPL-SINNRO
           WS-MPL-OBSNRO
           WS-MPL-JUBNRO
           WS-MPL-TALLPA
           WS-MPL-TALLCA
           WS-MPL-TALLGU
           WS-MPL-TALLZA
           WS-MPL-TALLSO
           WS-MPL-TALLGN
           WS-MPL-TALLOT
           WS-MPL-SEXO  
           WS-MPL-PISO  
           WS-MPL-DEPART
           WS-MPL-NUMPUE
           WS-MPL-CARSER
           WS-MPL-TOTBRU
           WS-MPL-CUIL NO-ERROR.
           
   CREATE Empleado.
   ASSIGN 
          Empleado.calle = WS-MPL-DIRECC.
          Empleado.cdg_banco = 1.
          Empleado.cdg_categoria = 1. 
          Empleado.cdg_convenio = 1.
          Empleado.cdg_Especializacion = "". 
          Empleado.cdg_estado = "AA"     . 
          Empleado.cdg_provincia  = "00" .
          Empleado.cdg_sexo       = "M"  .
          Empleado.depto          = WS-MPL-DEPART.     
          Empleado.cdg_forma      = "E"          .
          Empleado.localidad      = WS-MPL-LOCALD.
          Empleado.lugar_nac      = WS-MPL-LUGNAC.
          Empleado.nacionalid     = WS-MPL-NACDAD.
          Empleado.nombre         = WS-MPL-NOMBRE.
          Empleado.nom_madre      = WS-MPL-NMADRE. 
          Empleado.nom_padre      = WS-MPL-NPADRE.
          Empleado.nro_cuil       = WS-MPL-CUIL  .
          Empleado.nro_empleado   = NEXT-VALUE(proximo_empleado).
          Empleado.nro_legajo     = WS-MPL-LEGAJO.
          Empleado.numero         = WS-MPL-NUMPUE.
          Empleado.numero_doc     = WS-MPL-NUMDOC.
          Empleado.piso           = WS-MPL-PISO  .
          Empleado.telefono       = WS-MPL-TELEFN.
          Empleado.tipo_doc       = WS-MPL-TIPDOC.     
          Empleado.cdg_Especializacion = Especializacion.cdg_Especializacion.
          Empleado.cdg_postal      = C_Postal.cdg_postal.
          Empleado.cdg_est_civil  = Estado_Civil.cdg_est_civil.          
          /*
          Empleado.fecha_ingreso  = DATE(WS-MPL-FECHIN).        
          Empleado.fecha_baja     = DATE(WS-MPL-FECHBA).
          Empleado.fecha_nac      = DATE(WS-MPL-FECHNA).
            */
   DISPLAY            
           WS-MPL-LEGAJO
           WS-MPL-NOMBRE
/*
           WS-MPL-STATUS 
           WS-MPL-DIRECC
           WS-MPL-CODPOS
           WS-MPL-LOCALD
           WS-MPL-PRVCIA
           WS-MPL-TELEFN            
           WS-MPL-CDZONA
           WS-MPL-TIPDOC
           WS-MPL-NUMDOC
           WS-MPL-CIEMIT
           WS-MPL-CIDNRO
           WS-MPL-ESTCIV
           WS-MPL-FECHCA
           WS-MPL-FECHNA
           WS-MPL-LUGNAC
           WS-MPL-NACDAD
           WS-MPL-FECHIN
           WS-MPL-FECHBA
           WS-MPL-CATEGR
           WS-MPL-ESPECL
           WS-MPL-SECTRA
           WS-MPL-NPADRE
           WS-MPL-NMADRE
           WS-MPL-SINNRO
           WS-MPL-OBSNRO
           WS-MPL-JUBNRO
           WS-MPL-TALLPA
           WS-MPL-TALLCA
           WS-MPL-TALLGU
           WS-MPL-TALLZA
           WS-MPL-TALLSO
           WS-MPL-TALLGN
           WS-MPL-TALLOT
           WS-MPL-SEXO  
           WS-MPL-PISO  
           WS-MPL-DEPART
           WS-MPL-NUMPUE
           WS-MPL-CARSER
           WS-MPL-TOTBRU
           WS-MPL-CUIL
*/
           WITH USE-TEXT FONT 9 SIDE-LABELS DOWN .
END.           
