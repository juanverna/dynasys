'  XDefs translation of \EZTwain\VC\eztwain.h
Imports System
Imports System.Runtime.InteropServices

Friend Class EZTwain

    Public Shared Function DibToImage(ByVal hdib As System.IntPtr) As Image
        Dim data(EZTwain.DIB_Size(hdib) + 100) As Byte
        EZTwain.DIB_WriteToBuffer(hdib, EZTwain.TWFF_BMP, data(0), data.Length)
        Dim s As New System.IO.MemoryStream(data, False)
        Dim bm As Bitmap = Bitmap.FromStream(s)
        DibToImage = bm.Clone
        bm.Dispose()
    End Function

' EZTWAIN.H - interface to Easy TWAIN library
' (DLL=eztw32.dll)
'
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
'                         FreeNative, SetHideUI, GetHideUI, SetCurrentUnits,
'                         GetCurrentUnits, SetCurrentResolution, SetBitDepth,
'                         SetCurrentPixelType, SetCapOneValue.
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

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_AcquireNative")> _
        Public Shared Function AcquireNative(ByVal hwndApp As IntPtr, ByVal wPixTypes As Int32) As IntPtr
        End Function
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

        Friend Const TWAIN_BW = &H1
        Friend Const TWAIN_GRAY = &H2
        Friend Const TWAIN_RGB = &H4
        Friend Const TWAIN_PALETTE = &H8
        Friend Const TWAIN_ANYTYPE = &H0

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_FreeNative")> _
        Public Shared Sub FreeNative(ByVal hdib As IntPtr)
        End Sub
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

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_AcquireToClipboard")> _
        Public Shared Function AcquireToClipboard(ByVal hwndApp As IntPtr, ByVal wPixTypes As Int32) As Int32
        End Function
' Like AcquireNative, but puts the resulting image, if any, into the system
' clipboard.  Under Windows, this will put a CF_DIB item in the clipboard
' if successful.  If this call fails, the clipboard is either empty or
' contains the old contents.
' A return value of 1 indicates success, 0 indicates failure.
'
' Useful for environments like Visual Basic where it is hard to make direct
' use of a DIB handle.  In fact, TWAIN_AcquireToClipboard uses
' TWAIN_AcquireNative for all the hard work.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_AcquireToFilename")> _
        Public Shared Function AcquireToFilename(ByVal hwndApp As IntPtr, ByVal sFile As String) As Int32
        End Function
' Acquire an image and write it to a .BMP (Windows Bitmap) file.
' The file name and path in pszFile are used.  If pszFile is NULL or
' points to an empty string, the user is prompted with a Save File dialog.
' Return values:
' 0 success
' -1 Acquire failed OR user cancelled File Save dialog
' -2 file open error (invalid path or name, or access denied)
' -3 (weird) unable to lock DIB - probably an invalid handle.
' -4 writing BMP data failed, possibly output device is full

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SelectImageSource")> _
        Public Shared Function SelectImageSource(ByVal hwnd As IntPtr) As Int32
        End Function
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

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_IsAvailable")> _
        Public Shared Function IsAvailable() As Int32
        End Function
' Call this function any time to find out if TWAIN is installed on the
' system.  It takes a little time on the first call, after that it's fast,
' just testing a flag.  It returns 1 if the TWAIN Source Manager is
' installed & can be loaded, 0 otherwise. 


        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_EasyVersion")> _
        Public Shared Function EasyVersion() As Int32
        End Function
' Returns the version number of EZTWAIN.DLL, multiplied by 100.
' So e.g. version 2.01 will return 201 from this call.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_State")> _
        Public Shared Function State() As Int32
        End Function
' Returns the TWAIN Protocol State per the spec.
        Friend Const TWAIN_PRESESSION = 1
        Friend Const TWAIN_SM_LOADED = 2
        Friend Const TWAIN_SM_OPEN = 3
        Friend Const TWAIN_SOURCE_OPEN = 4
        Friend Const TWAIN_SOURCE_ENABLED = 5
        Friend Const TWAIN_TRANSFER_READY = 6
        Friend Const TWAIN_TRANSFERRING = 7

'--------- DIB handling utilities ---------

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DibDepth")> _
        Public Shared Function DibDepth(ByVal hdib As IntPtr) As Int32
        End Function
' Depth of DIB, in bits i.e. bits per pixel.
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DibWidth")> _
        Public Shared Function DibWidth(ByVal hdib As IntPtr) As Int32
        End Function
' Width of DIB, in pixels (columns)
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DibHeight")> _
        Public Shared Function DibHeight(ByVal hdib As IntPtr) As Int32
        End Function
' Height of DIB, in lines (rows)
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DibNumColors")> _
        Public Shared Function DibNumColors(ByVal hdib As IntPtr) As Int32
        End Function
' Number of colors in color table of DIB

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_RowSize")> _
        Public Shared Function RowSize(ByVal hdib As IntPtr) As Int32
        End Function

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_ReadRow")> _
        Public Shared Sub ReadRow(ByVal hdib As IntPtr, ByVal nRow As Int32, ByRef prow As System.Byte)
        End Sub
' Read row n of the given DIB into buffer at prow.
' Caller is responsible for ensuring buffer is large enough.
' Row 0 is the *top* row of the image, as it would be displayed.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_CreateDibPalette")> _
        Public Shared Function CreateDibPalette(ByVal hdib As IntPtr) As IntPtr
        End Function
' Create and return a logical palette to be used for drawing the DIB.
' For 1, 4, and 8-bit DIBs the palette contains the DIB color table.
' For 24-bit DIBs, a default halftone palette is returned.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DrawDibToDC")> _
        Public Shared Sub DrawDibToDC(ByVal hDC As IntPtr, ByVal dx As Int32, ByVal dy As Int32, ByVal w As Int32, ByVal h As Int32, ByVal hdib As IntPtr, ByVal sx As Int32, ByVal sy As Int32)
        End Sub
' Draws a DIB on a device context.
' You should call CreateDibPalette, select that palette
' into the DC, and do a RealizePalette(hDC) first.

'--------- BMP file utilities
 
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_WriteNativeToFilename")> _
        Public Shared Function WriteNativeToFilename(ByVal hdib As IntPtr, ByVal sFile As String) As Int32
        End Function
' Writes a DIB handle to a .BMP file
'
' hdib      = DIB handle, as returned by TWAIN_AcquireNative
' pszFile   = far pointer to NUL-terminated filename
' If pszFile is NULL or points to a null string, prompts the user
' for the filename with a standard file-save dialog.
'
' Return values:
'    0  success
'   -1  user cancelled File Save dialog
'   -2  file open error (invalid path or name, or access denied)
'   -3  (weird) unable to lock DIB - probably an invalid handle.
'   -4  writing BMP data failed, possibly output device is full

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_WriteNativeToFile")> _
        Public Shared Function WriteNativeToFile(ByVal hdib As IntPtr, ByVal fh As IntPtr) As Int32
        End Function
' Writes a DIB to a file in .BMP format.
'
' hdib      = DIB handle, as returned by TWAIN_AcquireNative
' fh        = file handle, as returned by _open, _lopen or OpenFile
'
' Return value as for TWAIN_WriteNativeToFilename

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_LoadNativeFromFilename")> _
        Public Shared Function LoadNativeFromFilename(ByVal sFile As String) As IntPtr
        End Function
' Load a .BMP file and return a DIB handle (as from AcquireNative.)
' Accepts a filename (including path & extension).
' If pszFile is NULL or points to a null string, the user is prompted.
' Returns a DIB handle if successful, otherwise NULL.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_LoadNativeFromFile")> _
        Public Shared Function LoadNativeFromFile(ByVal fh As IntPtr) As IntPtr
        End Function
' Like LoadNativeFromFilename, but takes an already open file handle.


        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetHideUI")> _
        Public Shared Sub SetHideUI(ByVal fHide As Int32)
        End Sub
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetHideUI")> _
        Public Shared Function GetHideUI() As Int32
        End Function
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

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_RegisterApp")> _
        Public Shared Sub RegisterApp(ByVal nMajorNum As Int32, ByVal nMinorNum As Int32, ByVal nLanguage As Int32, ByVal nCountry As Int32, ByVal lpszVersion As System.Text.StringBuilder, ByVal lpszMfg As System.Text.StringBuilder, ByVal lpszFamily As System.Text.S'
' TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the
' application. If this function is not called, the application is given a
' 'generic' registration by EZTWAIN.
' Registration only provides this information to the Source Manager and any
' sources you may open - it is used for debugging, and (frankly) by some
' sources to give special treatment to certain applications.

'--------- Error Analysis and Reporting ------------------------------------

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetResultCode")> _
        Public Shared Function GetResultCode() As Int32
        End Function
' Return the result code (TWRC_xxx) from the last triplet sent to TWAIN

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetConditionCode")> _
        Public Shared Function GetConditionCode() As Int32
        End Function
' Return the condition code from the last triplet sent to TWAIN.
' (To be precise, from the last call to TWAIN_DS below)
' If a source is NOT open, return the condition code of the source manager.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_ErrorBox")> _
        Public Shared Sub ErrorBox(ByVal sMsg As String)
        End Sub
' Post an error message dialog with an exclamation mark, OK button,
' and the title 'TWAIN Error'.
' pszMsg points to a null-terminated message string.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_ReportLastError")> _
        Public Shared Sub ReportLastError(ByVal sMsg As String)
        End Sub
' Like TWAIN_ErrorBox, but if some details are available from
' TWAIN about the last failure, they are included in the message box.


'--------- TWAIN State Control ------------------------------------

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_LoadSourceManager")> _
        Public Shared Function LoadSourceManager() As Int32
        End Function
' Finds and loads the Data Source Manager, TWAIN.DLL.
' If Source Manager is already loaded, does nothing and returns TRUE.
' This can fail if TWAIN.DLL is not installed (in the right place), or
' if the library cannot load for some reason (insufficient memory?) or
' if TWAIN.DLL has been corrupted.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_OpenSourceManager")> _
        Public Shared Function OpenSourceManager(ByVal hwnd As IntPtr) As Int32
        End Function
' Opens the Data Source Manager, if not already open.
' If the Source Manager is already open, does nothing and returns TRUE.
' This call will fail if the Source Manager is not loaded.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_OpenDefaultSource")> _
        Public Shared Function OpenDefaultSource() As Int32
        End Function
' This opens the source selected in the Select Source dialog.
' If a source is already open, does nothing and returns TRUE.
' Fails if the source manager is not loaded and open.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_EnableSource")> _
        Public Shared Function EnableSource(ByVal hwnd As IntPtr) As Int32
        End Function
' Enables the open Data Source. This posts the source's user interface
' and allows image acquisition to begin.  If the source is already enabled,
' this call does nothing and returns TRUE.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DisableSource")> _
        Public Shared Function DisableSource() As Int32
        End Function
' Disables the open Data Source, if any.
' This closes the source's user interface.
' If there is not an enabled source, does nothing and returns TRUE.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_CloseSource")> _
        Public Shared Function CloseSource() As Int32
        End Function
' Closes the open Data Source, if any.
' If the source is enabled, disables it first.
' If there is not an open source, does nothing and returns TRUE.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_CloseSourceManager")> _
        Public Shared Function CloseSourceManager(ByVal hwnd As IntPtr) As Int32
        End Function
' Closes the Data Source Manager, if it is open.
' If a source is open, disables and closes it as needed.
' If the Source Manager is not open, does nothing and returns TRUE.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_UnloadSourceManager")> _
        Public Shared Function UnloadSourceManager() As Int32
        End Function
' Unloads the Data Source Manager i.e. TWAIN.DLL - releasing
' any associated memory or resources.
' This call will fail if the Source Manager is open, otherwise
' it always succeeds and returns TRUE.



        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_WaitForNativeXfer")> _
        Public Shared Function WaitForNativeXfer(ByVal hwnd As IntPtr) As IntPtr
        End Function

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_ModalEventLoop")> _
        Public Shared Sub ModalEventLoop()
        End Sub
' Process messages until termination, source disable, or image transfer.


        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_EndXfer")> _
        Public Shared Function EndXfer() As Int32
        End Function

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_AbortAllPendingXfers")> _
        Public Shared Function AbortAllPendingXfers() As Int32
        End Function


'--------- High-level Capability Negotiation Functions --------

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_NegotiateXferCount")> _
        Public Shared Function NegotiateXferCount(ByVal nXfers As Int32) As Int32
        End Function
' Negotiate with open Source the number of images application will accept.
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' nXfers = -1 means any number

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_NegotiatePixelTypes")> _
        Public Shared Function NegotiatePixelTypes(ByVal wPixTypes As Int32) As Int32
        End Function
' Negotiate with the source to restrict pixel types that can be acquired.
' This tries to restrict the source to a *set* of pixel types,
' See TWAIN_AcquireNative above for some mask constants.
' --> This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' A parameter of 0 (TWAIN_ANYTYPE) causes no negotiation & no restriction.
' You should not assume that the source will honor your restrictions, even
' if this call succeeds!

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetCurrentUnits")> _
        Public Shared Function GetCurrentUnits() As Int32
        End Function
' Ask the source what its current unit of measure is.
' If anything goes wrong, this function just returns TWUN_INCHES (0).

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetCurrentUnits")> _
        Public Shared Function SetCurrentUnits(ByVal nUnits As Int32) As Int32
        End Function
' Set the current unit of measure for the source.
' Unit of measure codes are in TWAIN.H, but TWUN_INCHES is 0.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetBitDepth")> _
        Public Shared Function GetBitDepth() As Int32
        End Function
' Get the current bitdepth, which can depend on the current PixelType.
' Bit depth is per color channel e.g. 24-bit RGB has bit depth 8.
' If anything goes wrong, this function returns 0.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetBitDepth")> _
        Public Shared Function SetBitDepth(ByVal nBits As Int32) As Int32
        End Function
' (Try to) set the current bitdepth (for the current pixel type).

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetPixelType")> _
        Public Shared Function GetPixelType() As Int32
        End Function
' Ask the source for the current pixel type.
' If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW).

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetCurrentPixelType")> _
        Public Shared Function SetCurrentPixelType(ByVal nPixType As Int32) As Int32
        End Function
' (Try to) set the current pixel type for acquisition.
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' The source may select this pixel type, but don't assume it will.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetCurrentResolution")> _
        Public Shared Function GetCurrentResolution() As Double
        End Function
' Ask the source for the current (horizontal) resolution.
' Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
' If anything goes wrong (it shouldn't) this function returns 0.0

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetYResolution")> _
        Public Shared Function GetYResolution() As Double
        End Function
' Returns the current vertical resolution, in dots per *current unit*.
' In the event of failure, returns 0.0.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetCurrentResolution")> _
        Public Shared Function SetCurrentResolution(ByVal dRes As Double) As Int32
        End Function
' (Try to) set the current resolution for acquisition.
' Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
' This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
' Note: The source may select this resolution, but don't assume it will.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetContrast")> _
        Public Shared Function SetContrast(ByVal dCon As Double) As Int32
        End Function
' (Try to) set the current contrast for acquisition.
' The TWAIN standard says that the range for this cap is -1000 ... +1000

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetBrightness")> _
        Public Shared Function SetBrightness(ByVal dBri As Double) As Int32
        End Function
' (Try to) set the current brightness for acquisition.
' The TWAIN standard says that the range for this cap is -1000 ... +1000

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetXferMech")> _
        Public Shared Function SetXferMech(ByVal mech As Int32) As Int32
        End Function
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_XferMech")> _
        Public Shared Function XferMech() As Int32
        End Function
' (Try to) set or get the transfer mode - one of the following:
        Friend Const XFERMECH_NATIVE = 0
        Friend Const XFERMECH_FILE = 1
        Friend Const XFERMECH_MEMORY = 2

'--------- Low-level Capability Negotiation Functions --------

' Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN)
' Getting a capability is valid in State 4 or any higher state.
 
        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_SetCapOneValue")> _
        Public Shared Function SetCapOneValue(ByVal Cap As Int32, ByVal ItemType As Int32, ByVal ItemVal As Int32) As Int32
        End Function
' Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE,
' CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type
' and value.  The item value must fit into 32 bits.
' Returns TRUE (1) if successful, FALSE (0) otherwise.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_GetCapCurrent")> _
        Public Shared Function GetCapCurrent(ByVal Cap As Int32, ByVal ItemType As Int32, ByVal pVal As IntPtr) As Int32
        End Function
' Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'.
' Copy the current value out of the returned container into *pVal.
' If the operation fails (the source refuses the request), or if the
' container is not a ONEVALUE or ENUMERATION, or if the item type of the
' returned container is incompatible with the expected TWTY_ type in nType,
' returns FALSE.  If this function returns FALSE, *pVal is not touched.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_ToFix32")> _
        Public Shared Function ToFix32(ByVal d As Double) As Int32
        End Function
' Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed
' to e.g. TWAIN_SetCapOneValue

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_Fix32ToFloat")> _
        Public Shared Function Fix32ToFloat(ByVal nfix As Int32) As Double
        End Function
' Convert a TW_FIX32 value (as returned from some capability inquiries)
' to a double (floating point) value.

'--------- Lowest-level functions for TWAIN protocol --------


        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_DS")> _
        Public Shared Function DS(ByVal DG As Int32, ByVal DAT As Int32, ByVal MSG As Int32, ByVal pData As IntPtr) As Int32
        End Function
' Passes the triplet (DG, DAT, MSG, pData) to the open data source if any.
' Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
' The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
' condition code can be retrieved with TWAIN_GetConditionCode().
' If no source is open this call will fail, result code TWRC_FAILURE, condition code TWCC_NODS.

        <DllImport("eztw32.dll", CharSet:=CharSet.Ansi, ExactSpelling:=True, SetLastError:=False, EntryPoint:="TWAIN_Mgr")> _
        Public Shared Function Mgr(ByVal DG As Int32, ByVal DAT As Int32, ByVal MSG As Int32, ByVal pData As IntPtr) As Int32
        End Function
' Passes a triplet to the Data Source Manager (DSM).
' Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
' The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
' condition code can be retrieved with TWAIN_GetConditionCode().
' If the Source Manager is not open, this call will fail, and set the result code to TWRC_FAILURE,
' with a condition code of TWCC_SEQERROR (triplet out of sequence).




End Class
