DEFINE VARIABLE arch_salida AS CHARACTER.
arch_salida = PROGRAM-NAME(5).
arch_salida = LC(dire_tmp + SUBSTRING(arch_salida,1,INDEX(arch_salida,".") - 1) + ".txt").
/*
MESSAGE "0:" PROGRAM-NAME(0) SKIP
        "1:" PROGRAM-NAME(1) SKIP
        "2:" PROGRAM-NAME(2) SKIP
        "3:" PROGRAM-NAME(3) SKIP
        "4:" PROGRAM-NAME(4) SKIP
        "5:" PROGRAM-NAME(5) SKIP
        "6:" PROGRAM-NAME(6) SKIP
        "7:" PROGRAM-NAME(7) SKIP
        "8:" PROGRAM-NAME(8) SKIP
        "9:" PROGRAM-NAME(9) SKIP
         VIEW-AS ALERT-BOX MESSAGE TITLE "drsalida1.i".
*/
OUTPUT TO VALUE(arch_salida) PAGE-SIZE {1}. 
