/*=================================================================================*/
/*    MUESTRA EL BALANCE GENERADO EN LA TABLA LST_SUMYSAL                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-titulo_window  AS CHARACTER FORMAT "X(60)".

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}

/*{SHTSUMYS.I "NEW"}*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  p-titulo_window AT 40 
  "Pagina:" AT 110 PAGE-NUMBER FORMAT "ZZZ9" AT 117
  SKIP  
  fecha_lis   
  hora_lis AT 110
  SKIP(1)
  WITH WIDTH 195 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.


DEFINE FRAME frm-listado
  Lst_sumysal.que_codigo  FORMAT "X(40)"
  Lst_sumysal.que_nombre  FORMAT "X(100)"     
  WITH WIDTH 195 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX
       FRAME frm-listado FONT 2.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

/*=================================================================================*/
/*           INVOCA LA REPRESENTACION VISUAL DEL BALANCE                           */
/*=================================================================================*/

{dirprinfile.i}

FOR EACH Lst_sumysal NO-LOCK:
    
    VIEW FRAME frm-titulo.

    DISPLAY 
          Lst_sumysal.que_codigo        
          Lst_sumysal.que_nombre        
          WITH FRAME frm-listado.
END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT (arch_salida),
                 INPUT 22 ).
