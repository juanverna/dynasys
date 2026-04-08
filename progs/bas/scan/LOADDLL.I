/* You can have to modify this to get the Windows directory */

&SCOP   PATH    ".,C:/windows,c:/windows/system"      
&SCOP   I       I-{&SEQUENCE}

Def var p_{&DLL}            as Char no-UNDO.     
Def var {&I}                as Int  no-UNDO.

   DO {&I} = 1  to num-entries( {&PATH} ) :
           p_{&DLL} = Search( Entry({&I}, {&PATH}) + "/{&DLL}.dll").
           If p_{&DLL} <> ? then
                            leave.
           end.

   
   If p_{&DLL} = ? then do :
           Message "{&DLL}.dll is not found..."
                   view-as alert-box information.
           QUIT.
           end.
