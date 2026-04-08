&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r2
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Method-Library 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
/*-------------------------------------------------------------------------
    File        : viewer.i  
    Purpose     : Basic SmartViewer methods for the ADM
  
    Syntax      : {src/adm/method/viewer.i}

    Description :
  
    Author(s)   :
    Created     :
    Notes       :
    HISTORY: 
-------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

&IF DEFINED(adm-viewer) = 0 &THEN
&GLOBAL adm-viewer yes
/* Dialog program to run to set runtime attributes - if not defined in master */
&IF DEFINED(adm-attribute-dlg) = 0 &THEN
&SCOP adm-attribute-dlg src/adm/support/vortexd.w
&ENDIF

/* +++ This is the list of attributes whose values are to be returned
   by get-attribute-list, that is, those whose values are part of the
   definition of the object instance and should be passed to init-object
   by the UIB-generated code in adm-create-objects. */
&IF DEFINED(adm-attribute-list) = 0 &THEN
&SCOP adm-attribute-list Initial-Lock,Hide-on-Init,Disable-on-Init,Key-Name,~
Layout,Create-On-Add
&ENDIF

DEFINE TEMP-TABLE tt NO-UNDO LIKE vortex .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Method-Library
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: INCLUDE-ONLY
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Method-Library ASSIGN
         HEIGHT             = 6.86
         WIDTH              = 66.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Method-Library 
/* ************************* Included-Libraries *********************** */

{src/adm/method/smart.i}
{src/adm/method/record.i}
{src/adm/method/tableio.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Method-Library 


/* ***************************  Main Block  *************************** */

  /* Initialize attributes for update processing objects. */
  RUN set-attribute-list ('FIELDS-ENABLED=no,ADM-NEW-RECORD=no':U).

&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-archivar) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE archivar Method-Library 
PROCEDURE archivar :
/*Purpose:    este procedimiento tratara los archivos pasados en la lista
              como parametro para su almacenarlos en la base 
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER listarch AS CHAR NO-UNDO.


  DEF VAR i AS INT no-undo.

  DEF VAR rup AS LOGICAL NO-UNDO.
  DEF VAR vtipo AS CHAR NO-UNDO.
  DEF VAR vnombre AS CHAR FORMAT "X(50)" NO-UNDO.
  DEF VAR vaccion AS CHAR NO-UNDO.
  DEFINE var p-carpeta LIKE vortex.carpeta NO-UNDO.
  DEFINE VAR p-indice LIKE vortex.indice NO-UNDO.
  RUN getter( OUTPUT p-carpeta, OUTPUT p-indice ).
  FIND Usuario WHERE usuario.cdg_usuario = USERID("SIC") NO-LOCK.
  REPEAT i = 1 TO num-entries(listarch):
      FILE-INFO:FILE-NAME = entry(i,listarch).
      /*falta ver si son directorios los que se ingresaron*/
      vnombre = FILE-INFO:FILE-NAME.
      vnombre = REPLACE(vnombre,"/","\").
      vnombre = entry(NUM-ENTRIES(vnombre,"\") , vnombre ,"\" ).
      vtipo =   ENTRY(NUM-ENTRIES(vnombre,"."),vnombre,".").
      vnombre = REPLACE(vnombre,"." + vtipo,"").
      EMPTY TEMP-TABLE tt.           
      CREATE tt.
      FIND FIRST vortex WHERE vortex.nombre = vnombre NO-LOCK NO-error.
      IF AVAILABLE vortex THEN DO:
            BUFFER-COPY vortex EXCEPT vortex.archivo TO tt .
      END.
      ELSE
            ASSIGN tt.nombre = vnombre
                   tt.original = FILE-INFO:FILE-NAME
                   tt.tipo = vtipo
                   tt.nro_usuario = usuario.nro_usuario
                   tt.carpeta = p-carpeta
                   tt.indice = p-indice.

      RUN d-vortexq.w( INPUT-OUTPUT TABLE tt , AVAILABLE vortex , OUTPUT vaccion).
      FIND FIRST tt.
      IF vaccion = "G" THEN ASSIGN tt.fcreado = DATETIME(FILE-INFO:FILE-CREATE-DATE ,FILE-INFO:FILE-CREATE-TIME).
      IF vaccion = "V" /*versionar*/ THEN tt.Version = tt.VERSION + 1.
      IF vaccion = "G" OR vaccion = "V" THEN do: /*grabar o versionar*/
                              ASSIGN tt.fmodif = DATETIME(FILE-INFO:FILE-MOD-DATE, FILE-INFO:FILE-MOD-TIME) 
                                     tt.tamanio = FILE-INFO:FILE-SIZE.
                              CREATE vortex.
                              BUFFER-COPY tt EXCEPT tt.archivo TO vortex .
                              COPY-LOB FROM FILE FILE-INFO:FILE-NAME TO OBJECT vortex.archivo.
      END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

