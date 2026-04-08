/* EZTwain library declarations for Progress 4GL */
/* XDefs translation of \EZTwain\VC\Eztwain.h */
/* EZTwain 3.43.0.3, XDefs 1.44.0 */
/* ----------------------------------------------------------------- */
/* EZTWAIN.H - Easy interface to TWAIN library */
/* Copyright (C) 1999-2010 by Dosadi. */

/* This interface and the library which implements it, are the property of */
/* Dosadi and are protected by US and International copyright and trademark */
/* laws and treaties.  Dosadi strives to make this software both reliable, */
/* comprehensive, efficient, and affordable.  Do not use this software without */
/* obtaining a license for your use. */

/* Sales, support and licensing information at: www.dosadi.com */




PROCEDURE TWAIN_Testing123 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER s AS CHARACTER.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE INPUT PARAMETER u AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Displays a dialog box showing the parameter values received by the function. */
/* Pass in any valid values for the parameters - if they are faithfully */
/* displayed in the dialog box when you call this function, then parameter */
/* passing from your program to EZTwain is probably working correctly. */

/* Returns the value of the HDIB h parameter. */

/* --------- Top-Level Calls */

PROCEDURE TWAIN_ResetAll EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Resets EZTwain to default/just loaded state. */
/* (Except diagnostic logging, which is unaffected.) */
/* Any global settings are reset to initial values. */
/* Any open files are closed. */
/* Any open TWAIN device is closed. */
/* This function is used to place EZTwain in a 'known state' */
/* before starting a sequence of scanning calls. */

PROCEDURE TWAIN_Acquire EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquires a single image, from the currently selected Data Source. */

/* The parameter is a Win32 Window Handle.  In most applications you */
/* can use 0 or NULL, but on Citrix and WTS, this must be a top-level window */
/* or a child of a top level window. */

/* The return value is a handle to global memory containing a DIB -  */
/* a Device-Independent Bitmap.  Numerous EZTWAIN DIB_xxx functions can */
/* be used to examine, modify, and save these DIB images. */
/* Warning: Remember to call DIB_Free on each DIB when you are done with it! */

/* Normally only one image is acquired per call: All Acquire functions shut */
/* down TWAIN before returning.  Use TWAIN_SetMultiTransfer to change this. */

/* By default, the default data source (DS) is opened, displays its dialog, */
/* and determines all the parameters of the acquisition and transfer. */
/* If you want to (try to) hide the DS dialog, see TWAIN_SetHideUI. */
/* To set acquisition parameters, you need to do something like this: */
/* TWAIN_OpenDefaultSource() -or- TWAIN_OpenSource(sourceName) */
/* TWAIN_Set*        - one or more capability-setting functions */
/* hdib = TWAIN_Acquire(hwnd) */
/* if (hdib) then ... process image, TWAIN_FreeNative(hdib); end */

PROCEDURE TWAIN_SelectImageSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Display the standard TWAIN "Select Source" dialog which */
/* allows the user to specify the system-wide default TWAIN device. */

/* Note this is a configuration function, it does not open or activate the device. */
/* See: TWAIN_GetDefaultSourceName and TWAIN_OpenDefaultSource. */

/* Note: If only one TWAIN device is installed on a system, TWAIN selects it */
/* automatically, so there is no need for the user to do Select Source. */
/* You should not require your users to do Select Source before Acquire. */

/* It returns after the user either OK's or CANCEL's the dialog. */
/* A return of TRUE(1) indicates OK, FALSE(0) indicates one of the following: */
/* a) The user cancelled the dialog */
/* b) The Source Manager found no data sources installed */
/* c) There was a failure before the Select Source dialog could be posted */

/* Note: You can call (Get)DefaultSourceName to get the name of the */
/* current default source, after calling SelectImageSource, or any other time. */

PROCEDURE TWAIN_AcquireToFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquire an image and save it to a file. */
/* If the filename is NULL or an empty string, the user is prompted for */
/* the file name using a standard Save File dialog. */

/* The minimal use of EZTwain is to call this function with both arguments NULL (0). */

/* If the filename passed as a parameter or entered by the user contains a */
/* standard extension (.bmp, .jpg/.jpeg, .tif/.tiff, .png, .pdf, .gif, .dcx) */
/* then the file is saved in the implied format. */
/* Otherwise the file is saved in the current SaveFormat - see TWAIN_SetSaveFormat. */

/* See also TWAIN_AcquireFile below. */

/* Return values: */
/* 0  success. */
/* -1  the Acquire failed. */
/* -2  file open error (invalid path or name, or access denied) */
/* -3  invalid DIB, or image incompatible with file format, or... */
/* -4  writing failed, possibly output device is full. */
/* -10  user cancelled File Save dialog */


PROCEDURE TWAIN_AcquireMultipageFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquire (scan) all available images to a multipage file. */
/* If the filename is NULL or points to the null string, the user is */
/* prompted for the filename. */
/* If the filename ends with ".tif", ".tiff", or */
/* ".mpt" the file is written in TIFF format. */
/* If the filename ends with ".pdf" the file is written in PDF format. */
/* Otherwise, the default multipage format is used, as set by SetMultipageFormat. */
/* If it has not been set, the default multipage format is TIFF. */

/* If scanning fails or is cancelled before the first writable page */
/* is received, no file action is taken: The output filename is not prompted for, */
/* the file is not created, if it exists it is not touched. */

/* The function TWAIN_MultipageCount can be called during or after */
/* writing a multipage file, it reports the number of images written to the file. */
/* See also TWAIN_AcquireCount and TWAIN_BlankDiscardCount for other info. */

/* Return values: */
/* 0  success */
/* -1  the Acquire failed, or the device closed or quit after 0 pages. */
/* If 0 pages were written but no other error was diagnosed, */
/* TWAIN_LastErrorCode will be EZTEC_0_PAGES. */
/* -2  file open error (invalid path or name, or access denied) */
/* -3  could not load file-format module (EZTiff.dll or EZPdf.dll) */
/* Either the DLL was not found, or the version is out-of-date, */
/* For PDF output, EZJpeg.dll is also required. */
/* Less likely: The device returned an invalid DIB handle, or */
/* the transferred image has a bit depth of 9..15 bits per pixel (??) */
/* -4  writing failed, possibly output device is full. */
/* -7  Multipage support is not installed. */
/* -10  user cancelled - This can be during the filename prompt, if you */
/* did not supply a filename, or it can be when the scanner dialog */
/* is first displayed.  If the scanner dialog is visible, the user */
/* can cancel during a scan and the dialog will just stay open (usually) */
/* allowing another try.  If the user closed the scan dialog without */
/* scanning, TWAIN_LastErrorCode will be EZTEC_USER_CANCEL. */

/* This function respects TWAIN_SetHideUI as follows: */
/* If SetHideUI(1), then the device UI is hidden, AcquireMultipageFile */
/* will transfer images until the device indicates that it has no */
/* more images ready.  (Technically, it goes to State 5). */
/* Exception: If a device seems to be one-image-at-a-time (such as a flatbed) */
/* the user will be asked if they want to acquire another image. */

/* If SetHideUI(0) [the default case] then the device UI is shown, */
/* and AcquireMultipageFile will transfer images until the user */
/* closes the device dialog.  (You can call SetStopOnEmpty to have */
/* scanning stop when the device runs out of images/paper.) */

/* This function respects SetMultiTransfer() as follows: */
/* If SetMultiTransfer(1), the DS is left open on return. */
/* Otherwise (the default case), the DS is closed and TWAIN is unloaded. */

/* If you want to set scanning parameters (resolution, pixeltype...) */
/* first open the source (see OpenDefaultSource or OpenSource) */
/* then negotiate the settings using the Capability functions, and */
/* then call AcquireMultipageFile. */

/* Caution: It is not recommended to use this function on webcams */
/* if the UI is hidden.  Some will crash, others may supply images */
/* endlessly (until disk full.) */

PROCEDURE TWAIN_AcquireToArray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER nMax AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Scan and store images in the specified array. */
/* Very similar to TWAIN_AcquireMultipageFile. */
/* A return value of N > 0 means N images were scanned and stored */
/* without error. */
/* If no (0) images were scanned and stored and there was no other error, */
/* the return value will be -1 and TWAIN_LastErrorCode will be EZTEC_0_PAGES. */
/* Any unused entries in the array are set to 0 (NULL) */
/* In case of error, no images are returned - the scan must be restarted. */

PROCEDURE TWAIN_AcquireImagesToFiles EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Similar to TWAIN_AcquireMultipageFile above, but writes each */
/* image to a separate file.  The format of the output files is */
/* determined by the extension of the filename, as with AcquireToFilename. */

/* If the filename is NULL or points to the null string, the user is */
/* prompted for the name of the first file. */

/* Files after the first are given names 'incremented' from the name */
/* of the first file according to this pattern: */
/* document.pdf increments to document1.pdf */
/* document99.pdf increments to document100.pdf */
/* document0001.tif increments to document0002.tif. */

/* Return values: */
/* IMPORTANT: If successful, returns the number of files written. */
/* Note that this could be 0 if the scanner dialog is displayed and */
/* the user closes the dialog without any scans. */
/* Otherwise, return value same as TWAIN_AcquireMultipageFile, and */
/* details available from TWAIN_LastErrorCode & related functions. */

/* See also: TWAIN_AcquiredFileCount */
/* TWAIN_AcquireCount */
/* TWAIN_BlankDiscardCount. */

PROCEDURE TWAIN_AcquirePagesToFiles EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE INPUT PARAMETER nPPF AS LONG.
  DEFINE INPUT PARAMETER sFile AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Similar to AcquireImagesToFiles, but can acquire duplex or multipage files. */

/* hwnd     = parent window. Use 0 (NULL) if you can't obtain the window handle. */

/* nPPF     = *pages* per file. */
/* If the scanner is scanning duplex, 1 page = 2 images */
/* otherwise 1 page = 1 image. */

/* pzFile   = filename.  We recommend including the extension to specify the format. */
/* If the filename is NULL or points to the empty string, the user is */
/* prompted for the name of the first file. */

/* Return: If successful, returns the number of files written. */
/* Otherwise, same as TWAIN_AcquireMultipageFile, with */
/* details available from TWAIN_LastErrorCode & related functions. */

PROCEDURE TWAIN_AcquireMultipage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Similar to AcquireToArray and AcquireMultipageFile, but does nothing */
/* with the images except pass them to the callback function  */
/* (which you should set with SetAcquireImageCallback.) */

/* Return: 0 if successful, */
/* Otherwise a negative number: see AcquireMultipageFile. */

/* Details of Operation: */
/* If the callback returns a valid DIB handle, the returned DIB is */
/* freed with DIB_Free. */
/* Otherwise the callback's return value is ignored. */
/* In either case, scanning continues. */
/* To abort scanning the callback can call TWAIN_RecordError with an error. */
/* Two error codes are treated specially: */
/* EZTEC_NONE, which is ignored and has no effect on scanning, and */
/* EZTEC_USER_CANCEL which causes AcquireMultipage to abort the scan */
/* and return a value of -1, *after clearing* the error with TWAIN_ClearError. */
/* All other errors cause AcquireMultipage to abort the scan and */
/* return -1, leaving the error code available via TWAIN_LastErrorCode & co. */

/* This function allows EZTwain to handle the complexities of multipage */
/* scanning while your callback function does whatever you want done with */
/* each image. */

PROCEDURE TWAIN_AcquiredFileCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the number of files successfully written by the last call to */
/* AcquireImagesToFiles or AcquirePagesToFiles. */

PROCEDURE TWAIN_AcquireCompressed EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquire the next available image from the open (or default) device, */
/* accepting a compressed memory transfer if one is selected. */
/* (Use TWAIN_SetCompression to select the compression algorithm.) */

/* The DIB handle which is returned will normally reference a compressed */
/* DIB, which is acceptable to relatively few EZTwain functions. */
/* See also: DIB_IsCompressed */

/* Recommended use of this function: */
/* Open a device with TWAIN_OpenSource or TWAIN_OpenDefaultSource. */
/* Set any other scanning parameters such as PixelType, resolution, etc. */
/* Select memory transfer mode, using TWAIN_SetXferMech. */
/* Select a compression algorithm, using TWAIN_SetCompression. */
/* Call this function (possibly in a loop) to acquire images. */


PROCEDURE TWAIN_AcquireCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the number of images acquired by the last call to */
/* TWAIN_AcquireMultipageFile, TWAIN_AcquireImagesToFiles, */
/* or TWAIN_AcquirePagesToFiles. */

/* This includes only "keeper" pages - it *excludes* */
/* any discarded blank pages, separator pages, etc. */

/* Therefore it may differ from the value of TWAIN_MultipageCount. */

PROCEDURE TWAIN_PromptToContinue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Prompt the user "Continue scanning?" */
/* Return TRUE(1) if yes, FALSE(0) if not. */
/* If the parameter is a valid Windows window-handle, that window */
/* is used as the parent of the prompt message box, otherwise */
/* the foreground window of the current task/process is used. */

/* The prompt is automatically translated based on thread locale */
/* (which defaults to application locale, which defaults to user locale, */
/* which defaults to system locale) */
/* Languages: Danish, Dutch, English, French, German, Italian, */
/* Norwegian, Polish, Portuguese, Spanish, Swedish. */
/* Also Russian and Japanese, but those may not work.... */

PROCEDURE TWAIN_SetDefaultScanAnotherPagePrompt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER fYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Controls an aspect of TWAIN_AcquireMultipageFile - When used */
/* with a non-feeder device, with UI suppressed, that function */
/* asks the user if they want to scan another page, [Yes] or [No]. */
/* This function controls which answer is the default: */
/* fYes = 1         [Yes] is the default button/answer* */
/* fYes = 0         [No] is the default button/answer. */

/* * EZTwain initial setting. */

/* Return value: Previous value of the setting. */


PROCEDURE TWAIN_DoSettingsDialog EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Run the device's settings dialog, if this is supported, and return */
/* when the user closes the dialog.  See return codes below. */

/* The purpose of this feature, which is definitely not supported by all */
/* devices, is to allow a human operator to define a complete device */
/* configuration, including settings that are proprietary and that may */
/* appear only in the device's UI.  This configuration can then be saved */
/* exactly and in toto, using the (TWAIN_)GetCustomData */

/* If a device is open, work with that device.  If no device is currently */
/* open, work with the default device.  (See GetDefaultSourceName) */
/* This is an *optional* TWAIN feature - To check if a device supports this, */
/* open the device and call TWAIN_GetCapBool(CAP_ENABLEDSUIONLY, FALSE) - */
/* if that call returns TRUE(1) then this feature is supported. */
/* Return values: */
/* 1     dialog was displayed and user clicked OK */
/* 0     dialog was displayed and user clicked Cancel */
/* -1     dialog not displayed - some error.  Call LastErrorCode, */
/* ReportLastError, or similar function for more details. */

PROCEDURE TWAIN_EnableSourceUiOnly EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* The underlying 'asynchronous' function for TWAIN_DoSettingsDialog. */
/* Opens the device's settings dialog, if this is supported. */
/* Returns TRUE (1) if successful, FALSE (0) otherwise. */
/* NOTE: If successful, this call leaves the dialog open, so your */
/* program must run a message pump at least until the user closes it. */
/* If you don't understand what that means, don't call this guy. */

/* --------- Global Options */

PROCEDURE TWAIN_SetMultiTransfer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetMultiTransfer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* This function controls the 'multiple transfers' flag. */
/* By default, this feature is set to FALSE (0). */

/* If this flag is zero, the input device is closed when */
/* any TWAIN_AcquireXXX function finishes. */

/* If this flag is non-zero: After an Acquire, the input device */
/* is not closed, but is left open to allow additional images */
/* to be acquired.  In this case the programmer should */
/* close the input device after all images have been */
/* transferred, by calling either */
/* TWAIN_CloseSource or */
/* TWAIN_UnloadSourceManager */

/* See also: TWAIN_UserClosedSource() */

PROCEDURE TWAIN_SetHideUI EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bHide AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetHideUI EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* These functions control the 'hide source user interface' flag. */
/* This flag is cleared initially, but if you set it non-zero, then when */
/* a device is enabled it will be asked to hide its user interface. */
/* Note that this is only a request - some devices will ignore it! */
/* This affects AcquireNative, AcquireToClipboard, and EnableSource. */
/* If the user interface is hidden, you will probably want to set at least */
/* some of the basic acquisition parameters yourself - see */
/* SetUnits, SetPixelType, SetBitDepth and SetResolution below. */
/* See also: HasControllableUI */

PROCEDURE TWAIN_SetStopOnEmpty EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetStopOnEmpty EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* These functions manage the 'Stop On Empty' flag. */
/* This flag is off (FALSE) by default. */
/* When set, multipage scanning functions stop scanning and return */
/* when the device indicates that no more images are 'pending', */
/* *even if* the scanner's dialog is being displayed. */
/* Note that the normal behavior when the scanner dialog is displayed */
/* is to continue scanning until the user closes the dialog. */
/* Of course, behavior varies from scanner to scanner, but with most */
/* ADF scanners, setting Stop On Empty will cause multipage */
/* scanning to stop when everything in the feeder has been scanned. */

PROCEDURE TWAIN_DisableParent EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetDisableParent EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set or get the "DisableParent" flag. */
/* When this flag is set (non-zero), EZTwain attempts to */
/* disable the parent window during any Acquire function. */
/* (The parent window is the window you pass to the Acquire function. */
/* Typically this is your main application window or dialog.) */
/* This flag is TRUE (1) by default. */

/* Note 1: If you set this to FALSE, your window can receive user input while */
/* an Acquire is in progress, and your code must be prepared for this. */
/* Note 2: Some TWAIN data sources will disable the parent window on their */
/* own, and EZTWAIN cannot prevent this. */


/* --------- Basic TWAIN Inquiries */

PROCEDURE TWAIN_EasyVersion EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the version number of EZTWAIN.DLL, multiplied by 100. */
/* So e.g. version 2.01 will return 201 from this call. */
PROCEDURE TWAIN_EasyBuild EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the build number within the version. */

PROCEDURE TWAIN_IsAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Call this function any time to find out if TWAIN is installed on the */
/* system.  It takes a little time on the first call, after that it's fast, */
/* just testing a flag.  It returns 1 if the TWAIN Source Manager is */
/* installed & can be loaded, 0 otherwise.  */

PROCEDURE TWAIN_IsMultipageAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if EZTwain 'multipage' services are installed. */
/* This allows writing of multipage TIFF (if TIFF is available) */
/* and multipage PDF (if PDF is available). */
/* It also enables TWAIN_AcquireMultipageFile */

PROCEDURE TWAIN_State EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the TWAIN Protocol State per the spec. */
&GLOBAL-DEFINE TWAIN_PRESESSION 1
&GLOBAL-DEFINE TWAIN_SM_LOADED 2
&GLOBAL-DEFINE TWAIN_SM_OPEN 3
&GLOBAL-DEFINE TWAIN_SOURCE_OPEN 4
&GLOBAL-DEFINE TWAIN_SOURCE_ENABLED 5
&GLOBAL-DEFINE TWAIN_TRANSFER_READY 6
&GLOBAL-DEFINE TWAIN_TRANSFERRING 7

PROCEDURE TWAIN_IsDone EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return FALSE(0) if there is a device open and it is in a state */
/* where more scans are available or could be requested. */
/* Otherwise returns TRUE (1). */

/* Informally, TRUE means 'stop asking for images' and */
/* FALSE means something like 'It would be appropriate */
/* at this time to request another image.' */

/* Yes, it sounds bizarre, but that's actually */
/* how TWAIN works. */

/* This call can be used for multipage scanning */
/* as the test at the *bottom* of a do-until loop: */
/* If TWAIN_OpenDefaultSource() Then */
/* TWAIN_SetMultiTransfer(1) */
/* Do */
/* TWAIN_AcquireToFilename(0, NextFileName()) */
/* Until TWAIN_IsDone() */
/* TWAIN_CloseSource() */
/* End If */


PROCEDURE TWAIN_SourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Returns a pointer to the name of the currently open source, if any, or */
/* the name of the source that was just closed. */
/* Should be used while a source is open, or right after a */
/* source has been used and then closed. */

PROCEDURE TWAIN_GetSourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sName AS MEMPTR.
END PROCEDURE.
/* Like TWAIN_SourceName, but copies current/last source name into its parameter. */
/* The parameter is a string variable (char array in C/C++). */
/* You are responsible for allocating room for 33 8-bit characters */
/* in the string variable before calling this function. */

/* --------- DIB handling utilities --------- */

PROCEDURE DIB_IsValid EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if parameter seems to be a valid DIB, FALSE(0) otherwise. */
/* A true return is not a guarantee, but a false return means something is */
/* seriously wrong. */

PROCEDURE DIB_Depth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_BitsPerPixel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* 'depth' of image - number of bits used to store one pixel */

PROCEDURE DIB_PixelType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TWAIN PixelType that describes this DIB: TWPT_BW, TWPT_GRAY, TWPT_RGB, */
/* TWPT_PALETTE, TWPT_CMYK, TWPT_CMY, etc. */

PROCEDURE DIB_Width EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Width of DIB, in pixels (columns) */
PROCEDURE DIB_Height EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Height of DIB, in lines (rows) */

PROCEDURE DIB_SetResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER xdpi AS DOUBLE.
  DEFINE INPUT PARAMETER ydpi AS DOUBLE.
END PROCEDURE.
PROCEDURE DIB_SetResolutionInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER xdpi AS LONG.
  DEFINE INPUT PARAMETER ydpi AS LONG.
END PROCEDURE.
/* Sets the horizontal and vertical resolution of the DIB. */

PROCEDURE DIB_XResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Horizontal (x) resolution of DIB, in DPI (dots per inch) */
PROCEDURE DIB_YResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Vertical (y) resolution of DIB, in DPI (dots per inch) */

PROCEDURE DIB_XResolutionInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_YResolutionInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the nearest integer value to the x or y resolution of an image. */

/* Physical or 'implied' image size */
PROCEDURE DIB_PhysicalWidth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nUnits AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE DIB_PhysicalHeight EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nUnits AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Return the width(height), in the specified units, of the given */
/* image, calculated using its pixel width(height) and X(Y) resolution. */
/* If the resolution is 0, these functions return 0. */
/* nUnits is one of the TWUN_ values - see TWAIN_GetCurrentUnits. */
/* nUnits=0 is inches, and nUnits=1 is centimeters(cm). */

PROCEDURE DIB_RowBytes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Number of bytes needed to store one row of the DIB. */

PROCEDURE DIB_ColorCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Number of colors in color table of DIB. */
/* Primarily useful for B&W, gray, and palette images. */
/* 16-bit gray, RGB, CMY & CMYK images have no color table: DIB_ColorCount returns 0 */

PROCEDURE DIB_SamplesPerPixel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Number of 'samples' or components or color channels in each pixel. */
/* B&W and gray pixels have 1 sample, RGB and CMY have 3. */
/* CMYK has 4, and palette-color images are treated as having 3 channels. */

PROCEDURE DIB_BitsPerSample EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Number of bits per 'channel'.  For B&W and gray images this is */
/* the same as the DIB_Depth, because those formats have only one channel. */
/* For palette images, this will be 8, because the color values in a */
/* palette image are stored with 8 bits each for R, G, and B. */
/* For RGB, CMY, and CMYK images, this function returns the number of bits */
/* used to represent each color channel or component - almost always 8, but */
/* EZTwain has a limited ability to handle 16-bit per channel images. */

PROCEDURE DIB_IsCompressed EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return 1(True) if image is compressed in memory 0(False) otherwise. */

PROCEDURE DIB_Compression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the TWCP_xxx code representing the compression algorithm */
/* of this image.  Uncompressed images yield TWCP_NONE. */



PROCEDURE DIB_Size EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the size in memory of the given DIB. */

PROCEDURE DIB_ReadData EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pdata AS MEMPTR.
  DEFINE INPUT PARAMETER nbMax AS LONG.
END PROCEDURE.
/* Read up to nbMax bytes from the given DIB into the given buffer. */
/* The data is read 'verbatim' from the first byte of the DIB. */
/* To read pixel data, see DIB_ReadRowxxx below. */

PROCEDURE DIB_ReadRow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
END PROCEDURE.
PROCEDURE DIB_ReadRowRGB EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
END PROCEDURE.
PROCEDURE DIB_ReadRowGray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
END PROCEDURE.
PROCEDURE DIB_ReadRowChannel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
  DEFINE INPUT PARAMETER nChannel AS LONG.
END PROCEDURE.
PROCEDURE DIB_ReadRowSample EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
  DEFINE INPUT PARAMETER nSample AS LONG.
END PROCEDURE.
/* Read row r of the given DIB into buffer at prow. */
/* Caller is responsible for ensuring buffer is large enough. */
/* ReadRowRGB always reads 3 bytes (24 bits) for each pixel, */
/* ReadRowGray and ReadRowChannel always read 1 byte (8 bits) per pixel. */
/* Row 0 is the *top* row of the image, as it would be displayed. */
/* The first variant reads the data exactly as-is from the DIB, including */
/* BGR pixels from 24-bit DIBs, 16-bit grayscale, 1-bit B&W, etc. */
/* The RGB variant unpacks every DIB pixel into 3-byte RGB pixels. */
/* The Gray variant converts every pixel to its 8-bit gray value. */
/* Channel codes are: 0=Gray(Luminance), 1=Red, 2=Green, 3=Blue.  See */
/* 'Component codes' below. */
/* Samples are the bytes of the pixel: A grayscale pixel has sample 0, */
/* an RGB image has samples 0, 1 and 2 (which are actually Green, Red and Blue). */

PROCEDURE DIB_ReadPixelRGB EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
END PROCEDURE.
PROCEDURE DIB_ReadPixelGray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
END PROCEDURE.
PROCEDURE DIB_ReadPixelChannel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
  DEFINE INPUT PARAMETER nChannel AS LONG.
END PROCEDURE.
/* Read the value of the pixel at column x row y of the DIB into the buffer. */
/* RGB form reads 3 bytes R,G,B */
/* Gray form reads 1 byte of 'equivalent gray' */
/* Channel form reads 1 byte of channel/component, see COMPONENT_xxx codes. */


PROCEDURE DIB_WriteRow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT PARAMETER pdata AS MEMPTR.
END PROCEDURE.
/* Write data from buffer into row r of the given DIB. */
/* Caller is responsible for ensuring buffer and row exist, etc. */

PROCEDURE DIB_WriteRowChannel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT PARAMETER pdata AS MEMPTR.
  DEFINE INPUT PARAMETER nChannel AS LONG.
END PROCEDURE.
/* Write data from buffer into one color channel of row r of the given DIB. */
/* This function should only be used on 24-bit RGB, 32-bit RGBA, 24-bit CMY, */
/* 32-bit CMYK, or 8-bit grayscale images.  Its behavior on any other image is undefined. */
/* Channels are: 0=gray, 1=Red, 2=Green, 3=Blue, 4=Alpha or */
/* 1=C, 2=M, 3=Y, 4=K. */

PROCEDURE DIB_WriteRowSample EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT PARAMETER psrc AS MEMPTR.
  DEFINE INPUT PARAMETER nSample AS LONG.
END PROCEDURE.
/* Write row of data into one sample of an image. */
/* Only handles 8-bit data and images with 1 or more samples of 8 bits each. */
/* Channels are somewhat logical properties of an image, samples are */
/* just the bytes in a pixel - sample 0 is byte 0, sample 1 is byte 1, etc. */

/* Safe versions of ReadRow and WriteRow, handy for .NET languages */
PROCEDURE DIB_WriteRowSafe EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER r AS LONG.
  DEFINE INPUT PARAMETER pdata AS MEMPTR.
  DEFINE INPUT PARAMETER nbMax AS LONG.
END PROCEDURE.
PROCEDURE DIB_ReadRowSafe EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nRow AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
  DEFINE INPUT PARAMETER nbMax AS LONG.
END PROCEDURE.

PROCEDURE DIB_Allocate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nDepth AS LONG.
  DEFINE INPUT PARAMETER nWidth AS LONG.
  DEFINE INPUT PARAMETER nHeight AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create a DIB with the given dimensions.  Resolution is set to 0.  A default */
/* color table is provided if depth <= 8. */
/* The image data is uninitialized i.e. garbage. */

PROCEDURE DIB_Create EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPixelType AS LONG.
  DEFINE INPUT PARAMETER nWidth AS LONG.
  DEFINE INPUT PARAMETER nHeight AS LONG.
  DEFINE INPUT PARAMETER nDepth AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create a DIB of the given pixel type and dimensions. */
/* If nDepth <= 0, uses the default depth for the given pixel type. */
/* Resolution is set to 0. */
/* For TWPT_GRAY images, a standard black-to-white color table is set. */
/* For TWPT_PALETTE images, a Windows-standard 256-entry color table is set. */

PROCEDURE DIB_Free EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* Release the storage of the DIB. */

PROCEDURE DIB_FreeArray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
END PROCEDURE.
/* Release storage for n DIBs in array. */

/* under consideration for EZTwain 3.4 or 4.0 */
/* void EZTAPI DIB_FreeAll(void); */
/* // Free all DIB handles created by EZTwain but not yet freed. */
/* // This is convenient at the end of a complex scanning function, if */
/* // you are not keeping any DIB images in memory: Call this */
/* // function and it cleans everything up.  This way you do not have to */
/* // individually free each DIB as soon as you are done with it. */


PROCEDURE DIB_InUseCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of DIBs 'outstanding' - allocated but not disposed of. */
/* Note that a DIB that is put on the clipboard becomes the property of the */
/* clipboard and is considered 'disposed of'. */
/* This function can be used to detect leaks in application DIB management. */

PROCEDURE DIB_Copy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a byte-for-byte copy of a DIB. */

PROCEDURE DIB_Equal EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib1 AS LONG.
  DEFINE INPUT PARAMETER hdib2 AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if the two dibs are valid, have the same parameters, */
/* and are the same color pixel-for-pixel. */

PROCEDURE DIB_MaxError EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib1 AS LONG.
  DEFINE INPUT PARAMETER hdib2 AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* return the largest difference between two samples in the two images. */

PROCEDURE DIB_SetGrayColorTable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* Fill the DIB's color table with a gray ramp - so color 0 is black, and */
/* the last color (largest pixel value) is white.  No effect if depth > 8. */
PROCEDURE DIB_SetColorTableRGB EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
END PROCEDURE.
/* Set the ith entry in the DIB's color table to the specified color. */
/* R G and B range from 0 to 255. */

PROCEDURE DIB_IsVanilla EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TRUE if in this DIB, pixel value 0 means 'white'. */
PROCEDURE DIB_IsChocolate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TRUE if in this DIB, pixel value 0 means 'black'. */

PROCEDURE DIB_ColorTableR EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_ColorTableG EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_ColorTableB EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the R,G, or B component of the ith color table entry of a DIB. */
/* If i < 0 or >= DIB_ColorCount(hdib), returns 0. */

PROCEDURE DIB_FlipVertical EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* Flip (mirror) the bitmap vertically. */
/* Top and bottom rows are exchanged, etc. */

PROCEDURE DIB_FlipHorizontal EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* Flip (mirror) the bitmap horizontally. */
/* Leftmost pixels become rightmost, etc. */

PROCEDURE DIB_Rotate180 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* Rotate image 180 degrees */

PROCEDURE DIB_Rotate90 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER nSteps AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a copy of hOld rotated clockwise nSteps * 90 degrees. */
/* If nSteps is 0, the result is a copy of hOld. */
/* Negative values of nSteps rotate counterclockwise. */
/* Note that *hOld is not destroyed* */

PROCEDURE DIB_InPlaceRotate90 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nSteps AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* like DIB_Rotate90, but modifies the hdib. */

PROCEDURE DIB_Fill EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
END PROCEDURE.
/* Fill the DIB with the specified color */

PROCEDURE DIB_FillRectWithColorAlpha EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
  DEFINE INPUT PARAMETER A AS LONG.
END PROCEDURE.
/* Fill the specified rectangle in the image with the specified color using transparency=A */
/* A = 0  is transparent (so the fill has no effect) */
/* A = 255 is opaque,  */

PROCEDURE DIB_Negate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.

PROCEDURE DIB_AdjustBC EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nB AS LONG.
  DEFINE INPUT PARAMETER nC AS LONG.
END PROCEDURE.
/* *** BETA - new in 3.08b8 - use with caution. */
/* Adjust the brightness and/or contrast of the image. */
/* nB and nC are -1000 to 1000, with a value of 0 meaning 'no change'. */
/* Positive nB push all pixels toward white, negative toward black. */
/* Positive nC push all pixels away from mid-value, toward black and white. */
/* Negative nC pushes all pixels toward the mid-value. */
/* Works on grayscale, RGB, CMY(K) images - no effect on B&W and palette. */

PROCEDURE DIB_ApplyToneMap8 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER map1 AS MEMPTR.
END PROCEDURE.
/* Apply an 8-bit tone map to an image. */
/* For each pixel in hdib, calculate the 8-bit intensity (luminance) value of */
/* the pixel. Then replace the pixel's value with the nearest value */
/* whose intensity is map[v]. */

PROCEDURE DIB_AutoContrast EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Automatically adjust the values in the image to make */
/* the dominant light color into white, and the primary dark tone into black. */

PROCEDURE DIB_Convolve EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER hdibKernel AS LONG.
  DEFINE INPUT PARAMETER dNorm AS DOUBLE.
  DEFINE INPUT PARAMETER nOffset AS LONG.
END PROCEDURE.
/* Apply hdibKernel as a convolution kernel to hdibDst. */
/* At each pixel in hdibDst, hdibKernel is convolved with the neighborhood */
/* and the result is stored back into hdibDst. */
/* The point value of the convolution is normalized by dividing by dNorm, and */
/* then nOffset is added, before clipping to the pixel range of hdibDst. */

PROCEDURE DIB_Correlate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER hdibKernel AS LONG.
END PROCEDURE.
/* Similar to DIB_Convolve, but performs a correlation between hdibDst and hdibKernel, */
/* assuming that hdibKernel is image data (preferably grayscale), and putting */
/* the result into hdibDst. */

PROCEDURE DIB_CrossCorrelate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER hdibTemplate AS LONG.
  DEFINE INPUT PARAMETER dScale AS DOUBLE.
  DEFINE INPUT PARAMETER nMin AS LONG.
END PROCEDURE.
/* Similar to DIB_Convolve, but performs a cross-correlation between hdibDst and hdibTemplate, */
/* assuming that hdibTemplate is grayscale image data, and putting */
/* the result into hdibDst.  In the output, a value of 255 signifies perfect correlation, */
/* 0 signifies perfect non-correlation (actually, a perfect opposite). */
/* All output values are divided by dScale. */
/* If nMin > 0, the correlation at each output pixel stops as soon as the value at that */
/* pixel is known to be <= nMin.  If you know that the values of interest are (say) > 200, */
/* setting a dMin of 128 can speed up the correlation greatly. */

PROCEDURE DIB_HorizontalDifference EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.

PROCEDURE DIB_HorizontalCorrelation EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
PROCEDURE DIB_VerticalCorrelation EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.

PROCEDURE DIB_MedianFilter EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER W AS LONG.
  DEFINE INPUT PARAMETER H AS LONG.
  DEFINE INPUT PARAMETER nStyle AS LONG.
END PROCEDURE.
/* Apply a median filter to hdib using an W x H neighborhood. */
/* nStyle is currently ignored, but should be 0 for future compatibility. */

PROCEDURE DIB_MeanFilter EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER W AS LONG.
  DEFINE INPUT PARAMETER H AS LONG.
END PROCEDURE.
/* Replace each pixel with the average of a W x H pixel neighborhood. */
/* We recommend you use odd value for W and H. */

PROCEDURE DIB_Smooth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sigma AS DOUBLE.
  DEFINE INPUT PARAMETER opacity AS DOUBLE.
END PROCEDURE.
/* Apply a (gaussian) smoothing filter to the image. */
/* sigma is the controlling parameter of the Gaussian */
/* G(x,y) = exp(-(x^2+y^2) / 2*sigma^2) / (2 * pi * sigma^2) */
/* opacity is the fraction of the filter output that is blended */
/* back into the image i.e. out = in*(1-opacity) + f(in)*opacity */

PROCEDURE DIB_Sobel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER mode AS LONG.
  DEFINE INPUT PARAMETER Thresh AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the Sobel-edge filtered image. */
/* mode: */
&GLOBAL-DEFINE SOBEL_HORIZONTAL 0
&GLOBAL-DEFINE SOBEL_VERTICAL 1
&GLOBAL-DEFINE SOBEL_SUM 2
&GLOBAL-DEFINE SOBEL_MAX 3

PROCEDURE DIB_ScaledCopy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a new image - which is a copy of hOld */
/* but scaled (resampled) to have width w and height h. */
/* The input image must be of type TWPT_BW, TWPT_GRAY, or TWPT_RGB. */
/* If the input image is of type TWPT_BW, the returned image will be */
/* 8-bit grayscale. */
/* Otherwise the output image has the same type and depth as the input. */
/* *Don't forget to DIB_Free the old DIB when you are done with it. */

PROCEDURE DIB_Resize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Scale image to new pixel dimensions. */
/* The resolution (DPI) values are not changed. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE DIB_ScaleToGray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibOld AS LONG.
  DEFINE INPUT PARAMETER nRatio AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a new DIB containing the hdibOld image */
/* converted to grayscale and reduced in width & height by nRatio. */
/* Works well on B&W images. */

PROCEDURE DIB_Thumbnail EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibSource AS LONG.
  DEFINE INPUT PARAMETER MaxWidth AS LONG.
  DEFINE INPUT PARAMETER MaxHeight AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a DIB containing a copy of hdibSource, scaled so that its width */
/* is no more than MaxWidth, and height is no more than MaxHeight. */
/* B&W images are converted to grayscale thumbnails. */
/* Remember to DIB_Free hdibSource and the thumbnail, when you are done with them. */

PROCEDURE DIB_Resample EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER xdpi AS DOUBLE.
  DEFINE INPUT PARAMETER ydpi AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a new image which is a copy of the old image, but resampled */
/* to the specified resolution. */
/* "Resampling" is the technical term for recomputing the pixels of */
/* an image, when you want to change the number of pixels in the image */
/* but not the physical size (like 8.5" x 11"). */
/* If you resample from 300DPI to 100DPI, you will have 1/3 as many rows, */
/* 1/3 as many columns, 1/9 as many pixels - but the pixels will be */
/* marked in the image as being 3 times as 'wide' and 'tall' - so the */
/* physical size of the image stays the same. */
/* This is the same as DIB_ScaledCopy, just looked at in a different way. */
/* DIB_Resample will fail if the input image as either resolution <= 0, */
/* or if either xdpi or ydpi is <= 0.  It can also fail with insufficient memory. */
/* Remember to DIB_Free the old DIB when you are done with it. */

PROCEDURE DIB_RegionCopy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER leftx AS LONG.
  DEFINE INPUT PARAMETER topy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER FillByte AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a portion of DIB hOld.  The copied region is a rectangle */
/* w pixels wide, h pixels high, starting at (x, y) in the hOld image, */
/* where (0,0) is the upper-left corner of hOld, visually. */
/* Pixels that don't fit into the new DIB are discarded. */
/* (So this function can be used to crop an image.) */
/* If the new DIB is taller or wider than the old, the new */
/* pixels are filled with bytes = fill.  Common values for */
/* fill are: */
/*                                -1 (or 255 or 0xFF) which fills with 1's producing white */
/* 0 which produces black fill. */

PROCEDURE DIB_AutoCrop EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER nOpts AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a copy of its image argument, cropped to the 'actual document' */
/* within that image, if that can be determined by software. */
/* Uses RegionCopy (above). */
/* After this call, remember to DIB_Free(hOld) if you don't need it. */

&GLOBAL-DEFINE AUTOCROP_DARK 1
&GLOBAL-DEFINE AUTOCROP_LIGHT 2
&GLOBAL-DEFINE AUTOCROP_EDGE 4
&GLOBAL-DEFINE AUTOCROP_CHECK 8
&GLOBAL-DEFINE AUTOCROP_CHECK_BACK 16

/* note, we recommend not combining AUTOCROP_CHECK with DARK, LIGHT, or EDGE options. */

PROCEDURE DIB_GetCropRect EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nOptions AS LONG.
  DEFINE OUTPUT PARAMETER cropx AS LONG.
  DEFINE OUTPUT PARAMETER cropy AS LONG.
  DEFINE OUTPUT PARAMETER cropw AS LONG.
  DEFINE OUTPUT PARAMETER croph AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a suggested crop rectangle to remove a dark border from the image. */
/* The rectangle is defined by an upper-left point and a width and height, in pixels. */
/* (As needed by DIB_RegionCopy above.) */
/* nOptions is currently unused and must be 0. */
/* DIB_AutoCrop uses this function to decide what to crop. */
/* A return of FALSE means no crop rectangle was found - generally this means */
/* that the image has content that extends to the edges, or has no definite borders */
/* of dark color.  For convenience, when this function returns FALSE it */
/* still returns a valid crop rectangle containing the entire image. */

PROCEDURE DIB_AutoDeskew EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER nOptions AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns a copy of the image in hOld, possibly 'deskewed'. */
/* If it can be determined that the input image is consistently */
/* skewed (rotated by a small angle) then the returned image is rotated */
/* to eliminate that skew. */
/* The depth and pixel type of the image are not changed. */
/* The dimensions of the returned image may be slightly changed. */
/* nOptions is currently unused and must be 0 (zero). */

PROCEDURE DIB_DeskewAngle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Compute and return the small clockwise rotation that would best */
/* 'deskew' the given image.  The return value is that angle */
/* in radians.  Only rotations in the range +-4 degrees are considered. */

PROCEDURE DIB_SkewByDegrees EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER dAngle AS DOUBLE.
END PROCEDURE.
/* Skew the given image clockwise in place by the specified angle (in degrees) */

PROCEDURE DIB_ConvertToPixelType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a new DIB containing the hOld image converted */
/* to the specified pixel type.  Supported pixel types are: */
/* TWPT_BW, TWPT_GRAY, TWPT_RGB, TWPT_PALETTE, TWPT_CMY or TWPT_CMYK. */
/* When converting to black & white (TWPT_BW) the default conversion */
/* is simple thresholding - each pixel is converted to grayscale, */
/* then values 0..127 => Black, 128..255 => White. */

PROCEDURE DIB_ConvertToFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hOld AS LONG.
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE INPUT PARAMETER nBPP AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a new DIB containing the hOld image converted */
/* to the specified pixel type and bits per pixel. */
/* Unsupported and impossible combinations cause a NULL return. */

PROCEDURE DIB_SmartThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Apply automatic, adaptive thresholding to hdib, return */
/* the resulting 1-bit image.  This function is optimized for */
/* thresholding scanned text. */
/* ** Remember to free the input image if you are done with it. */

PROCEDURE DIB_SimpleThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nT AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Threshold hdib against nT and return the resulting 1-bit image. */
/* nT should be in the range 0 to 255. */
/* Pixels that are darker than nT become black in the output, */
/* pixels that are equal to or lighter than nT become white. */
/* ** Remember to free the input image if you are done with it. */

PROCEDURE DIB_SetConversionThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nT AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_ConversionThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the threshold used by DIB_ConvertToPixelType above */
/* when converting to B&W.  The default value is 128 which means '50%'. */
/* Pixels lighter than 50% => white, darker => black. */
/* DIB_SetConversionThreshold returns the previous value of the threshold. */

PROCEDURE DIB_FindAdaptiveGlobalThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Find the adaptive threshold for input image */

PROCEDURE DIB_ErrorDiffuse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a new DIB containing the input image rendered */
/* to 1-bit B&W using error diffusion. The input image is not modified. */

PROCEDURE DIB_SetConversionColorCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER n AS LONG.
END PROCEDURE.
PROCEDURE DIB_ConversionColorCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the number of colors that will be used in the next */
/* call to DIB_ConvertToPixelType or DIB_ConvertToFormat, if */
/* the output type is TWPT_PALETTE. */

PROCEDURE DIB_SwapRedBlue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* For 24-bit DIB only, exchange R and B components of each pixel. */

PROCEDURE DIB_CreatePalette EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a logical palette to be used for drawing the DIB. */
/* For 1, 4, and 8-bit DIBs the palette contains the DIB color table. */
/* For 24-bit DIBs, a default halftone palette is returned. */

PROCEDURE DIB_SetColorModel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nCM AS LONG.
END PROCEDURE.
PROCEDURE DIB_ColorModel EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
&GLOBAL-DEFINE EZT_CM_RGB 0
&GLOBAL-DEFINE EZT_CM_GRAY 3
&GLOBAL-DEFINE EZT_CM_CMYK 5

PROCEDURE DIB_SetColorCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
END PROCEDURE.

PROCEDURE DIB_Blt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER dx AS LONG.
  DEFINE INPUT PARAMETER dy AS LONG.
  DEFINE INPUT PARAMETER hdibSrc AS LONG.
  DEFINE INPUT PARAMETER sx AS LONG.
  DEFINE INPUT PARAMETER sy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER uRop AS LONG.
END PROCEDURE.
/* Transfer pixels from hdibSrc into hdibDst, starting at */
/* (dx,dy) in the destination, and (sx,sy) in the source, */
/* and transferring w columns x h rows. */
/* Any pixels that fall outside the actual bounds of the source */
/* and destination DIBs are ignored. */
/* The operations available are: */
&GLOBAL-DEFINE EZT_ROP_COPY 0
&GLOBAL-DEFINE EZT_ROP_OR 1
&GLOBAL-DEFINE EZT_ROP_AND 2
&GLOBAL-DEFINE EZT_ROP_XOR 3
&GLOBAL-DEFINE EZT_ROP_ANDNOT 18

PROCEDURE DIB_BltMask EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER dx AS LONG.
  DEFINE INPUT PARAMETER dy AS LONG.
  DEFINE INPUT PARAMETER hdibSrc AS LONG.
  DEFINE INPUT PARAMETER sx AS LONG.
  DEFINE INPUT PARAMETER sy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER uRop AS LONG.
  DEFINE INPUT PARAMETER hdibMask AS LONG.
END PROCEDURE.
/* Like DIB_Blt, but hdibMask contains an 8-bit alpha mask that controls */
/* how hdibSrc and hdibDst pixels are blended.  hdibMask must be the */
/* same size as hdibSrc, and be 8-bits deep. */
/* NOTE: The only uRop currently supported is EZT_ROP_COPY */

PROCEDURE DIB_PaintMask EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER dx AS LONG.
  DEFINE INPUT PARAMETER dy AS LONG.
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
  DEFINE INPUT PARAMETER sx AS LONG.
  DEFINE INPUT PARAMETER sy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER uRop AS LONG.
  DEFINE INPUT PARAMETER hdibMask AS LONG.
END PROCEDURE.
/* Like DIB_BltMask - but paints a solid color into the destination DIB */
/* using hdibMask as a mask or stencil.  The mask must be an 8-bit */
/* grayscale image. The each mask pixel controls how much paint is mixed */
/* into the corresponding destination pixel: white=100%, black=0%. */
/* if w == -1 or h == -1 it means "as much as possible" */
/* NOTE: The only uRop currently supported is EZT_ROP_COPY */
/* See the User Guide for details. */

PROCEDURE DIB_DrawLine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER x1 AS LONG.
  DEFINE INPUT PARAMETER y1 AS LONG.
  DEFINE INPUT PARAMETER x2 AS LONG.
  DEFINE INPUT PARAMETER y2 AS LONG.
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
END PROCEDURE.

PROCEDURE DIB_DrawText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibDst AS LONG.
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE INPUT PARAMETER leftx AS LONG.
  DEFINE INPUT PARAMETER topy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
END PROCEDURE.
/* Draw the text string into the DIB inside the given rectangle. */
/* If w or h is 0, the rectangle is extended to the bottom or right of the DIB. */
/* Default height is 14 pixels.  Default typeface is "Arial". */
/* Default color is black (R=G=B=0) */
/* See the following functions to override the default text settings. */

/* The following functions modify the default settings for DIB_DrawText: */
PROCEDURE DIB_SetTextColor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
END PROCEDURE.
PROCEDURE DIB_TextColor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* return the current text color as a 32-bit COLORREF (0x00BBGGRR) */
PROCEDURE DIB_GetTextColor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER pR AS LONG.
  DEFINE OUTPUT PARAMETER pG AS LONG.
  DEFINE OUTPUT PARAMETER pB AS LONG.
END PROCEDURE.
/* returns the current text color as R,G,B values to its three parameters. */

PROCEDURE DIB_SetTextAngle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nDegrees AS LONG.
END PROCEDURE.
/* Set the rotation of text within the drawing rectangle, clockwise. */
/* NOTE: Currently only multiples of 90 degrees are supported. */

PROCEDURE DIB_SetTextHeight EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nH AS LONG.
END PROCEDURE.
/* Set the text character height in pixels. */
/* If you want to set the text height in physical units (inches) */
/* multiply the physical height in inches by the DIB_YResolution. */
/* Note! Some files have resolution=0, which can often be treated as 72dpi */

PROCEDURE DIB_SetTextFace EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sTypeface AS CHARACTER.
END PROCEDURE.
/* Specify a typeface - Use a typeface that is available on the host system, */
/* or use a standard face such as Arial, MS San Serif, MS Serif. */
/* You can also specify "Courier" or "Times" as shortcuts for the classic */
/* fixed-width and serif fonts. */
/* Passing NULL or the empty string resets to the default face ("Arial") */

PROCEDURE DIB_SetTextFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFlags AS LONG.
END PROCEDURE.
/* Sets text format according to the following flags.  The default */
/* format is normal, top, left */
&GLOBAL-DEFINE EZT_TEXT_NORMAL 0
&GLOBAL-DEFINE EZT_TEXT_BOLD 1
&GLOBAL-DEFINE EZT_TEXT_ITALIC 2
&GLOBAL-DEFINE EZT_TEXT_UNDERLINE 4
&GLOBAL-DEFINE EZT_TEXT_STRIKEOUT 8
&GLOBAL-DEFINE EZT_TEXT_BOTTOM 256
&GLOBAL-DEFINE EZT_TEXT_VCENTER 512
&GLOBAL-DEFINE EZT_TEXT_TOP 0
&GLOBAL-DEFINE EZT_TEXT_LEFT 0
&GLOBAL-DEFINE EZT_TEXT_CENTER 4096
&GLOBAL-DEFINE EZT_TEXT_RIGHT 8192
&GLOBAL-DEFINE EZT_TEXT_WRAP 16384

PROCEDURE DIB_SetTextBackgroundColor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER R AS LONG.
  DEFINE INPUT PARAMETER G AS LONG.
  DEFINE INPUT PARAMETER B AS LONG.
  DEFINE INPUT PARAMETER A AS LONG.
END PROCEDURE.
/* Set the text background color, including transparency (alpha). */
/* RGB are color components, 0..255 */
/* A is the alpha channel, from 0=100% transparent to 255=100% opaque. */

/* ///////////////////////////////////////////////////////////////////// */
/* Image viewing services */

PROCEDURE DIB_View EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sTitle AS CHARACTER.
  DEFINE INPUT PARAMETER hwndParent AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Display the given image in a window with the given title. */
/* hwndParent is the window handle of the parent window - if you */
/* use 0 (NULL) for this parameter, EZTwain uses the active window */
/* of the application if there is one, or no parent window. */
/* By default, the window contains just an [OK] button. */
/* The style of the window is a resizable dialog box. */
/* 0    = the [Cancel] button was pressed. */
/* 1    = the [OK] button was pressed. */

PROCEDURE DIB_SetViewOption EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sOption AS CHARACTER.
  DEFINE INPUT PARAMETER sValue AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Same as TWAIN_SetViewOption. */

PROCEDURE DIB_SetViewImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* If the image viewer is open, change the displayed image to this one. */

PROCEDURE DIB_IsViewOpen EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return True if the image-view window is open, False otherwise. */
/* Note that the image viewer can be hidden, so it could be open */
/* and not be visible. */

PROCEDURE DIB_ViewClose EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Close the image viewer window, if it is open. */
/* Only applies if the image viewer has been opened with the modeless option. */
/* Same as TWAIN_ViewClose. */

PROCEDURE DIB_DrawOnWindow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER hwnd AS LONG.
END PROCEDURE.
/* Draw the DIB on the window. */
/* The image is scaled to just fit inside the window, while */
/* keeping the correct aspect ratio.  Any part of the window */
/* not covered by the image is left untouched (so it will normally */
/* be filled with the window's background color.) */

PROCEDURE DIB_DrawToDC EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER hDC AS LONG.
  DEFINE INPUT PARAMETER dx AS LONG.
  DEFINE INPUT PARAMETER dy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER sx AS LONG.
  DEFINE INPUT PARAMETER sy AS LONG.
END PROCEDURE.
/* Draws DIB on a device context. */
/* You should call CreateDibPalette, select that palette */
/* into the DC, and do a RealizePalette(hDC) first. */

/* ///////////////////////////////////////////////////////////////////// */
/* Printing services */

PROCEDURE DIB_SpecifyPrinter EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sPrinterName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Specify the printer to be used when printing to the 'default printer' */
/* with the following functions. */
/* This does not change the user's default printer - it just tells */
/* EZTwain which printer to use as 'default'. */
/* Setting the printer name to NULL or the empty string tells EZTwain to */
/* use the user's default printer as its default printer. */

PROCEDURE DIB_EnumeratePrinters EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of available printers */

PROCEDURE DIB_PrinterName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the name of the ith available printer, as found */
/* by a previous call to DIB_EnumeratePrinters. */

PROCEDURE DIB_GetPrinterName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER PrinterName AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get the name of the ith available printer, as found by a previous */
/* call to DIB_EnumeratePrinters. */
/* You must allocate 256 characters for the printer name, and in many */
/* languages (especially Basic dialects) you must initialize the */
/* PrinterName variable with 256 spaces. */

PROCEDURE DIB_SetPrintToFit EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE DIB_GetPrintToFit EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get/Set the 'Print To Fit' flag. */
/* When this flag is non-zero, EZTwain reduces the size of images */
/* to fit within the printer page.  This only affects images that */
/* are too large to fit on the page. */
/* By default, this flag is FALSE (0) */

PROCEDURE DIB_Print EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Prompt the user with a Print Dialog, then print the DIB. */
/* Normally prints the DIB at 'actual size' - meaning the resolution */
/* values are used to convert the width and height from pixels to physical */
/* units (e.g. inches.) */
/* If the PrintToFit flag (see DIB_SetPrintToFit) is set and the image */
/* is larger than the printer page, the image is scaled to fit on the page. */
/* If the DIB has resolution values of 0, 72 DPI is assumed. */
/* The image is printed centered on the page. */
/* Return values: */
/* 0  success, no error */
/* -2  specified printer not recognized or could not be opened */
/* -3  invalid DIB handle (null, or DIB has been freed, or isn't a DIB handle) */
/* -4  could not start document or start page error during printing */
/* -10  user cancelled a dialog (probably the Print dialog) */

PROCEDURE DIB_PrintNoPrompt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Identical to DIB_Print, but prints on the default printer with */
/* default settings - the user is not prompted. */


PROCEDURE TWAIN_PrintFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE INPUT PARAMETER bNoPrompt AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_PrintFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE INPUT PARAMETER bNoPrompt AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Print the specified file as a print job with the specified job name. */
/* If the filename is null or empty, the user is prompted to select a file. */
/* If the jobname is null or empty, the actual filename is used as the jobname. */
/* If bNoPrompt is non-zero (True) the job is sent to the default printer, */
/* If bNoPrompt is zero (False) the user is prompted with the standard Print dialog. */

/* Printing - Multi-Page */


PROCEDURE DIB_PrintArray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER nCount AS LONG.
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE INPUT PARAMETER bNoPrompt AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Print the first nCount images in the array ahdib, under the given print-job name. */

/* If the job-name parameter is NULL or the empty string, the application title is used. */
/* If bNoPrompt is TRUE(non-zero), prints to the default printer without prompting the user, */
/* If bNoPrompt is FALSE(0) this function displays the standard print dialog. */

/* Return value is same as DIB_Print above. */

PROCEDURE DIB_SetNextPrintJobPageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPages AS LONG.
END PROCEDURE.
/* If you are about to call DIB_PrintJobBegin, you can call this function */
/* *before* calling that one, to set the page count for the next print job. */
/* This allows the print dialog to enable the page-range controls, so the */
/* user can designate a range of pages to print. */

/* Do not call this function unless you are calling DIB_PrintJobBegin directly. */

/* A page count of 0 or less means 'unknown page count', which disables */
/* the page-range controls. */
/* If you enable print-range selection in the print dialog, EZTwain */
/* automatically suppresses printing of all non-selected pages. */

PROCEDURE DIB_PrintJobBegin EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sJobname AS CHARACTER.
  DEFINE INPUT PARAMETER bUseDefaultPrinter AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Begin creating a multi-page print job. */

/* Jobname is the name of the print job. */
/* The jobname appears in the job-queue of the printer. */
/* In some environments it also appears on a job-separator */
/* page that is printed out ahead of each job. */
/* If Jobname is null or empty, the application title is used. */
/* (See TWAIN_SetAppTitle) */

/* If bUseDefaultPrinter is true (non-zero) the default printer */
/* is used, otherwise the user is prompted with a standard Print dialog. */

/* If you have called DIB_SetNextPrintJobPageCount (above) then the print */
/* dialog will offer the user the option of specifying a range of pages */
/* to print.  Otherwise that option is disabled and all pages are printed. */

/* If there is already a print job open when this function is called, */
/* it calls DIB_PrintJobEnd() to close that job before starting the new one. */

/* Return values: */
/* 0       success */
/* -2       could not open/access printer */
/* -4       printing output error */
/* -10       user cancelled Print dialog */

PROCEDURE DIB_PrintPage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Add a page to the current print job. */

/* Only valid after a successful call to DIB_PrintJobBegin and */
/* before the matching DIB_PrintJobEnd. */

/* See DIB_Print for more details. */
/* 0       success */
/* -3       the DIB is null or invalid */
/* -4       printing output error */
/* -5       no print job is open */

PROCEDURE DIB_PrintJobEnd EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* End the current print job and release it for printing. */
/* (Some environments will start printing as soon as a page is available.) */
/* 0       success */
/* -4       printing output error */
/* -5       no print job is open */

/* ///////////////////////////////////////////////////////////////////// */
/* Clipboard functions */

PROCEDURE DIB_PutOnClipboard EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Place DIB on the clipboard (format CF_DIB) */
/* ** IMPORTANT ** After this call, the clipboard owns the */
/* DIB and you do not - do not attempt any */
/* further operations on the hdib handle. */
/* Treat this call just as you would a call to DIB_Free. */
/* Returns TRUE(1) for success, FALSE(0) otherwise. */

PROCEDURE DIB_CanGetFromClipboard EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE(1) if there is something on the clipboard that */
/* can be delivered as a DIB (by DIB_GetFromClipboard below.) */
/* Return FALSE(0) if not. */

PROCEDURE DIB_GetFromClipboard EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_FromClipboard EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create and return a DIB with the contents of the clipboard. */
/* This is the first step of a 'paste' function for images. */
/* Returns NULL in case of error, or if no image on clipboard. */

/* Working with a DIB through a DC */

PROCEDURE DIB_OpenInDC EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER hdc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_CloseInDC EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER hdc AS LONG.
END PROCEDURE.

/* DIB File I/O */

PROCEDURE DIB_WriteToFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write image to file, using format implied by the filename extension. */

/* If the filename is NULL or points to a null string, the user is */
/* prompted for the filename and format with a standard Windows */
/* file-save dialog. */

/* If the final filename has a standard extension (.bmp, .jpg, .jpeg, .tif, */
/* .tiff, .png, .pdf, .gif, .dcx) then the file is saved in that format. */
/* Otherwise, the current SaveFormat is used - see TWAIN_SetSaveFormat. */

/* Return values: */
/*                                 0                                success */
/*                                -1                                user cancelled File Save dialog */
/*                                -2                                file open error (invalid path or name, or access denied) */
/*                                -3                                a) image is invalid (null or invalid DIB handle) */
/* b) support for the save format is not configured */
/* c) DIB format incompatible with save format e.g. B&W to JPEG. */
/*                                -4                                writing data failed, possibly output device is full */
/* -5  other unspecified internal error */

PROCEDURE DIB_WriteToBmp EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToBmpFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER fh AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToJpeg EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToPng EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToTiff EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToPdf EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToGif EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_WriteToDcx EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Note: a return value of -3 indicates an invalid hdib handle, or */
/* 'no support for this format'.  -3 is also returned when attempting */
/* to write a Jpeg file from an image that is not 24-bit color or */
/* 8-bit grayscale.  1-bit B&W images cannot be saved as JPEG. */
/* 24-bit color images are 'quantized' to 8-bit color when written to GIF. */
/* All image types are converted to 1-bit B&W when written to DCX. */
/* Other internal errors will return -5, including insufficient memory. */
/* Check TWAIN_LastErrorCode for more details (maybe) */

PROCEDURE DIB_LoadFromFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load an image from a file and return its handle. */
/* The file can be in any format supported by EZTwain Pro. */
/* If the file is multipage, normally this function loads page 0, */
/* but a preceding call to DIB_SelectPageToLoad changes that. */
/* A return of NULL(0) indicates failure, see TWAIN_LastErrorCode */
/* and related functions for more details. */
/* If the filename is an empty string (or NULL) the user is prompted */
/* with a standard file-open dialog. */
/* EZTwain should read any variant of its supported formats, */
/* except for PDF: We only claim to support reading images */
/* from PDFs if they were created by EZTwain Pro. */

PROCEDURE DIB_FormatOfFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the EZT_FF_ code for the format of the specified file. */
/* A return < 0 indicates 'unrecognized format' or some error */
/* when opening or reading the file. */

PROCEDURE DIB_SelectPageToLoad EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPage AS LONG.
END PROCEDURE.
/* For use when loading multipage files.  Tells DIB_LoadFromFilename */
/* and DIB_LoadFromBuffer which page to load next, from a multipage file. */
/* Default is page 0 (first page in file). */
/* This value is reset to 0 after any call that tries to load a page. */

PROCEDURE DIB_GetFilePageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_FilePageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of pages in the specified file. */
/* If the file is a recognized multipage format */
/* (TIFF, PDF, DCX), the pages in the file are counted. */
/* All other recognized formats return a page count of 1. */
/* If the file cannot be opened, read, recognized, etc. */
/* this function records an error and returns -1. */

PROCEDURE DIB_LoadPage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE INPUT PARAMETER nPage AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Short for DIB_SelectPageToLoad, DIB_LoadFromFilename. */
/* Load the specified page from the specified file. */
/* Page 0 is the first page in a file.  Multiple */
/* pages are only supported in TIFF, PDF and DCX files, all other file */
/* formats have a single page, page 0 */

PROCEDURE DIB_LoadArrayFromFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER nMax AS LONG.
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load up to nMax images as DIBs into an array, reading from the specified file. */
/* If filename is null or the empty string, the user is prompted to select a file. */

/* If the user is prompted and cancels, this function returns -10. */
/* Otherwise if successful it returns the number of pages (images) loaded. */
/* Otherwise it returns -1 and you should call TWAIN_ReportLastError, TWAIN_LastErrorCode,etc. */

/* If this function returns < 0, the first nMax entries of the DIB array will be NULL (0). */
/* If returns N >= 0, the first N entries of the DIB array will */
/* contain handles to DIBs representing the first N images in the file. */
/* The remaining nMax-N entries in the DIB array will be NULL (0). */

/* Make sure you eventually call DIB_Free on all the loaded DIBs! */

PROCEDURE DIB_LoadPagesFromFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER index0 AS LONG.
  DEFINE INPUT PARAMETER nMax AS LONG.
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load up to nMax images from a specified file (or URL), starting at page index0. */
/* Remember pages are indexed from 0. */
/* Returns the number of images loaded - which can be 0 if there are no images */
/* in the file within the specified range. */
/* Returns -1 in case of error, call TWAIN_LastErrorCode & co. for more details. */

PROCEDURE DIB_FormatOfBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Assuming the buffer contains something like an image file, return */
/* the format implied by the leading bytes. */
/* nBytes = number of bytes of data in buffer. */

PROCEDURE DIB_PageCountOfBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_BufferPageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Assuming the buffer contains something like an image file, return */
/* the number of pages (images technically) in it. */
/* nBytes = number of bytes of data in buffer. */

PROCEDURE DIB_LoadFromBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load an image from a buffer, presumably formatted like an image file. */
/* If DIB_SelectPageToLoad was called just before, the */
/* designated page is loaded from the buffer. */
/* nBytes = number of bytes of data in buffer. */

PROCEDURE DIB_LoadPageFromBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE INPUT PARAMETER nPage AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load the specified page from a buffer - the buffer must contain an image */
/* file.  If the image format is one that can hold only one image, the page */
/* number is ignored. */
/* nBytes = number of bytes of data in buffer. */

PROCEDURE DIB_LoadArrayFromBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER nMax AS LONG.
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load up to nMax images as DIBs into an array, reading from a file in memory. */
/* pBuffer is the address of the buffer (memory block) holding the file to read. */
/* nBytes is the number of bytes of data in the buffer. */

/* Returns the number of images loaded if successful, otherwise */
/* it returns -1 and you should call TWAIN_ReportLastError, TWAIN_LastErrorCode, or similar. */

/* Make sure you eventually call DIB_Free on all the loaded DIBs. */

PROCEDURE DIB_LoadFaxData EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE INPUT PARAMETER nFlags AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load a DIB's contents from a buffer of CCITT fax-encoded data. */
/* pBuffer is the address of the buffer in memory. */
/* nBytes is the number of bytes of data in the buffer. */
/* nFlags are decoding options: */
/* Override with flags: */
&GLOBAL-DEFINE FAX_GROUP3_2D 32
&GLOBAL-DEFINE FAX_GROUP4 64
&GLOBAL-DEFINE FAX_BYTE_ALIGNED 128
&GLOBAL-DEFINE FAX_REQUIRE_EOLS 256
&GLOBAL-DEFINE FAX_EXPECT_EOB 512
&GLOBAL-DEFINE FAX_VANILLA 1024
/* default is Group3 1D, chocolate, not byte-aligned, EOLs not required, EOB not expected. */


PROCEDURE DIB_WriteToBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nFormat AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nbMax AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write the image into the buffer in the format, not more than nbMax bytes. */
/* The return value is the actual size of the image - this may be more or less */
/* than nbMax.  If the return value > nbMax, it means only part of the image */
/* was written, and the buffer needs to be bigger. */
/* If pBuffer is NULL, no data is written - the function just returns the required */
/* buffer size in bytes. */
/* A return value of <= 0 indicates an error, such as */
/* The image is invalid (null or invalid DIB handle) */
/* The format is unrecognized, not supported, not installed, etc. */
/* You can't save that image in that format e.g. B&W image to JPEG format. */
/* Insufficient memory for temporary data structures (or corrupted heap) */
/* Other internal failure. */
/* You can call TWAIN_LastErrorCode and similar functions for more details. */

PROCEDURE DIB_WriteArrayToBuffer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER nFormat AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nbMax AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* A combination of DIB_WriteArrayToFilename and DIB_WriteToBuffer. */
/* Writes n images to a memory buffer in the specified format. */
/* See DIB_WriteToBuffer above for the meaning of pBuffer and nbMax. */
/* Return value: See DIB_WriteToBuffer above. */



PROCEDURE DIB_ToDibSection EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Converts the given DIB into a kind of bitmap called a DibSection. */
/* *** IMPORTANT: The input DIB is consumed and becomes invalid *** */
/* A DibSection is a special kind of HBITMAP.  Many languages */
/* and imaging classes (such as GDI+, .NET Image, Delphi TBitmap) do */
/* not easily accept DIBs but readily accept a DibSection/HBITMAP. */

PROCEDURE DIB_FromBitmap EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hbm AS LONG.
  DEFINE INPUT PARAMETER hdc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create a DIB with the contents of a GDI bitmap (preferably a DibSection). */
/* >> The input bitmap is NOT deleted - the returned DIB is a copy. */
/* If hdc = 0 (NULL) a default HDC is used. */
/* See also: DIB_ToDibSection */

PROCEDURE DIB_IsBlank EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER dDarkness AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE(1) if the DIB has less than dDarkness fraction of 'dark' pixels. */
/* Return FALSE(0) otherwise. */
/* A typical value of dDarkness would be 0.02 which means 2% dark pixels. */
/* A page with less than 2% dark pixels is probably blank. */

PROCEDURE DIB_Darkness EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdibFull AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Returns the fraction of an image that consists of 'dark' pixels. */
/* These are pixels that would be black, if the image was converted */
/* to B&W using a smart thresholding.  See DIB_SmartThreshold. */
/* Used by DIB_IsBlank to decide if an image is blank. */
/* A return of 0.0 means none, 1.0 means all.  A typical office */
/* document is 0.02 (2%) to 0.32 (32%) dark pixels. */

PROCEDURE DIB_GetHistogram EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComponent AS LONG.
  DEFINE OUTPUT PARAMETER histo AS MEMPTR.
END PROCEDURE.
/* Count the number of occurences of each value of the specified component */
/* in the given DIB (see component codes below).  Put the counts */
/* of each value (0..255) into the histo array. */
/* The histo array *must* be an array of 256 32-bit integers. */
/* Only works on B&W, grayscale, palette, and 24-bit RGB images. */
/* Example: If hdib contains 237 pixels with a grayscale value of 17, then */
/* this call will return histo[17] = 237.  Components are normalized */
/* into the range 0..255. */
/* Note: If hdib is a 1-bit B&W image, then histo will be all 0's, except */
/* for hist[0] (black) and hist[255] (white). */

/* Component codes: */
&GLOBAL-DEFINE COMPONENT_GRAY 0
&GLOBAL-DEFINE COMPONENT_RED 1
&GLOBAL-DEFINE COMPONENT_GREEN 2
&GLOBAL-DEFINE COMPONENT_BLUE 3
&GLOBAL-DEFINE COMPONENT_LUMINANCE 0
&GLOBAL-DEFINE COMPONENT_SAT 4
&GLOBAL-DEFINE COMPONENT_HUE 5

/* For gray and B&W images, R, G, and B components are equal, and Hue and Sat are 0. */
/* Other components available upon request: support@dosadi.com */


PROCEDURE DIB_ComponentCopy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComponent AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Extract and return one component (channel) of the given image. */
/* The returned image is an 8-bit grayscale image containing the */
/* specified channel of the input image, with the same width, */
/* height, and DPI. */

/* Note: In future this function may return a 16-bit deep image */
/* when given a 16 bit/channel input image. */

PROCEDURE DIB_Avg EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE DIB_AvgRegion EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE INPUT PARAMETER leftx AS LONG.
  DEFINE INPUT PARAMETER topy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE DIB_AvgRow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE INPUT PARAMETER rowy AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE DIB_AvgColumn EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE INPUT PARAMETER colx AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Average the values of pixels in an image, region, row or column. */
/* Note that row 0 is the visually top-most row of an image. */
/* Averages either intensity (brightness) or individual color channels, */
/* or saturation. */
/* See component codes above, for DIB_GetHistogram. */
/* Regardless of image format, white = 255.0 and black = 0, even */
/* for 1-bit B&W or 16-bit grayscale or color images. */
/* DOES NOT SUPPORT: 4-bit/pixel images, CMY(K) images. */

PROCEDURE DIB_GetBrightRects EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER t AS LONG.
  DEFINE OUTPUT PARAMETER xBlob AS MEMPTR.
  DEFINE OUTPUT PARAMETER yBlob AS MEMPTR.
  DEFINE OUTPUT PARAMETER wBlob AS MEMPTR.
  DEFINE OUTPUT PARAMETER hBlob AS MEMPTR.
  DEFINE INPUT PARAMETER nMax AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Search the image for rectangular areas that are unusually bright. */

/* Return value: Number of rectangles found and returned.  Always <= nMax. */

/* Input parameters: */
/* w,h   are the minimum rectangle width & height, in pixels */
/* t     minimum average intensity value to be considered 'bright' */
/* nMax  maximum number of rectangles to return. */

/* Output parameters: */
/* xBlob array of long (32-bit int) values, receives x-coordinates of found rectangles */
/* yBlob ditto, for y-coordinates */
/* wBlob ditto, for widths of rectangles */
/* hBlob ditto, for heights of rectangles */


PROCEDURE DIB_ProjectRows EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DIB_ProjectColumns EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER leftx AS LONG.
  DEFINE INPUT PARAMETER topy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* These functions create and return a 1 row x N column image, containing */
/* the average value of the rows (columns) of the input image, in the */
/* specified channel (component). */
/* If the source image is <= 8-bit/sample, the result image is 8-bit/sample. */
/* If the source image is 16 bit/sample, so is the result image. */

PROCEDURE DIB_Posterize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nLevels AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.


/* --- EXPERIMENTAL: The following functions may be removed or changed at any time. */
PROCEDURE DIB_ForwardDCT EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

/* --- OBSOLETE: The following functions are for backward compatibility only: */
PROCEDURE TWAIN_WriteNativeToFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_LoadNativeFromFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* HDIB EZTAPI TWAIN_LoadNativeFromFile(HFILE fh); */
/* removed - contact Dosadi if this causes problems for you. */
PROCEDURE TWAIN_NegotiateXferCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nXfers AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibDepth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibWidth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibHeight EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibNumColors EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibRowBytes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DibReadRow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nRow AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER prow AS MEMPTR.
END PROCEDURE.
PROCEDURE TWAIN_CreateDibPalette EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_DrawDibToDC EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hDC AS LONG.
  DEFINE INPUT PARAMETER dx AS LONG.
  DEFINE INPUT PARAMETER dy AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sx AS LONG.
  DEFINE INPUT PARAMETER sy AS LONG.
END PROCEDURE.

/* --------- Documents */

/* The following functions provide an abstraction of a Document, */
/* represented by an opaque handle called an HDOC. */

/* A document is a sequence of 0 or more images. Documents can represent */
/* image files, or be entirely in memory, or a combination. They can be */
/* loaded, edited, saved, printed, and so on. */
/* . */
/* Images can be added to, deleted from, or re-ordered within a document. */
/* Individual images can be operated on using any of our DIB functions. */

/* Documents are modelled as containers for images, represented by DIBs. */
/* So for example, adding a DIB to a document does not copy the DIB, it */
/* places that actual image/DIB in the document. */

/* EZTwain keeps track of which DIBs are in which documents: If a DIB is */
/* 'freed' its destruction is deferred until no document contains it. */

PROCEDURE DOC_CreateEmpty EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create an empty document and return its handle. */
/* It has no associated file, 0 pages, and is marked unmodified. */

PROCEDURE DOC_Destroy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
END PROCEDURE.
/* Close and destroy the document object. */
/* Closes any associated open file. */
/* Does not save changes! Use DOC_Save or related functions. */

PROCEDURE DOC_ImageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of images in the document. */

PROCEDURE DOC_IsModified EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE if the document or any image in the document has been */
/* modified since the last operation that cleared the Modified flag. */

PROCEDURE DOC_SetModified EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER bIsMod AS LONG.
END PROCEDURE.

PROCEDURE DOC_Filename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return (a pointer to) the filename associated with this document. */
/* If there is no associated file, returns the empty string ("") */

PROCEDURE DOC_SetCurPos EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE DOC_CurPos EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/return the current position within the document. */
/* Intended as a way to designate an 'active' or selected page. */
/* The value of this property is normally >= 0 and < ImageCount, but */
/* can be -1 which conventionally means 'undefined' or 'no current position'. */
/* Operations that add, move, or remove pages may change the */
/* current position, see the descriptions of specific functions */
/* for details. */

PROCEDURE DOC_OpenReadOnly EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Open an image file for read-only access. */

/* If the filename is NULL or the empty string, the user is prompted */
/* to select a file in a supported format. */

/* Returns NULL (0) if the file does not exist or cannot be opened. */

/* This function opens the designated file for shared read-only access, */
/* the file cannot be opened for writing as long as this document */
/* has it open. */

/* Important: The returned document can be freely modified, the */
/* modifications will not (and cannot) be saved back to the file. */

PROCEDURE DOC_OpenForUpdate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Open an image file for reading & modification. */
/* The designated file is opened for read/write with exclusive access: */
/* the file cannot be opened for reading *or* writing by anybody else. */
/* Changes are not written back to the file until DOC_Save is called. */

PROCEDURE DOC_Reset EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
END PROCEDURE.
/* Reset the document to empty, unmodified, no associated file. */

PROCEDURE DOC_WriteToFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER filename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write the contents of the document to the designated file. */
/* If the filename is NULL or the empty string, the user is prompted */
/* for the file (and folder) to write to. */
/* Does *not* clear the modified flag or associate filename with this document. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE DOC_Save EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Save the contents of the document to the associated file. */
/* If no associated file, does a DOC_SaveAs. */
/* Clears the modified flag if successful. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE DOC_SaveAs EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER filename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE DOC_Image EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the image at position i (0..N-1) where N=ImageCount. */
/* If hdoc is not valid or there is no image i (or image i cannot be read) */
/* then this function returns NULL. */

PROCEDURE DOC_SetImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the image at position i. */
/* The image is *not* copied - it becomes part of the document. */
/* hdoc must be a valid document */
/* i must be >= 0 and < ImageCount(hdoc) */
/* hdib must be a valid DIB handle. */
/* Otherwise this function fails and returns FALSE(0). */

PROCEDURE DOC_AppendImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Such a common case of insertion it gets its own function. */

PROCEDURE DOC_ExtractImages EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Using the n images starting at position i in this document, */
/* create a new document containing *copies* of those images, in order. */
/* If there are less than n images at position i, uses as */
/* many as there are. */
/* The new document has no associated file and is marked unmodified(?) */

PROCEDURE DOC_DeleteImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Delete the ith image in the document. */
/* If this document is the only document containing that image, the */
/* image is freed/destroyed. */
/* Fails if there is no image at position i. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE DOC_DeleteImages EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* delete n images starting with image i in the document. */
/* If there are fewer than n images starting at position i, deletes */
/* as many as there are. */

PROCEDURE DOC_InsertImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Insert the image at position i in the document. */
/* The image is *not* copied, it becomes part of the document. */
/* position 0 is the first image in the document. */
/* position -1 is interpreted as 'at the end'. */

PROCEDURE DOC_InsertImageArray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER i AS LONG.
  DEFINE OUTPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* insert n images from array ahdib at position i */

PROCEDURE DOC_MoveImage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdoc AS LONG.
  DEFINE INPUT PARAMETER iOld AS LONG.
  DEFINE INPUT PARAMETER iNew AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Move the image at position iOld in the document to position iNew. */


/* --------- File Read/Write */

/* ---- Dosadi File Format Codes */
&GLOBAL-DEFINE EZT_FF_TIFF 0
&GLOBAL-DEFINE EZT_FF_BMP 2
&GLOBAL-DEFINE EZT_FF_JFIF 4
&GLOBAL-DEFINE EZT_FF_PNG 7
&GLOBAL-DEFINE EZT_FF_PDFA 15
&GLOBAL-DEFINE EZT_FF_DCX 97
&GLOBAL-DEFINE EZT_FF_GIF 98
&GLOBAL-DEFINE EZT_FF_PDF 99

/* GIF and DCX support is only provided by EZTwain. */
/* Note: BMP support is built into EZTwain, so is always available. */


PROCEDURE TWAIN_IsJpegAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if JPEG/JFIF image files can be read and written. */
/* Returns 0 if JPEG support has not been installed. */

PROCEDURE TWAIN_IsPngAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if PNG format support is available. */

PROCEDURE TWAIN_IsTiffAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if TIFF format support is available. */

PROCEDURE TWAIN_IsPdfAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if PDF format support is available. */

PROCEDURE TWAIN_IsGifAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if GIF format support is available. */

PROCEDURE TWAIN_IsDcxAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if DCX format support is available. */
/* Note that DCX files can only hold 1-bit */
/* B&W images - EZTwain converts the image data as needed. */

PROCEDURE TWAIN_IsFormatAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if the specified file format support */
/* is available for writing and possibly reading files. */
/* A format is considered available if EZTwain can load */
/* the necessary DLLs.  See the  */

PROCEDURE TWAIN_FormatVersion EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the format module version * 100. */

PROCEDURE TWAIN_IsFileExtensionAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sExt AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if the file format corresponding to the given */
/* file extension ("TIF", ".gif", "jpeg", etc.) is available. */
/* Case does not matter, leading '.' is optional. */

PROCEDURE TWAIN_FormatFromExtension EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sExt AS CHARACTER.
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the file-format code (see File Formats above) for */
/* the given extension.  If pzExt is unrecognized, returns nFF. */
/* Case does not matter, leading '.' is optional. */

PROCEDURE TWAIN_ExtensionFromFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE INPUT PARAMETER sDefExt AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the default extension associated with a file format.(See File Formats above.) */
/* Note: The leading '.' is included e.g. ".bmp", ".tif", etc. */
/* If nFF is not a valid value, returns its second parameter. */

PROCEDURE TWAIN_GetExtensionFromFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE INPUT PARAMETER sDefExt AS CHARACTER.
  DEFINE INPUT-OUTPUT PARAMETER szExtension AS MEMPTR.
END PROCEDURE.
/* Return the default extension for the given file-format code, in the 3rd parameter. */
/* The caller is responsible for allocating a string of at least 5 characters for the 3rd parameter. */
/* If the file format is not recognized, returns the value of the 2nd parameter. */

PROCEDURE TWAIN_SetSaveFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetSaveFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the default file format for DIB_WriteToFilename */
/* and TWAIN_WriteToFilename to use, when they do not */
/* recognize the file extension. */
/* Displays a warning message if the format is not available. */
/* Returns TRUE (1) if ok, FALSE (0) if format is invalid or not available. */
/* See list of file formats above.  Some formats are not supported */
/* by some versions of EZTWAIN, or require external DLLs be installed. */

PROCEDURE TWAIN_SetJpegQuality EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nQ AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetJpegQuality EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the 'quality' of subsequently saved JPEG/JFIF image files. */
/* nQ = 100 is maximum quality & minimum compression. */
/* nQ = 75 is 'good' quality, the default. */
/* nQ = 1 is minimum quality & maximum compression. */

/* - Special TIFF options ------------------------------------------ */

PROCEDURE TWAIN_SetTiffStripSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nBytes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetTiffStripSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the size of the 'strips' that TIFF files are divided into. */
/* Some (bogus) TIFF readers cannot handle multiple strips, to make */
/* them happy set the strip size to -1. */
/* Default value = 32768 (subject to change, in theory.) */

PROCEDURE TWAIN_SetTiffImageDescription EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffDocumentName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the TIFF ImageDescription or DocumentName tags for output. */
/* These values apply only to the next TIFF file written, and are cleared */
/* once the file is closed. */

PROCEDURE TWAIN_SetTiffCompression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetTiffCompression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the compression mode to use when writing TIFF files. */
/* Set returns TRUE (1) if successful, FALSE (0) otherwise. */
/* nPT specifies the Pixel Type - See the TWPT_* constants. */
/* Different compressions apply to different pixel types - see below. */
/* Using nPT=-1 means 'for all applicable pixel types.' */
/* nComp specifies the compression, here are the codes: */
&GLOBAL-DEFINE TIFF_COMP_NONE 1
&GLOBAL-DEFINE TIFF_COMP_CCITTRLE 2
&GLOBAL-DEFINE TIFF_COMP_CCITTFAX3 3
&GLOBAL-DEFINE TIFF_COMP_CCITTFAX4 4
&GLOBAL-DEFINE TIFF_COMP_LZW 5
&GLOBAL-DEFINE TIFF_COMP_JPEG 7
&GLOBAL-DEFINE TIFF_COMP_PACKBITS 32773

/* Default for BW is TIFF_COMP_CCITTFAX4 */
/* Default for all other pixel types is TIFF_COMP_NONE. */

/* Setting TIFF tags explicitly, including custom/private tags: */
PROCEDURE TWAIN_SetTiffTagShort EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER sValue AS SHORT.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagLong EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER nValue AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagString EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagDouble EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER dValue AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagRational EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER dValue AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagRationalArray EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER dValues AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagBytes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER pdata AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiffTagUndefined EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nTagId AS LONG.
  DEFINE INPUT PARAMETER pdata AS MEMPTR.
  DEFINE INPUT PARAMETER nBytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Note: It works to use SetTiffTagDouble to set standard TIFF tags that are of */
/* type RATIONAL, but we recommend using SetTiffTagRational. */
/* If you have trouble setting a custom private tag, it may help to */
/* define it to EZTwain - see TWAIN_DefineCustomTiffTag, below. */

PROCEDURE TWAIN_ResetTiffTags EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* The functions above allow specific TIFF tags to be set. */
/* Whatever value(s) you set will be used in *each image written to TIFF* */
/* until you call TWAIN_ResetTiffTags. */
/* Note that integer values are appropriately converted to 16- or 32-bit */
/* signed or unsigned as needed by the specific tag. */

PROCEDURE TWAIN_GetTiffTagAscii EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER nPage AS LONG.
  DEFINE INPUT PARAMETER nTag AS LONG.
  DEFINE INPUT PARAMETER nLen AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Read the value of the specified tag from the given page of the given TIFF file, */
/* copying the string into buffer, which has room for len characters. */
/* Returns True(1) if successful, False(0) otherwise. */

PROCEDURE TWAIN_TiffTagAscii EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER nPage AS LONG.
  DEFINE INPUT PARAMETER nTag AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the value of the specified tag from the given page of the given TIFF file, */
/* as a human-readable string. */
/* Numeric values are converted to decimal numeric representation. */
/* In case of failure, it returns the empty string. */
/* In case of error, call TWAIN_ReportLastError to display details, */
/* or call TWAIN_LastErrorCode and related functions. */

PROCEDURE TWAIN_SetFileAppendFlag EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bAppend AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetFileAppendFlag EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set or get the File Append Flag. */
/* When this flag is non-zero and EZTwain writes to an existing TIFF, PDF or DCX */
/* file, the new images are *appended* to the existing file. */
/* When this flag is False (0), writing to any existing file replaces the file. */

/* The default state of this flag is: False (0). */

/* Note: Only TIFF, PDF, and DCX formats are affected. */
/* This applies to all functions that write images, primarily: */
/* TWAIN_AcquireToFilename, TWAIN_AcquireMultipageFile, */
/* DIB_WriteToFilename, TWAIN_BeginMultipageFile, etc. */

/* - PDF Specific ------------------------------------------ */


PROCEDURE PDF_IsOneOfOurs EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the specified PDF file was probably written by the */
/* Dosadi PDF module. */

PROCEDURE PDF_DocumentProperty EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER sProperty AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* From the given PDF file, extract the designated document property's string value, */
/* and return (a pointer to an internal buffer holding) that value. */
/* See also PDF_GetDocumentProperty below. */

/* Legal values for the Property parameter are: */
/* "Title", "Author", "Subject", "Keywords", "Creator" and "Producer". */
/* Case matters, so use these exact strings. */

/* If the file cannot be opened and parsed as a PDF file, or if the specified property */
/* cannot be found and read, this function returns the empty string, and */
/* records an error: See TWAIN_ReportLastError and related functions. */

PROCEDURE PDF_GetDocumentProperty EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE INPUT PARAMETER sProperty AS CHARACTER.
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
  DEFINE INPUT PARAMETER buflen AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Same as PDF_DocumentProperty, except: */
/* The property value is obtained as a string and its length is calculated with strlen. */
/* The return value of this function is the 'strlen' of the string value found in the file - */
/* independent of the value of buflen. */

/* These functions configure or add information to the next output PDF file: */
PROCEDURE TWAIN_SetPdfTitle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPdfAuthor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPdfSubject EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPdfKeywords EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPdfCreator EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

/* Alternate forms of TWAIN_SetPdfTitle & co: */
PROCEDURE PDF_SetTitle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_SetAuthor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_SetSubject EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_SetKeywords EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_SetCreator EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE PDF_SetCompression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE INPUT PARAMETER nComp AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_GetCompression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPT AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the compression algorithm to use for images with the given pixel format. */
/* See the TWPT_* constants for the various pixel formats. */
/* Note that a pixel format of -1 means 'all applicable formats'. */
/* Available values of nComp are: */
&GLOBAL-DEFINE COMPRESSION_DEFAULT -1
&GLOBAL-DEFINE COMPRESSION_NONE 1
&GLOBAL-DEFINE COMPRESSION_FLATE 5
&GLOBAL-DEFINE COMPRESSION_JPEG 7

PROCEDURE PDF_SelectPageSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPaper AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_SelectedPageSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the standard page-size for subsequent PDF output pages. */
/* The values are PAPER_ values defined elsewhere */
/* in this file, search for PAPER_A4 etc. */
/* EZTwain initializes this to PAPER_NONE (0). */
/* With PAPER_NONE selected, EZTwain writes each output image into a */
/* page the same size as the image.  Setting a page size tells */
/* EZTwain to center each output image within a page of the */
/* specified size, shrinking larger images to fit. */
/* Calling PDF_SelectPageSize(PAPER_NONE) clears the page-size */
/* back to the default i.e. 'no specific size'. */

PROCEDURE PDF_SetPDFACompliance EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nLevel AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE PDF_GetPDFACompliance EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the PDF/A Compliance level. */
/* Level 0 is 'no particular compliance'. (*default*) */
/* Level 1 is PDF/A-1(b) - the PDF/A Part 1 level suitable for */
/* scanned documents. */
/* No other nLevel values are accepted at this time. */
/* When PDFA compliance is set to 1, PDF output is made to comply with */
/* ISO 19005-1 PDF/A-1.  For the most part this is invisible, but certain */
/* PDF settings and operations become illegal, and there are optional */
/* function calls that make your PDF's "more" PDF/A compliant. */


/* -- Passwords and encryption of PDF files ------------------------ */


PROCEDURE PDF_IsEncrypted EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the specified PDF file is encrypted. */

PROCEDURE PDF_SetOpenPassword EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sPassword AS CHARACTER.
END PROCEDURE.
/* Set the password to be used to open subsequent PDF files. */
/* This password is used until reset to the empty string. */

/* Once you set a non-null OpenPassword, the user will not be prompted */
/* for a password when an encrypted PDF is opened for reading: */
/* If the OpenPassword is valid for the file, the file will be */
/* silently opened and decrypted. */
/* If the OpenPassword is not valid for the file, the function that */
/* is trying to read the file will fail. In this case, */
/* the code returned by TWAIN_LastErrorCode is EZTEC_PDF_PASSWORD */

/* To suppress PDF password prompting by EZTwain, set the OpenPassword */
/* to some extremely unlikely password string, such as " " or "1". */

PROCEDURE PDF_SetUserPassword EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sPassword AS CHARACTER.
END PROCEDURE.
/* Define a user password for the next/current output PDF file. */
/* This turns on encryption for the file. */
/* When a PDF file is completed and closed, this user password is cleared. */

PROCEDURE PDF_SetOwnerPassword EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sPassword AS CHARACTER.
END PROCEDURE.
/* Define an owner password for the next/current output PDF file. */
/* This turns on encryption for the file. */
/* When a PDF file is completed and closed, this owner password is cleared. */

PROCEDURE PDF_SetPermissions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPermission AS LONG.
END PROCEDURE.
PROCEDURE PDF_GetPermissions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set or Get the permissions mask to be written into the next/current */
/* output PDF file. This mask specifies operations to be allowed or */
/* prevented on the file - see the PDF_PERMIT constants. */

/* Important Notes */

/* * Permissions are only written if you set a User or Owner password. */
/* * Acrobat honors these restrictions, but other PDF readers may not. */
/* * Any permissions you set only apply to the next PDF file you write. */
/* * The default permissions mask is 'allow everything' (-1) */
/* * Setting permissions=0 means 'prevent everything' */

/* You can use bitwise operations, or +/- to combine these constants. */
/* For example, to disallow copying text and graphics from the file: */
/* PDF_SetPermissions(PDF_PERMIT_ALL - PDF_PERMIT_COPY) */

/* named constant                                                                                     value                             if restricted, Acrobat will prevent: */
&GLOBAL-DEFINE PDF_PERMIT_PRINT 4
&GLOBAL-DEFINE PDF_PERMIT_MODIFY 8
&GLOBAL-DEFINE PDF_PERMIT_COPY 16
&GLOBAL-DEFINE PDF_PERMIT_ANNOTS 32
/* You can also use this nPermission value, by itself: */
&GLOBAL-DEFINE PDF_PERMIT_ALL -1


/* -- Writing text into PDF. ------------------------ */

/* The following functions apply to the next PDF file or page that is output, */
/* so you make them *before* you write the PDF page they apply to. */

PROCEDURE PDF_DrawText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER leftx AS DOUBLE.
  DEFINE INPUT PARAMETER topy AS DOUBLE.
  DEFINE INPUT PARAMETER sText AS CHARACTER.
END PROCEDURE.
/* Draw text into the next PDF page, x pixels from the left edge */
/* and y pixels down from the top of the page. */
/* Note 1: This is not 'native' PDF coordinates, which are */
/* usually in points, from the lower-left corner of the page. */
/* Note 2: This call only makes sense if followed at some point */
/* by a call that writes an image to PDF. */

PROCEDURE PDF_DrawInvisibleText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER leftx AS DOUBLE.
  DEFINE INPUT PARAMETER topy AS DOUBLE.
  DEFINE INPUT PARAMETER sText AS CHARACTER.
END PROCEDURE.
/* Like PDF_DrawText, but text is drawn in invisible mode. */

PROCEDURE PDF_SetTextVisible EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bVisible AS LONG.
END PROCEDURE.
PROCEDURE PDF_GetTextVisible EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the visibility of the text written by subsequent PDF_DrawText */
/* calls. A parameter of True (non-0) means make text visible, a parameter */
/* of False (0) means make text invisible. */

PROCEDURE PDF_SetTextSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dfs AS DOUBLE.
END PROCEDURE.
/* Set the size of the current font, for subsequent PDF_DrawText calls. */
/* Normally this is a traditional size in points, like 10. */
PROCEDURE PDF_SetTextHorizontalScaling EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dhs AS DOUBLE.
END PROCEDURE.

PROCEDURE PDF_WriteOcrText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER text1 AS CHARACTER.
  DEFINE INPUT PARAMETER ax AS MEMPTR.
  DEFINE INPUT PARAMETER ay AS MEMPTR.
  DEFINE INPUT PARAMETER aw AS MEMPTR.
  DEFINE INPUT PARAMETER ah AS MEMPTR.
  DEFINE INPUT PARAMETER xdpi AS DOUBLE.
  DEFINE INPUT PARAMETER ydpi AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write previously OCR'd text to the next PDF output page. */
/* ---parameters--- */
/* text is the text, of course - as returned by OCR_Text. */
/* ax and ay are arrays of x,y positions of the characters in text - as returned */
/* by OCR_GetCharPositions.  These are pixel coordinates relative to the top-left of the page. */
/* aw and ah are arrays of (width,height) information as returned by OCR_GetCharSizes. */
/* xdpi and ydpi are the resolution values (DPI) of the source image, required to map the text */
/* size from pixels into PDF font sizes.  The resolution can be obtained from the image */
/* using DIB_XResolution and DIB_YResolution, or you can call OCR_GetResolution at the */
/* same time you call OCR_GetCharPositions and OCR_GetCharSizes. */

/* --------------------------------------------------------- */

PROCEDURE TWAIN_WriteToFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Writes the specified image to a file. */
/* This is the same as DIB_WriteToFilename - please refer to that function. */

PROCEDURE TWAIN_LoadFromFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Load a .BMP file, or any other available format. */
/* Accepts a filename (including path & extension). */
/* If the filename is NULL or points to a null string, the user is */
/* prompted to choose a file with a standard File Open dialog. */
/* Returns a DIB handle if successful, otherwise NULL. */

PROCEDURE TWAIN_LoadPage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE INPUT PARAMETER nPage AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Short for DIB_SelectPageToLoad, DIB_LoadFromFilename. */
/* Load the specified page from the specified file. */
/* Page 0 is the first page in a file.  Multiple */
/* pages are only supported in TIFF, PDF and DCX files, all other file */
/* formats have a single page, page #0. */

PROCEDURE TWAIN_FormatOfFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the format of the specified file. */
/* See the EZT_FORMAT_ codes elsewhere in this file. */
/* A return value < 0 means 'unrecognized format'. */

PROCEDURE TWAIN_PagesInFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of pages in the specified file. */
/* For multipage formats (TIFF, PDF, DCX), the pages are counted. */
/* All other recognized formats return a page count of 1. */
/* If the file cannot be opened, read, recognized, etc. */
/* this function records an error and returns -1. */

PROCEDURE TWAIN_PromptForOpenFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sFileName AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Prompt the user for a file to open. */
/* Returns TRUE(1) if user selected a file, FALSE(0) if user cancelled. */
/* If it returns TRUE, the fully-qualified filepath & name is returned */
/* in the buffer referenced by the parameter. */
/* The caller is responsible for allocating (and deallocating) the */
/* buffer of at least 260 characters. */
/* The file dialog has a file-type list, which is loaded based */
/* on the formats that are currently supported for loading. */
/* The default file-type is "any supported format". */

/* --------- File View Dialog */

PROCEDURE TWAIN_ViewFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Display the specified file in a viewer window that allows the */
/* user to browse to all pages (if more than one). */
/* If the file name is NULL or the null string, the user is prompted */
/* with a standard file-open dialog, offering all the filetypes that */
/* EZTwain believes it can open. */
/* The default dialog has an OK button only. */
/* Return values: */
/* 1   [OK] button pressed (in modal dialog) */
/* 1   File displayed - in case of modeless dialog. */
/* 0   [Cancel] button pressed */
/* -1   user cancelled file-open prompt (if you supplied a null filename) */
/* -2   error displaying dialog, opening file, etc. */

PROCEDURE TWAIN_SetViewOption EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sOption AS CHARACTER.
  DEFINE INPUT PARAMETER sValue AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set various options and parameters for the viewer window. */
/* See TWAIN_ViewFile above. */

/* option                                                                                             form                              meaning */
/* title                                                                                              string                            the title (caption) of the viewer window */
/* left                                                                                                                                 x|x%                              left(x) coordinate of window, in pixels or as a percent of screen. */
/* top                                                                                                                                  y|y%                              top coordinate of window */
/* bottom                                                                                             y|y% */
/* right                                                                                              x|x% */
/* width                                                                                              w|w%                              width of viewer window, in pixels or as a percent of screen. */
/* height                                                                                             h|h% */
/* size                                                                                                                                 w,h                                                                 width and height together, pixels or percentages */
/* topleft                                                                                            x,y                                                                 x and y together, pixels or percentages */
/* position                                                                                           x,y,w,h                           left,top,width,height - in pixels or percentages */
/* pos                                                                                                                                                                    same as position */
/* pos.remember                                                     bool                              if true, remember viewer position between showings. Default: false. */
/* timeout                                                                                            n                                                                   in seconds. Currently ignored. */
/* visible                                                                                            bool                              if viewer is open, show or hide it.  Default: true */
/* ok.visible                                                       bool                              if true, include an [OK] button in the viewer. Default: true. */
/* cancel.visible                 bool                              if true, include a [Cancel] button. Default: false */
/* print.visible                  bool                              if true, include a [Print] button. Default: false. */
/* modeless                                                                                           bool                              if true, leave viewer open until TWAIN_ViewClose. Default: false. */
/* modal                                                                                              bool                              opposite of modeless. */
/* reset                                                                                              ...                                                                 setting this option resets all options to default value. */


PROCEDURE TWAIN_IsViewOpen EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return True if the viewer window is open, False otherwise. */

PROCEDURE TWAIN_ViewClose EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* If the viewer window is open (as a modeless dialog), close it. */
/* The viewer window is normally modal, but can be made modeless */
/* with TWAIN_SetViewOption("modeless", "true") */
/* No effect if no viewer window is open. */
/* Returns True(1) if it closed the viewer window, False(0) otherwise. */

PROCEDURE TWAIN_GetLastViewPosition EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER pleft AS LONG.
  DEFINE OUTPUT PARAMETER ptop AS LONG.
  DEFINE OUTPUT PARAMETER pwidth AS LONG.
  DEFINE OUTPUT PARAMETER pheight AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the screen coordinates, in pixels, of the last known position of the */
/* viewer window (the dialog displayed by TWAIN_ViewFile and DIB_View functions.) */
/* The four parameters are pointers to 32-bit integers or if your language */
/* prefers, four 32-bit integers passed by reference. */
/* The four returned values are the left edge, the top edge (counting down from screen top) */
/* the width, and the height of the View window, the last time it was closed or resized. */

/* This function can be used in conjunction with TWAIN_SetViewOption("position","x,y,w,h") to */
/* remember and restore the view window position. */

/* --------- Multipage File Output */

&GLOBAL-DEFINE MULTIPAGE_TIFF 0
&GLOBAL-DEFINE MULTIPAGE_PDF 1
&GLOBAL-DEFINE MULTIPAGE_DCX 2

PROCEDURE TWAIN_SetMultipageFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetMultipageFormat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select/query the default multipage file save format. */
/* The default when EZTwain is loaded is MULTIPAGE_TIFF. */
/* Note that if you use a recognized extension in the name */
/* of your multipage file - such as .tif, .pdf or .dcx, then */
/* the file will be written in that format.  The file */
/* extension overrides SetMultipageFormat. */

/* SetMultipageFormat returns: */
/* 0 = success, */
/* -1 = invalid/unrecognized format */
/* -3 = format is currently unavailable (missing/bad DLL) */

PROCEDURE TWAIN_SetLazyWriting EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetLazyWriting EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get/Query the value of the 'LazyWriting' flag. */
/* NOTE: The default value of this flag is: TRUE. */
/* When the LazyWriting flag is set (TRUE), multipage files */
/* are written by a background thread, allowing your */
/* program to continue executing (scanning for example). */
/* Only when EndMultipageFile is called does the program */
/* wait until all the pages of the file have actually */
/* been written to disk. */
/* This also applies to AcquireMultipageFile, which internally */
/* uses these multipage output functions. */

PROCEDURE DIB_WriteArrayToFilename EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write n images from array ahdib to the specified file. */
/* If n is 1, this is exactly equivalent to calling DIB_WriteToFilename. */
/* If n > 1, this is a shortcut for calling */
/* TWAIN_BeginMultipageFile, */
/* TWAIN_DibWritePage (for each image) */
/* TWAIN_EndMultipageFile */
/* ...with appropriate error handling, of course. */

/* Return values: */
/*                                 0                                success */
/*                                -1                                user cancelled File Save dialog */
/*                                -2                                file open error (invalid path or name, or access denied) */
/*                                -3                                a) image is invalid (null or invalid DIB handle) */
/* b) support for the save format is not available */
/* c) DIB format incompatible with save format e.g. B&W to JPEG. */
/*                                -4                                writing data failed, possibly output device is full */
/* -5  other unspecified internal error */
/* -6  a multipage file is already open */
/* -7  multipage support is not installed. */

PROCEDURE TWAIN_BeginMultipageFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create an empty multipage file of the given name. */
/* If the filename is NULL or points to the null string, the user */
/* is prompted with a standard File Save dialog. */
/* If the filename includes an extension (.tif, .tiff, .mpt, .pdf or .dcx) */
/* then the corresponding format is used for the file. */
/* If you do not supply an extension, the default multipage format is used. */

/* Return values: */
/*                                 0                                success */
/*                                -1                                user cancelled File Save dialog */
/*                                -2                                file open error (invalid path or name, or access denied) */
/* -3  file format not available */
/* -5  other unspecified internal error */
/* -6  multipage file already open */
/* -7  Multipage support is not installed. */

PROCEDURE TWAIN_DibWritePage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* 0                              success */
/* -2  internal limit exceeded or insufficient memory */
/* -3  File format is not available (EZxxx DLL not found) */
/* -4  Write error: Output device is full? */
/* -5  invalid/unrecognized file format or 'other' - internal */
/* -6  multipage file not open */
/* -7  Multipage support is not installed. */

PROCEDURE TWAIN_WritePageAndFree EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Like TWAIN_DibWritePage followed by DIB_Free. */
/* The advantage is that the write can be done on a background thread */
/* without making a copy of the image. */

PROCEDURE TWAIN_EndMultipageFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* 0                              success */
/* -3  File format is not available */
/* -4  Write error - drive offline, or ?? (very unlikely) */
/* -5  invalid/unrecognized file format or other internal error */
/* -6  multipage file not open */
/* -7  Multipage support is not installed. */

PROCEDURE TWAIN_MultipageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of images (scans) written to the most recently */
/* started multipage file.  In other words, this returns a counter */
/* which is reset by BeginMultipageFile, and is incremented by DibWritePage. */

PROCEDURE TWAIN_IsMultipageFileOpen EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return True if a multipage output file is open, False otherwise. */
/* Only one multipage output file can be open at a time (per process.) */


PROCEDURE TWAIN_LastOutputFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the name of the last file written by EZTwain. */
/* Useful if you pass NULL or the empty string as a filename to */
/* DIB_WriteToFilename or TWAIN_AcquireToFilename, etc. */


PROCEDURE TWAIN_SetOutputPageCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPages AS LONG.
END PROCEDURE.
/* Tell EZTwain how many pages you are about to write to a file. */
/* This is OPTIONAL: The only effect is to add PageNumber tags */
/* to TIFF files.  You can use nPages=0, which means "I don't know". */

PROCEDURE TWAIN_FileCopy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sInFile AS CHARACTER.
  DEFINE INPUT PARAMETER sOutFile AS CHARACTER.
  DEFINE INPUT PARAMETER nOptions AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Read all the images or pages from the in file and write them to the out file. */
/* nOptions is currently not used and should be 0. */
/* The formats need not be the same, in fact this function is most often */
/* used to convert for example from TIFF to PDF.  If you specify a single-image */
/* output format (BMP, GIF, PNG, JPG) the input file must have only one page. */
/* Return values: */
/*                                 0                                success */
/*                                -1                                user cancelled */
/*                                -2                                file open error (invalid path or name, or access denied) */
/* -3  file format not available or inappropriate (e.g. copying 5-page TIF to JPEG) */
/* -5  other unspecified internal error */
/* -7  Multipage support is not installed. */

/* --------- Network file transfer services */

/* These functions require EZCurl.dll to be */
/* in the same folder as Eztwain3.dll */

PROCEDURE UPLOAD_IsAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TRUE(1) if uploading services are available (= EZCurl.dll can be loaded.) */
/* Returns FALSE(0) otherwise. */

PROCEDURE UPLOAD_Version EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the upload module version * 100. */

PROCEDURE UPLOAD_MaxFiles EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the maximum number of files that can be uploaded in one UPLOAD operation. */
/* i.e. UPLOAD_FilesToURL, UPLOAD_DibsSeparatelyToURL. */

PROCEDURE UPLOAD_AddFormField EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER fieldName AS CHARACTER.
  DEFINE INPUT PARAMETER fieldValue AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set a form field to a value in the next Upload (see below). */
/* The name of the field must be expected by the page/script you upload to. */
/* All fields set with this function are discarded and forgotten after */
/* the next upload that uses them. */

/* For example, suppose you have been uploading scanned documents to your server */
/* using a web form like this: */
/* <form name="form1" method="post" action="http://server.com/newdoc.php" > */
/* <input type="hidden" name="key" value="12345678"> */
/* <input type="text" name="vendor id"> */
/* <input type="file" name="file"> */
/* <input type="submit" name="submit" value="Submit"> */
/* </form> */

/* You might automate the upload of a just-scanned image in memory (hdib) */
/* with vendor id = 1290331, with code similar to this: */
/* UPLOAD_AddFormField("key", "12345678") */
/* UPLOAD_AddFormField("vendor id", "1290331") */
/* UPLOAD_DibToURL(hdib, "http://server.com/newdoc.php", "document.pdf", "file") */

PROCEDURE UPLOAD_AddHeader EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER header1 AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Add a header line to the next HTTP upload. */
/* You should have some understanding of HTTP protocol to use this! */
/* Don't include any line-break characters. */
/* To send a cookie, use UPLOAD_AddCookie (below). */

PROCEDURE UPLOAD_AddCookie EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cookie AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Add a cookie line to the next HTTP upload. */
/* Often used to provide session id's e.g. */
/* UPLOAD_AddCookie("ASP.NET_SessionID=" & strSessionID) */
/* or */
/* UPLOAD_AddCookie("JSESSIONID=" & strSessionID) */

PROCEDURE UPLOAD_EnableProgressBar EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bEnable AS LONG.
END PROCEDURE.
PROCEDURE UPLOAD_IsEnabledProgressBar EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Enable or disable the progress-bar during uploads. */
/* Default state is enabled (TRUE). */

PROCEDURE UPLOAD_DibToURL EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER URL AS CHARACTER.
  DEFINE INPUT PARAMETER fileName AS CHARACTER.
  DEFINE INPUT PARAMETER fieldName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE UPLOAD_DibsToURL EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER URL AS CHARACTER.
  DEFINE INPUT PARAMETER fileName AS CHARACTER.
  DEFINE INPUT PARAMETER fieldName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE UPLOAD_DibsSeparatelyToURL EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER ahdib AS MEMPTR.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER URL AS CHARACTER.
  DEFINE INPUT PARAMETER fileName AS CHARACTER.
  DEFINE INPUT PARAMETER fieldName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE UPLOAD_FilesToURL EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER files AS CHARACTER.
  DEFINE INPUT PARAMETER URL AS CHARACTER.
  DEFINE INPUT PARAMETER fieldName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Upload an image, set of images, or some files on disk, to a script on a server, */
/* AS IF a form was being submitted via HTTP-POST, with a field or fields of type 'file'. */

/* Important Note - This confuses some people, don't let it happen to you! */
/* Only UPLOAD_FilesToURL looks for actual disk files and uploads them. */
/* All the other UPLOAD functions upload image data, *pretending* it is from a file - no such */
/* file is read, used, or created on the client machine. */

/* UPLOAD_DibsSeparatelyToURL uploads each image as a separate file, appending '1', '2', etc. */
/* to both the filename and the fieldname.  So if you upload n images with fileName="page.jpg" */
/* and fieldName="file", it will upload files as "file1"="page1.jpg", "file2=page2.jpg", etc. */

/* Similarly, UPLOAD_FilesToURL uploads multiple files, appending the counter to the fieldName. */
/* If you specify a fieldName of "file", UPLOAD_FilesToURL will use "file1", "file2", etc. */
/* Note that this applies even if you upload just one file. */

/* hdib      = handle to image to upload. */
/* ahdib     = address or reference to array of hdibs (image handles). */
/* n         = number of images in array ahdib. */
/* fileName  = name of (imaginary) file being uploaded. */
/* Note: the extension on the filename determines the file format. */
/* files     = a string containing one or more filenames, separated by semicolons (;) or vertical bars (|) */
/* URL       = URL to POST the file to, such as http://www.dosadi.com/upload.php */
/* fieldName = name of the form-field. If null or blank, "file" is used. */

/* NOTE: When uploading multiple images as a single file, you must of course */
/* use a file format that supports multiple pages: TIFF, PDF, or DCX. */

/* Return values: */
/* 0    success (transaction completed) */
/* Important: A success return (0) means only that the data was sent to the */
/* server and a response was received, not that the receiving script */
/* necessarily accepted the submitted file.  See DIB_UploadResponse below.  */
/* -1                                user cancelled File Save dialog (should never happen) */
/* -2                                could not write temp file - access denied, volume protected, etc. */
/* -3    a) image is invalid (null or invalid DIB handle) */
/* b) The DLL(s) needed to save that format failed to load */
/* c) DIB format incompatible with save format e.g. uploading a B&W image as JPEG. */
/* d) fileName does not have a recognized extension (.tif, .jpg, .gif, etc) */
/* -4    writing data failed, maybe the disk with the temp folder is full? */
/* -5    other unspecified internal error */
/* -100+n  libcurl returned error code n */
/* for example: */
/* -106    could not resolve host */
/* -107    couldn't connect */
/* -126    could not open/read local file */

PROCEDURE UPLOAD_SetProxy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hostport AS CHARACTER.
  DEFINE INPUT PARAMETER userpwd AS CHARACTER.
  DEFINE INPUT PARAMETER bTunnel AS LONG.
END PROCEDURE.

PROCEDURE UPLOAD_Response EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the text received from the server in response to the last upload. */
/* You can check this text to see if the server-script accepted the upload. */
/* There is no predefined limit to the length of the returned string - please */
/* code defensively.  This call is extremely fast,  */
/* (See DIB_PostToURL above.) */

PROCEDURE UPLOAD_ResponseLength EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the length of the last server response string, as returned */
/* by UPLOAD_Response. */

PROCEDURE UPLOAD_GetResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER ResponseText AS MEMPTR.
END PROCEDURE.
/* Retrieve the text received from the server in response to the last upload. */
/* * This text is limited to 1024 characters. * */
/* (See DIB_PostToURL above.) */

PROCEDURE UPLOAD_ClearResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.


/* --------- Application Registration and Licensing */

PROCEDURE TWAIN_SetAppTitle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sAppTitle AS CHARACTER.
END PROCEDURE.
/* The short form of Application/Product name registration. */
/* Sets the product name as far as EZTwain and TWAIN are concerned. */
/* This title is used in several ways: */
/* As the title (caption) of any EZTwain dialog boxes / error boxes. */
/* In the progress box of some devices as they transfer images. */
/* In the 'software' field of saved image files in some formats, */
/* including TIFF. */

PROCEDURE TWAIN_SetApplicationKey EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nKey AS LONG.
END PROCEDURE.
/* Unlock EZTwain Pro for use with the current application - call this AFTER */
/* calling RegisterApp or SetAppTitle above:  The nKey value must match */
/* the application title (product name) passed to one of those functions. */

PROCEDURE TWAIN_ApplicationLicense EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sAppTitle AS CHARACTER.
  DEFINE INPUT PARAMETER nAppKey AS LONG.
END PROCEDURE.
/* Unlock EZTwain using a Single Application License. */

PROCEDURE TWAIN_SetVendorKey EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sVendorName AS CHARACTER.
  DEFINE INPUT PARAMETER nKey AS LONG.
END PROCEDURE.
/* Unlock EZTwain using a Universal Application / Vendor License */

PROCEDURE TWAIN_OrganizationLicense EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sOrganization AS CHARACTER.
  DEFINE INPUT PARAMETER nKey AS LONG.
END PROCEDURE.
/* Unlock EZTwain using an Organization / In-House Application License. */

PROCEDURE TWAIN_RenewTrialLicense EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uKey AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Renew or recreate the EZTwain Pro trial license in this computer, */
/* if the Key parameter is a valid trial-renewal key. */
/* Such keys are valid only for some number of days after issue. */
/* Contact Dosadi Support (support@dosadi.com) for such a key. */

PROCEDURE TWAIN_SingleMachineLicense EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sMsg AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* If no valid EZTwain Pro license is found on this computer, prompt */
/* the user with a dialog box asking for a single-machine license key. */
/* If the user supplies a key, try to record & validate it. */
/* Return value: */
/* TRUE if EZTwain Pro is licensed for use on this computer. */
/* (Note this could be because of a trial license, or an organization license). */
/* FALSE if EZTwain Pro is not licensed for use on this computer. */

PROCEDURE TWAIN_RegisterApp EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMajorNum AS LONG.
  DEFINE INPUT PARAMETER nMinorNum AS LONG.
  DEFINE INPUT PARAMETER nLanguage AS LONG.
  DEFINE INPUT PARAMETER nCountry AS LONG.
  DEFINE INPUT PARAMETER sVersion AS CHARACTER.
  DEFINE INPUT PARAMETER sMfg AS CHARACTER.
  DEFINE INPUT PARAMETER sFamily AS CHARACTER.
  DEFINE INPUT PARAMETER sAppTitle AS CHARACTER.
END PROCEDURE.

/* TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the */
/* application. If this function is not called, the application is given a */
/* 'generic' registration by EZTWAIN. */
/* Registration only provides this information to the Source Manager and any */
/* sources you may open - it is used for debugging, and possibly by some */
/* sources to give special treatment to certain applications. */

/* --------- Error Analysis and Reporting ------------------------------------ */

/* EZTwain Error codes */
&GLOBAL-DEFINE EZTEC_NONE 0
&GLOBAL-DEFINE EZTEC_START_TRIPLET_ERRS 1
&GLOBAL-DEFINE EZTEC_CAP_GET 2
&GLOBAL-DEFINE EZTEC_CAP_SET 3
&GLOBAL-DEFINE EZTEC_DSM_FAILURE 4
&GLOBAL-DEFINE EZTEC_DS_FAILURE 5
&GLOBAL-DEFINE EZTEC_XFER_FAILURE 6
&GLOBAL-DEFINE EZTEC_END_TRIPLET_ERRS 7
&GLOBAL-DEFINE EZTEC_OPEN_DSM 8
&GLOBAL-DEFINE EZTEC_OPEN_DEFAULT_DS 9
&GLOBAL-DEFINE EZTEC_NOT_STATE_4 10
&GLOBAL-DEFINE EZTEC_NULL_HCON 11
&GLOBAL-DEFINE EZTEC_BAD_HCON 12
&GLOBAL-DEFINE EZTEC_BAD_CONTYPE 13
&GLOBAL-DEFINE EZTEC_BAD_ITEMTYPE 14
&GLOBAL-DEFINE EZTEC_CAP_GET_EMPTY 15
&GLOBAL-DEFINE EZTEC_CAP_SET_EMPTY 16
&GLOBAL-DEFINE EZTEC_INVALID_HWND 17
&GLOBAL-DEFINE EZTEC_PROXY_WINDOW 18
&GLOBAL-DEFINE EZTEC_USER_CANCEL 19
&GLOBAL-DEFINE EZTEC_RESOLUTION 20
&GLOBAL-DEFINE EZTEC_LICENSE 21
&GLOBAL-DEFINE EZTEC_JPEG_DLL 22
&GLOBAL-DEFINE EZTEC_SOURCE_EXCEPTION 23
&GLOBAL-DEFINE EZTEC_LOAD_DSM 24
&GLOBAL-DEFINE EZTEC_NO_SUCH_DS 25
&GLOBAL-DEFINE EZTEC_OPEN_DS 26
&GLOBAL-DEFINE EZTEC_ENABLE_FAILED 27
&GLOBAL-DEFINE EZTEC_BAD_MEMXFER 28
&GLOBAL-DEFINE EZTEC_JPEG_GRAY_OR_RGB 29
&GLOBAL-DEFINE EZTEC_JPEG_BAD_Q 30
&GLOBAL-DEFINE EZTEC_BAD_DIB 31
&GLOBAL-DEFINE EZTEC_BAD_FILENAME 32
&GLOBAL-DEFINE EZTEC_FILE_NOT_FOUND 33
&GLOBAL-DEFINE EZTEC_FILE_ACCESS 34
&GLOBAL-DEFINE EZTEC_MEMORY 35
&GLOBAL-DEFINE EZTEC_JPEG_ERR 36
&GLOBAL-DEFINE EZTEC_JPEG_ERR_REPORTED 37
&GLOBAL-DEFINE EZTEC_0_PAGES 38
&GLOBAL-DEFINE EZTEC_UNK_WRITE_FF 39
&GLOBAL-DEFINE EZTEC_NO_TIFF 40
&GLOBAL-DEFINE EZTEC_TIFF_ERR 41
&GLOBAL-DEFINE EZTEC_PDF_WRITE_ERR 42
&GLOBAL-DEFINE EZTEC_NO_PDF 43
&GLOBAL-DEFINE EZTEC_GIFCON 44
&GLOBAL-DEFINE EZTEC_FILE_READ_ERR 45
&GLOBAL-DEFINE EZTEC_BAD_REGION 46
&GLOBAL-DEFINE EZTEC_FILE_WRITE 47
&GLOBAL-DEFINE EZTEC_NO_DS_OPEN 48
&GLOBAL-DEFINE EZTEC_DCXCON 49
&GLOBAL-DEFINE EZTEC_NO_BARCODE 50
&GLOBAL-DEFINE EZTEC_UNK_READ_FF 51
&GLOBAL-DEFINE EZTEC_DIB_FORMAT 52
&GLOBAL-DEFINE EZTEC_PRINT_ERR 53
&GLOBAL-DEFINE EZTEC_NO_DCX 54
&GLOBAL-DEFINE EZTEC_APP_BAD_CON 55
&GLOBAL-DEFINE EZTEC_LIC_KEY 56
&GLOBAL-DEFINE EZTEC_INVALID_PARAM 57
&GLOBAL-DEFINE EZTEC_INTERNAL 58
&GLOBAL-DEFINE EZTEC_LOAD_DLL 59
&GLOBAL-DEFINE EZTEC_CURL 60
&GLOBAL-DEFINE EZTEC_MULTIPAGE_OPEN 61
&GLOBAL-DEFINE EZTEC_BAD_SHUTDOWN 62
&GLOBAL-DEFINE EZTEC_DLL_VERSION 63
&GLOBAL-DEFINE EZTEC_OCR_ERR 64
&GLOBAL-DEFINE EZTEC_ONLY_TO_PDF 65
&GLOBAL-DEFINE EZTEC_APP_TITLE 66
&GLOBAL-DEFINE EZTEC_PATH_CREATE 67
&GLOBAL-DEFINE EZTEC_LATE_LIC 68
&GLOBAL-DEFINE EZTEC_PDF_PASSWORD 69
&GLOBAL-DEFINE EZTEC_PDF_UNSUPPORTED 70
&GLOBAL-DEFINE EZTEC_PDF_BAFFLED 71
&GLOBAL-DEFINE EZTEC_PDF_INVALID 72
&GLOBAL-DEFINE EZTEC_PDF_COMPRESSION 73
&GLOBAL-DEFINE EZTEC_NOT_ENOUGH_PAGES 74
&GLOBAL-DEFINE EZTEC_DIB_ARRAY_OVERFLOW 75
&GLOBAL-DEFINE EZTEC_DEVICE_PAPERJAM 76
&GLOBAL-DEFINE EZTEC_DEVICE_DOUBLEFEED 77
&GLOBAL-DEFINE EZTEC_DEVICE_COMM 78
&GLOBAL-DEFINE EZTEC_DEVICE_INTERLOCK 79
&GLOBAL-DEFINE EZTEC_BAD_DOC 80
&GLOBAL-DEFINE EZTEC_OTHER_DS_OPEN 81



PROCEDURE TWAIN_GetResultCode EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the result code (TWRC_xxx) from the last triplet sent to TWAIN */

PROCEDURE TWAIN_GetConditionCode EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the condition code from the last triplet sent to TWAIN. */
/* If a source is NOT open, return the condition code of the source manager. */

PROCEDURE TWAIN_UserClosedSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) if during the last acquire the user asked */
/* the DataSource to close.  0 otherwise of course. */
/* This flag is cleared each time you start any kind of acquire, */
/* and it is set if EZTWAIN receives a */
/* MSG_CLOSEDSREQ message through TWAIN. */

PROCEDURE TWAIN_ErrorBox EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sMsg AS CHARACTER.
END PROCEDURE.
/* Post an error message dialog with an OK button. */
/* pzMsg points to a null-terminated message string. */
/* The box caption is the current AppTitle - see SetAppTitle. */
/* If messages are suppressed (see below) this function does nothing. */

PROCEDURE TWAIN_SuppressErrorMessages EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Enable or disable EZTWAIN error messages to the user. */
/* When bYes = FALSE(0), error messages are displayed. */
/* When bYes = TRUE(non-0), error messages are suppressed. */
/* By default, error messages are displayed. */
/* Returns the previous state of the flag. */

/* EZTWAIN cannot suppress messages from TWAIN or TWAIN device drivers. */

PROCEDURE TWAIN_ReportLastError EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER msg AS CHARACTER.
END PROCEDURE.
/* If EZTwain has recorded an error and that error has not been */
/* reported to the user, this function displays a modal error dialog */
/* with information about that error. */
/* If msg is non-null and not the empty string, it is included */
/* in the dialog box. */
/* Many EZTwain errors record additional details, and those details */
/* are also inserted in the error dialog. */

/* If the recorded error is EZTEC_NONE (no error) or EZTEC_USER_CANCEL, */
/* no error dialog is displayed. */
/* If the recorded error information indicates that the user cancelled */
/* a TWAIN operation, *or* that the user has already seen an error */
/* message about the error, then no error dialog is displayed. */

/* This function *clears* the recorded error, whether or */
/* not it displays a message, by calling TWAIN_ClearError. */

PROCEDURE TWAIN_GetLastErrorText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sMsg AS MEMPTR.
END PROCEDURE.
/* Get a string that describes the last error detected by EZTwain. */
/* Note: This function is called by TWAIN_ReportLastError. */
/* Note: The returned string may contain end-of-line characters. */
/* The parameter is a string variable (char array in C/C++). */
/* You are responsible for allocating room for 512 8-bit characters */
/* in the string variable before calling this function. */

PROCEDURE TWAIN_LastErrorText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return a string that describes the last error detected by EZTwain - */
/* see Notes for TWAIN_GetLastErrorText. */

PROCEDURE TWAIN_LastErrorCode EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the last internal EZTWAIN error code. (see EZTEC_ codes above) */

PROCEDURE TWAIN_ClearError EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Set the EZTWAIN internal error code to EZTEC_NONE */

PROCEDURE TWAIN_RecordError EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER code AS LONG.
  DEFINE INPUT PARAMETER note AS CHARACTER.
END PROCEDURE.
/* Set the internal EZTwain error code, if it is not set already. */
/* This is the error info that is reported by LastErrorCode, LastErrorText, */
/* ReportLastError, and so on. */
/* The error code can be cleared by TWAIN_ClearError, and a few other */
/* functions also clear it. */

PROCEDURE TWAIN_ReportLeaks EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Display a message box if EZTwain can detect any memory leaks. */
/* Currently this only counts image handles (DIBs) that have been */
/* allocated but never freed. */
/* Returns True(1) if a problem is detected, False(0) otherwise. */


/* --------- TWAIN State Control ------------------------------------ */

PROCEDURE TWAIN_Shutdown EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Shuts down and cleans up all EZTwain operations. */
/* All memory allocations are freed, all I/O operations */
/* are completed, any threads are terminated, and */
/* TWAIN is closed and unloaded. */

PROCEDURE TWAIN_LoadSourceManager EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Finds and loads the Data Source Manager, TWAIN.DLL. */
/* If Source Manager is already loaded, does nothing and returns TRUE(1). */
/* This can fail if TWAIN.DLL is not installed (in the right place), or */
/* if the library cannot load for some reason (insufficient memory?) or */
/* if TWAIN.DLL has been corrupted. */

PROCEDURE TWAIN_OpenSourceManager EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Opens the Data Source Manager, if not already open. */
/* If the Source Manager is already open, does nothing and returns TRUE. */
/* This call will fail if the Source Manager is not loaded. */

PROCEDURE TWAIN_OpenDefaultSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* This opens the source selected in the Select Source dialog. */
/* If some source is already open, does nothing and returns TRUE. */
/* Will load and open the Source Manager if needed. */
/* If this call returns TRUE, TWAIN is in STATE 4 (TWAIN_SOURCE_OPEN) */

/* These two functions allow you to enumerate the available data sources: */
PROCEDURE TWAIN_GetSourceList EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Fetches the list of sources into memory, so they can be returned */
/* one by one by TWAIN_GetNextSourceName, below. */
/* Returns TRUE (1) if successful, FALSE (0) otherwise. */
/* Note: In the special (and very unusual) case of an empty list, */
/* this function returns TRUE(1) if there was no other error. */

PROCEDURE TWAIN_GetNextSourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sName AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Copies the next source name in the list into its parameter. */
/* The parameter is a string variable (char array in C/C++). */
/* You are responsible for allocating room for 33 8-bit characters */
/* in the string variable before calling this function. */
/* Returns TRUE (1) if successful, FALSE (0) if there are no more. */

PROCEDURE TWAIN_NextSourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Returns the next source name in the list. */
/* Returns the empty string when it comes to the end of the list. */

PROCEDURE TWAIN_GetDefaultSourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sName AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Copies the name of the TWAIN default source into its parameter. */
/* This is the global 'default source' as defined by TWAIN - which can */
/* only be set by a user in the Select Source dialog, which */
/* is displayed by (TWAIN_)SelectImageSource. */

/* Normally returns TRUE (1) but could return FALSE (0) if: */
/* - the TWAIN Source Manager cannot be loaded & initialized or */
/* - there is no current default source (e.g. no sources are installed) */

/* The parameter is a string variable (char array in C/C++). */
/* You are responsible for allocating room for 33 8-bit characters */
/* in the string variable before calling this function. */

PROCEDURE TWAIN_DefaultSourceName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Like GetDefaultSourceName but returns a string */

PROCEDURE TWAIN_OpenSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Opens the source with the given name. */
/* If that source is already open, does nothing and returns TRUE. */
/* If another source is open, closes it and attempts to open the specified source. */
/* Will load and open the Source Manager if needed. */

PROCEDURE TWAIN_EnableSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Enables the open Data Source. This posts the source's user interface */
/* and allows image acquisition to begin.  If the source is already enabled, */
/* this call does nothing and returns TRUE. */

PROCEDURE TWAIN_DisableSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Disables the open Data Source, if any. */
/* This closes the source's user interface. */
/* If successful or the source is already disabled, returns TRUE(1). */

PROCEDURE TWAIN_CloseSource EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Closes the open Data Source, if any. */
/* If the source is enabled, disables it first. */
/* If successful or source is already closed, returns TRUE(1). */

PROCEDURE TWAIN_CloseSourceManager EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Closes the Data Source Manager, if it is open. */
/* If a source is open, disables and closes it as needed. */
/* If successful (or if source manager is already closed) returns TRUE(1). */

PROCEDURE TWAIN_UnloadSourceManager EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Unloads the Data Source Manager i.e. TWAIN.DLL - releasing */
/* any associated memory or resources. */
/* If necessary, it will abort transfers, close the open source */
/* if any, and close the Source Manager. */
/* If successful, it returns TRUE(1) */


PROCEDURE TWAIN_IsTransferReady EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE TWAIN_EndXfer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE TWAIN_AbortAllPendingXfers EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

/* --------- High-level Capability Negotiation Functions -------- */

/* These functions should only be called in State 4 (TWAIN_SOURCE_OPEN) */

PROCEDURE TWAIN_SetXferCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nXfers AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Negotiate with open Source the number of images application will accept. */
/* nXfers = -1 means any number */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

/* ----- Unit of Measure */
/* TWAIN unit codes (from twain.h) */
&GLOBAL-DEFINE TWUN_INCHES 0
&GLOBAL-DEFINE TWUN_CENTIMETERS 1
&GLOBAL-DEFINE TWUN_PICAS 2
&GLOBAL-DEFINE TWUN_POINTS 3
&GLOBAL-DEFINE TWUN_TWIPS 4
&GLOBAL-DEFINE TWUN_PIXELS 5

PROCEDURE TWAIN_GetCurrentUnits EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the current unit of measure: inches, cm, pixels, etc. */
/* Many TWAIN parameters such as resolution are set and returned */
/* in the current unit of measure. */
/* There is no error return - in case of error it returns 0 (TWUN_INCHES) */

PROCEDURE TWAIN_SetUnits EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nUnits AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCurrentUnits EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nUnits AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the current unit of measure for the source. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */
/* Common unit codes (TWUN_*) are given above. */
/* Notes: */
/* 1. Most sources do not support all units, some support *only* inches! */
/* 2. If you want to get or set resolution in DPI (dots per *inch*), make */
/* sure the current units are inches, or you might get Dots-Per-cm! */
/* 3. Ditto (same comment) for ImageLayout, see below. */

PROCEDURE TWAIN_GetBitDepth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get the current bitdepth, which can depend on the current PixelType. */
/* Bit depth is per color channel e.g. 24-bit RGB has bit depth 8. */
/* If anything goes wrong, this function returns 0. */

PROCEDURE TWAIN_SetBitDepth EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nBits AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* (Try to) set the current bitdepth (for the current pixel type). */
/* Note: You should set a PixelType, then set the bitdepth for that type. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

/* ------- TWAIN Pixel Types (from twain.h) */
&GLOBAL-DEFINE TWPT_BW 0
&GLOBAL-DEFINE TWPT_GRAY 1
&GLOBAL-DEFINE TWPT_RGB 2
&GLOBAL-DEFINE TWPT_PALETTE 3
&GLOBAL-DEFINE TWPT_CMY 4
&GLOBAL-DEFINE TWPT_CMYK 5

PROCEDURE TWAIN_GetPixelType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Ask the source for the current pixel type. */
/* If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW). */

PROCEDURE TWAIN_SetPixelType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPixType AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCurrentPixelType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPixType AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set the current pixel type for acquisition. */
/* The source may select this pixel type, but don't assume it will. */

PROCEDURE TWAIN_GetCurrentResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Ask the source for the current (horizontal) resolution. */
/* Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above) */
/* If anything goes wrong (it shouldn't) this function returns 0.0 */

PROCEDURE TWAIN_GetXResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE TWAIN_GetYResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Returns the current horizontal or vertical resolution, in dots per *current unit*. */
/* In the event of failure, returns 0.0. */

PROCEDURE TWAIN_SetResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dRes AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetResolutionInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nRes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCurrentResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dRes AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set the current resolution (in both x & y). */
/* Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above) */
/* Note: The source may select this resolution, but don't assume it will. */

/* You can also set the resolution in X and Y separately, if your TWAIN */
/* device can handle this: */
PROCEDURE TWAIN_SetXResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dxRes AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetYResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dyRes AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE TWAIN_SetContrast EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dCon AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set the current contrast for acquisition. */
/* The TWAIN standard *says* that the range for this cap is -1000 ... +1000 */

PROCEDURE TWAIN_SetBrightness EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dBri AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set the current brightness for acquisition. */
/* The TWAIN standard *says* that the range for this cap is -1000 ... +1000 */

PROCEDURE TWAIN_SetThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dThresh AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set the threshold for black and white scanning. */
/* Should only affect 1-bit scans i.e. PixelType == TWPT_BW. */
/* The TWAIN default threshold value is 128. */
/* After staring at the TWAIN 1.6 spec for a while, I imagine that it implies */
/* that for 8-bit samples, values >= nThresh are thresholded to 1, others to 0. */

PROCEDURE TWAIN_GetCurrentThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Try to get and return the current value (MSG_GETCURRENT) of the */
/* ICAP_THRESHOLD capability.  If this fails for any reason, it */
/* will return -1.  *VERSIONS BEFORE 2.65 RETURNED 128.0* */

/* -------------------------------------------------------------- */
/* Automatic post-processing of scanned pages */


/* Automatic deskewing of scanned pages */

PROCEDURE TWAIN_SetAutoDeskew EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMode AS LONG.
END PROCEDURE.
/* Select the 'auto-deskew' mode. */
/* Auto-deskew attempts to straighten up scans that are slightly crooked, */
/* up to about 10 degrees. */
/* The currently defined modes are: */
/* 0   - no auto deskew (default) */
/* 1   - auto deskew using EZTwain software algorithms */

PROCEDURE TWAIN_GetAutoDeskew EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the current AutoDeskew mode. */


/* Automatic discarding of blank pages */

PROCEDURE TWAIN_SetBlankPageMode EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMode AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetBlankPageMode EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Sets or gets the 'Skip Blank Pages' mode. */
/* The currently defined modes are: */
/* 0 = no special treatment for blank pages (default) */
/* 1 = blank pages are discarded by all multipage Acquire functions. */
/* See TWAIN_SetBlankPageThreshold below for more details. */

PROCEDURE TWAIN_SetBlankPageThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dDarkness AS DOUBLE.
END PROCEDURE.
PROCEDURE TWAIN_GetBlankPageThreshold EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Sets or gets the blank page 'darkness' threshold. */
/* In 'Skip Blank Pages' mode (see above), each page of a multipage */
/* scan is measured for 'darkness'.  If the darkness of a page */
/* is below the BlankPageThreshold, it is considered blank. */
/* See the related functions DIB_IsBlank and DIB_Darkness. */

/* The default BlankPageThreshold is 0.02 (= 2% dark pixels). */

PROCEDURE TWAIN_BlankDiscardCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of blank pages discarded (skipped) during */
/* the most recent multipage scan. */
/* Of course this only reports pages skipped by software, not */
/* any pages discarded as 'blank' inside the scanner - if such */
/* a feature is enabled. */

/* Automatic cropping of scanned pages */

PROCEDURE TWAIN_SetAutoCrop EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMode AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetAutoCrop EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the AutoCrop mode. */
/* Auto-crop attempts to trim off black areas on the outside */
/* edges of each incoming image during scanning. */
/* It will not be effective on scanners that have white */
/* background outside the scanned document. */
/* The currently defined modes are: */
/* 0   - no auto crop (default) */
/* 1   - auto crop using EZTwain software algorithms */
/* 2   - use scanner autocrop if possible, otherwise no autocrop */
/* 3   - use scanner autocrop if possible, otherwise do software autocrop. */

PROCEDURE TWAIN_SetAutoCropOptions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nOpts AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetAutoCropOptions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/get the Options flags for auto-crop during scanning. */
/* See DIB_AutoCrop for details of these flags. */

PROCEDURE TWAIN_SetAutoCropSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER w AS DOUBLE.
  DEFINE INPUT PARAMETER h AS DOUBLE.
  DEFINE INPUT PARAMETER nUnits AS LONG.
END PROCEDURE.
/* Set the width & height for subsequent auto-crops, in the given units. */
/* This restricts subsequent auto-crops to select the best-match crop */
/* position of the specified size. */
/* Use this call if you know the size of the expected document. */
/* For units, see (TWAIN_)GetCurrentUnits. */

/* Note: This setting persists until changed! You must clear it explicitly. */
/* To clear, use SetAutoCropSize(0,0) or call ClearAutoCropSize (below) */

PROCEDURE TWAIN_ClearAutoCropSize EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Clear any restrictions on auto-crop size. */


/* Automatic contrast adjustment of scanned pages */

PROCEDURE TWAIN_SetAutoContrast EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMode AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetAutoContrast EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the AutoContrast mode. */
/* Automatically adjust the contrast of each image - see */
/* DIB_AutoContrast for more information. */
/* The currently defined modes are: */
/* 0   - no autocontrast. */
/* 1   - autocontrast using EZTwain software algorithms */


/* Automatic OCR of scanned pages. */

PROCEDURE TWAIN_SetAutoOCR EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nMode AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetAutoOCR EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Sets or gets the auto-OCR mode */
/* By default this mode is 0 = OFF. */
/* When this mode is on (1), EZTwain applies OCR, if available, to each incoming */
/* scanned page or image and temporarily stores the result.  In this mode, */
/* if you are scanning directly to PDF format using TWAIN_AcquireToFilename */
/* or TWAIN_AcquireMultipageFile, the OCR'd text is also written to each */
/* PDF page as invisible text, to facilitate indexing and searching. */
/* If you are scanning individual pages you can call OCR_Text or OCR_GetText */
/* to retrieve the text found on the most recently scanned page. */
/* In this mode, any Acquire call discards any previous OCR text. */

/* The currently selected OCR engine is used: See OCR_SelectEngine and co. */
/* Caution: If OCR fails for some reason in auto-OCR mode, an error is recorded */
/* (see TWAIN_LastErrorCode, TWAIN_ReportLastError) but the scanning function */
/* may report success. */


/* Automatic negation of scanned pages */

PROCEDURE TWAIN_SetAutoNegate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetAutoNegate EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set or get the "AutoNegate" flag: When this flag is set (non-zero) */
/* EZTwain automatically 'negates' any B&W scanned image that is > 80% black */
/* i.e. it exchanges black & white in the image. */
/* This flag is TRUE (1) by default. */

/* -------------------------------------------------------------- */


PROCEDURE TWAIN_SetXferMech EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER mech AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_XferMech EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Try to set or get the transfer mode - one of the following: */
&GLOBAL-DEFINE XFERMECH_NATIVE 0
&GLOBAL-DEFINE XFERMECH_FILE 1
&GLOBAL-DEFINE XFERMECH_MEMORY 2
/* It is normally not necessary to set the transfer mode,  */
/* TWAIN_Acquire, TWAIN_AcquireMultipageFile and the other general-purpose */
/* scanning functions will select the appropriate transfer mode, taking */
/* the scanner model and scan settings into account. */

/* If your application is used with a particularly wide variety of scanners, */
/* you may encounter a user with a scanning problem that is resolved by forcing */
/* memory transfer mode. To address this, offer a field-settable option that */
/* adds this call as part of scan-parameter setting: */
/* TWAIN_SetXferMech(XFERMECH_MEMORY) */


PROCEDURE TWAIN_SupportsFileXfer EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the open DS claims to support file transfer mode (XFERMECH_FILE) */
/* Returns FALSE(0) otherwise. */
/* This mode is optional.  If TRUE, you can use AcquireFile. */

PROCEDURE TWAIN_SetPaperSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPaper AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* During the next scan, request that the scanner scan the specified paper size. */
/* Most scanners support the first few paper sizes, excluding any that are */
/* larger than their physical scan capacity. */
/* To determine the paper sizes supported by a particular scanner, see */
/* "Working with Capabilities" in the EZTwain User Guide. */

/* Note - These are synonyms for the TWSS_* constants in TWAIN.H */
&GLOBAL-DEFINE PAPER_NONE 0
&GLOBAL-DEFINE PAPER_A4LETTER 1
&GLOBAL-DEFINE PAPER_A4 1
&GLOBAL-DEFINE PAPER_B5LETTER 2
&GLOBAL-DEFINE PAPER_JISB5 2
&GLOBAL-DEFINE PAPER_USLETTER 3
&GLOBAL-DEFINE PAPER_USLEGAL 4
&GLOBAL-DEFINE PAPER_A5 5
&GLOBAL-DEFINE PAPER_B4 6
&GLOBAL-DEFINE PAPER_ISOB4 6
&GLOBAL-DEFINE PAPER_B6 7
&GLOBAL-DEFINE PAPER_ISOB6 7
&GLOBAL-DEFINE PAPER_USLEDGER 9
&GLOBAL-DEFINE PAPER_USEXECUTIVE 10
&GLOBAL-DEFINE PAPER_A3 11
&GLOBAL-DEFINE PAPER_B3 12
&GLOBAL-DEFINE PAPER_ISOB3 12
&GLOBAL-DEFINE PAPER_A6 13
&GLOBAL-DEFINE PAPER_C4 14
&GLOBAL-DEFINE PAPER_C5 15
&GLOBAL-DEFINE PAPER_C6 16
&GLOBAL-DEFINE PAPER_4A0 17
&GLOBAL-DEFINE PAPER_2A0 18
&GLOBAL-DEFINE PAPER_A0 19
&GLOBAL-DEFINE PAPER_A1 20
&GLOBAL-DEFINE PAPER_A2 21
&GLOBAL-DEFINE PAPER_A7 22
&GLOBAL-DEFINE PAPER_A8 23
&GLOBAL-DEFINE PAPER_A9 24
&GLOBAL-DEFINE PAPER_A10 25
&GLOBAL-DEFINE PAPER_ISOB0 26
&GLOBAL-DEFINE PAPER_ISOB1 27
&GLOBAL-DEFINE PAPER_ISOB2 28
&GLOBAL-DEFINE PAPER_ISOB5 29
&GLOBAL-DEFINE PAPER_ISOB7 30
&GLOBAL-DEFINE PAPER_ISOB8 31
&GLOBAL-DEFINE PAPER_ISOB9 32
&GLOBAL-DEFINE PAPER_ISOB10 33
&GLOBAL-DEFINE PAPER_JISB0 34
&GLOBAL-DEFINE PAPER_JISB1 35
&GLOBAL-DEFINE PAPER_JISB2 36
&GLOBAL-DEFINE PAPER_JISB3 37
&GLOBAL-DEFINE PAPER_JISB4 38
&GLOBAL-DEFINE PAPER_JISB6 39
&GLOBAL-DEFINE PAPER_JISB7 40
&GLOBAL-DEFINE PAPER_JISB8 41
&GLOBAL-DEFINE PAPER_JISB9 42
&GLOBAL-DEFINE PAPER_JISB10 43
&GLOBAL-DEFINE PAPER_C0 44
&GLOBAL-DEFINE PAPER_C1 45
&GLOBAL-DEFINE PAPER_C2 46
&GLOBAL-DEFINE PAPER_C3 47
&GLOBAL-DEFINE PAPER_C7 48
&GLOBAL-DEFINE PAPER_C8 49
&GLOBAL-DEFINE PAPER_C9 50
&GLOBAL-DEFINE PAPER_C10 51
&GLOBAL-DEFINE PAPER_USSTATEMENT 52
&GLOBAL-DEFINE PAPER_BUSINESSCARD 53

PROCEDURE TWAIN_GetPaperDimensions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nPaper AS LONG.
  DEFINE INPUT PARAMETER nUnits AS LONG.
  DEFINE OUTPUT PARAMETER pdW AS DOUBLE.
  DEFINE OUTPUT PARAMETER pdH AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Retrieve the width and height of a standard paper size. */
/* 1st parameter is a PAPER_ code. */
/* 2nd parameter is a unit code, TWUN_INCHES, TWUN_CENTIMETERS, etc. */
/* 3rd & 4th parameter are pointers to double variables that receive the width */
/* and height of the specified paper size, in the specified units. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

/* -------- Document Feeder ------- */

PROCEDURE TWAIN_HasFeeder EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the source indicates it has a document feeder. */
/* Note: A FALSE(0) is returned if the source does not handle this inquiry. */

PROCEDURE TWAIN_ProbablyHasFlatbed EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if we think the source has a flatbed available. */
/* It's a good guess but not a guarantee - we could be wrong. */

PROCEDURE TWAIN_IsFeederSelected EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the document feeder is selected. */

PROCEDURE TWAIN_SelectFeeder EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* (Try to) select or deselect the document feeder. */
/* The document feeder, if any, is selected if bYes is non-zero. */
/* The flatbed, if any, is selected if bYes is zero. */
/* Note: A few of the scanners that have both a flatbed and  */
/* a feeder ignore this request in some circumstances. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE TWAIN_IsAutoFeedOn EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if automatic feeding is enabled, otherwise FALSE(0). */
/* Make sure the feeder is selected before calling this function. */

PROCEDURE TWAIN_SetAutoFeed EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* (Try to) turn on/off automatic feeding thru the feeder. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */
/* Note: TWAIN_AcquireMultipageFile calls TWAIN_SetAutoFeed(True). */

PROCEDURE TWAIN_IsFeederLoaded EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if there are documents in the feeder. */
/* Make sure the feeder is selected before calling this function. */

PROCEDURE TWAIN_IsPaperDetectable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the open device (better have one open!) */
/* is capable of detecting paper in its feeder. */
/* If not, returns FALSE. */
/* Displays an error dialog if called with no scanner open. */

PROCEDURE TWAIN_SetAutoScan EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Setting this to TRUE gives the scanner permission to 'scan ahead' */
/* i.e. to pull pages from the feeder and scan them before  */
/* they have been requested.  On high-speed scanners, you may */
/* have to enable AutoScan to achieve the maximum scanning rate. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */
/* This call will fail on most flatbeds & cameras, and some 'feeder' */
/* scanners. */
/* TWAIN_AcquireMultipageFile calls TWAIN_SetAutoScan(True). */

/* -------- Duplex Scanning ------- */

PROCEDURE TWAIN_GetDuplexSupport EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Query the device for duplex scanning support. */
/* Return values: */
/* 0    = no support (or error, or query not recognized) */
/* 1    = 1-pass duplex */
/* 2    = 2-pass duplex */

PROCEDURE TWAIN_EnableDuplex EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Enable (bYes not 0) or disable (bYes=0) duplex scanning. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE TWAIN_IsDuplexEnabled EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if the device supports duplex scanning */
/* and duplex scanning is enabled.  FALSE(0) otherwise. */

/* --------- Other 'exotic' capabilities -------- */

PROCEDURE TWAIN_HasControllableUI EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return 1 if source claims UI can be hidden (see SetHideUI above) */
/* Return 0 if source says UI *cannot* be hidden */
/* Return -1 if source (pre TWAIN 1.6) cannot answer the question. */

PROCEDURE TWAIN_SetIndicators EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bVisible AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetIndicators EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the value of CAP_INDICATORS. */
/* This is set & read from the open Source if a source is open, otherwise */
/* these functions set & report the value that will be used the next time */
/* a source is opened. */

/* Default is TRUE, which gives the device permission to show a progress */
/* box or similar, but does not require it. */

PROCEDURE TWAIN_Compression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCompression EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER compression AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get compression style for transferred data */
/* Set returns TRUE(1) for success, FALSE(0) for failure. */

PROCEDURE TWAIN_Tiled EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetTiled EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bTiled AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get whether source does memory xfer via strips or tiles. */
/* bTiled = TRUE if it uses tiles for transfer. */
/* Set returns: TRUE(1) for success, FALSE(0) for failure. */

PROCEDURE TWAIN_PlanarChunky EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPlanarChunky EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER shape AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get current pixel shape (TWPC_CHUNKY or TWPC_PLANAR), or -1. */
/* Set returns TRUE(1) for success, FALSE(0) for failure. */

&GLOBAL-DEFINE CHUNKY_PIXELS 0
&GLOBAL-DEFINE PLANAR_PIXELS 1

PROCEDURE TWAIN_PixelFlavor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetPixelFlavor EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER flavor AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get pixel 'flavor' - whether a '0' pixel value means black or white: */
/* Set returns: TRUE(1) for success, FALSE(0) for failure. */

&GLOBAL-DEFINE CHOCOLATE_PIXELS 0
&GLOBAL-DEFINE VANILLA_PIXELS 1


PROCEDURE TWAIN_SetLightPath EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bTransmissive AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Tries to select transparent or reflective media on the open source. */
/* A parameter of TRUE(1) means transparent, FALSE(0) means reflective. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

PROCEDURE TWAIN_SetAutoBright EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bOn AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetGamma EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER dGamma AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetShadow EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetHighlight EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set auto-brightness, gamma, shadow, and highlight values. */
/* Refer to the TWAIN specification for definitions of these settings. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

/* --------- Image Layout (Region of Interest) -------- */

PROCEDURE TWAIN_SetRegion EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER L AS DOUBLE.
  DEFINE INPUT PARAMETER T AS DOUBLE.
  DEFINE INPUT PARAMETER R AS DOUBLE.
  DEFINE INPUT PARAMETER B AS DOUBLE.
END PROCEDURE.
/* Specify the region to be acquired, in current unit of measure. */
/* This is the recommended most-general way to scan a region. */
/* Tries to use TWAIN_SetImageLayout and TWAIN_SetFrame (see below). */
/* If the device ignores those, the specified region is extracted */
/* after each scan completes, by software cropping. (DIB_RegionCopy) */
/* In other words, this call should *always* produce scans of */
/* the requested region, unless you specify a region in inches or */
/* centimeters and the device is a camera whose only unit is pixels. */

PROCEDURE TWAIN_ResetRegion EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Clear any region set with TWAIN_SetRegion above. */

PROCEDURE TWAIN_SetImageLayout EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER L AS DOUBLE.
  DEFINE INPUT PARAMETER T AS DOUBLE.
  DEFINE INPUT PARAMETER R AS DOUBLE.
  DEFINE INPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Specify the area to scan, sometimes called the ROI (Region of Interest) */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */
/* This call is only valid in State 4. */
/* L, T, R, B = distance to left, top, right, and bottom edge of */
/* area to scan, measured in the current unit of measure, */
/* from the top-left corner of the 'original page' (TWAIN 1.6 8-22) */

PROCEDURE TWAIN_GetImageLayout EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER L AS DOUBLE.
  DEFINE OUTPUT PARAMETER T AS DOUBLE.
  DEFINE OUTPUT PARAMETER R AS DOUBLE.
  DEFINE OUTPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetDefaultImageLayout EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER L AS DOUBLE.
  DEFINE OUTPUT PARAMETER T AS DOUBLE.
  DEFINE OUTPUT PARAMETER R AS DOUBLE.
  DEFINE OUTPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get the current or default (power-on) area to scan. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */
/* This call is valid in States 4-6. */
/* Supposedly the returned values (see above) */
/* are in the current unit of measure (ICAP_UNITS), but I observe that */
/* many DS's ignore ICAP_UNITS when dealing with Image Layout. */

PROCEDURE TWAIN_ResetImageLayout EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Reset the area to scan to the default (power-on) settings. */
/* This call is only valid in State 4. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */


/* Closely related: */
PROCEDURE TWAIN_SetFrame EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER L AS DOUBLE.
  DEFINE INPUT PARAMETER T AS DOUBLE.
  DEFINE INPUT PARAMETER R AS DOUBLE.
  DEFINE INPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* This is an alternative way to set the scan area. */
/* Some scanners will respond to this instead of SetImageLayout. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */
/* This call is only valid in State 4. */
/* L, T, R, B = distance to left, top, right, and bottom edge of */
/* area to scan, measured in the current unit of measure, */


/* --------- Tone Response Curves -------- */

PROCEDURE TWAIN_SetGrayResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pcurve AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Define a translation of gray pixel values. */
/* When device digitizes a pixel with value V, that */
/* pixel is translated to value pcurve[V] before it */
/* is returned to the application. */
/* Device must be open (State 4), */
/* Current PixelType must be TWPT_GRAY or TWPT_RGB, */
/* current BitDepth should be 8. */
/* pcurve must be a table (array, vector) of 256 entries. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

PROCEDURE TWAIN_SetColorResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER pred AS MEMPTR.
  DEFINE INPUT PARAMETER pgreen AS MEMPTR.
  DEFINE INPUT PARAMETER pblue AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Define a translation of color values. */
/* Like TWAIN_SetGrayResponse (above) but separate translation can */
/* be applied to each color channel. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

PROCEDURE TWAIN_ResetGrayResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_ResetColorResponse EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* These two functions reset the response curve to map every */
/* value V to itself i.e. a 'do nothing' translation. */
/* Returns: TRUE(1) for success, FALSE(0) for failure. */

/* --------- Barcode Recognition ------- */

PROCEDURE BARCODE_IsAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TRUE(1) if barcode recognition is available. */
/* Returns FALSE(0) otherwise. */

PROCEDURE BARCODE_Version EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the barcode module version * 100. */

/* Barcode recognition engines supported by EZTwain: */
&GLOBAL-DEFINE EZBAR_ENGINE_NONE 0
&GLOBAL-DEFINE EZBAR_ENGINE_DOSADI 1
&GLOBAL-DEFINE EZBAR_ENGINE_AXTEL 2
&GLOBAL-DEFINE EZBAR_ENGINE_LEADTOOLS15 3
&GLOBAL-DEFINE EZBAR_ENGINE_BLACKICE 4
&GLOBAL-DEFINE EZBAR_ENGINE_LEADTOOLS16 5

&GLOBAL-DEFINE EZBAR_ENGINE_LEADTOOLS 3

/* The Axtel barcode engine has been discontinued by Axtel. */
/* The LEADTOOLS engine must be separately licensed from LEADTOOLS - www.leadtools.com */
/* The Black Ice barcode engine must be separately licensed from Black Ice.  */

PROCEDURE BARCODE_IsEngineAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE BARCODE_SelectEngine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE BARCODE_SelectedEngine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE BARCODE_EngineName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Returns the short name ("None", "Dosadi", "Axtel", "LEADTOOLS", "Black Ice") of the specified */
/* engine, or the empty string if nEngine is not a recognized barcode engine code. */

PROCEDURE BARCODE_SetLicenseKey EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sKey AS CHARACTER.
END PROCEDURE.
/* Supply your license key for the currently selected engine. */
/* The Dosadi engine does not currently require a key. */
/* For LeadTools, this is a 1D Barcode Module key obtained from LeadTools */

PROCEDURE BARCODE_ReadableCodes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the sum of the barcode types recognized by the current selected engine. */

/* Barcode types: */
&GLOBAL-DEFINE EZBAR_EAN_13 1
&GLOBAL-DEFINE EZBAR_EAN_8 2
&GLOBAL-DEFINE EZBAR_UPCA 4
&GLOBAL-DEFINE EZBAR_UPCE 8
&GLOBAL-DEFINE EZBAR_CODE_39 16
&GLOBAL-DEFINE EZBAR_CODE_39FA 32
&GLOBAL-DEFINE EZBAR_CODE_128 64
&GLOBAL-DEFINE EZBAR_CODE_I25 128
&GLOBAL-DEFINE EZBAR_CODA_BAR 256
&GLOBAL-DEFINE EZBAR_UCCEAN_128 512
&GLOBAL-DEFINE EZBAR_CODE_93 1024
&GLOBAL-DEFINE EZBAR_ANY -1

PROCEDURE BARCODE_TypeName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nType AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return a human-readable name for the specified barcode type/symbology. */

PROCEDURE BARCODE_SetDirectionFlags EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nDirFlags AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE BARCODE_GetDirectionFlags EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE BARCODE_AvailableDirectionFlags EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set/Get the directions the engine will scan for barcodes. */
/* The default is left-to-right ONLY. */
/* Scanning for barcodes in multiple directions can slow the */
/* recognition process.  BARCODE_SetDirectionFlags will return TRUE if */
/* completely successful, FALSE if any direction is invalid or not supported. */
/* Setting the direction flags to -1 is interpreted as "select all supported */
/* directions." */

/* Barcode direction flags - can be or'ed together */
&GLOBAL-DEFINE EZBAR_LEFT_TO_RIGHT 1
&GLOBAL-DEFINE EZBAR_RIGHT_TO_LEFT 2
&GLOBAL-DEFINE EZBAR_TOP_TO_BOTTOM 4
&GLOBAL-DEFINE EZBAR_BOTTOM_TO_TOP 8
&GLOBAL-DEFINE EZBAR_DIAGONAL 16
/* some common combinations: */
&GLOBAL-DEFINE EZBAR_HORIZONTAL 3
&GLOBAL-DEFINE EZBAR_VERTICAL 12

PROCEDURE BARCODE_SetZone EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
END PROCEDURE.
/* Restrict barcode recognition to one zone (in pixels) of each image. */
/* Coordinates are left pixel, top pixel, width and height in pixels. */

PROCEDURE BARCODE_NoZone EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Cancel any zone restriction - subsequent barcode recognition */
/* applies to the entire image. */

PROCEDURE BARCODE_Recognize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER nMaxCount AS LONG.
  DEFINE INPUT PARAMETER nType AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Find and recognize barcodes in the given image. */
/* Don't look for more than nMaxCount barcodes (-1 means 'any number') */
/* Expect barcodes of the specified type (-1 means 'any recognized type') */
/* You can add or 'or' together barcode types. */

/* Return values: */
/* n>0    n barcodes found */
/* 0      no barcodes found */
/* -1      barcode services not available. */
/*                                -2                                                                  -not used- */
/* -3      invalid or null image */
/*                                -4                                                                  memory error (low memory?) */
/* -5                                                               internal error, or error from 3rd party barcode engine. */

PROCEDURE BARCODE_Text EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the text of the nth barcode recognized by the last BARCODE_Recognize. */
/* barcodes are numbered from 0. */
/* If there is any problem of any kind, returns the empty string. */

PROCEDURE BARCODE_GetText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER Text1 AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get the text of the nth barcode recognized by the last BARCODE_Recognize. */
/* Please allow 64 characters in your text buffer.  Use a smaller buffer */
/* only if you *know* that the barcode type is limited to shorter strings. */

PROCEDURE BARCODE_Type EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the type (symbology) of the nth barcode recognized. */

PROCEDURE BARCODE_GetRect EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE OUTPUT PARAMETER L AS DOUBLE.
  DEFINE OUTPUT PARAMETER T AS DOUBLE.
  DEFINE OUTPUT PARAMETER R AS DOUBLE.
  DEFINE OUTPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get the rectangle bounding the nth barcode found in the last BARCODE_Recognize. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise.  The only likely cause */
/* of a FALSE return would be an invalid value of n, or a null reference. */
/* L    = left edge */
/* T    = top edge */
/* R    = right edge */
/* B    = bottom edge */
/* Note: Returned coordinates are in pixels, relative to the upper-left corner */
/* of the image given to BARCODE_Recognize. */

/* --------- OCR (Optical Character Recognition) ------- */

/* Note: Requires the Transym OCR engine (TOCR) which must be separately */
/* licensed from Transym - See www.transym.com */

PROCEDURE OCR_IsAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* TRUE(1) if OCR recognition is available in some form. */
/* Returns FALSE(0) otherwise. */

PROCEDURE OCR_Version EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns version * 100 of the EZTwain OCR module. */

/* ----- OCR engines supported by EZTwain ----- */
&GLOBAL-DEFINE EZOCR_ENGINE_NONE 0
&GLOBAL-DEFINE EZOCR_ENGINE_TRANSYM 1

PROCEDURE OCR_IsEngineAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE OCR_SelectEngine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE OCR_SelectedEngine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE OCR_SelectDefaultEngine EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE OCR_EngineName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nEngine AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Returns the short name ("None", "Transym TOCR") of the specified */
/* engine, or the empty string if nEngine is not a recognized OCR engine code. */

PROCEDURE OCR_SetEngineKey EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sKey AS CHARACTER.
END PROCEDURE.
/* Set the license key to be passed to the OCR engine. */
/* * If you are using the reseller version of Transym's TOCR, pass the */
/* RegNo provided by Transym, as a string e.g. "0123-4567-89AB-CDEF" */

PROCEDURE OCR_SetLineBreak EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sEOL AS CHARACTER.
END PROCEDURE.
/* Set the character sequence to use for line breaks in */
/* the returned OCR'd text (as returned by OCR_Text and OCR_GetText). */
/* .. */
/* The default OCR line break is \n (LF, 0x0A) */
/* Other commonly used line breaks are \r (CR, 0x0D) or CRLF. */
/* Set this *before* doing OCR - it does not modify already */
/* recognized text. */

PROCEDURE OCR_RecognizeDib EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE OCR_RecognizeDibZone EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE INPUT PARAMETER x AS LONG.
  DEFINE INPUT PARAMETER y AS LONG.
  DEFINE INPUT PARAMETER w AS LONG.
  DEFINE INPUT PARAMETER h AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Find and recognize text in the given image, or */
/* in a designated zone of an image. */
/* Coordinates are left pixel, top pixel, width & height in pixels. */

/* Return values: */
/* 0                                                                no error, but no text found */
/* n > 0                          n characters found (including spaces and returns) */
/* -1                                                               OCR services not available */
/* -3                                                               invalid or null image */
/* -5                                                               internal error or error returned by OCR engine */

/* In case of error, call TWAIN_ReportLastError to display details, */
/* or call TWAIN_LastErrorCode and related functions. */

PROCEDURE OCR_Text EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the text found by the last OCR_RecognizeDib */
/* If there is any problem of any kind, returns the empty string. */

PROCEDURE OCR_GetText EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER TextBuffer AS MEMPTR.
  DEFINE INPUT PARAMETER nBufLen AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Read the text recognized by the last OCR_RecognizeDib */
/* into the TextBuffer, which is allocated to hold nBufLen chars. */
/* Returns the number of characters actually returned. */
/* Always appends a trailing 0 (NUL). */
/* Will return 0 if the available text does not fit. */

PROCEDURE OCR_TextLength EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the number of characters in OCR_Text. */
/* Does not count the terminal NUL, */
/* for those of you working with C-style strings. */

PROCEDURE OCR_TextOrientation EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns the orientation of the text found by the last OCR_RecognizeDib. */
/* The value is the number of degrees clockwise that the input */
/* image was auto-rotated before OCR was performed. */
/* Currently, the returned value is always a multiple of 90, so */
/* the only possible values are 0, 90, 180 and 270. */
/* Example: If the original was turned 90 degrees clockwise before scanning, */
/* it will be auto-rotated 90 degrees *counter-clockwise* before OCR, so */
/* then the value of this function will be 270. */

PROCEDURE OCR_GetCharPositions EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER charx AS MEMPTR.
  DEFINE OUTPUT PARAMETER chary AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE OCR_GetCharSizes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER charw AS MEMPTR.
  DEFINE OUTPUT PARAMETER charh AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the coordinates or sizes of the characters found by the last */
/* OCR_RecognizeDib call. */
/* For each character of the string returned by OCR_Text or OCR_GetText, */
/* these functions return the x and y coordinates in the array charx and chary, */
/* and the width and height in the arrays charw and charh. */
/* So (charx[i],chary[i]) will be the position of the ith character. */
/* Coordinates are for the top-left corner of the character, relative */
/* to the top-left corner of the OCR'd image. */
/* Width and height are in pixels. */

/* Please make *sure* that you pass in (the address/reference of) */
/* two arrays allocated to hold n values, where n is the return */
/* value from the last call to OCR_Recognize. */

PROCEDURE OCR_GetResolution EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE OUTPUT PARAMETER xdpi AS DOUBLE.
  DEFINE OUTPUT PARAMETER ydpi AS DOUBLE.
END PROCEDURE.
/* Return the resolution (in DPI) of the last image given to OCR_RecognizeDib. */
/* Useful for translating pixel coordinates and sizes into physical (inch) values. */

PROCEDURE OCR_ClearText EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Clear any currently stored OCR text. */

PROCEDURE OCR_WritePage EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* If an OCR engine is selected and available, and there is */
/* a PDF file open for writing (by TWAIN_BeginMultipageFile), then */
/* this function OCRs the image, and writes both the image and */
/* the text to the output PDF. */

/* Returns TRUE if successful, FALSE otherwise: */
/* In case of error, call TWAIN_ReportLastError to display details, */
/* or call TWAIN_LastErrorCode and related functions. */

PROCEDURE OCR_WriteTextToPDF EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Write the text from the last OCR to the next PDF page. */
/* Returns TRUE if successful, FALSE in case of error. */
/* If there is no OCR text to write, does nothing & returns TRUE. */

PROCEDURE OCR_SetAutoRotatePagesToPDF EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER bYes AS LONG.
END PROCEDURE.
PROCEDURE OCR_GetAutoRotatePagesToPDF EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get/Get a global option 'Auto Rotate Pages to PDF' that affects */
/* output of OCR'd text and images to PDF. */

/* When this option is set, OCR_WritePage and OCR_WriteTextToPDF use the */
/* orientation of any OCR'd text to rotate each page so text is 'upright'. */
/* This requires rotating both the text and image on each affected page. */
/* Of course any functions that call those functions are also affected. */

/* --------- Fun With Containers -------- */

/* Capability values are passed thru the TWAIN API in complex global */
/* memory structures called 'containers'.  EZTWAIN abstracts these */
/* containers with a handle (an integer) called an HCONTAINER. */
/* If you are coding in VB or similar, this is a 32-bit integer. */
/* The following functions provide reasonably comprehensive access */
/* to the contents of containers.  See also TWAIN_Get, TWAIN_Set. */

/* There are four shapes of containers, which I call 'formats'. */
/* Depending on its format, a container holds some 'items' - these */
/* are simple data values, all the same type in a given container. */
/* Item types are enumerated by TWTY_* */

/* Container formats, same codes as in TWAIN.H */
&GLOBAL-DEFINE TWON_ARRAY 3
&GLOBAL-DEFINE TWON_ENUMERATION 4
&GLOBAL-DEFINE TWON_ONEVALUE 5
&GLOBAL-DEFINE TWON_RANGE 6


PROCEDURE CONTAINER_Free EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
END PROCEDURE.
/* Free the memory and resources of a capability container. */

PROCEDURE CONTAINER_Copy EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Create an exact copy of the container. */

PROCEDURE CONTAINER_Equal EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hconA AS LONG.
  DEFINE INPUT PARAMETER hconB AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE (1) iff all properties of hconA and hconB are the same. */

PROCEDURE CONTAINER_Format EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the 'format' of this container: TWON_ONEVALUE, etc. */

PROCEDURE CONTAINER_ItemCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of values in the container. */
/* For a ONEVALUE, return 1. */

PROCEDURE CONTAINER_ItemType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the item type (what exact kind of values are in the container.) */
/* See the TWTY_* definitions in TWAIN.H */

PROCEDURE CONTAINER_TypeSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nItemType AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the size in bytes of an item of the specified type (TWTY_*) */

PROCEDURE CONTAINER_GetStringValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER sText AS MEMPTR.
END PROCEDURE.
PROCEDURE CONTAINER_FloatValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_IntValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_StringValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Get the value of the nth item in the container. */
/* n is forced into the range 0 to ItemCount(hcon)-1. */
/* For string values, if the container items are not strings, they */
/* are converted to an equivalent string (e.g. "TRUE", "23", "2.37", etc.) */


PROCEDURE CONTAINER_ContainsValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_ContainsValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE(1) if the value is one of the items in the container. */
PROCEDURE CONTAINER_FindValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_FindValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the 0-origin index of the value in the container. */
/* Return -1 if not found. */

PROCEDURE CONTAINER_CurrentValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_DefaultValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_CurrentValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_DefaultValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the container's current or power-up (default) value. */
/* Array containers do not have these and will return -1.0. */
/* OneValue containers always return their (one) value. */

PROCEDURE CONTAINER_DefaultIndex EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_CurrentIndex EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the index of the Default or Current value. */
/* Works on Enumerations, Ranges and OneValues. */
/* (Always returns 0 for a OneValue) */
/* Returns -1 for an Array. */


PROCEDURE CONTAINER_MinValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_MaxValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_MinValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_MaxValueInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the smallest/largest value in the container. */
/* For a OneValue, this is just the value. */
/* For a Range, these are the Min and Max values of the range. */
/* For an Array or Enumeration, the container is searched to find */
/* the smallest/largest value. */

PROCEDURE CONTAINER_StepSize EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE CONTAINER_StepSizeInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the 'step' value of a Range container. */
/* Returns -1 if the container is not a Range. */

/* The following four functions create containers from scratch: */
/* nItemType is one of the TWTY_* item types from TWAIN.H */
/* nItems is the number of items, in an array or enumeration. */
/* dMin, dMax, dStep are the beginning, ending, and step value of a range. */
PROCEDURE CONTAINER_OneValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nItemType AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_Range EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nItemType AS LONG.
  DEFINE INPUT PARAMETER dMin AS DOUBLE.
  DEFINE INPUT PARAMETER dMax AS DOUBLE.
  DEFINE INPUT PARAMETER dStep AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_Array EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nItemType AS LONG.
  DEFINE INPUT PARAMETER nItems AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_Enumeration EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nItemType AS LONG.
  DEFINE INPUT PARAMETER nItems AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE CONTAINER_SetItem EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_SetItemInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER nVal AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_SetItemString EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER sVal AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_SetItemFrame EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER l AS DOUBLE.
  DEFINE INPUT PARAMETER t AS DOUBLE.
  DEFINE INPUT PARAMETER r AS DOUBLE.
  DEFINE INPUT PARAMETER b AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_GetItemFrame EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE OUTPUT PARAMETER L AS DOUBLE.
  DEFINE OUTPUT PARAMETER T AS DOUBLE.
  DEFINE OUTPUT PARAMETER R AS DOUBLE.
  DEFINE OUTPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set(or get) the nth item of the container to dVal or pzText, or frame(l,t,r,b). */
/* NOTE: A OneValue is treated as an array with 1 element.  */
/* Return TRUE(1) if successful. FALSE(0) for error such as: */
/* The container is not an array, enumeration, or onevalue */
/* n < 0 or n >= CONTAINER_ItemCount(hcon) */
/* the value cannot be represented in this container's ItemType. */
/* Frame operations fail if the CONTAINER_ItemType is not TWTY_FRAME. */

PROCEDURE CONTAINER_SelectCurrentValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_SelectCurrentItem EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the current value within an enumeration or range, */
/* by specifying either the value, or its index. */
/* Returns TRUE(1) if successful, FALSE(0) otherwise. */
/* This will fail if: */
/* The container is not an enumeration or range. */
/* dVal is not one of the values in the container */
/* n < 0 or n >= CONTAINER_ItemCount(hcon) */

PROCEDURE CONTAINER_SelectDefaultValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE CONTAINER_SelectDefaultItem EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Select the default value in an enumeration or range. */
/* We're not sure what this would be good for, since an application */
/* cannot change the default value of a capability - that value is */
/* determined by the device TWAIN driver. */
/* So these functions are for logical completeness only. */

PROCEDURE CONTAINER_DeleteItem EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Delete the nth item from an Array or Enumeration container. */
/* Returns TRUE(1) for success, FALSE(0) otherwise. Failure causes: */
/* invalid container handle */
/* container is not an array or enumeration */
/* n < 0 or n >= ItemCount(hcon) */

PROCEDURE CONTAINER_InsertItem EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Insert an item with value dVal into the container at position n. */
/* If n < 0, the item is inserted at the end of the container. */
/* Return TRUE(1) on success, FALSE(0) on failure. */
/* Possible causes of failure: */
/* NULL or invalid container handle */
/* container format is not enumeration or array */
/* memory allocation failed - heap corrupted, or out of memory. */

/* --- Very low level CONTAINER functions you probably won't need: */
PROCEDURE CONTAINER_Wrap EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nFormat AS LONG.
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Wrap a TWAIN container handle into an HCONTAINER object. */
/* Note: *Do Not* free the hcon - it is now owned by the HCONTAINER. */
PROCEDURE CONTAINER_Unwrap EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Unwrap a TWAIN container from an HCONTAINER object - free the */
/* HCONTAINER and return the original TWAIN container handle. */
PROCEDURE CONTAINER_Handle EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Retrieve the handle of the TWAIN container wrapped in our HCONTAINER */
PROCEDURE CONTAINER_IsValid EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE if the argument seems to be a valid HCONTAINER object. */

/* --------- Low-level Capability Negotiation Functions -------- */

/* Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN) */
/* Getting a capability is valid in State 4 or any higher state. */

PROCEDURE TWAIN_IsCapAvailable EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Test if open device responds to a 'Get' on a capability. */
/* Only valid in State 4 or higher. */
/* Returns TRUE(1) if the capability can be queried, FALSE(0) if not. */

PROCEDURE TWAIN_Get EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a DAT_CAPABILITY/MSG_GET to the open source. */
/* Return a capability 'container' - the 'MSG_GET' value of the capability. */
/* Use CONTAINER_* functions to examine and modify the container object. */
/* Use CONTAINER_Free to release it when you are done with it. */
/* A return value of 0 indicates failure:  Call GetConditionCode */
/* or ReportLastError above. */

PROCEDURE TWAIN_GetDefault EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetCurrent EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a DAT_CAPABILITY/MSG_GETDEFAULT or MSG_GETCURRENT.  See Get above. */

PROCEDURE TWAIN_Set EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE INPUT PARAMETER hcon AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a DAT_CAPABILITY/MSG_SET to the open source, */
/* using the specified capability and container. */
/* Return value as for TWAIN_DS */

PROCEDURE TWAIN_Reset EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a MSG_RESET on the specified capability. */
/* State must be 4.  Returns TRUE(1) if successful, FALSE(0) otherwise. */

PROCEDURE TWAIN_QuerySupport EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER uCap AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a MSG_QUERYSUPPORT on the specified capability. */
/* State must be 4 or higher.  Returns the integer value that the device */
/* returned, which can be 0. */
/* A return < 0 indicates an error. */

PROCEDURE TWAIN_SetCapability EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER dValue AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* The most general capability-setting function, it negotiates */
/* with the open device to set the given capability to the specified value. */
/* If successful, returns TRUE(1), otherwise FALSE(0). */
/* There must be a device open and in state 4, or an error is recorded. */
/* (See TWAIN_ReportLastError.) */

PROCEDURE TWAIN_SetCapString EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER sValue AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the value of a capability that takes a string value. */
/* You don't need to specify the 'itemType', EZTwain asks the driver */
/* which itemType it wants. */

PROCEDURE TWAIN_SetCapBool EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER bValue AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Shorthand for TWAIN_SetCapOneValue(cap, TWTY_BOOL, bValue); */

PROCEDURE TWAIN_GetCapBool EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER bDefault AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetCapFix32 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER dDefault AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
PROCEDURE TWAIN_GetCapUint16 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER nDefault AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_GetCapUint32 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER cap AS LONG.
  DEFINE INPUT PARAMETER lDefault AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a DAT_CAPABILITY/MSG_GETCURRENT on the specified capability, */
/* assuming the value type is Bool, Fix32, etc.. */
/* If successful, return the returned value.  Otherwise return bDefault. */
/* This is only valid in State 4 (TWAIN_SOURCE_OPEN) or higher. */

PROCEDURE TWAIN_SetCapFix32 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER Cap AS LONG.
  DEFINE INPUT PARAMETER dVal AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCapOneValue EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER Cap AS LONG.
  DEFINE INPUT PARAMETER ItemType AS LONG.
  DEFINE INPUT PARAMETER ItemVal AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE, */
/* CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type */
/* and value.  Use SetCapFix32 for capabilities that take a FIX32 value, */
/* use SetCapOneValue for the various ints and uints.  These functions */
/* do not support FRAME or STR items. */
/* Return Value: TRUE (1) if successful, FALSE (0) otherwise. */

PROCEDURE TWAIN_SetCapFix32R EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER Cap AS LONG.
  DEFINE INPUT PARAMETER Numerator AS LONG.
  DEFINE INPUT PARAMETER Denominator AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Just like TWAIN_SetCapFix32, but uses the value Numerator/Denominator */
/* This is useful for languages that make it hard to pass double parameters. */

PROCEDURE TWAIN_GetCapCurrent EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER Cap AS LONG.
  DEFINE INPUT PARAMETER ItemType AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pVal AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'. */
/* Copy the current value out of the returned container into *pVal. */
/* If the operation fails (the source refuses the request), or if the */
/* container is not a ONEVALUE or ENUMERATION, or if the item type of the */
/* returned container is incompatible with the expected TWTY_ type in nType, */
/* returns FALSE.  If this function returns FALSE, *pVal is not touched. */

PROCEDURE TWAIN_ToFix32 EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER d AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed */
/* to e.g. TWAIN_SetCapOneValue */
PROCEDURE TWAIN_ToFix32R EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER Numerator AS LONG.
  DEFINE INPUT PARAMETER Denominator AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Convert a rational number to a 32-bit TW_FIX32 value. */
/* Returns a TW_FIX32 value that approximates Numerator/Denominator */

PROCEDURE TWAIN_Fix32ToFloat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nfix AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Convert a TW_FIX32 value (as returned from some capability inquiries) */
/* to a double (floating point) value. */


/* --------- Custom DS Data */

/* The following functions support the CUSTOMDSDATA feature */
/* introduced in TWAIN 1.7.  This is an optional feature - many document */
/* scanners support it, and some flatbeds.  It allows an application to */
/* capture a snapshot of a particular device's settings, and then to restore */
/* that state at a later time.  It is particularly useful in conjunction */
/* with TWAIN_DoSettingsDialog, q.v. */

/* Note: The format of the custom data is not defined or restricted by TWAIN */
/* so typically differs between vendors and even between scanner models. */
/* It is also *not* restricted to be ANSI text, although most vendors seem to */
/* use a text format. */

/* To find out if a device supports this feature, open the device and see if */
/* TWAIN_GetCapBool(CAP_CUSTOMDSDATA, FALSE) returns TRUE. */

/* These are valid only in TWAIN_State() = 4 (TWAIN_SOURCE_OPEN) */

PROCEDURE TWAIN_GetCustomDataToFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
PROCEDURE TWAIN_SetCustomDataFromFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFilename AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Get or Set the 'custom data' of the currently open device, if supported, */
/* by writing it to, or reading it from, a file. */

/* If the device supports it, Get will save the entire settings-state of */
/* the device into the file. Set will restore all settings of the device */
/* from those saved in the file. */

/* Both functions return TRUE(1) if successful, FALSE(0) otherwise. */
/* These functions record an error and return FALSE if called outside State 4. */
/* In case of failure, call LastErrorCode, ReportLastError, etc. for details. */
/* No file extension is assumed, you should provide one, such as ".dat". */

PROCEDURE TWAIN_SetCustomData EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER data AS MEMPTR.
  DEFINE INPUT PARAMETER nbytes AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Same as TWAIN_SetCustomDataFromFile, but from a buffer in memory. */

PROCEDURE TWAIN_GetCustomData EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER buffer AS MEMPTR.
  DEFINE INPUT PARAMETER bufsize AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Read device custom data into a buffer in memory, up to bufsize bytes. */
/* Returns the size of the actual data, if successful. */
/* Returns 0 if the device doesn't support this, no device open, etc. */

PROCEDURE TWAIN_CustomData EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Reads the custom data from the device and returns a pointer to it. */
/* This works best if you know the custom data is 8-bit text. */

/* --------- Extended Image Info */

/* The following functions support the 'Extended Image Info' feature of TWAIN, */
/* which is implemented by only a few TWAIN drivers.  This consists of special */
/* information, sometimes called 'metadata' which can be collected about */
/* each scanned image, in addition to the image itself. */
/* Examples of extended image info include */
/* TWEI_BARCODETEXT - text of a barcode found in the scan */
/* TWEI_SKEWORIGINALANGLE - the amount of 'skew' in the original raw scan */
/* See the TWAIN Specification (version 1.9 or later) for details. */

PROCEDURE TWAIN_IsExtendedInfoSupported EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Asks the currently open device if it supports Extended Image Info. */
/* Returns TRUE(1) if yes, FALSE(0) if not. */

PROCEDURE TWAIN_EnableExtendedInfo EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER enabled AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Enable or disable collection of a particular kind of extended image info. */
/* Each type of information is represented by an integer constant with */
/* prefix TWEI_ see the list of constants elsewhere in this file. */
/* There is a limit to how many different info types can be enabled at the */
/* same time.  If this limit is exceeded, this function returns FALSE */
/* and has no effect.  Otherwise (if successful) it returns TRUE. */

PROCEDURE TWAIN_IsExtendedInfoEnabled EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return TRUE if the specified extended image type is enabled */
/* (for collection) */

PROCEDURE TWAIN_DisableExtendedInfo EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Disables all extended image info - none is collected after this. */

/* After a successful scan, you can use the following functions to */
/* retrieve the extended image info associated with that scan: */
PROCEDURE TWAIN_ExtendedInfoItemCount EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the number of items of data available of the given info type. */

PROCEDURE TWAIN_ExtendedInfoItemType EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return a number indicating the type of data returned for the specified extended info. */
/* Returns the same TWTY_ codes as CONTAINER_ItemType. */

PROCEDURE TWAIN_ExtendedInfoInt EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Return the (integer) value of the 'nth' item of the specified extended info. */

PROCEDURE TWAIN_ExtendedInfoFloat EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS DOUBLE.
END PROCEDURE.
/* Return the (floating point) value of the 'nth' item of the specified extended info. */

PROCEDURE TWAIN_GetExtendedInfoString EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER Buffer AS MEMPTR.
  DEFINE INPUT PARAMETER Bufsize AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Read the (string) value of the nth item of the specified info type into Buffer, */
/* which has been allocated by the caller to hold Bufsize characters. */
/* Note that the value returned is ASCII (byte) text, not unicode, and *always* */
/* includes an ending 0 byte, even if it must be truncated to fit. */
/* Returns TRUE if the data was retrieved and could fit in the buffer. */
/* Returns FALSE otherwise. */

PROCEDURE TWAIN_ExtendedInfoString EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* As above, but the string is returned as a temporary pointer to a */
/* 0-terminated ASCII string. */
/* In case of any failure, returns the empty string (""). */

PROCEDURE TWAIN_GetExtendedInfoFrame EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER eiCode AS LONG.
  DEFINE INPUT PARAMETER n AS LONG.
  DEFINE OUTPUT PARAMETER L AS DOUBLE.
  DEFINE OUTPUT PARAMETER T AS DOUBLE.
  DEFINE OUTPUT PARAMETER R AS DOUBLE.
  DEFINE OUTPUT PARAMETER B AS DOUBLE.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Fetch the TW_FRAME value of the 'nth' item of the specified extended info. */
/* This is rarely used, but is here for completeness. */

/* Extended Image Info codes */
&GLOBAL-DEFINE TWEI_MIN 4608

&GLOBAL-DEFINE TWEI_BARCODEX 4608
&GLOBAL-DEFINE TWEI_BARCODEY 4609
&GLOBAL-DEFINE TWEI_BARCODETEXT 4610
&GLOBAL-DEFINE TWEI_BARCODETYPE 4611
&GLOBAL-DEFINE TWEI_DESHADETOP 4612
&GLOBAL-DEFINE TWEI_DESHADELEFT 4613
&GLOBAL-DEFINE TWEI_DESHADEHEIGHT 4614
&GLOBAL-DEFINE TWEI_DESHADEWIDTH 4615
&GLOBAL-DEFINE TWEI_DESHADESIZE 4616
&GLOBAL-DEFINE TWEI_SPECKLESREMOVED 4617
&GLOBAL-DEFINE TWEI_HORZLINEXCOORD 4618
&GLOBAL-DEFINE TWEI_HORZLINEYCOORD 4619
&GLOBAL-DEFINE TWEI_HORZLINELENGTH 4620
&GLOBAL-DEFINE TWEI_HORZLINETHICKNESS 4621
&GLOBAL-DEFINE TWEI_VERTLINEXCOORD 4622
&GLOBAL-DEFINE TWEI_VERTLINEYCOORD 4623
&GLOBAL-DEFINE TWEI_VERTLINELENGTH 4624
&GLOBAL-DEFINE TWEI_VERTLINETHICKNESS 4625
&GLOBAL-DEFINE TWEI_PATCHCODE 4626
&GLOBAL-DEFINE TWEI_ENDORSEDTEXT 4627
&GLOBAL-DEFINE TWEI_FORMCONFIDENCE 4628
&GLOBAL-DEFINE TWEI_FORMTEMPLATEMATCH 4629
&GLOBAL-DEFINE TWEI_FORMTEMPLATEPAGEMATCH 4630
&GLOBAL-DEFINE TWEI_FORMHORZDOCOFFSET 4631
&GLOBAL-DEFINE TWEI_FORMVERTDOCOFFSET 4632
&GLOBAL-DEFINE TWEI_BARCODECOUNT 4633
&GLOBAL-DEFINE TWEI_BARCODECONFIDENCE 4634
&GLOBAL-DEFINE TWEI_BARCODEROTATION 4635
&GLOBAL-DEFINE TWEI_BARCODETEXTLENGTH 4636
&GLOBAL-DEFINE TWEI_DESHADECOUNT 4637
&GLOBAL-DEFINE TWEI_DESHADEBLACKCOUNTOLD 4638
&GLOBAL-DEFINE TWEI_DESHADEBLACKCOUNTNEW 4639
&GLOBAL-DEFINE TWEI_DESHADEBLACKRLMIN 4640
&GLOBAL-DEFINE TWEI_DESHADEBLACKRLMAX 4641
&GLOBAL-DEFINE TWEI_DESHADEWHITECOUNTOLD 4642
&GLOBAL-DEFINE TWEI_DESHADEWHITECOUNTNEW 4643
&GLOBAL-DEFINE TWEI_DESHADEWHITERLMIN 4644
&GLOBAL-DEFINE TWEI_DESHADEWHITERLAVE 4645
&GLOBAL-DEFINE TWEI_DESHADEWHITERLMAX 4646
&GLOBAL-DEFINE TWEI_BLACKSPECKLESREMOVED 4647
&GLOBAL-DEFINE TWEI_WHITESPECKLESREMOVED 4648
&GLOBAL-DEFINE TWEI_HORZLINECOUNT 4649
&GLOBAL-DEFINE TWEI_VERTLINECOUNT 4650
&GLOBAL-DEFINE TWEI_DESKEWSTATUS 4651
&GLOBAL-DEFINE TWEI_SKEWORIGINALANGLE 4652
&GLOBAL-DEFINE TWEI_SKEWFINALANGLE 4653
&GLOBAL-DEFINE TWEI_SKEWCONFIDENCE 4654
&GLOBAL-DEFINE TWEI_SKEWWINDOWX1 4655
&GLOBAL-DEFINE TWEI_SKEWWINDOWY1 4656
&GLOBAL-DEFINE TWEI_SKEWWINDOWX2 4657
&GLOBAL-DEFINE TWEI_SKEWWINDOWY2 4658
&GLOBAL-DEFINE TWEI_SKEWWINDOWX3 4659
&GLOBAL-DEFINE TWEI_SKEWWINDOWY3 4660
&GLOBAL-DEFINE TWEI_SKEWWINDOWX4 4661
&GLOBAL-DEFINE TWEI_SKEWWINDOWY4 4662
&GLOBAL-DEFINE TWEI_BOOKNAME 4664
&GLOBAL-DEFINE TWEI_CHAPTERNUMBER 4665
&GLOBAL-DEFINE TWEI_DOCUMENTNUMBER 4666
&GLOBAL-DEFINE TWEI_PAGENUMBER 4667
&GLOBAL-DEFINE TWEI_CAMERA 4668
&GLOBAL-DEFINE TWEI_FRAMENUMBER 4669
&GLOBAL-DEFINE TWEI_FRAME 4670
&GLOBAL-DEFINE TWEI_PIXELFLAVOR 4671
&GLOBAL-DEFINE TWEI_ICCPROFILE 4672
&GLOBAL-DEFINE TWEI_LASTSEGMENT 4673
&GLOBAL-DEFINE TWEI_SEGMENTNUMBER 4674
&GLOBAL-DEFINE TWEI_MAGDATA 4675
&GLOBAL-DEFINE TWEI_MAGTYPE 4676
&GLOBAL-DEFINE TWEI_PAGESIDE 4677
&GLOBAL-DEFINE TWEI_FILESYSTEMSOURCE 4678

&GLOBAL-DEFINE TWEI_MAX 4678


/* --------- Lowest-level functions for TWAIN protocol -------- */


PROCEDURE TWAIN_DS EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER DG AS LONG.
  DEFINE INPUT PARAMETER DAT AS LONG.
  DEFINE INPUT PARAMETER MSG AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pData AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Pass the triplet (DG, DAT, MSG, pData) to the open data source if any. */
/* Returns TRUE(1) if the result code is TWRC_SUCCESS, FALSE(0) otherwise. */
/* The last result code can be retrieved with TWAIN_GetResultCode(), and the */
/* corresponding condition code can be retrieved with TWAIN_GetConditionCode(). */
/* If no source is open this call will fail, result code TWRC_FAILURE, */
/* condition code TWCC_NODS. */

PROCEDURE TWAIN_Mgr EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER DG AS LONG.
  DEFINE INPUT PARAMETER DAT AS LONG.
  DEFINE INPUT PARAMETER MSG AS LONG.
  DEFINE INPUT-OUTPUT PARAMETER pData AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Pass a triplet to the Data Source Manager (DSM). */
/* Returns TRUE(1) for success, FALSE(0) otherwise. */
/* See GetResultCode, GetConditionCode, and ReportLastError functions */
/* for diagnosing and reporting a TWAIN_Mgr failure. */
/* If the Source Manager is not open, this call fails setting result code */
/* TWRC_FAILURE, and condition code=TWCC_SEQERROR (triplet out of sequence). */


/* --------- Advanced / Exotic -------- */

/* Functions to do a memory transfer in individual blocks: */
PROCEDURE TWAIN_BeginAcquireMemory EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE INPUT PARAMETER nRows AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Begin a memory transfer. */
/* Returns TRUE(1) if the transfer is ready to proceed (using */
/* TWAIN_AcquireMemoryBlock, below.) */
/* Returns FALSE(0) if the transfer could not be started for some reason. */

/* Loads TWAIN if necessary, opens the default source if no source is open. */
/* If it opens a source, it negotiates any 'pending' settings (resolution, */
/* pixel type, etc.) that were specified before the device was open. */
/* Enables the device if not already enabled. */
/* Waits for a 'transfer ready' message from the device. */
/* Tells the driver to begin transferring in blocks of nRows rows or less. */
/* If nRows is <= 0, lets the driver pick the optimal block size. */

PROCEDURE TWAIN_AcquireMemoryBlock EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquire the next block of data in a memory transfer. */
/* If there is an error or there is no more data, returns NULL(0). */
/* Only valid after a successful call to TWAIN_BeginAcquireMemory (above.) */
/* Asks the device to deliver another block of pixels, and returns */
/* those pixels as a DIB represented by its handle.  This is the same */
/* image format returned by TWAIN_Acquire, TWAIN_AcquireMemory, etc. */
/* See the DIB_* functions for what can be done with the returned handle. */

PROCEDURE TWAIN_EndAcquireMemory EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Clean up after a block-by-block memory transfer. */
/* Only valid after a successful call to TWAIN_BeginAcquireMemory (above.) */
/* Frees any temporary storage, and tells the device the transfer */
/* is over.  In Multi-transfer mode, the device will move to */
/* State 6 if more images are available, or State 5 if not. */
/* In single-transfer mode (the default) the device is automatically closed. */


PROCEDURE TWAIN_AcquireFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER nFF AS LONG.
  DEFINE INPUT PARAMETER sFileName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Acquire an image directly to a file using File Transfer Mode. */
/* Be warned: File Transfer Mode is unusual. TWAIN drivers are not required */
/* to support it! If they do support it, the only required file format is BMP. */
/* We recommend not using this function unless you understand the issues */
/* and have a compelling reason for using this mode. */

/* ---- Aliases for TWAIN File Formats */
&GLOBAL-DEFINE TWAIN_FF_TIFF 0
&GLOBAL-DEFINE TWAIN_FF_PICT 1
&GLOBAL-DEFINE TWAIN_FF_BMP 2
&GLOBAL-DEFINE TWAIN_FF_XBM 3
&GLOBAL-DEFINE TWAIN_FF_JFIF 4
&GLOBAL-DEFINE TWAIN_FF_FPX 5
&GLOBAL-DEFINE TWAIN_FF_TIFFMULTI 6
&GLOBAL-DEFINE TWAIN_FF_PNG 7
&GLOBAL-DEFINE TWAIN_FF_SPIFF 8
&GLOBAL-DEFINE TWAIN_FF_EXIF 9
&GLOBAL-DEFINE TWAIN_FF_PDF 10
&GLOBAL-DEFINE TWAIN_FF_JP2 11
&GLOBAL-DEFINE TWAIN_FF_JPN 12
&GLOBAL-DEFINE TWAIN_FF_JPX 13
&GLOBAL-DEFINE TWAIN_FF_DEJAVU 14
&GLOBAL-DEFINE TWAIN_FF_PDFA 15

/* * Unlike AcquireToFilename, this function uses TWAIN File Transfer Mode. */
/* * The image is written to disk by the Data Source, not by EZTWAIN. */
/* * Warning: This mode is -not- supported by all TWAIN devices. */

/* Use TWAIN_SupportsFileXfer to see if the open DS supports File Transfer. */

/* You can use TWAIN_Get(ICAP_IMAGEFILEFORMAT) to get an enumeration of */
/* the available file formats, and CONTAINER_ContainsValue to check for */
/* a particular format you are interested in. */

/* If the filename is NULL or an empty string, this functions prompts for */
/* the file name in a standard Save File dialog. */

/* Note Boolean return value! */
/* TRUE(1) for success */
/* FALSE(0) for failure - use GetResultCode/GetConditionCode for details. */
/* If the user cancels the Save File dialog, GetResultCode will be TWRC_CANCEL */

PROCEDURE TWAIN_SetImageReadyTimeout EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER nSec AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the maximum seconds to wait for an image-ready notification, */
/* (when one is expected i.e. after an enable) before posting a */
/* dialog that says 'Waiting for <device>' - with a Cancel button. */
/* Returns the previous setting. */
/* ** Default is -1 which disables this feature. */
/* With certain scanners there is a long delay between when the scanner */
/* is enabled and when it says "ready to scan".  Also, we have found */
/* a few scanners that intermittently fail to send "ready to scan" - by */
/* setting this timeout, you give your users a way to recover from */
/* this failure (otherwise the application has to be forcibly terminated.) */

PROCEDURE TWAIN_AutoClickButton EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sButtonName AS CHARACTER.
END PROCEDURE.
/* Calling this function before scanning tells EZTwain to attempt to */
/* automatically press a button when the device dialog appears. */
/* If you pass a null button name, EZTwain tries a number */
/* of likely choices (in English) including: */
/* "Scan" "Capture" "Acquire" "Scan Now" "Start Scan"  "Start Scanning" */
/* Case is ignored in the comparison ("SCAN" and "scan" are equivalent.) */
/* This function is useful when you want to automate operation of */
/* a device that insists on showing its user interface.  */

PROCEDURE TWAIN_BreakModalLoop EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Expert: If EZTwain is hung inside an Acquire or GetMessage loop waiting for */
/* something to happen, this function will break the loop, as if the pending */
/* transfer had failed.  TWAIN_State() will be valid, and you will need to */
/* call appropriate functions to transition TWAIN as desired. */

PROCEDURE TWAIN_EmptyMessageQueue EXTERNAL "Eztwain3.dll" PERSISTENT:
END PROCEDURE.
/* Expert: Get and process any pending Windows messages for this thread. */
/* For example, keystrokes or mouse clicks.  Calling this during */
/* long processes will allow the user to interact with the UI. */
/* Use only if you understand the message pump. */

/* --------- Dosadi Special -------- */

PROCEDURE TWAIN_BuildName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return a string describing the build of EZTWAIN e.g. "Release - Build 6" */

PROCEDURE TWAIN_GetBuildName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER sName AS MEMPTR.
END PROCEDURE.
/* Like TWAIN_BuildName, but copies the build string into its parameter. */
/* The parameter is a string variable (char array in C/C++). */
/* You are responsible for allocating room for 128 8-bit characters */
/* in the string variable before calling this function. */

PROCEDURE TWAIN_GetSourceIdentity EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER ptwid AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.

PROCEDURE TWAIN_GetImageInfo EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT-OUTPUT PARAMETER ptwinfo AS MEMPTR.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Issue a DG_IMAGE / DAT_IMAGEINFO / MSG_GET placing the returned data */
/* at ptwinfo.  The returned structure is a TW_IMAGEINFO - see twain.h. */

PROCEDURE TWAIN_LogFile EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER fLog AS LONG.
END PROCEDURE.
/* Turn logging eztwain.log on or off. */
/* By default the log file is written to C:\ but this */
/* can be overridden, see TWAIN_SetLogFolder below. */

/* fLog = 0    close log file and turn off logging */
/* The following flags can be combined to enable logging: */
/* 1            basic logging of TWAIN and EZTwain operations. */
/* 2            flush log constantly (use if EZTwain crashes) */
/* 4            log Windows messages flowing through EZTwain */
&GLOBAL-DEFINE EZT_LOG_ON 1
&GLOBAL-DEFINE EZT_LOG_FLUSH 2
&GLOBAL-DEFINE EZT_LOG_DETAIL 4


PROCEDURE TWAIN_SetLogFolder EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sFolder AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Specify the folder (directory) where the log file */
/* should be placed.  Default is "c:\" - the root of the C: drive. */
/* EZTwain appends a trailing 'slash' if needed. */
/* Passing NULL or "" resets to the default: "c:\" */

/* If the file cannot be created in this folder, EZTwain tries */
/* to create it in the Windows temp folder - this varies somewhat */
/* by Windows version, search for the Windows API call GetTempPath. */

PROCEDURE TWAIN_SetLogName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sName AS CHARACTER.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Set the filename or path & filename of the EZTwain log file. */
/* If there is a log file open, it is closed, renamed & re-opened. */
/* The default extension is ".log". */
/* The default log filename is "eztwain.log". */

/* You can specify a fully-qualified filename, which changes */
/* both the folder and filename for logging: */
/* TWAIN_SetLogName("c:\temp\scan2tape.log") */

PROCEDURE TWAIN_LogFileName EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS MEMPTR.
END PROCEDURE.
/* Return the (fully qualified) file path and name for logging. */

PROCEDURE TWAIN_WriteToLog EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER sText AS CHARACTER.
END PROCEDURE.
/* Write text to the EZTwain log file (c:\eztwain.log) */
/* If the text does not end with a newline, one is supplied. */
/* If logging is turned off, this call has no effect. */
/* Logging is controlled by TWAIN_LogFile - see above. */


PROCEDURE TWAIN_SelfTest EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER f AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Perform internal self-test. */
/* f      ignored for now */
/* Return value: */
/* 0      success */
/* other  internal test failed. */

PROCEDURE TWAIN_Blocked EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Returns TRUE(1) if processing is inside TWAIN (Source Manager or a DS) */
/* FALSE(0) otherwise.  If the former, making any TWAIN call will */
/* fail immediately or deadlock the application (Not recommended.) */


/* ---------------------------------------------------- */
/* Deprecated - still work, don't use in new code. */
/* ---------------------------------------------------- */

PROCEDURE TWAIN_FreeNative EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hdib AS LONG.
END PROCEDURE.
/* superceded by DIB_Free. */

PROCEDURE TWAIN_NegotiatePixelTypes EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER wPixMask AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Legacy function */
/* Negotiate a set of acceptable pixel types. */

/* The parameter is a bit-mask - set bit N to allow pixel type N. */
/* Important: You cannot use the TWPT_ constants for the parameter, those */
/* are not bit-masks!  In other words, to tell the scanner you will accept */
/* only grayscale or color images, in C/C++ you write something like this: */

/* TWAIN_NegotiatePixelTypes((1 << TWPT_BW) | (1 << TWPT_GRAY)); */

/* See TWAIN_AcquireNative for more details. */

/* Note: Instead of using this function, most developers use */
/* TWAIN_SetPixelType to designate a single pixel type. */


PROCEDURE TWAIN_AcquireNative EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER wPixMask AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Legacy function, superceded by TWAIN_Acquire, TWAIN_AcquireToFilename, etc. */
/* Acquire one image from the currently open or default scanner. */

/* Parameter 1 is a Windows window-handle, the handle of the window that */
/* should own or be the parent of the TWAIN interaction. */
/* NULL(0) can be used if it is not convenient to obtain a valid window handle. */

/* Parameter 2 specifies a *pixel type mask*, as used with */
/* Most developers pass 0 for this parameter, and either allow the user */
/* to select the pixel type, or make an earlier call to TWAIN_SetPixelType */
/* to select the pixel type for scanning. */

/* In the pixel mask, set bit N to allow pixel type N. */
/* Bit 0 is the least-significant bit. */
/* Pixel Type constant          value     equiv. PixMask value */
/* TWPT_BW (black & white)        0               1 */
/* TWPT_GRAY (grayscale)          1               2 */
/* TWPT_RGB (RGB color)           2               4 */
/* TWPT_PALETTE (indexed color)   3               8 */
/* Since the parameter is a mask, you can add or 'or' together mask values */
/* to represent a set of more than one acceptable pixel type. */

PROCEDURE TWAIN_AcquireMemory EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwnd AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Same as TWAIN_Acquire but prefers to use 'memory transfer mode'. */
/* Equivalent to calling TWAIN_Acquire after calling TWAIN_SetXferMech(XFERMECH_MEMORY) */

/* It is better to use the general scanning functions like TWAIN_Acquire, */
/* and use TWAIN_SetXferMech to force memory transfer in the rare case */
/* that this solves a problem for an end-user. */
/* Note that EZTwain automatically uses memory transfer mode when appropriate, */
/* such as with scanner models known to require it for correct operation, */
/* so the only field problem should occur with a scanner not previously */
/* known to EZTwain, that malfunctions with our default handling. */

PROCEDURE TWAIN_AcquireToClipboard EXTERNAL "Eztwain3.dll" PERSISTENT:
  DEFINE INPUT PARAMETER hwndApp AS LONG.
  DEFINE INPUT PARAMETER wPixMask AS LONG.
  DEFINE RETURN PARAMETER retval AS LONG.
END PROCEDURE.
/* Like AcquireNative, but puts the resulting image, if any, into the */
/* system clipboard as a CF_DIB item. If this call fails, the clipboard is */
/* either empty or retains its previous content. */
/* Returns TRUE(1) for success, FALSE(0) for failure. */
/* 2nd parameter is a pixel type mask - See NegotiatePixelTypes above. */

/* Useful for environments like Visual Basic where it is hard to make direct */
/* use of a DIB handle.  In fact, TWAIN_AcquireToClipboard uses */
/* TWAIN_AcquireNative for all the hard work. */



/* From twain.h: */
/* **************************************************************************** */
/* * Capabilities                                                             * */
/* **************************************************************************** */

&GLOBAL-DEFINE CAP_CUSTOMBASE 32768

/* all data sources are REQUIRED to support these caps  */
&GLOBAL-DEFINE CAP_XFERCOUNT 1

/* image data sources are REQUIRED to support these caps  */
&GLOBAL-DEFINE ICAP_COMPRESSION 256
&GLOBAL-DEFINE ICAP_PIXELTYPE 257
&GLOBAL-DEFINE ICAP_UNITS 258
&GLOBAL-DEFINE ICAP_XFERMECH 259

/* all data sources MAY support these caps  */
&GLOBAL-DEFINE CAP_AUTHOR 4096
&GLOBAL-DEFINE CAP_CAPTION 4097
&GLOBAL-DEFINE CAP_FEEDERENABLED 4098
&GLOBAL-DEFINE CAP_FEEDERLOADED 4099
&GLOBAL-DEFINE CAP_TIMEDATE 4100
&GLOBAL-DEFINE CAP_SUPPORTEDCAPS 4101
&GLOBAL-DEFINE CAP_EXTENDEDCAPS 4102
&GLOBAL-DEFINE CAP_AUTOFEED 4103
&GLOBAL-DEFINE CAP_CLEARPAGE 4104
&GLOBAL-DEFINE CAP_FEEDPAGE 4105
&GLOBAL-DEFINE CAP_REWINDPAGE 4106
&GLOBAL-DEFINE CAP_INDICATORS 4107
&GLOBAL-DEFINE CAP_SUPPORTEDCAPSEXT 4108
&GLOBAL-DEFINE CAP_PAPERDETECTABLE 4109
&GLOBAL-DEFINE CAP_UICONTROLLABLE 4110
&GLOBAL-DEFINE CAP_DEVICEONLINE 4111
&GLOBAL-DEFINE CAP_AUTOSCAN 4112
&GLOBAL-DEFINE CAP_THUMBNAILSENABLED 4113
&GLOBAL-DEFINE CAP_DUPLEX 4114
&GLOBAL-DEFINE CAP_DUPLEXENABLED 4115
&GLOBAL-DEFINE CAP_ENABLEDSUIONLY 4116
&GLOBAL-DEFINE CAP_CUSTOMDSDATA 4117
&GLOBAL-DEFINE CAP_ENDORSER 4118
&GLOBAL-DEFINE CAP_JOBCONTROL 4119
&GLOBAL-DEFINE CAP_ALARMS 4120
&GLOBAL-DEFINE CAP_ALARMVOLUME 4121
&GLOBAL-DEFINE CAP_AUTOMATICCAPTURE 4122
&GLOBAL-DEFINE CAP_TIMEBEFOREFIRSTCAPTURE 4123
&GLOBAL-DEFINE CAP_TIMEBETWEENCAPTURES 4124
&GLOBAL-DEFINE CAP_CLEARBUFFERS 4125
&GLOBAL-DEFINE CAP_MAXBATCHBUFFERS 4126
&GLOBAL-DEFINE CAP_DEVICETIMEDATE 4127
&GLOBAL-DEFINE CAP_POWERSUPPLY 4128
&GLOBAL-DEFINE CAP_CAMERAPREVIEWUI 4129
&GLOBAL-DEFINE CAP_DEVICEEVENT 4130
&GLOBAL-DEFINE CAP_SERIALNUMBER 4132
&GLOBAL-DEFINE CAP_PRINTER 4134
&GLOBAL-DEFINE CAP_PRINTERENABLED 4135
&GLOBAL-DEFINE CAP_PRINTERINDEX 4136
&GLOBAL-DEFINE CAP_PRINTERMODE 4137
&GLOBAL-DEFINE CAP_PRINTERSTRING 4138
&GLOBAL-DEFINE CAP_PRINTERSUFFIX 4139
&GLOBAL-DEFINE CAP_LANGUAGE 4140
&GLOBAL-DEFINE CAP_FEEDERALIGNMENT 4141
&GLOBAL-DEFINE CAP_FEEDERORDER 4142
&GLOBAL-DEFINE CAP_REACQUIREALLOWED 4144
&GLOBAL-DEFINE CAP_BATTERYMINUTES 4146
&GLOBAL-DEFINE CAP_BATTERYPERCENTAGE 4147

/* image data sources MAY support these caps  */
&GLOBAL-DEFINE ICAP_AUTOBRIGHT 4352
&GLOBAL-DEFINE ICAP_BRIGHTNESS 4353
&GLOBAL-DEFINE ICAP_CONTRAST 4355
&GLOBAL-DEFINE ICAP_CUSTHALFTONE 4356
&GLOBAL-DEFINE ICAP_EXPOSURETIME 4357
&GLOBAL-DEFINE ICAP_FILTER 4358
&GLOBAL-DEFINE ICAP_FLASHUSED 4359
&GLOBAL-DEFINE ICAP_GAMMA 4360
&GLOBAL-DEFINE ICAP_HALFTONES 4361
&GLOBAL-DEFINE ICAP_HIGHLIGHT 4362
&GLOBAL-DEFINE ICAP_IMAGEFILEFORMAT 4364
&GLOBAL-DEFINE ICAP_LAMPSTATE 4365
&GLOBAL-DEFINE ICAP_LIGHTSOURCE 4366
&GLOBAL-DEFINE ICAP_ORIENTATION 4368
&GLOBAL-DEFINE ICAP_PHYSICALWIDTH 4369
&GLOBAL-DEFINE ICAP_PHYSICALHEIGHT 4370
&GLOBAL-DEFINE ICAP_SHADOW 4371
&GLOBAL-DEFINE ICAP_FRAMES 4372
&GLOBAL-DEFINE ICAP_XNATIVERESOLUTION 4374
&GLOBAL-DEFINE ICAP_YNATIVERESOLUTION 4375
&GLOBAL-DEFINE ICAP_XRESOLUTION 4376
&GLOBAL-DEFINE ICAP_YRESOLUTION 4377
&GLOBAL-DEFINE ICAP_MAXFRAMES 4378
&GLOBAL-DEFINE ICAP_TILES 4379
&GLOBAL-DEFINE ICAP_BITORDER 4380
&GLOBAL-DEFINE ICAP_CCITTKFACTOR 4381
&GLOBAL-DEFINE ICAP_LIGHTPATH 4382
&GLOBAL-DEFINE ICAP_PIXELFLAVOR 4383
&GLOBAL-DEFINE ICAP_PLANARCHUNKY 4384
&GLOBAL-DEFINE ICAP_ROTATION 4385
&GLOBAL-DEFINE ICAP_SUPPORTEDSIZES 4386
&GLOBAL-DEFINE ICAP_THRESHOLD 4387
&GLOBAL-DEFINE ICAP_XSCALING 4388
&GLOBAL-DEFINE ICAP_YSCALING 4389
&GLOBAL-DEFINE ICAP_BITORDERCODES 4390
&GLOBAL-DEFINE ICAP_PIXELFLAVORCODES 4391
&GLOBAL-DEFINE ICAP_JPEGPIXELTYPE 4392
&GLOBAL-DEFINE ICAP_TIMEFILL 4394
&GLOBAL-DEFINE ICAP_BITDEPTH 4395
&GLOBAL-DEFINE ICAP_BITDEPTHREDUCTION 4396
&GLOBAL-DEFINE ICAP_UNDEFINEDIMAGESIZE 4397
&GLOBAL-DEFINE ICAP_IMAGEDATASET 4398
&GLOBAL-DEFINE ICAP_EXTIMAGEINFO 4399
&GLOBAL-DEFINE ICAP_MINIMUMHEIGHT 4400
&GLOBAL-DEFINE ICAP_MINIMUMWIDTH 4401
&GLOBAL-DEFINE ICAP_FLIPROTATION 4406
&GLOBAL-DEFINE ICAP_BARCODEDETECTIONENABLED 4407
&GLOBAL-DEFINE ICAP_SUPPORTEDBARCODETYPES 4408
&GLOBAL-DEFINE ICAP_BARCODEMAXSEARCHPRIORITIES 4409
&GLOBAL-DEFINE ICAP_BARCODESEARCHPRIORITIES 4410
&GLOBAL-DEFINE ICAP_BARCODESEARCHMODE 4411
&GLOBAL-DEFINE ICAP_BARCODEMAXRETRIES 4412
&GLOBAL-DEFINE ICAP_BARCODETIMEOUT 4413
&GLOBAL-DEFINE ICAP_ZOOMFACTOR 4414
&GLOBAL-DEFINE ICAP_PATCHCODEDETECTIONENABLED 4415
&GLOBAL-DEFINE ICAP_SUPPORTEDPATCHCODETYPES 4416
&GLOBAL-DEFINE ICAP_PATCHCODEMAXSEARCHPRIORITIES 4417
&GLOBAL-DEFINE ICAP_PATCHCODESEARCHPRIORITIES 4418
&GLOBAL-DEFINE ICAP_PATCHCODESEARCHMODE 4419
&GLOBAL-DEFINE ICAP_PATCHCODEMAXRETRIES 4420
&GLOBAL-DEFINE ICAP_PATCHCODETIMEOUT 4421
&GLOBAL-DEFINE ICAP_FLASHUSED2 4422
&GLOBAL-DEFINE ICAP_IMAGEFILTER 4423
&GLOBAL-DEFINE ICAP_NOISEFILTER 4424
&GLOBAL-DEFINE ICAP_OVERSCAN 4425
&GLOBAL-DEFINE ICAP_AUTOMATICBORDERDETECTION 4432
&GLOBAL-DEFINE ICAP_AUTOMATICDESKEW 4433
&GLOBAL-DEFINE ICAP_AUTOMATICROTATE 4434
&GLOBAL-DEFINE ICAP_JPEGQUALITY 4435

/* Container and Extended Info item types: */
&GLOBAL-DEFINE TWTY_INT8 0
&GLOBAL-DEFINE TWTY_INT16 1
&GLOBAL-DEFINE TWTY_INT32 2
&GLOBAL-DEFINE TWTY_UINT8 3
&GLOBAL-DEFINE TWTY_UINT16 4
&GLOBAL-DEFINE TWTY_UINT32 5
&GLOBAL-DEFINE TWTY_BOOL 6
&GLOBAL-DEFINE TWTY_FIX32 7
&GLOBAL-DEFINE TWTY_FRAME 8
&GLOBAL-DEFINE TWTY_STR32 9
&GLOBAL-DEFINE TWTY_STR64 10
&GLOBAL-DEFINE TWTY_STR128 11
&GLOBAL-DEFINE TWTY_STR255 12
&GLOBAL-DEFINE TWTY_STR1024 13
&GLOBAL-DEFINE TWTY_UNI512 14

/* ICAP_ORIENTATION values (OR_ means ORientation)  */
&GLOBAL-DEFINE TWOR_ROT0 0
&GLOBAL-DEFINE TWOR_ROT90 1
&GLOBAL-DEFINE TWOR_ROT180 2
&GLOBAL-DEFINE TWOR_ROT270 3



/* EZTwain History: See History.txt */
