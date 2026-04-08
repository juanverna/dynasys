/*==========================================================================================*/
/*          IMPORTA UN TXT CON LA DEFINICION DE UN MENU ARBOLADO PARA TREE VIEW             */
/*==========================================================================================*/

DEFINE VARIABLE modulos AS CHARACTER INITIAL "DSP,COM,UTL,CXP,TES,INV,CPS,GLA,CXC,FAC,AFI,ABA".
DEFINE VARIABLE j       AS INTEGER.
DEFINE VARIABLE maximo  AS INTEGER.

DEFINE VARIABLE ver     AS LOGICAL INITIAL NO.
DEFINE VARIABLE solouno AS LOGICAL INITIAL NO.

DEFINE TEMP-TABLE T-Treemenu LIKE Treemenu.

maximo = IF solouno THEN 1 ELSE  NUM-ENTRIES(modulos,",").

FOR EACH Treemenu:
    DELETE Treemenu.
END.    

DO j = 1 TO maximo:

    INPUT FROM VALUE("c:\desa\sic\r3.1\progs\bas\menu" + ENTRY(j,modulos,",") + ".txt").
    REPEAT:
       CREATE Treemenu.
       IMPORT DELIMITER "," Treemenu.
  
       IF ver THEN DISPLAY Treemenu.cdg_item FORMAT "x(20)" cdg_padre FORMAT "x(20)" WITH STREAM-IO.
  
    END.
    INPUT CLOSE.   

END.

IF solouno
THEN DO:
    RUN w-treeTreemenu.w ( INPUT ENTRY(1,modulos,",") ).
END.
ELSE DO:
    COMPILE SIC.P SAVE.
    RUN SIC.P.
END
