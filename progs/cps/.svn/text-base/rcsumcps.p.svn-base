
DEFINE INPUT PARAMETER que_clase                 AS ROWID.
DEFINE INPUT PARAMETER nivel                     AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_per  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_per LIKE Aps_detalle.credito LABEL "Acum.creditos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_tot  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_tot LIKE Aps_detalle.credito LABEL "Acum.creditos".

DEFINE VARIABLE l-saldo_per        LIKE Aps_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_per  LIKE Aps_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_per LIKE Aps_detalle.credito LABEL "Acum.creditos" INITIAL 0.
DEFINE VARIABLE l-saldo_tot        LIKE Aps_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_tot  LIKE Aps_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_tot LIKE Aps_detalle.credito LABEL "Acum.creditos" INITIAL 0.

{VRSHARED.I}
{VPERSINM.I}

DEFINE SHARED STREAM listado.

DEFINE BUFFER   Clase  FOR Clase_de_ctapsp.
DEFINE BUFFER Subclase FOR Clase_de_ctapsp.

DEFINE QUERY qry_clasificacion  FOR Subclase.
DEFINE QUERY qry_cuentas        FOR Ctapsp.

{SHVSUMYS.I}

DEFINE VARIABLE que_subclase AS CHARACTER.

DEFINE SHARED FRAME frm-titulo.
  {SHFCPSTI.I}

DEFINE SHARED FRAME frm-clases.
  {SHFCPSCL.I}

DEFINE SHARED FRAME frm-cuentas.
  {SHFCPSCU.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.

pg = PAGE-NUMBER(Listado).                                                  

IF Clase.cdg_clase <> ?
THEN DO:
   que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
   FRAME frm-clases:COLUMN = 1 + nivel * 3. /* Fijamos identacion de los totales */
   DISPLAY STREAM listado 
           que_subclase 
           Clase.nombre_subclase 
           WITH FRAME frm-clases.   
   DOWN STREAM listado WITH FRAME frm-clases.
   nivel = nivel + 1.
END.   

IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase)
THEN DO: /* No es el £ltimo nivel. Seguimos profundizando */

   RUN ABRE_QUERY.
   GET FIRST qry_clasificacion.
   DO WHILE AVAILABLE Subclase:              

      l-acm_debitos_per  = 0.
      l-acm_creditos_per = 0.
      l-acm_debitos_tot  = 0.
      l-acm_creditos_tot = 0.

      RUN RCSUMCPS.P ( INPUT ROWID(Subclase) , 
                       INPUT nivel,
                       INPUT-OUTPUT l-acm_debitos_per,
                       INPUT-OUTPUT l-acm_creditos_per,
                       INPUT-OUTPUT l-acm_debitos_tot,
                       INPUT-OUTPUT l-acm_creditos_tot ).
      ASSIGN
          l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
          l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.
            
      FRAME frm-clases:COLUMN = 1 + nivel * 3. /* Fijamos identacion de los totales */
      DISPLAY STREAM listado 
              "Total" @ que_subclase
              Subclase.nombre_subclase @ Clase.nombre_subclase
              l-acm_debitos_per
              l-acm_creditos_per
              l-saldo_per
              l-acm_creditos_tot
              l-acm_debitos_tot
              l-saldo_tot
              WITH FRAME frm-clases.   
      DOWN STREAM listado WITH FRAME frm-clases.
      
      ASSIGN
         p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
         p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
         p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
         p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
      
      GET NEXT qry_clasificacion.
   END.

END.
ELSE DO:

   FRAME frm-cuentas:COLUMN = 1 + ( nivel + 1 ) * 3. /* Las cuentas se listan identadas
                                                        respecto del nivel de clasifcacion */

   RUN ABRE_QUERY_CUENTAS.
   GET FIRST qry_cuentas.
   DO WHILE AVAILABLE Ctapsp:

      RUN CALCULAR_SALDO. 
      ASSIGN
          l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
          l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.
          
      DISPLAY STREAM listado 
              Ctapsp.cdg_ctapsp
              Ctapsp.nombre_cps
              l-acm_debitos_per
              l-acm_creditos_per
              l-saldo_per
              l-acm_creditos_tot
              l-acm_debitos_tot
              l-saldo_tot
              WITH FRAME frm-cuentas.   
      DOWN STREAM listado WITH FRAME frm-cuentas.   

      ASSIGN
         p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
         p-acm_creditos_per = p-acm_creditos_per  + p-acm_creditos_per
         p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
         p-acm_creditos_tot = p-acm_creditos_tot  + p-acm_creditos_tot.

      GET NEXT qry_cuentas.
   END.

   /* ---------------- Preparado para futuras implementaciones -------------------
   ASSIGN
          l-saldo_per = p-acm_debitos_per - p-acm_creditos_per
          l-saldo_tot = p-acm_debitos_tot - p-acm_creditos_tot.  

   FRAME frm-clases:COLUMN = 1 + (nivel ) * 3.
   DISPLAY STREAM listado 
           "Total" @ que_subclase
           Clase.nombre_subclase
           p-acm_debitos_per  @ l-acm_debitos_per
           p-acm_creditos_per @ l-acm_creditos_per
           l-saldo_per
           p-acm_creditos_tot @ l-acm_creditos_tot
           p-acm_debitos_tot  @ l-acm_debitos_tot
           l-saldo_tot
           WITH FRAME frm-clases.   
   DOWN STREAM listado WITH FRAME frm-clases.
   ------------------------------------------------------------------------------- */
   
END.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE ABRE_QUERY_CUENTAS:

        OPEN QUERY qry_cuentas 
             FOR EACH Ctapsp WHERE Ctapsp.cdg_subclase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE CALCULAR_SALDO:

    l-acm_debitos_per  = 0. 
    l-acm_creditos_per = 0.
    l-acm_debitos_tot  = 0.
    l-acm_creditos_tot = 0.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_ctapsp OF Ctapsp
       WHERE   DATE(Acumulado_ctapsp.mes,1,Acumulado_ctapsp.ano) < 
               DATE(MONTH(has_fecha),1,YEAR(has_fecha)):
                             
      l-acm_debitos_tot  = l-acm_debitos_tot  + Acumulado_ctapsp.tot_debitos.
      l-acm_creditos_tot = l-acm_creditos_tot + Acumulado_ctapsp.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Aps_detalle OF Ctapsp 
       WHERE Aps_detalle.fecha_mayor >= DATE(MONTH(has_fecha),1,YEAR(has_fecha)) 
         AND Aps_detalle.fecha_mayor <= has_fecha 
          BY fecha_mayor:

      l-acm_debitos_per  = l-acm_debitos_per  + Aps_detalle.debito.
      l-acm_creditos_per = l-acm_creditos_per + Aps_detalle.credito.


   END.

   l-acm_debitos_tot  = l-acm_debitos_tot  + l-acm_debitos_per.
   l-acm_creditos_tot = l-acm_creditos_tot + l-acm_creditos_per.

   l-saldo_per = l-acm_debitos_per  - l-acm_creditos_per.
   l-saldo_tot = l-acm_debitos_tot  - l-acm_creditos_tot.

END.
