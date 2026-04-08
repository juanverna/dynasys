/*=================================================================================*/
/*                   IMPRESION DE LA TABLA DE PARAMETROS                           */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE valor       AS CHARACTER COLUMN-LABEL "Valor Actual" FORMAT "X(90)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.

DEFINE VARIABLE que_archivo AS CHARACTER.

FORM HEADER
   que_empresa FORMAT "X(25)"
   "Valor actual de los parametros" AT 58 
   "Pagina:" AT 144 PAGE-NUMBER FORMAT ">9" AT 151 
   SKIP  
   fecha_lis   
   hora_lis AT 144
   SKIP(2)
   WITH FRAME frm-parametro CENTERED TOP-ONLY STREAM-IO USE-TEXT WIDTH 156.


FORM 
   Parametro.cdg_Parametro LABEL "Codigo"
   Parametro.tipo    
   Parametro.descripcion 
   valor COLUMN-LABEL "Valor Actual"
   WITH FRAME frm-parametro STREAM-IO USE-TEXT WIDTH 156 DOWN.

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

FIND FIRST Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

que_archivo = dire_tmp + "lisparam.txt".

OUTPUT TO VALUE(que_archivo) PAGED.

PUT CONTROL "~033" + "&k4S".
FOR EACH Parametro BY descripcion:

    CASE Parametro.tipo:
         WHEN "N" THEN valor = STRING(Parametro.valor_n,"ZZZZZZZ9-").
         WHEN "D" THEN valor = STRING(Parametro.valor_d,"ZZZZZZZ9.9999-").
         WHEN "C" THEN valor = Parametro.valor_c.
         WHEN "L" THEN valor = "      " + STRING(Parametro.valor_l,"Si/No").
    END  CASE.

    DISPLAY Parametro.cdg_Parametro
            Parametro.descripcion 
            Parametro.tipo
            valor
            WITH FRAME frm-Parametro.

    DOWN WITH FRAME frm-parametro.

END.        

UNDERLINE Parametro.cdg_Parametro
          Parametro.descripcion 
          Parametro.tipo
          valor
          WITH FRAME frm-Parametro.

OUTPUT CLOSE.

/*RUN PRINFILE.P ( INPUT que_archivo, "LPT1"). */