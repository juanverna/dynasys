DEF VARIABLE oSuccessful  AS LOGICAL NO-UNDO.
DEF VARIABLE vmessage  AS CHAR NO-UNDO.

RUN smtpmailv5_7a.p (                                   
    /*mailhub*/ "smtp.mail.yahoo.com.ar" ,               
    /*EmailTo*/ "fvergniaud@dynasys.com.ar" ,         
    /*EmailFrom*/  "soporte@dynasys.com.ar"  ,           
    /*EmailCC*/ "" ,                                  
    /*Attachments*/ "procedimiento.pdf:type=application/notepad:filetype=binary" ,                              
    /*LocalFiles*/ "c:\mail\procedimiento.pdf",                                
    /*subject*/"Mail de Prueba de soporte con PDF" ,               
    /*body*/"Esto es solo un email de prueba",                        
    /*MIMEHeader*/ "multipart/related",                                
    /*BodyType*/ "",                                  
    /*Importance*/ 2,                                 
    /*L_DoAUTH*/ YES,                                
    /*C_AuthType*/ "base64",                                
    /*C_User*/ "fvergniaud",           
    /*C_Password*/ "alcaudon",                        
    OUTPUT  oSuccessful ,
    OUTPUT vmessage ).


MESSAGE oSuccessful SKIP vmessage VIEW-AS ALERT-BOX ERROR.
/*
ocal file : path and file name
Attachement : <nom fichier>:type=application/notepad:filetype=binary
mime : multipart/related
*/
