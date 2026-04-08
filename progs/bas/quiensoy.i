DEFINE VARIABLE quien_soy AS CHARACTER.
quien_soy = PROGRAM-NAME(1).
quien_soy = SUBSTRING(quien_soy,1,INDEX(quien_soy,".") - 1).