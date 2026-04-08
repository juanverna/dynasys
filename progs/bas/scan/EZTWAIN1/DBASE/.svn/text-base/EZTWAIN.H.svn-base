//
// EZTwain.h for dBASE
//
// XDefs translation of \EZTwain\VC\eztwain.h
//
// Remember to #include <WinDEF.h> (part of the dBASE install)
// in your program to bring in the Windows API data types.
//
//-----------------------------------------------------------------
//
//

#define HDIB         HANDLE
#define HCONTAINER   HANDLE

// EZTWAIN.H - interface to Easy TWAIN library
// (DLL=eztw32.dll)
//
// 1.15     2006.05.09 Fix: If user closed the scan dialog during an Acquire,
//                     the last DIB handle, if any, was returned!
//                     Added VB\Eztwain.bas to package.
// 1.14     2004.08.06 Set XFERMECH=NATIVE as soon as DS is opened.
//                     trying to deal with scanners that default to memory xfer.
// 1.13     1999.09.08 Documented correct return codes of AcquireToFilename.
//                     - No code changes -
// 1.12     1998.09.14 Added Fix32ToFloat, allow MSG_OPENDS triplet.
//                     Added SetXferMech, XferMech.
// 1.11     1998.08.17 Added ToFix32, SetContrast, SetBrightness.
//                     Modified TWAIN_ToFix32 to round away-from-zero.
// 1.09beta 1998.07.27 Reverted from 1.08 to 1.06 and worked forward again.
// 1.06     1997.08.21 correction to message hook, fixed 32-bit exports
// 1.05     1996.11.06 32-bit conversion
// 1.04     1995.05.03 added: WriteNativeToFile, WriteNativeToFilename,
//                        FreeNative, SetHideUI, GetHideUI, SetCurrentUnits,
//                        GetCurrentUnits, SetCurrentResolution, SetBitDepth,
//                        SetCurrentPixelType, SetCapOneValue.
// 1.0a     1994.06.23 first alpha version
// 0.0      1994.05.11 created
//
// EZTWAIN 1.x is not a product, and is not the work of any company involved
// in promoting or using the TWAIN standard.  This code is sample code,
// provided without charge, and you use it entirely at your own risk.
// No rights or ownership is claimed by the author, or by any company
// or organization.  There are no restrictions on use or (re)distribution.
//
// Download from:    www.dosadi.com
//
// Support contact:  support@dosadi.com
//




        
//--------- Basic calls

extern HANDLE TWAIN_AcquireNative(CHWND, CUINT) eztw32.dll from "TWAIN_AcquireNative"
// The minimal use of EZTWAIN.DLL is to just call this routine, with 0 for
// both params.  EZTWAIN creates a window if hwndApp is 0.
//
// Acquires a single image, from the currently selected Data Source, using
// Native-mode transfer. It waits until the source closes (if it's modal) or
// forces the source closed if not.  The return value is a handle to the
// acquired image.  Only one image can be acquired per call.
//
// Under Windows, the return value is a global memory handle - applying
// GlobalLock to it will return a (huge) pointer to the DIB, which
// starts with a BITMAPINFOHEADER.
// NOTE: You are responsible for disposing of the returned DIB - these things
// can eat up your Windows memory fast!  See TWAIN_FreeNative below.
//
// The image type can be restricted using the following masks.  A mask of 0
// means 'any pixel type is welcome'.
// Caution: You should not assume that the source will honor a pixel type
// restriction!  If you care, check the parameters of the DIB.

#define TWAIN_BW 1
#define TWAIN_GRAY 2
#define TWAIN_RGB 4
#define TWAIN_PALETTE 8
#define TWAIN_ANYTYPE 0

extern CVOID TWAIN_FreeNative(HANDLE) eztw32.dll from "TWAIN_FreeNative"
// Release the memory allocated to a native format image, as returned by
// TWAIN_AcquireNative. (If you are coding in C or C++, this is just a call
// to GlobalFree.)
// If you use TWAIN_AcquireNative and don't free the returned image handle,
// it stays around taking up Windows (virtual) memory until your application
// terminates.  Memory required per square inch:
//             1 bit B&W       8-bit grayscale     24-bit color
// 100 dpi      1.25KB              10KB               30KB
// 200 dpi        5KB               40KB              120KB
// 300 dpi      11.25KB             90KB              270KB
// 400 dpi       20KB              160KB              480KB
//

extern CINT TWAIN_AcquireToClipboard(CHWND, CUINT) eztw32.dll from "TWAIN_AcquireToClipboard"
// Like AcquireNative, but puts the resulting image, if any, into the system
// clipboard.  Under Windows, this will put a CF_DIB item in the clipboard
// if successful.  If this call fails, the clipboard is either empty or
// contains the old contents.
// A return value of 1 indicates success, 0 indicates failure.
//
// Useful for environments like Visual Basic where it is hard to make direct
// use of a DIB handle.  In fact, TWAIN_AcquireToClipboard uses
// TWAIN_AcquireNative for all the hard work.

extern CINT TWAIN_AcquireToFilename(CHWND, CSTRING) eztw32.dll from "TWAIN_AcquireToFilename"
// Acquire an image and write it to a .BMP (Windows Bitmap) file.
// The file name and path in pszFile are used.  If pszFile is NULL or
// points to an empty string, the user is prompted with a Save File dialog.
// Return values:
// 0 success
// -1 Acquire failed OR user cancelled File Save dialog
// -2 file open error (invalid path or name, or access denied)
// -3 (weird) unable to lock DIB - probably an invalid handle.
// -4 writing BMP data failed, possibly output device is full

extern CINT TWAIN_SelectImageSource(CHWND) eztw32.dll from "TWAIN_SelectImageSource"
// This is the routine to call when the user chooses the "Select Source..."
// menu command from your application's File menu.  Your app has one of
// these, right?  The TWAIN spec calls for this feature to be available in
// your user interface, preferably as described.
// Note: If only one TWAIN device is installed on a system, it is selected
// automatically, so there is no need for the user to do Select Source.
// You should not require your users to do Select Source before Acquire.
//
// This function posts the Source Manager's Select Source dialog box.
// It returns after the user either OK's or CANCEL's that dialog.
// A return of 1 indicates OK, 0 indicates one of the following:
//   a) The user cancelled the dialog
//   b) The Source Manager found no data sources installed
//   c) There was a failure before the Select Source dialog could be posted
// -- details --
// Only sources that can return images (that are in the DG_IMAGE group) are
// displayed.  The current default source will be highlighted initially.
// In the standard implementation of "Select Source...", your application
// doesn't need to do anything except make this one call.
//
// If you want to be meticulous, disable your "Acquire" and "Select Source"
// menu items or buttons if TWAIN_IsAvailable() returns 0 - see below.


//--------- Basic TWAIN Inquiries

extern CINT TWAIN_IsAvailable() eztw32.dll from "TWAIN_IsAvailable"
// Call this function any time to find out if TWAIN is installed on the
// system.  It takes a little time on the first call, after that it's fast,
// just testing a flag.  It returns 1 if the TWAIN Source Manager is
// installed & can be loaded, 0 otherwise. 


extern CINT TWAIN_EasyVersion() eztw32.dll from "TWAIN_EasyVersion"
// Returns the version number of EZTWAIN.DLL, multiplied by 100.
// So e.g. version 2.01 will return 201 from this call.

extern CINT TWAIN_State() eztw32.dll from "TWAIN_State"
// Returns the TWAIN Protocol State per the spec.
#define TWAIN_PRESESSION 1
#define TWAIN_SM_LOADED 2
#define TWAIN_SM_OPEN 3
#define TWAIN_SOURCE_OPEN 4
#define TWAIN_SOURCE_ENABLED 5
#define TWAIN_TRANSFER_READY 6
#define TWAIN_TRANSFERRING 7

//--------- DIB handling utilities ---------

extern CINT TWAIN_DibDepth(HANDLE) eztw32.dll from "TWAIN_DibDepth"
// Depth of DIB, in bits i.e. bits per pixel.
extern CINT TWAIN_DibWidth(HANDLE) eztw32.dll from "TWAIN_DibWidth"
// Width of DIB, in pixels (columns)
extern CINT TWAIN_DibHeight(HANDLE) eztw32.dll from "TWAIN_DibHeight"
// Height of DIB, in lines (rows)
extern CINT TWAIN_DibNumColors(HANDLE) eztw32.dll from "TWAIN_DibNumColors"
// Number of colors in color table of DIB

extern CINT TWAIN_RowSize(HANDLE) eztw32.dll from "TWAIN_RowSize"

extern CVOID TWAIN_ReadRow(HANDLE, CINT, CPTR) eztw32.dll from "TWAIN_ReadRow"
// Read row n of the given DIB into buffer at prow.
// Caller is responsible for ensuring buffer is large enough.
// Row 0 is the *top* row of the image, as it would be displayed.

extern HPALETTE TWAIN_CreateDibPalette(HANDLE) eztw32.dll from "TWAIN_CreateDibPalette"
// Create and return a logical palette to be used for drawing the DIB.
// For 1, 4, and 8-bit DIBs the palette contains the DIB color table.
// For 24-bit DIBs, a default halftone palette is returned.

extern CVOID TWAIN_DrawDibToDC(HDC, CINT, CINT, CINT, CINT, HANDLE, CINT, CINT) eztw32.dll from "TWAIN_DrawDibToDC"
// Draws a DIB on a device context.
// You should call CreateDibPalette, select that palette
// into the DC, and do a RealizePalette(hDC) first.

//--------- BMP file utilities
 
extern CINT TWAIN_WriteNativeToFilename(HANDLE, CSTRING) eztw32.dll from "TWAIN_WriteNativeToFilename"
// Writes a DIB handle to a .BMP file
//
// hdib     = DIB handle, as returned by TWAIN_AcquireNative
// pszFile  = far pointer to NUL-terminated filename
// If pszFile is NULL or points to a null string, prompts the user
// for the filename with a standard file-save dialog.
//
// Return values:
//   0  success
//  -1  user cancelled File Save dialog
//  -2  file open error (invalid path or name, or access denied)
//  -3  (weird) unable to lock DIB - probably an invalid handle.
//  -4  writing BMP data failed, possibly output device is full

extern CINT TWAIN_WriteNativeToFile(HANDLE, HFILE) eztw32.dll from "TWAIN_WriteNativeToFile"
// Writes a DIB to a file in .BMP format.
//
// hdib     = DIB handle, as returned by TWAIN_AcquireNative
// fh       = file handle, as returned by _open, _lopen or OpenFile
//
// Return value as for TWAIN_WriteNativeToFilename

extern HANDLE TWAIN_LoadNativeFromFilename(CSTRING) eztw32.dll from "TWAIN_LoadNativeFromFilename"
// Load a .BMP file and return a DIB handle (as from AcquireNative.)
// Accepts a filename (including path & extension).
// If pszFile is NULL or points to a null string, the user is prompted.
// Returns a DIB handle if successful, otherwise NULL.

extern HANDLE TWAIN_LoadNativeFromFile(HFILE) eztw32.dll from "TWAIN_LoadNativeFromFile"
// Like LoadNativeFromFilename, but takes an already open file handle.


extern CVOID TWAIN_SetHideUI(CINT) eztw32.dll from "TWAIN_SetHideUI"
extern CINT TWAIN_GetHideUI() eztw32.dll from "TWAIN_GetHideUI"
// These functions control the 'hide source user interface' flag.
// This flag is cleared initially, but if you set it non-zero, then when
// a source is enabled it will be asked to hide its user interface.
// Note that this is only a request - some sources will ignore it!
// This affects AcquireNative, AcquireToClipboard, and EnableSource.
// If the user interface is hidden, you will probably want to set at least
// some of the basic acquisition parameters yourself - see
// SetCurrentUnits, SetBitDepth, SetCurrentPixelType and
// SetCurrentResolution below.

//--------- Application Registration

extern CVOID TWAIN_RegisterApp(CINT, CINT, CINT, CINT, CSTRING, CSTRING, CSTRING, CSTRING) eztw32.dll from "TWAIN_RegisterApp"
//
// TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the
// application. If this function is not called, the application is given a
// 'generic' registration by EZTWAIN.
// Registration only provides this information to the Source Manager and any
// sources you may open - it is used for debugging, and (frankly) by some
// sources to give special treatment to certain applications.

//--------- Error Analysis and Reporting ------------------------------------

extern CUINT TWAIN_GetResultCode() eztw32.dll from "TWAIN_GetResultCode"
// Return the result code (TWRC_xxx) from the last triplet sent to TWAIN

extern CUINT TWAIN_GetConditionCode() eztw32.dll from "TWAIN_GetConditionCode"
// Return the condition code from the last triplet sent to TWAIN.
// (To be precise, from the last call to TWAIN_DS below)
// If a source is NOT open, return the condition code of the source manager.

extern CVOID TWAIN_ErrorBox(CSTRING) eztw32.dll from "TWAIN_ErrorBox"
// Post an error message dialog with an exclamation mark, OK button,
// and the title 'TWAIN Error'.
// pszMsg points to a null-terminated message string.

extern CVOID TWAIN_ReportLastError(CSTRING) eztw32.dll from "TWAIN_ReportLastError"
// Like TWAIN_ErrorBox, but if some details are available from
// TWAIN about the last failure, they are included in the message box.


//--------- TWAIN State Control ------------------------------------

extern CINT TWAIN_LoadSourceManager() eztw32.dll from "TWAIN_LoadSourceManager"
// Finds and loads the Data Source Manager, TWAIN.DLL.
// If Source Manager is already loaded, does nothing and returns TRUE.
// This can fail if TWAIN.DLL is not installed (in the right place), or
// if the library cannot load for some reason (insufficient memory?) or
// if TWAIN.DLL has been corrupted.

extern CINT TWAIN_OpenSourceManager(CHWND) eztw32.dll from "TWAIN_OpenSourceManager"
// Opens the Data Source Manager, if not already open.
// If the Source Manager is already open, does nothing and returns TRUE.
// This call will fail if the Source Manager is not loaded.

extern CINT TWAIN_OpenDefaultSource() eztw32.dll from "TWAIN_OpenDefaultSource"
// This opens the source selected in the Select Source dialog.
// If a source is already open, does nothing and returns TRUE.
// Fails if the source manager is not loaded and open.

extern CINT TWAIN_EnableSource(CHWND) eztw32.dll from "TWAIN_EnableSource"
// Enables the open Data Source. This posts the source's user interface
// and allows image acquisition to begin.  If the source is already enabled,
// this call does nothing and returns TRUE.

extern CINT TWAIN_DisableSource() eztw32.dll from "TWAIN_DisableSource"
// Disables the open Data Source, if any.
// This closes the source's user interface.
// If there is not an enabled source, does nothing and returns TRUE.

extern CINT TWAIN_CloseSource() eztw32.dll from "TWAIN_CloseSource"
// Closes the open Data Source, if any.
// If the source is enabled, disables it first.
// If there is not an open source, does nothing and returns TRUE.

extern CINT TWAIN_CloseSourceManager(CHWND) eztw32.dll from "TWAIN_CloseSourceManager"
// Closes the Data Source Manager, if it is open.
// If a source is open, disables and closes it as needed.
// If the Source Manager is not open, does nothing and returns TRUE.

extern CINT TWAIN_UnloadSourceManager() eztw32.dll from "TWAIN_UnloadSourceManager"
// Unloads the Data Source Manager i.e. TWAIN.DLL - releasing
// any associated memory or resources.
// This call will fail if the Source Manager is open, otherwise
// it always succeeds and returns TRUE.



extern HANDLE TWAIN_WaitForNativeXfer(CHWND) eztw32.dll from "TWAIN_WaitForNativeXfer"

extern CVOID TWAIN_ModalEventLoop() eztw32.dll from "TWAIN_ModalEventLoop"
// Process messages until termination, source disable, or image transfer.


extern CINT TWAIN_EndXfer() eztw32.dll from "TWAIN_EndXfer"

extern CINT TWAIN_AbortAllPendingXfers() eztw32.dll from "TWAIN_AbortAllPendingXfers"


//--------- High-level Capability Negotiation Functions --------

extern CINT TWAIN_NegotiateXferCount(CINT) eztw32.dll from "TWAIN_NegotiateXferCount"
// Negotiate with open Source the number of images application will accept.
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// nXfers = -1 means any number

extern CINT TWAIN_NegotiatePixelTypes(CUINT) eztw32.dll from "TWAIN_NegotiatePixelTypes"
// Negotiate with the source to restrict pixel types that can be acquired.
// This tries to restrict the source to a *set* of pixel types,
// See TWAIN_AcquireNative above for some mask constants.
// --> This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// A parameter of 0 (TWAIN_ANYTYPE) causes no negotiation & no restriction.
// You should not assume that the source will honor your restrictions, even
// if this call succeeds!

extern CINT TWAIN_GetCurrentUnits() eztw32.dll from "TWAIN_GetCurrentUnits"
// Ask the source what its current unit of measure is.
// If anything goes wrong, this function just returns TWUN_INCHES (0).

extern CINT TWAIN_SetCurrentUnits(CINT) eztw32.dll from "TWAIN_SetCurrentUnits"
// Set the current unit of measure for the source.
// Unit of measure codes are in TWAIN.H, but TWUN_INCHES is 0.

extern CINT TWAIN_GetBitDepth() eztw32.dll from "TWAIN_GetBitDepth"
// Get the current bitdepth, which can depend on the current PixelType.
// Bit depth is per color channel e.g. 24-bit RGB has bit depth 8.
// If anything goes wrong, this function returns 0.

extern CINT TWAIN_SetBitDepth(CINT) eztw32.dll from "TWAIN_SetBitDepth"
// (Try to) set the current bitdepth (for the current pixel type).

extern CINT TWAIN_GetPixelType() eztw32.dll from "TWAIN_GetPixelType"
// Ask the source for the current pixel type.
// If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW).

extern CINT TWAIN_SetCurrentPixelType(CINT) eztw32.dll from "TWAIN_SetCurrentPixelType"
// (Try to) set the current pixel type for acquisition.
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// The source may select this pixel type, but don't assume it will.

extern CDOUBLE TWAIN_GetCurrentResolution() eztw32.dll from "TWAIN_GetCurrentResolution"
// Ask the source for the current (horizontal) resolution.
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// If anything goes wrong (it shouldn't) this function returns 0.0

extern CDOUBLE TWAIN_GetYResolution() eztw32.dll from "TWAIN_GetYResolution"
// Returns the current vertical resolution, in dots per *current unit*.
// In the event of failure, returns 0.0.

extern CINT TWAIN_SetCurrentResolution(CDOUBLE) eztw32.dll from "TWAIN_SetCurrentResolution"
// (Try to) set the current resolution for acquisition.
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// Note: The source may select this resolution, but don't assume it will.

extern CINT TWAIN_SetContrast(CDOUBLE) eztw32.dll from "TWAIN_SetContrast"
// (Try to) set the current contrast for acquisition.
// The TWAIN standard says that the range for this cap is -1000 ... +1000

extern CINT TWAIN_SetBrightness(CDOUBLE) eztw32.dll from "TWAIN_SetBrightness"
// (Try to) set the current brightness for acquisition.
// The TWAIN standard says that the range for this cap is -1000 ... +1000

extern CINT TWAIN_SetXferMech(CINT) eztw32.dll from "TWAIN_SetXferMech"
extern CINT TWAIN_XferMech() eztw32.dll from "TWAIN_XferMech"
// (Try to) set or get the transfer mode - one of the following:
#define XFERMECH_NATIVE 0
#define XFERMECH_FILE 1
#define XFERMECH_MEMORY 2

//--------- Low-level Capability Negotiation Functions --------

// Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN)
// Getting a capability is valid in State 4 or any higher state.
 
extern CINT TWAIN_SetCapOneValue(CUINT, CUINT, CLONG) eztw32.dll from "TWAIN_SetCapOneValue"
// Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE,
// CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type
// and value.  The item value must fit into 32 bits.
// Returns TRUE (1) if successful, FALSE (0) otherwise.

extern CINT TWAIN_GetCapCurrent(CUINT, CUINT, CPTR) eztw32.dll from "TWAIN_GetCapCurrent"
// Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'.
// Copy the current value out of the returned container into *pVal.
// If the operation fails (the source refuses the request), or if the
// container is not a ONEVALUE or ENUMERATION, or if the item type of the
// returned container is incompatible with the expected TWTY_ type in nType,
// returns FALSE.  If this function returns FALSE, *pVal is not touched.

extern CLONG TWAIN_ToFix32(CDOUBLE) eztw32.dll from "TWAIN_ToFix32"
// Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed
// to e.g. TWAIN_SetCapOneValue

extern CDOUBLE TWAIN_Fix32ToFloat(CLONG) eztw32.dll from "TWAIN_Fix32ToFloat"
// Convert a TW_FIX32 value (as returned from some capability inquiries)
// to a double (floating point) value.

//--------- Lowest-level functions for TWAIN protocol --------


extern CINT TWAIN_DS(CLONG, CUINT, CUINT, CPTR) eztw32.dll from "TWAIN_DS"
// Passes the triplet (DG, DAT, MSG, pData) to the open data source if any.
// Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
// The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
// condition code can be retrieved with TWAIN_GetConditionCode().
// If no source is open this call will fail, result code TWRC_FAILURE, condition code TWCC_NODS.

extern CINT TWAIN_Mgr(CLONG, CUINT, CUINT, CPTR) eztw32.dll from "TWAIN_Mgr"
// Passes a triplet to the Data Source Manager (DSM).
// Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
// The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
// condition code can be retrieved with TWAIN_GetConditionCode().
// If the Source Manager is not open, this call will fail, and set the result code to TWRC_FAILURE,
// with a condition code of TWCC_SEQERROR (triplet out of sequence).



