/*=======================================================================================================*/
/*                 COPIA LOS DATOS DE DEFINICION DE UN MENU DE UNA EMPRESA A OTRA                        */
/*=======================================================================================================*/

DEFINE VARIABLE v-cdg_empresa LIKE Empresa.cdg_empresa INITIAL "N".
DEFINE BUFFER B-Menu FOR treeMenu.

FOR EACH treeMenu WHERE treeMenu.cdg_empresa = "C":
    CREATE B-Menu.
    BUFFER-COPY treeMenu TO B-Menu ASSIGN B-Menu.cdg_empresa = v-cdg_empresa.
END.    
