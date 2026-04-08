USING ThoughtWorks.QRCode.Codec.*.
USING System.Drawing.*.
 
DEFINE VARIABLE oEncoder AS ThoughtWorks.QRCode.Codec.QRCodeEncoder NO-UNDO.
DEFINE VARIABLE oImage  AS System.Drawing.Image  NO-UNDO.
 
oEncoder = NEW QRCodeEncoder().
oEncoder:QRCodeVersion = 7.
oEncoder:QRCodeErrorCorrect = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ERROR_CORRECTION:L.
oEncoder:qrcodeEncodeMode = ThoughtWorks.QRCode.Codec.QRCodeEncoder+ENCODE_MODE:byte.

oImage = oEncoder:Encode("http://www.dghpsh.agcontrol.gob.ar/EDA/Mobile/CEDyT/GetOblea/MjQ3MzU=").
DELETE OBJECT oEncoder.
oImage:Save("c:\temp\oblea.gif",System.Drawing.Imaging.ImageFormat:Gif).
