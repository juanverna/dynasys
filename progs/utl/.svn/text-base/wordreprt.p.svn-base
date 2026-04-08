/* 
 * This sample extracts data from a Progress database
 * and graphs the information using the Automation Objects
 * from the Excel server in Office 95/97.
 * You must connect to a sports database before running this.
 * This sample program leaves Excel open.  You should close it manually
 * when the program completes.
 */

DEF TEMP-TABLE ttReprt
FIELD ttNombr AS CHAR
FIELD ttValr AS CHAR.

def input parameter table for ttReprt.

DEFINE VARIABLE chWordApplication      AS COM-HANDLE.
DEFINE VARIABLE chWorkDoc              AS COM-HANDLE.
def var cDirctr as char no-undo.
get-key-value section "Instalacion" key "Directorio" value cDirctr.

/* create a new Word Application object */
CREATE "Word.Application" chWordApplication.

/* launch Word so it is visible to the user */
chWordApplication:Visible = TRUE.

chWorkDoc = chWordApplication:Documents:Add(cDirctr + "\rpt\infpersn").

for each ttReprt:
chWorkDoc:Range():Find:Execute ( 
	  '<' + ttNombr + '>',
	  false,
	  false,
	  false,
	  false,
	  false,
	  true,
	  0,
	  false,
	  ttValr).
chWorkDoc:Range():Find:Execute().
end.


/* release com-handles */
RELEASE OBJECT chWordApplication.      

