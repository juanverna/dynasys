'
' EZTwain
'
' EZTwain for PowerBasic
' XDefs translation of \EZTwain\VC\Eztwain.h
' Thanks to:
'   Carlo Pagani for pioneering.
'   Peter De Wilde for inspiration.
'   John Gibson for motivation.
'   Michael Mattias for clarification.
'
'-----------------------------------------------------------------
'
#if not %def(%EZTWAIN_BAS)
%EZTWAIN_BAS = 1
#include "win32api.inc"
'
' EZTWAIN.H - interface to Easy TWAIN library
'
' 1.18		2008.07.10 Fix: DIB_ReadRow and DIB_RowBytes exported.
' 1.17		2008.02.27 Fix: Handle TWRC_CANCEL returned from MSG_ENABLEDS by some drivers.
'						(Fix contributed by forum member lpringle!)
' 1.16          2007.03.14 Fix: In TWAIN_CloseSourceManager, don't make unnecessary calls.
' 1.15     2006.05.09 Fix: If user closed the scan dialog during an Acquire,
'                     the last DIB handle, if any, was returned!
'                     Added VB\Eztwain.bas to package.
' 1.14     2004.08.06 Set XFERMECH=NATIVE as soon as DS is opened.
'                     trying to deal with scanners that default to memory xfer.
' 1.13     1999.09.08 Documented correct return codes of AcquireToFilename.
'                     - No code changes -
' 1.12     1998.09.14 Added Fix32ToFloat, allow MSG_OPENDS triplet.
'                     Added SetXferMech, XferMech.
' 1.11     1998.08.17 Added ToFix32, SetContrast, SetBrightness.
'                     Modified TWAIN_ToFix32 to round away-from-zero.
' 1.09beta 1998.07.27 Reverted from 1.08 to 1.06 and worked forward again.
' 1.06     1997.08.21 correction to message hook, fixed 32-bit exports
' 1.05     1996.11.06 32-bit conversion
' 1.04     1995.05.03 added: WriteNativeToFile, WriteNativeToFilename,
'                                             FreeNative, SetHideUI, GetHideUI, SetCurrentUnits,
'                                             GetCurrentUnits, SetCurrentResolution, SetBitDepth,
'                                             SetCurrentPixelType, SetCapOneValue.
' 1.0a      1994.06.23 first alpha version
' 0.0      1994.05.11 created
'
' EZTWAIN 1.x is not a product, and is not the work of any company involved
' in promoting or using the TWAIN standard.  This code is sample code,
' provided without charge, and you use it entirely at your own risk.
' No rights or ownership is claimed by the author, or by any company
' or organization.  There are no restrictions on use or (re)distribution.
'
' Download from:    www.dosadi.com
'
' Support contact:  support@dosadi.com
'




        
'--------- Basic calls

Declare Function TWAIN_AcquireNative Lib "Eztwain3.dll" Alias "TWAIN_AcquireNative" _
      (ByVal hwndApp As Long, ByVal wPixTypes As Long) As Long
' The minimal use of EZTWAIN.DLL is to just call this routine, with 0 for
' both params.  EZTWAIN creates a window if hwndApp is 0.
'
' Acquires a single image, from the currently selected Data Source, using
' Native-mode transfer. It waits until the source closes (if it's modal) or
' forces the source closed if not.  The return value is a handle to the
' acquired image.  Only one image can be acquired per call.
'
' Under Windows, the return value is a global memory handle - applying
' GlobalLock to it will return a (huge) pointer to the DIB, which
' starts with a BITMAPINFOHEADER.
' NOTE: You are responsible for disposing of the returned DIB - these things
' can eat up your Windows memory fast!  See TWAIN_FreeNative below.
'
' The image type can be restricted using the following masks.  A mask of 0
' means 'any pixel type is welcome'.
' Caution: You should not assume that the source will honor a pixel type
' restriction!  If you care, check the parameters of the DIB.

%TWAIN_BW = 1
%TWAIN_GRAY = 2
%TWAIN_RGB = 4
%TWAIN_PALETTE = 8
%TWAIN_ANYTYPE = 0

Declare Sub TWAIN_FreeNative Lib "Eztwain3.dll" Alias "TWAIN_FreeNative" _
      (ByVal hdib As Long)
' Release the memory allocated to a native format image, as returned by
' TWAIN_AcquireNative. (If you are coding in C or C++, this is just a call
' to GlobalFree.)
' If you use TWAIN_AcquireNative and don't free the returned image handle,
' it stays around taking up Windows (virtual) memory until your application
' terminates.  Memory required per square inch:
'             1 bit B&W       8-bit grayscale     24-bit color
' 100 dpi      1.25KB              10KB               30KB
' 200 dpi        5KB               40KB              120KB
' 300 dpi      11.25KB             90KB              270KB
' 400 dpi       20KB              160KB              480KB
'

Declare Function TWAIN_AcquireToClipboard Lib "Eztwain3.dll" Alias "TWAIN_AcquireToClipboard" _
      (ByVal hwndApp As Long, ByVal wPixTypes As Long) As Long
' Like AcquireNative, but puts the resulting image, if any, into the system
' clipboard.  Under Windows, this will put a CF_DIB item in the clipboard
' if successful.  If this call fails, the clipboard is either empty or
' contains the old contents.
' A return value of 1 indicates success, 0 indicates failure.
'
' Useful for environments like Visual Basic where it is hard to make direct
' use of a DIB handle.  In fact, TWAIN_AcquireToClipboard uses
' TWAIN_AcquireNative for all the hard work.

Declare Function TWAIN_AcquireToFilename Lib "Eztwain3.dll" Alias "TWAIN_AcquireToFilename" _
      (ByVal hwndApp As Long, sFile As Asciiz) As Long
' Acquire an image and write it to a .BMP (Windows Bitmap) file.
' The file name and path in pszFile are used.  If pszFile is NULL or
' points to an empty string, the user is prompted with a Save File dialog.
' Return values:
' 0 success
' -1 Acquire failed OR user cancelled File Save dialog
' -2 file open error (invalid path or name, or access denied)
' -3 (weird) unable to lock DIB - probably an invalid handle.
' -4 writing BMP data failed, possibly output device is full

Declare Function TWAIN_SelectImageSource Lib "Eztwain3.dll" Alias "TWAIN_SelectImageSource" _
      (ByVal hwnd As Long) As Long
' This is the routine to call when the user chooses the "Select Source..."
' menu command from your application's File menu.  Your app has one of
' these, right?  The TWAIN spec calls for this feature to be available in
' your user interface, preferably as described.
' Note: If only one TWAIN device is installed on a system, it is selected
' automatically, so there is no need for the user to do Select Source.
' You should not require your users to do Select Source before Acquire.
'
' This function posts the Source Manager's Select Source dialog box.
' It returns after the user either OK's or CANCEL's that dialog.
' A return of 1 indicates OK, 0 indicates one of the following:
'   a) The user cancelled the dialog
'   b) The Source Manager found no data sources installed
'   c) There was a failure before the Select Source dialog could be posted
' -- details --
' Only sources that can return images (that are in the DG_IMAGE group) are
' displayed.  The current default source will be highlighted initially.
' In the standard implementation of "Select Source...", your application
' doesn't need to do anything except make this one call.
'
' If you want to be meticulous, disable your "Acquire" and "Select Source"
' menu items or buttons if TWAIN_IsAvailable() returns 0 - see below.


'--------- Basic TWAIN Inquiries

Declare Function TWAIN_IsAvailable Lib "Eztwain3.dll" Alias "TWAIN_IsAvailable" () As Long
' Call this function any time to find out if TWAIN is installed on the
' system.  It takes a little time on the first call, after that it's fast,
' just testing a flag.  It returns 1 if the TWAIN Source Manager is
' installed & can be loaded, 0 otherwise. 


Declare Function TWAIN_EasyVersion Lib "Eztwain3.dll" Alias "TWAIN_EasyVersion" () As Long
' Returns the version number of EZTWAIN.DLL, multiplied by 100.
' So e.g. version 2.01 will return 201 from this call.

Declare Function TWAIN_State Lib "Eztwain3.dll" Alias "TWAIN_State" () As Long
' Returns the TWAIN Protocol State per the spec.
%TWAIN_PRESESSION = 1
%TWAIN_SM_LOADED = 2
%TWAIN_SM_OPEN = 3
%TWAIN_SOURCE_OPEN = 4
%TWAIN_SOURCE_ENABLED = 5
%TWAIN_TRANSFER_READY = 6
%TWAIN_TRANSFERRING = 7

'--------- DIB handling utilities ---------

Declare Function TWAIN_DibDepth Lib "Eztwain3.dll" Alias "TWAIN_DibDepth" _
      (ByVal hdib As Long) As Long
' Depth of DIB, in bits i.e. bits per pixel.
Declare Function TWAIN_DibWidth Lib "Eztwain3.dll" Alias "TWAIN_DibWidth" _
      (ByVal hdib As Long) As Long
' Width of DIB, in pixels (columns)
Declare Function TWAIN_DibHeight Lib "Eztwain3.dll" Alias "TWAIN_DibHeight" _
      (ByVal hdib As Long) As Long
' Height of DIB, in lines (rows)
Declare Function TWAIN_DibNumColors Lib "Eztwain3.dll" Alias "TWAIN_DibNumColors" _
      (ByVal hdib As Long) As Long
' Number of colors in color table of DIB

Declare Function TWAIN_RowSize Lib "Eztwain3.dll" Alias "TWAIN_RowSize" _
      (ByVal hdib As Long) As Long

Declare Sub TWAIN_ReadRow Lib "Eztwain3.dll" Alias "TWAIN_ReadRow" _
      (ByVal hdib As Long, ByVal nRow As Long, ByRef prow As Any)
' Read row n of the given DIB into buffer at prow.
' Caller is responsible for ensuring buffer is large enough.
' Row 0 is the *top* row of the image, as it would be displayed.

Declare Function TWAIN_CreateDibPalette Lib "Eztwain3.dll" Alias "TWAIN_CreateDibPalette" _
      (ByVal hdib As Long) As Long
' Create and return a logical palette to be used for drawing the DIB.
' For 1, 4, and 8-bit DIBs the palette contains the DIB color table.
' For 24-bit DIBs, a default halftone palette is returned.

Declare Sub TWAIN_DrawDibToDC Lib "Eztwain3.dll" Alias "TWAIN_DrawDibToDC" _
      (ByVal hDC As Long, ByVal dx As Long, ByVal dy As Long, ByVal w As Long, ByVal h As Long, ByVal hdib As Long, ByVal sx As Long, ByVal sy As Long)
' Draws a DIB on a device context.
' You should call CreateDibPalette, select that palette
' into the DC, and do a RealizePalette(hDC) first.

'--------- BMP file utilities
 
Declare Function TWAIN_WriteNativeToFilename Lib "Eztwain3.dll" Alias "TWAIN_WriteNativeToFilename" _
      (ByVal hdib As Long, sFile As Asciiz) As Long
' Writes a DIB handle to a .BMP file
'
' hdib          = DIB handle, as returned by TWAIN_AcquireNative
' pszFile       = far pointer to NUL-terminated filename
' If pszFile is NULL or points to a null string, prompts the user
' for the filename with a standard file-save dialog.
'
' Return values:
'        0      success
'       -1      user cancelled File Save dialog
'       -2      file open error (invalid path or name, or access denied)
'       -3      (weird) unable to lock DIB - probably an invalid handle.
'       -4      writing BMP data failed, possibly output device is full

Declare Function TWAIN_WriteNativeToFile Lib "Eztwain3.dll" Alias "TWAIN_WriteNativeToFile" _
      (ByVal hdib As Long, ByVal fh As Long) As Long
' Writes a DIB to a file in .BMP format.
'
' hdib          = DIB handle, as returned by TWAIN_AcquireNative
' fh            = file handle, as returned by _open, _lopen or OpenFile
'
' Return value as for TWAIN_WriteNativeToFilename

Declare Function TWAIN_LoadNativeFromFilename Lib "Eztwain3.dll" Alias "TWAIN_LoadNativeFromFilename" _
      (sFile As Asciiz) As Long
' Load a .BMP file and return a DIB handle (as from AcquireNative.)
' Accepts a filename (including path & extension).
' If pszFile is NULL or points to a null string, the user is prompted.
' Returns a DIB handle if successful, otherwise NULL.

Declare Function TWAIN_LoadNativeFromFile Lib "Eztwain3.dll" Alias "TWAIN_LoadNativeFromFile" _
      (ByVal fh As Long) As Long
' Like LoadNativeFromFilename, but takes an already open file handle.


Declare Sub TWAIN_SetHideUI Lib "Eztwain3.dll" Alias "TWAIN_SetHideUI" _
      (ByVal fHide As Long)
Declare Function TWAIN_GetHideUI Lib "Eztwain3.dll" Alias "TWAIN_GetHideUI" () As Long
' These functions control the 'hide source user interface' flag.
' This flag is cleared initially, but if you set it non-zero, then when
' a source is enabled it will be asked to hide its user interface.
' Note that this is only a request - some sources will ignore it!
' This affects AcquireNative, AcquireToClipboard, and EnableSource.
' If the user interface is hidden, you will probably want to set at least
' some of the basic acquisition parameters yourself - see
' SetCurrentUnits, SetBitDepth, SetCurrentPixelType and
' SetCurrentResolution below.

'--------- Application Registration

Declare Sub TWAIN_RegisterApp Lib "Eztwain3.dll" Alias "TWAIN_RegisterApp" _
      (ByVal nMajorNum As Long, ByVal nMinorNum As Long, ByVal nLanguage As Long, ByVal nCountry As Long, lpszVersion As Asciiz, lpszMfg As Asciiz, lpszFamily As Asciiz, lpszProduct As Asciiz)
'
' TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the
' application. If this function is not called, the application is given a
' 'generic' registration by EZTWAIN.
' Registration only provides this information to the Source Manager and any
' sources you may open - it is used for debugging, and (frankly) by some
' sources to give special treatment to certain applications.

'--------- Error Analysis and Reporting ------------------------------------

Declare Function TWAIN_GetResultCode Lib "Eztwain3.dll" Alias "TWAIN_GetResultCode" () As Long
' Return the result code (TWRC_xxx) from the last triplet sent to TWAIN

Declare Function TWAIN_GetConditionCode Lib "Eztwain3.dll" Alias "TWAIN_GetConditionCode" () As Long
' Return the condition code from the last triplet sent to TWAIN.
' (To be precise, from the last call to TWAIN_DS below)
' If a source is NOT open, return the condition code of the source manager.

Declare Sub TWAIN_ErrorBox Lib "Eztwain3.dll" Alias "TWAIN_ErrorBox" _
      (sMsg As Asciiz)
' Post an error message dialog with an exclamation mark, OK button,
' and the title 'TWAIN Error'.
' pszMsg points to a null-terminated message string.

Declare Sub TWAIN_ReportLastError Lib "Eztwain3.dll" Alias "TWAIN_ReportLastError" _
      (sMsg As Asciiz)
' Like TWAIN_ErrorBox, but if some details are available from
' TWAIN about the last failure, they are included in the message box.


'--------- TWAIN State Control ------------------------------------

Declare Function TWAIN_LoadSourceManager Lib "Eztwain3.dll" Alias "TWAIN_LoadSourceManager" () As Long
' Finds and loads the Data Source Manager, TWAIN.DLL.
' If Source Manager is already loaded, does nothing and returns TRUE.
' This can fail if TWAIN.DLL is not installed (in the right place), or
' if the library cannot load for some reason (insufficient memory?) or
' if TWAIN.DLL has been corrupted.

Declare Function TWAIN_OpenSourceManager Lib "Eztwain3.dll" Alias "TWAIN_OpenSourceManager" _
      (ByVal hwnd As Long) As Long
' Opens the Data Source Manager, if not already open.
' If the Source Manager is already open, does nothing and returns TRUE.
' This call will fail if the Source Manager is not loaded.

Declare Function TWAIN_OpenDefaultSource Lib "Eztwain3.dll" Alias "TWAIN_OpenDefaultSource" () As Long
' This opens the source selected in the Select Source dialog.
' If a source is already open, does nothing and returns TRUE.
' Fails if the source manager is not loaded and open.

Declare Function TWAIN_EnableSource Lib "Eztwain3.dll" Alias "TWAIN_EnableSource" _
      (ByVal hwnd As Long) As Long
' Enables the open Data Source. This posts the source's user interface
' and allows image acquisition to begin.  If the source is already enabled,
' this call does nothing and returns TRUE.

Declare Function TWAIN_DisableSource Lib "Eztwain3.dll" Alias "TWAIN_DisableSource" () As Long
' Disables the open Data Source, if any.
' This closes the source's user interface.
' If there is not an enabled source, does nothing and returns TRUE.

Declare Function TWAIN_CloseSource Lib "Eztwain3.dll" Alias "TWAIN_CloseSource" () As Long
' Closes the open Data Source, if any.
' If the source is enabled, disables it first.
' If there is not an open source, does nothing and returns TRUE.

Declare Function TWAIN_CloseSourceManager Lib "Eztwain3.dll" Alias "TWAIN_CloseSourceManager" _
      (ByVal hwnd As Long) As Long
' Closes the Data Source Manager, if it is open.
' If a source is open, disables and closes it as needed.
' If the Source Manager is not open, does nothing and returns TRUE.

Declare Function TWAIN_UnloadSourceManager Lib "Eztwain3.dll" Alias "TWAIN_UnloadSourceManager" () As Long
' Unloads the Data Source Manager i.e. TWAIN.DLL - releasing
' any associated memory or resources.
' This call will fail if the Source Manager is open, otherwise
' it always succeeds and returns TRUE.



Declare Function TWAIN_WaitForNativeXfer Lib "Eztwain3.dll" Alias "TWAIN_WaitForNativeXfer" _
      (ByVal hwnd As Long) As Long

Declare Sub TWAIN_ModalEventLoop Lib "Eztwain3.dll" Alias "TWAIN_ModalEventLoop" ()
' Process messages until termination, source disable, or image transfer.


Declare Function TWAIN_EndXfer Lib "Eztwain3.dll" Alias "TWAIN_EndXfer" () As Long

Declare Function TWAIN_AbortAllPendingXfers Lib "Eztwain3.dll" Alias "TWAIN_AbortAllPendingXfers" () As Long


'--------- High-level Capability Negotiation Functions --------

Declare Function TWAIN_NegotiateXferCount Lib "Eztwain3.dll" Alias "TWAIN_NegotiateXferCount" _
      (ByVal nXfers As Long) As Long
' Negotiate with open Source the number of images application will accept.
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' nXfers = -1 means any number

Declare Function TWAIN_NegotiatePixelTypes Lib "Eztwain3.dll" Alias "TWAIN_NegotiatePixelTypes" _
      (ByVal wPixTypes As Long) As Long
' Negotiate with the source to restrict pixel types that can be acquired.
' This tries to restrict the source to a *set* of pixel types,
' See TWAIN_AcquireNative above for some mask constants.
' --> This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' A parameter of 0 (TWAIN_ANYTYPE) causes no negotiation & no restriction.
' You should not assume that the source will honor your restrictions, even
' if this call succeeds!

Declare Function TWAIN_GetCurrentUnits Lib "Eztwain3.dll" Alias "TWAIN_GetCurrentUnits" () As Long
' Ask the source what its current unit of measure is.
' If anything goes wrong, this function just returns TWUN_INCHES (0).

Declare Function TWAIN_SetCurrentUnits Lib "Eztwain3.dll" Alias "TWAIN_SetCurrentUnits" _
      (ByVal nUnits As Long) As Long
' Set the current unit of measure for the source.
' Unit of measure codes are in TWAIN.H, but TWUN_INCHES is 0.

Declare Function TWAIN_GetBitDepth Lib "Eztwain3.dll" Alias "TWAIN_GetBitDepth" () As Long
' Get the current bitdepth, which can depend on the current PixelType.
' Bit depth is per color channel e.g. 24-bit RGB has bit depth 8.
' If anything goes wrong, this function returns 0.

Declare Function TWAIN_SetBitDepth Lib "Eztwain3.dll" Alias "TWAIN_SetBitDepth" _
      (ByVal nBits As Long) As Long
' (Try to) set the current bitdepth (for the current pixel type).

Declare Function TWAIN_GetPixelType Lib "Eztwain3.dll" Alias "TWAIN_GetPixelType" () As Long
' Ask the source for the current pixel type.
' If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW).

Declare Function TWAIN_SetCurrentPixelType Lib "Eztwain3.dll" Alias "TWAIN_SetCurrentPixelType" _
      (ByVal nPixType As Long) As Long
' (Try to) set the current pixel type for acquisition.
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' The source may select this pixel type, but don't assume it will.

Declare Function TWAIN_GetCurrentResolution Lib "Eztwain3.dll" Alias "TWAIN_GetCurrentResolution" () As Double
' Ask the source for the current (horizontal) resolution.
' Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
' If anything goes wrong (it shouldn't) this function returns 0.0

Declare Function TWAIN_GetYResolution Lib "Eztwain3.dll" Alias "TWAIN_GetYResolution" () As Double
' Returns the current vertical resolution, in dots per *current unit*.
' In the event of failure, returns 0.0.

Declare Function TWAIN_SetCurrentResolution Lib "Eztwain3.dll" Alias "TWAIN_SetCurrentResolution" _
      (ByVal dRes As Double) As Long
' (Try to) set the current resolution for acquisition.
' Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' Note: The source may select this resolution, but don't assume it will.

Declare Function TWAIN_SetContrast Lib "Eztwain3.dll" Alias "TWAIN_SetContrast" _
      (ByVal dCon As Double) As Long
' (Try to) set the current contrast for acquisition.
' The TWAIN standard says that the range for this cap is -1000 ... +1000

Declare Function TWAIN_SetBrightness Lib "Eztwain3.dll" Alias "TWAIN_SetBrightness" _
      (ByVal dBri As Double) As Long
' (Try to) set the current brightness for acquisition.
' The TWAIN standard says that the range for this cap is -1000 ... +1000

Declare Function TWAIN_SetXferMech Lib "Eztwain3.dll" Alias "TWAIN_SetXferMech" _
      (ByVal mech As Long) As Long
Declare Function TWAIN_XferMech Lib "Eztwain3.dll" Alias "TWAIN_XferMech" () As Long
' (Try to) set or get the transfer mode - one of the following:
%XFERMECH_NATIVE = 0
%XFERMECH_FILE = 1
%XFERMECH_MEMORY = 2

'--------- Low-level Capability Negotiation Functions --------

' Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN)
' Getting a capability is valid in State 4 or any higher state.
 
Declare Function TWAIN_SetCapOneValue Lib "Eztwain3.dll" Alias "TWAIN_SetCapOneValue" _
      (ByVal Cap As Long, ByVal ItemType As Long, ByVal ItemVal As Long) As Long
' Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE,
' CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type
' and value.  The item value must fit into 32 bits.
' Returns TRUE (1) if successful, FALSE (0) otherwise.

Declare Function TWAIN_GetCapCurrent Lib "Eztwain3.dll" Alias "TWAIN_GetCapCurrent" _
      (ByVal Cap As Long, ByVal ItemType As Long, ByRef pVal As Any) As Long
' Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'.
' Copy the current value out of the returned container into *pVal.
' If the operation fails (the source refuses the request), or if the
' container is not a ONEVALUE or ENUMERATION, or if the item type of the
' returned container is incompatible with the expected TWTY_ type in nType,
' returns FALSE.  If this function returns FALSE, *pVal is not touched.

Declare Function TWAIN_ToFix32 Lib "Eztwain3.dll" Alias "TWAIN_ToFix32" _
      (ByVal d As Double) As Long
' Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed
' to e.g. TWAIN_SetCapOneValue

Declare Function TWAIN_Fix32ToFloat Lib "Eztwain3.dll" Alias "TWAIN_Fix32ToFloat" _
      (ByVal nfix As Long) As Double
' Convert a TW_FIX32 value (as returned from some capability inquiries)
' to a double (floating point) value.

'--------- Lowest-level functions for TWAIN protocol --------


Declare Function TWAIN_DS Lib "Eztwain3.dll" Alias "TWAIN_DS" _
      (ByVal DG As Long, ByVal DAT As Long, ByVal MSG As Long, ByRef pData As Any) As Long
' Passes the triplet (DG, DAT, MSG, pData) to the open data source if any.
' Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
' The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
' condition code can be retrieved with TWAIN_GetConditionCode().
' If no source is open this call will fail, result code TWRC_FAILURE, condition code TWCC_NODS.

Declare Function TWAIN_Mgr Lib "Eztwain3.dll" Alias "TWAIN_Mgr" _
      (ByVal DG As Long, ByVal DAT As Long, ByVal MSG As Long, ByRef pData As Any) As Long
' Passes a triplet to the Data Source Manager (DSM).
' Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
' The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
' condition code can be retrieved with TWAIN_GetConditionCode().
' If the Source Manager is not open, this call will fail, and set the result code to TWRC_FAILURE,
' with a condition code of TWCC_SEQERROR (triplet out of sequence).



#endif
