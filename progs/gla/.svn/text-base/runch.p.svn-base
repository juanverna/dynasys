
PROPATH=".,C:\Archivos de programa\Progress_91D\gui,C:\Archivos de programa\Progress_91D\gui\adecomm.pl,C:\Archivos de programa\Progress_91D\gui\adeicon.pl,C:\Archivos de programa\Progress_91D\gui\adeshar.pl,C:\Archivos de programa\Progress_91D\gui\protools.pl,C:\Archivos de programa\Progress_91D\gui\adedict.pl,C:\Archivos de programa\Progress_91D\gui\prodict.pl,C:\Archivos de programa\Progress_91D\gui\adeuib.pl,C:\Archivos de programa\Progress_91D\gui\adexml.pl,C:\Archivos de programa\Progress_91D\gui\adeweb.pl,C:\Archivos de programa\Progress_91D\gui\adeedit.pl,C:\Archivos de programa\Progress_91D\gui\adedesk.pl,C:\Archivos de programa\Progress_91D\gui\adecomp.pl,C:\Archivos de programa\Progress_91D\gui\aderes.pl,C:\Archivos de programa\Progress_91D\gui\as4dict.pl,C:\Archivos de programa\Progress_91D,C:\Archivos de programa\Progress_91D\bin,C:\Archivos de programa\Progress_91D\PROBUILD\EUCAPP\EUC.PL,C:\Archivos de programa\Progress_91D\PROBUILD\EUCAPP,.\seg,.\bas,.\bdu,.\utl,.\afi,.\dsp,.\prd,.\inv,.\gla,.\tes,.\adp,.\cxp,.\fac,.\com,.\cxc,.\aba,.\exp,.\imp,.\cps,.\cpy,..\procs,..\imagenes".
IF NOT CONNECTED("sic")
   THEN connect dynasys35 -ld sic -H milenium -N tcp -S dynasys35.

COMPILE chegreso.w save.
COMPILE chlogon.w SAVE.
def var lok as logical.
DEF VAR xx AS INTEGER.
/*lok = SETUSERID("carlos","carlitos","sic").*/
RUN chlogon.w ( OUTPUT lok, OUTPUT XX ).
RUN chegreso.w
