/*=================================================================================*/
/*                                E S T R U C T U R A                              */
/*=================================================================================*/

DEFINE SUB-MENU Tablas
   MENU-ITEM Cuentas                LABEL "&Cuentas de Presupuesto"
   MENU-ITEM Clasifica              LABEL "Clasi&ficacion de Presupuesto".
   RULE
   MENU-ITEM Obras                  LABEL "&Obras"
   MENU-ITEM Entidades              LABEL "&Entidades Contables"
   RULE
   MENU-ITEM Mensajes               LABEL "Men&sajes"
   MENU-ITEM Parametros             LABEL "&Parametros".

DEFINE SUB-MENU Modelos
   MENU-ITEM Ingresos               LABEL "&Ingresos"
   MENU-ITEM Consultas              LABEL "&Consultas/Bajas".

DEFINE SUB-MENU Asientos
   MENU-ITEM Ingresos               LABEL "&Ingreso de Presupuesto"
   MENU-ITEM Consultas              LABEL "&Consultas/Bajas".
   
DEFINE SUB-MENU De-obras
   MENU-ITEM Mayobra                LABEL "Ma&yor de Obra".

DEFINE SUB-MENU De-entidades
   MENU-ITEM Mayentid               LABEL "Ma&yor de Entidades".
   
DEFINE SUB-MENU Reportes
   MENU-ITEM Clasifica              LABEL "Clasi&ficaci¢n de Presupuesto"
   RULE
   MENU-ITEM Diario                 LABEL "Asientos de &Presupuesto"
   MENU-ITEM Mayor                  LABEL "Libro &Mayor"
   MENU-ITEM CnsMayor               LABEL "&Consulta Mayor"
   MENU-ITEM Sumysald               LABEL "Balance de &Sumas y Saldos"
   MENU-ITEM Sumysxcu               LABEL "Su&mas y Saldos por Cuenta"
   RULE
   MENU-ITEM Cuadrores              LABEL "C&uadro de Resultados"
   RULE
   SUB-MENU  De-obras               LABEL "De &Obras"
   SUB-MENU  De-entidades           LABEL "De &Entidades"  DISABLED
   RULE
   MENU-ITEM Saldoscom              LABEL "Saldos Com&parados".

DEFINE SUB-MENU Utilidades
   MENU-ITEM Impresora              LABEL "Definici¢n de &Impresoras".

DEFINE SUB-MENU Archivo
   MENU-ITEM Datos                  LABEL "&Datos de la Empresa".
   MENU-ITEM Empresa                LABEL "Cambio de &Empresa".
   RULE
   SUB-MENU  Utilidades             LABEL "&Utilidades".
   RULE
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Tablas                 LABEL "&Tablas"
   SUB-MENU  Modelos                LABEL "&Modelos"
   SUB-MENU  Asientos               LABEL "A&sientos"
   SUB-MENU  Reportes               LABEL "&Reportes".
/*   SUB-MENU  Procesos               LABEL "&Procesos"*/
      
/*=================================================================================*/
/*                                T R I G G E R S                                  */
/*=================================================================================*/

{TRIGMENU.I "Datos"        "Archivo"       "VEREMPRE"  " " "RUN VER_PERMISO."}

{TRIGMENU.I "Cuentas"      "Tablas"        "ACTCTAPS"  "(INPUT 0)"}
{TRIGMENU.I "Clasifica"    "Tablas"        "ACTCLPSP"  "(INPUT 0, OUTPUT dumy_intg)"}
{TRIGMENU.I "Entidades"    "Tablas"        "ACTENTID"  "(INPUT 0)"}
{TRIGMENU.I "Obras"        "Tablas"        "ACTOBRGL"  "(INPUT 0)"}
{TRIGMENU.I "Mensajes"     "Tablas"        "EDTMENSJ" }
{TRIGMENU.I "Parametros"   "Tablas"        "ACTPARAM"  "(INPUT 0)" "RUN CARPARAM.P."}

{TRIGMENU.I "Ingresos"     "Asientos"      "ABMAEAPS"  "(INPUT 0)" }
{TRIGMENU.I "Consultas"    "Asientos"      "ABMAEAPS"  "(INPUT 1)" }

{TRIGMENU.I "Ingresos"     "Modelos"       "ABMAEMPS"  "(INPUT 0)" }
{TRIGMENU.I "Consultas"    "Modelos"       "ABMAEMPS"  "(INPUT 1)" }

{TRIGMENU.I "Impresora"    "Utilidades"    "ACTIMPRE"  "(INPUT 0)" }


{TRIGMENU.I "Diario"       "Reportes"      "RLASNPSP" }
{TRIGMENU.I "Mayor"        "Reportes"      "RLMAYPSP" }
{TRIGMENU.I "CnsMayor"     "Reportes"      "CNSMAPSP"  "(INPUT 0)" }
{TRIGMENU.I "SumySald"     "Reportes"      "RLSUMCPS" }
{TRIGMENU.I "SumySxcu"     "Reportes"      "RLSYSCPS" }
{TRIGMENU.I "Saldoscom"    "Reportes"      "RLRESCOM" }
{TRIGMENU.I "Cuadrores"    "Reportes"      "RLCUADRORES" }

{TRIGMENU.I "Mayobra"      "De-obras"      "RLMAYOPS" }

/*
{TRIGMENU.I "Balance"      "Reportes"      "LISBALAN" }
{TRIGMENU.I "Clasifica"    "Reportes"      "RLCLSCUE" }

{TRIGMENU.I "Ingresos"     "Ejercicios"    "ACBRWEJR"  "(INPUT 0)"}
{TRIGMENU.I "Periodos"     "Ejercicios"    "EDPERFIS" }
{TRIGMENU.I "Refundir"     "Ejercicios"    "RLASNREF" }
{TRIGMENU.I "Cierre"       "Ejercicios"    "RLASNCIE" }
{TRIGMENU.I "Apertura"     "Ejercicios"    "RLASNAPR" }

*/
