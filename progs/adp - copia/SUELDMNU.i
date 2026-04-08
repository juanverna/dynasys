/*=================================================================================*/
/*                            E S T R U C T U R A                                  */
/*=================================================================================*/

DEFINE SUB-MENU Dst-Reportes
   MENU-ITEM Destin                 LABEL "&Destinos"
   MENU-ITEM Dotacion               LABEL "D&otación".

DEFINE SUB-MENU Destinos
   MENU-ITEM Ingresos               LABEL "&Ingresos" .

DEFINE SUB-MENU Certific
   MENU-ITEM Importar               LABEL "&Importar totales"
   MENU-ITEM Exportar               LABEL "&Exportar totales"
   MENU-ITEM Carga                  LABEL "Car&ga manual"
   RULE
   MENU-ITEM Consulta               LABEL "Co&nsulta/Emisión".
   RULE
   MENU-ITEM CuartaCat              LABEL "Consulta DDJJ &4a. Cat."
   MENU-ITEM FicCuartaCat           LABEL "Ficha DDJJ &4a. Cat."
   MENU-ITEM LisCuartaCat           LABEL "Listado DDJJ &4a. Cat.".

DEFINE SUB-MENU Emp-Reportes
   MENU-ITEM Domicilios             LABEL "&Domicilios"
   MENU-ITEM DatosPer               LABEL "&Datos Personales"
   MENU-ITEM Antropo                LABEL "&Antropométricos"
   MENU-ITEM Seguros                LABEL "&Seguros"
   MENU-ITEM Horarios               LABEL "&Horarios"
   MENU-ITEM Por_cuil               LABEL "&Por CUIL"
   MENU-ITEM Cod_opt                LABEL "Conceptos &Optativos"
   RULE
   MENU-ITEM Seccion                LABEL "Por Secc&ión"
   MENU-ITEM Categoria              LABEL "Por &Categoría"
   MENU-ITEM Convenio               LABEL "Por Con&venio"

   RULE
   MENU-ITEM Dat_liq                LABEL "Datos de Li&quidación".
      
DEFINE SUB-MENU Empleados
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones"
   RULE
   MENU-ITEM Eddatliq               LABEL "&Editar Datos de Liquidación"
   MENU-ITEM Francos                LABEL "&Gestión de Francos".
   
DEFINE SUB-MENU Utl-Tablas 
   MENU-ITEM Cposta                 LABEL "Códigos P&ostales"         
   MENU-ITEM Provca                 LABEL "Pro&vincias"
   MENU-ITEM Bancos                 LABEL "&Bancos"
   MENU-ITEM Feriados               LABEL "&Feriados"
   MENU-ITEM Mensajes               LABEL "Men&sajes"
   MENU-ITEM Parametros             LABEL "&Parámetros".

DEFINE SUB-MENU Tablas 
   SUB-MENU  Destinos               LABEL "&Destinos"
   SUB-MENU  Empleados              LABEL "&Empleados"
   RULE
   MENU-ITEM Concep                 LABEL "Conceptos de &Haberes" 
   MENU-ITEM Constantes             LABEL "Cons&tantes de Liquidación"   
   MENU-ITEM Totales                LABEL "&Totales Generales de la Liquidación"   
   MENU-ITEM Sumadores              LABEL "&Sumadores por Empleado de la Liquidación"   
   MENU-ITEM Datliq                 LABEL "&Datos de Liquidación"   
   MENU-ITEM Conven                 LABEL "Con&venios"
   MENU-ITEM Tipos                  LABEL "Tipos de Li&quidación"   
   MENU-ITEM Retenciones            LABEL "Retenciones &4a. Categoría"   
   RULE
   MENU-ITEM Secciones              LABEL "Secc&iones"
   MENU-ITEM Supertabla             LABEL "S&upertabla"
   MENU-ITEM Noveda                 LABEL "Códigos de &Novedades"
   MENU-ITEM Prepagas               LABEL "&Prepagas"   
   MENU-ITEM Sindicatos             LABEL "S&indicatos"   
   MENU-ITEM Afjp                   LABEL "A.F.&J.P."   
   MENU-ITEM Art                    LABEL "A.&R.T."   
   RULE
   MENU-ITEM Cestad                 LABEL "Códigos de E&stado de Empleados"
   MENU-ITEM Catego                 LABEL "Cate&gorías de Empleados"         
   MENU-ITEM Especs                 LABEL "&Especialidades Laborales"         
   MENU-ITEM Esciv                  LABEL "Estados Ci&viles"
   MENU-ITEM Grufran                LABEL "Gr&upos de Francos"
   MENU-ITEM Tareas                 LABEL "&Tareas Parte Diario".
   
DEFINE SUB-MENU Par-Reportes
   MENU-ITEM ParteDiario            LABEL "&Parte Diario"
   MENU-ITEM FichaDiario            LABEL "&Ficha de Parte Diario" DISABLED
   MENU-ITEM Francos                LABEL "Francos por &Empleado"
   MENU-ITEM Libreta                LABEL "&Libreta de Horarios"
   MENU-ITEM Plantareas             LABEL "P&lan de Tareas"
   RULE
   MENU-ITEM PorLegDia              LABEL "Novedades por &Legajo/Fecha"
   MENU-ITEM PorDesDia              LABEL "Novedades por &Destino/Fecha"   
   MENU-ITEM PorNovDia              LABEL "Novedades por &Novedad/Fecha"   
   MENU-ITEM PorDiaDes              LABEL "Novedades por F&echa/Destino"
   RULE
   MENU-ITEM Ocurrencia             LABEL "&Ocurrencia de novedades"
   MENU-ITEM Formularios            LABEL "For&mularios".

DEFINE SUB-MENU Par-Consulta            
   MENU-ITEM PorLegDia              LABEL "&Legajo/Fecha"
   MENU-ITEM PorDesDia              LABEL "&Destino/Fecha"
   MENU-ITEM PorNovDia              LABEL "&Novedad/Fecha"   
   MENU-ITEM PorDiaLeg              LABEL "Fec&ha/Legajo"
   MENU-ITEM PorDiaDes              LABEL "Fec&ha/Destino".
   
DEFINE SUB-MENU Partes
   MENU-ITEM Partediario            LABEL "&Actualización Parte Diario"
   RULE
   MENU-ITEM Ingresos               LABEL "&Ingreso de Novedades"
   MENU-ITEM Procmest               LABEL "&Procesar Cambios de Estado"
   MENU-ITEM Importar               LABEL "I&mportar Novedades"
   MENU-ITEM Exportar               LABEL "E&xportar Novedades"
   MENU-ITEM Procesar               LABEL "Procesar &Novedades"
   SUB-MENU  Par-Consulta           LABEL "&Consultas".
   
DEFINE SUB-MENU Ciclos
   MENU-ITEM Crear                  LABEL "&Actualizaciones"
   MENU-ITEM Cambiar                LABEL "Cam&biar de Ciclo"
   MENU-ITEM Fijar                  LABEL "&Fijar Actual"
   MENU-ITEM Cerrar                 LABEL "&Cerrar".

DEFINE SUB-MENU Pagos
   MENU-ITEM Cuenta                 LABEL "&Consulta Cuenta Corriente"
   RULE
   MENU-ITEM Anticipos              LABEL "&Ingreso de Anticipos"
   MENU-ITEM Aprorech               LABEL "Aprobación/&Rechazo Anticipos"
   MENU-ITEM Antipag                LABEL "Pa&go de Anticipos" DISABLED
   RULE
   MENU-ITEM Pageft                 LABEL "Pagos en &Efectivo"
   MENU-ITEM Pagchq                 LABEL "Pagos en Che&ques"
   MENU-ITEM Pagdep                 LABEL "Pagos en &Acredit. Bancaria"
   RULE
   MENU-ITEM GenBco                 LABEL "&Generar Interface a Bancos".

DEFINE SUB-MENU Liq-Reportes
   MENU-ITEM Plaliq                 LABEL "Planilla de Li&quidación"
   RULE
   MENU-ITEM Coprec                 LABEL "&Copia de Recibos"
   MENU-ITEM Recibos                LABEL "Reci&bos"
   RULE
   MENU-ITEM Expdgi                 LABEL "E&xportar Archivo DGI"
   RULE
   MENU-ITEM Placam                 LABEL "Planilla de Ca&mbio"
   MENU-ITEM Plachq                 LABEL "&Valores a Emitir"
   MENU-ITEM Pladep                 LABEL "Depósitos a E&fectuar"   
   RULE
   MENU-ITEM Obras                  LABEL "Aportes &Obra Social"
   MENU-ITEM Sindicales             LABEL "Aportes &Sindicales"
   MENU-ITEM Libro                  LABEL "&Libro Art 52. Ley 21297"
   MENU-ITEM Pasivos                LABEL "&Libro Art 52. Ley 21297 Pasivos"
   MENU-ITEM Asiento                LABEL "&Asiento de Sueldos".

DEFINE SUB-MENU Editar
   MENU-ITEM Edporemp               LABEL "Por &Empleado".
   MENU-ITEM Edpordat               LABEL "Por &Dato".

DEFINE SUB-MENU Liquidaciones
   MENU-ITEM Familiares             LABEL "Proceso de &Familiares"
   MENU-ITEM Procparte              LABEL "Proceso de Parte &Diario"
   MENU-ITEM Procesar               LABEL "&Procesar Novedades".
   RULE
   SUB-MENU Editar                  LABEL "&Editar Datos de Liquidación".
   RULE
   MENU-ITEM Crear                  LABEL "&Crear/Ejecutar Liquidación"
   MENU-ITEM Confirmar              LABEL "Con&firmar/Retroceder Liquidación"
   MENU-ITEM Recibos                LABEL "Con&sulta de Recibos".
    
DEFINE SUB-MENU Utilidades
   SUB-MENU Utl-tablas              LABEL "&Tablas Generales"
   RULE
   MENU-ITEM Sacar-Liq              LABEL "Extraer &Liquidación"
   MENU-ITEM Reponer-Liq            LABEL "Reponer L&iquidación"
   RULE
   MENU-ITEM Sacar-Nov              LABEL "Extraer &Novedades"
   MENU-ITEM Reponer-Nov            LABEL "Reponer N&ovedades"
   RULE
   MENU-ITEM Sacar-Leg              LABEL "Extraer L&egajo"
   MENU-ITEM Reponer-Leg            LABEL "Reponer Le&gajo"   
   RULE
   MENU-ITEM Impresora              LABEL "Definición de &Impresoras".

DEFINE SUB-MENU Archivo
   MENU-ITEM Datos                  LABEL "&Datos de la Empresa".
   MENU-ITEM Empresa                LABEL "Cambio de &Empresa".
   RULE
   SUB-MENU  Utilidades             LABEL "&Utilidades".
   RULE
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE SUB-MENU Reportes
   MENU-ITEM ReportesRB             LABEL "Definidos por el &Usuario"
   RULE 
   SUB-MENU  Dst-Reportes           LABEL "&Destinos"
   SUB-MENU  Emp-Reportes           LABEL "&Empleados"
   SUB-MENU  Par-Reportes           LABEL "&Partes"
   SUB-MENU  Liq-Reportes           LABEL "&Liquidación". 

DEFINE SUB-MENU Excel
   MENU-ITEM LegDia                 LABEL "&Partes Por Legajo/fecha".
   MENU-ITEM Liquid                 LABEL "&Liquidaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Tablas                 LABEL "&Tablas".
   SUB-MENU  Ciclos                 LABEL "&Ciclos"
   SUB-MENU  Partes                 LABEL "&Partes"
   SUB-MENU  Liquidaciones          LABEL "&Liquidaciones"
   SUB-MENU  Pagos                  LABEL "Pa&gos"
   SUB-MENU  Reportes               LABEL "&Reportes"
   SUB-MENU  Certific               LABEL "Certi&fic."
   SUB-MENU  Excel                  LABEL "E&xcel".

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TRIGMENU.I "Datos"        "Archivo"       "VEREMPRE" " " "RUN VER_PERMISO."}

{TRIGMENU.I "Conven"       "Tablas"        "ACBRWCNV"  "(INPUT 0)"}
{TRIGMENU.I "Totales"      "Tablas"        "ACBRWTOL"  "(INPUT 0)"}
{TRIGMENU.I "Sumadores"    "Tablas"        "ACBRWSUM"  "(INPUT 0)"}
{TRIGMENU.I "Noveda"       "Tablas"        "ACTNOVED"  "(INPUT 0)"}
{TRIGMENU.I "Supertabla"   "Tablas"        "ACBRWOTR"  }
{TRIGMENU.I "Concep"       "Tablas"        "ACTCNCEP"  "(INPUT 0)"}
{TRIGMENU.I "Cestad"       "Tablas"        "ACBRWEST"  "(INPUT 0)"}
{TRIGMENU.I "Tipos"        "Tablas"        "ACTTIPLQ"  "(INPUT 0)"}
{TRIGMENU.I "Prepagas"     "Tablas"        "ACTPREPG"  "(INPUT 0)"}
{TRIGMENU.I "Sindicatos"   "Tablas"        "ACTSINDI"  "(INPUT 0)"}
{TRIGMENU.I "Constantes"   "Tablas"        "ACBRWCTE"  "(INPUT 0)"}
{TRIGMENU.I "Datliq"       "Tablas"        "ACBRWDLQ"  "(INPUT 0)"}
{TRIGMENU.I "Afjp"         "Tablas"        "ACBRWAFJ"  "(INPUT 0)"}
{TRIGMENU.I "Art"          "Tablas"        "ACBRWART"  "(INPUT 0)"}
{TRIGMENU.I "Catego"       "Tablas"        "ACBRWCAT"  "(INPUT 0)"}
{TRIGMENU.I "Especs"       "Tablas"        "ACBRWSPC"  "(INPUT 0)"}
{TRIGMENU.I "Secciones"    "Tablas"        "ACBRWSCC"  "(INPUT 0)"}
{TRIGMENU.I "Esciv"        "Tablas"        "ACBRWECV"  "(INPUT 0)"}
{TRIGMENU.I "Grufran"      "Tablas"        "ACTGRUFR"  "(INPUT 0)"}
{TRIGMENU.I "Tareas"       "Tablas"        "ACTTAREA"  "(INPUT 0)"}
{SMARTRIG.I "Retenciones"  "Tablas"        "W-CUARCT.W"}

{TRIGMENU.I "Cposta"       "Utl-Tablas"    "ACBRWCPS"  "(INPUT 0)"}
{TRIGMENU.I "Provca"       "Utl-Tablas"    "ACBRWPRV"  "(INPUT 0)"}
{TRIGMENU.I "Bancos"       "Utl-Tablas"    "ACBRWBCO"  "(INPUT 0)"}
{TRIGMENU.I "Feriados"     "Utl-Tablas"    "ACBRWFER"  "(INPUT 0)"}
{TRIGMENU.I "Mensajes"     "Utl-Tablas"    "EDTMENSJ"  }
{TRIGMENU.I "Parametros"   "Utl-Tablas"    "ACTPARAM"  "(INPUT 0)" "RUN CARPARAM.P."}

{TRIGMENU.I "ReportesRB"   "Reportes"      "EXECUTRB"}

{SMARTRIG.I "Ingresos"     "Empleados"     "w-empleados.w"}
{TRIGMENU.I "Eddatliq"     "Empleados"     "EDDATEMP"  "(INPUT 0)"}
{TRIGMENU.I "Francos"      "Empleados"     "PROCFRAN"}
{TRIGMENU.I "Cuenta"       "Pagos"         "CNSCCEMP"  "(INPUT 0)"}
{TRIGMENU.I "Anticipos"    "Pagos"         "ACTANSUE"  "(INPUT 0)"}
{TRIGMENU.I "Aprorech"     "Pagos"         "APRBADEL"}
{TRIGMENU.I "Pageft"       "Pagos"         "RLPAGEFT"}
{TRIGMENU.I "Pagchq"       "Pagos"         "RLPAGCHQ"}
{TRIGMENU.I "Pagdep"       "Pagos"         "RLPAGBCO"}
{TRIGMENU.I "GenBco"       "Pagos"         "LSGENBCO"}

{TRIGMENU.I "Domicilios"   "Emp-reportes"  "RLEMDOMI"}
{TRIGMENU.I "DatosPer"     "Emp-reportes"  "RLEMDAPR"}
{TRIGMENU.I "Antropo"      "Emp-reportes"  "RLEMANTR"}
{TRIGMENU.I "Seguros"      "Emp-reportes"  "RLEMSEGU"}
{TRIGMENU.I "Horarios"     "Emp-reportes"  "RLEMHORA"}
{TRIGMENU.I "Por_cuil"     "Emp-reportes"  "RLEMCUIL"}
{TRIGMENU.I "Cod_opt"      "Emp-reportes"  "RLCOOPEM"}
{TRIGMENU.I "Dat_liq"      "Emp-reportes"  "RLDATLIQ"}
{TRIGMENU.I "Seccion"      "Emp-reportes"  "RLREMSEC"}
{TRIGMENU.I "Categoria"    "Emp-reportes"  "RLREMCAT"}
{TRIGMENU.I "Convenio"     "Emp-reportes"  "RLREMCNV"}


{TRIGMENU.I "Consulta"     "Certific"      "CNCTFSRV"  "(INPUT 0)" }
{TRIGMENU.I "LisCuartaCat" "Certific"      "RLEMDDJJ" }
{TRIGMENU.I "FicCuartaCat" "Certific"      "RLFIDDJJ" }

{SMARTRIG.I "Cuartacat"    "Certific"      "W-CN4CAT.W"}

{TRIGMENU.I "Ingresos"     "Destinos"      "ACTDESTI"  "(INPUT 0)"}
{TRIGMENU.I "Destin"       "Dst-reportes"  "LSDESTIN"}
{TRIGMENU.I "Dotacion"     "Dst-reportes"  "LSDSDOTA"}

{TRIGMENU.I "Partediario"  "Partes"        "EDPARDIA"  "(INPUT 0)"}
{TRIGMENU.I "Ingresos"     "Partes"        "ACTPARTE"  "(INPUT 0)"}
{TRIGMENU.I "Procmest"     "Partes"        "PROCMEST"}
{TRIGMENU.I "Procesar"     "Partes"        "PROCNOVD"}
{TRIGMENU.I "Importar"     "Partes"        "IMPONOVE"}
{TRIGMENU.I "Exportar"     "Partes"        "EXPONOVE"}

{TRIGMENU.I "PorLegDia"    "Par-Consulta"  "CNPAEMFE"  "(INPUT 0)"}
{TRIGMENU.I "PorDesDia"    "Par-Consulta"  "CNPADEFE"  "(INPUT 0)"}
{TRIGMENU.I "PorNovDia"    "Par-Consulta"  "CNPANOFE"  "(INPUT 0)"}
{TRIGMENU.I "PorDiaLeg"    "Par-Consulta"  "CNPAFEEM"}
{TRIGMENU.I "PorDiaDes"    "Par-Consulta"  "CNPAFEDE"}

{TRIGMENU.I "Crear"        "Ciclos"        "ACTCICLO"  "(INPUT 0)"}
{TRIGMENU.I "Cambiar"      "Ciclos"        "QUECICLO"}
{TRIGMENU.I "Fijar"        "Ciclos"        "FIJCICLO"}
{TRIGMENU.I "Cerrar"       "Ciclos"        "CICERRAR"}

{TRIGMENU.I "Edporemp"     "Editar"        "EDDATEMP"  "(INPUT 0)"}
{TRIGMENU.I "Edpordat"     "Editar"        "EDEMPDAT"  "(INPUT 0)"}

{TRIGMENU.I "Familiares"   "Liquidaciones" "PROCFAML"}
{TRIGMENU.I "Procparte"    "Liquidaciones" "PROCPART"}
{TRIGMENU.I "Procesar"     "Liquidaciones" "PROCNOVD"}
{TRIGMENU.I "Crear"        "Liquidaciones" "ACTLIQUD"  "(INPUT 0)"}
{TRIGMENU.I "Confirmar"    "Liquidaciones" "CNFIRLIQ"}
{TRIGMENU.I "Recibos"      "Liquidaciones" "ABMAERCB"  "(INPUT 0)"}

{TRIGMENU.I "Plaliq"       "Liq-reportes"  "LSPLALIQ"}
{TRIGMENU.I "Placam"       "Liq-reportes"  "LSPLACAM"}
{TRIGMENU.I "Plachq"       "Liq-reportes"  "LSPLACHQ"}
{TRIGMENU.I "Pladep"       "Liq-reportes"  "LSPLADEP"}

{TRIGMENU.I "Expdgi"       "Liq-reportes"  "LSEXPDGI"}

{TRIGMENU.I "Coprec"       "Liq-reportes"  "LSCOPREC"}
{TRIGMENU.I "Recibos"      "Liq-reportes"  "LSLISREC"}
{TRIGMENU.I "Obras"        "Liq-reportes"  "LSPLAOBS"}
{TRIGMENU.I "Sindicales"   "Liq-reportes"  "LSPLASIN"}
{TRIGMENU.I "Libro"        "Liq-reportes"  "LSLIBLEY"}
{TRIGMENU.I "Pasivos"      "Liq-reportes"  "LSLLEYPA"}
{TRIGMENU.I "Asiento"      "Liq-reportes"  "LSASNSYJ"}

{TRIGMENU.I "ParteDiario"  "Par-reportes"  "LSPARDIA"}
{TRIGMENU.I "Francos"      "Par-reportes"  "LSPAFRAN"}
{TRIGMENU.I "Libreta"      "Par-reportes"  "LSPALBRE"}
{TRIGMENU.I "PorLegDia"    "Par-reportes"  "LSPAEMFE"}
{TRIGMENU.I "PorDesDia"    "Par-reportes"  "LSPADEFE"}
{TRIGMENU.I "PorNovDia"    "Par-reportes"  "LSPANOFE"}
{TRIGMENU.I "PorDiaDes"    "Par-reportes"  "LSPAFEDE"}
{TRIGMENU.I "Ocurrencia"   "Par-reportes"  "LSPAOCUR"}
{TRIGMENU.I "Formularios"  "Par-reportes"  "LSPAFORM"}
{TRIGMENU.I "PlanTareas"   "Par-reportes"  "RLPLNTAR"}

{TRIGMENU.I "LegDia"       "Excel"         "EXPAEMFE"}
{TRIGMENU.I "Liquid"       "Excel"         "LSEXPLIQ"}

{TRIGMENU.I "Impresora"    "Utilidades"    "ACTIMPRE"  "(INPUT 0)" }
