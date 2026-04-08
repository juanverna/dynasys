DEF VARIABLE oSuccessful  AS LOGICAL NO-UNDO.
DEF VARIABLE vmessage  AS CHAR NO-UNDO.
/*
RUN  smtpmail53.p (                                   
    /*mailhub*/ "mail.dynasys.com.ar" ,               
    /*EmailTo*/ "fvergniaud@yahoo.com.ar" ,         
    /*EmailFrom*/  "fvergniaud@dynasys.com.ar"  ,           
    /*EmailCC*/ "" ,                                  
    /*Attachments*/ "" ,                              
    /*LocalFiles*/ "",                                
    /*subject*/"Probando el Sendmail" ,               
    /*body*/"este es el Body",                        
    /*MIMEHeader*/ "type=text/html:charset=us-ascii:filetype=ascii",                                
    /*BodyType*/ "",                                  
    OUTPUT  oSuccessful ,
    OUTPUT vmessage ).


*/
RUN smtpmailv5_7a.p (                                   
    /*mailhub*/ "smtp.mail.yahoo.com.ar" ,               
    /*EmailTo*/ "fvergniaud@dynasys.com.ar" ,         
    /*EmailFrom*/  "fvergniaud@yahoo.com.ar"  ,           
    /*EmailCC*/ "" ,                                  
    /*Attachments*/ "" ,                              
    /*LocalFiles*/ "",                                
    /*subject*/"Probando el Sendmail" ,               
    /*body*/"este es el Body",                        
    /*MIMEHeader*/ "",                                
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
