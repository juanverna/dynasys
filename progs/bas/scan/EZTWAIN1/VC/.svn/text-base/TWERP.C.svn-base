// TWERP - EZTWAIN.DLL demo application
//
// Created  05/11/94    spike
// Revised  06/23/94    spike - rev 1.0  alpha 1
// Revised  07/17/94    spike - rev 1.0  alpha 2 - removed use of Bitmap
// Revised  02/06/95    spike - rev 1.1  added Save As command
// Revised  05/03/95    spike - rev 1.2  added Options menu with PixelTypes
// Revised  04/02/97    spike - rev 1.4  single source for Win16 and Win32.
// Revised  08/21/97    spike - rev 1.5  eztwain 1.06, no real changes
// Revised  06/14/98    spike - rev 1.6  my own 'Dosadi' version

//---------- Includes

#include "eztwain.h"
#include "twain.h"
#include "resource.h"

//---------- Global variables

static HANDLE   	hInst;              // current instance
static HWND			hwndMain;           // main window handle

static HANDLE		hdib;               // current DIB, if any
static HPALETTE 	hpal;               // logical palette for same, if any

static unsigned	wPixTypes;          // enabled pixel types
static int			fHideUI;            // hide source U/I
static HCURSOR		hcurWait;           // wait cursor (hourglass)

static char			szAppName[32];
static char			szMessage[128];


//---------- Forward function declarations

BOOL InitInstance(int CmdShow);
long FAR PASCAL  MainWndProc (HWND hwnd, WORD wMsg, WPARAM wP, LPARAM lP);
BOOL FAR PASCAL AboutDlgProc(HWND, WORD, WORD, LONG);
void ResizeWindow(HWND hwnd, HANDLE hdib);
VOID DiscardImage(VOID);                       

//---------- Public functions

int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
            LPSTR  lpszCmdLine, int CmdShow)
{
    WNDCLASS    wc;
    MSG			msg;

    lpszCmdLine=lpszCmdLine;			// suppress no-use warning

    // Save the instance handle in static variable, which will be used in
    // many subsequence calls from this application to Windows.
    hInst = hInstance;

	LoadString(hInst, IDS_APPNAME, szAppName, sizeof szAppName);

	if (hPrevInstance) {
        // Don't allow multiple instances of this program.
        return FALSE;
    }

    // Define & register main window class
    wc.style         = 0;								// this class has no style!
    wc.lpfnWndProc   = (WNDPROC)MainWndProc;			// name of window proc
    wc.cbClsExtra    = 0;								// no extra bits
    wc.cbWndExtra    = 0;
    wc.hInstance     = hInst;							// handle to cur instance
    wc.hIcon         = LoadIcon( hInst, "TW_APP_ICO");
    wc.hCursor       = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = NULL;
    wc.lpszMenuName  = "TW_App_Menu";					// class default menu
    wc.lpszClassName = "TW_App_MainWnd";				// class named

    if (!RegisterClass(&wc)) {
        return FALSE;
    }

    if (!InitInstance(CmdShow)) {
            return (FALSE);
    }

    // The main loop of the program.  Get a Message; if it's not an
    // accelerator key, translate it and dispatch it to the application.
    while (GetMessage((LPMSG)&msg, NULL, 0, 0)) {
        if (!TWAIN_MessageHook ((LPMSG)&msg)) {
        	TranslateMessage ((LPMSG)&msg);
        	DispatchMessage ((LPMSG)&msg);
        }
    }
    return (msg.wParam);
} // WinMain




//---------------------------------------------------------------------------

BOOL InitInstance(int CmdShow)
{
    char		WindowTitle[64];
    HMENU		hmenu;
    UINT		uEnable = MF_BYCOMMAND | (TWAIN_IsAvailable() ? MF_ENABLED : MF_GRAYED);

    hcurWait = LoadCursor(NULL, IDC_WAIT);

    LoadString(hInst, IDS_WINDOWTITLE, WindowTitle,  sizeof(WindowTitle));
    hwndMain = CreateWindow("TW_App_MainWnd", WindowTitle, WS_OVERLAPPEDWINDOW,
             CW_USEDEFAULT, CW_USEDEFAULT, 500, 350,
             NULL, NULL, hInst, NULL);

    if (!hwndMain)
        return (FALSE);

	wPixTypes = TWAIN_ANYTYPE;

	// enable or disable the TWAIN menu items
	hmenu = GetMenu(hwndMain);
    EnableMenuItem(hmenu, TW_APP_ACQUIRE, uEnable);
    EnableMenuItem(hmenu, TW_APP_ACQUIRE_TO_CLPB, uEnable);
    EnableMenuItem(hmenu, TW_APP_SELECT_SOURCE, uEnable);
    ShowWindow (hwndMain, CmdShow);
    UpdateWindow (hwndMain);
    return (TRUE);
} // InitInstance



//---------------------------------------------------------------------------

long FAR PASCAL  MainWndProc (HWND hwnd, WORD wMsg, WPARAM wP, LPARAM lP)
{
    HDC         	hDC;

	switch (wMsg) {

//-----------------------------------------------------------------
	case WM_INITMENU:
	{
		HMENU hmenu = (HMENU) wP;
		EnableMenuItem(hmenu, TW_APP_SAVEAS, MF_BYCOMMAND | (hdib ? MF_ENABLED : MF_GRAYED));
		// update the pixel type items
		CheckMenuItem(hmenu, TW_APP_BW, MF_BYCOMMAND | ((wPixTypes & TWAIN_BW) ? MF_CHECKED : MF_UNCHECKED));
		CheckMenuItem(hmenu, TW_APP_GRAYSCALE, MF_BYCOMMAND | ((wPixTypes & TWAIN_GRAY) ? MF_CHECKED : MF_UNCHECKED));
		CheckMenuItem(hmenu, TW_APP_RGB, MF_BYCOMMAND | ((wPixTypes & TWAIN_RGB) ? MF_CHECKED : MF_UNCHECKED));
		CheckMenuItem(hmenu, TW_APP_PALETTE, MF_BYCOMMAND | ((wPixTypes & TWAIN_PALETTE) ? MF_CHECKED : MF_UNCHECKED));
		CheckMenuItem(hmenu, TW_APP_ANYPIX, MF_BYCOMMAND | ((wPixTypes == TWAIN_ANYTYPE) ? MF_CHECKED : MF_UNCHECKED));
		CheckMenuItem(hmenu, TW_APP_SHOWUI, MF_BYCOMMAND | (fHideUI ? MF_UNCHECKED : MF_CHECKED));
		CheckMenuItem(hmenu, TW_APP_HIDEUI, MF_BYCOMMAND | (fHideUI ? MF_CHECKED : MF_UNCHECKED));
		return DefWindowProc (hwnd, wMsg, wP, lP);
	}
	
//-----------------------------------------------------------------
	case WM_DESTROY:
    	DiscardImage();
    	PostQuitMessage(0);
		return DefWindowProc (hwnd, wMsg, wP, lP);

//-----------------------------------------------------------------
	case WM_PALETTECHANGED:
		if ((HWND) wP == hwnd)
			return 0;				// this app changed palette: ignore

	// Otherwise, fall through to WM_QUERYNEWPALETTE.

	case WM_QUERYNEWPALETTE: {
		HPALETTE hpalT;
		UINT i;

		if (!hpal)
			return 0;				// no palette in effect

	    hDC = GetDC(hwnd);
    	hpalT = SelectPalette (hDC, hpal, FALSE);

		i = RealizePalette(hDC); // i == #entries that changed

	    SelectPalette (hDC, hpalT, FALSE);
    	ReleaseDC(hwnd, hDC);


    	// If any palette entries changed, repaint the window.

		if (i > 0) {
        	InvalidateRect(hwnd, NULL, TRUE);
        }

    	return i;
    } // WM_QUERYNEWPALETTE, WM_PALETTECHANGED

//-----------------------------------------------------------------
    case WM_ERASEBKGND:
		return TRUE;

	case WM_PAINT: {
    	PAINTSTRUCT 	ps;
		hDC = BeginPaint(hwnd, &ps);
		if (hDC) {
            RECT rc;
            GetClientRect(hwnd, &rc);
			if (hpal) {
				SelectPalette (hDC, hpal, FALSE);
				RealizePalette (hDC);
			}   /* if */
			if (hdib) {
				int w = TWAIN_DibWidth(hdib);
				int h = TWAIN_DibHeight(hdib);
				HCURSOR hcurSave = SetCursor(hcurWait);
				TWAIN_DrawDibToDC(hDC, 0, 0, w, h, hdib, 0, 0);
				SetCursor(hcurSave);
                ExcludeClipRect(hDC, 0, 0, w, h);
			}
            FillRect(hDC, &ps.rcPaint, (HBRUSH)GetStockObject(GRAY_BRUSH));
		}
        EndPaint(hwnd, &ps);
        break;
	} // WM_PAINT


//-----------------------------------------------------------------
	 case WM_COMMAND:

        switch (wP) {

			case TW_APP_ACQUIRE: {
                // free up current image and palette if any
				DiscardImage();
				// clear the window during/before Acquire dialog
				InvalidateRect(hwnd, NULL, TRUE);
				TWAIN_SetHideUI(fHideUI);
            if (TWAIN_OpenDefaultSource()) {
               //TWAIN_SetCurrentUnits(TWUN_INCHES);
               //TWAIN_SetCurrentPixelType(TWPT_RGB);
               //TWAIN_SetBitDepth(24);
               //TWAIN_SetCurrentResolution(300.0);
               //hdib = TWAIN_AcquireNative(hwnd, 0);
				   hdib = TWAIN_AcquireNative(hwnd, wPixTypes);
            }
				if (hdib) {
					// compute or guess a palette to use for display
				    hpal = TWAIN_CreateDibPalette(hdib);
				    // size the window to just contain the image
					ResizeWindow(hwnd, hdib);        
					// force repaint of window
					InvalidateRect(hwnd, NULL, TRUE);
				}
				break;
			} // case TW_APP_ACQUIRE

			case TW_APP_ACQUIRE_TO_CLPB: {
				if (!TWAIN_AcquireToClipboard(hwnd, TWAIN_ANYTYPE)) {
					LoadString(hInst, IDS_ERR_NOIMAGE, szMessage, sizeof szMessage);
					MessageBox(hwnd, szMessage, szAppName, MB_ICONINFORMATION | MB_OK);
				}
				break;
			}

			case TW_APP_SELECT_SOURCE:

				TWAIN_SelectImageSource(hwnd);
				break;


			case TW_APP_SAVEAS:
			{
				int result = TWAIN_WriteNativeToFilename(hdib, NULL);
				//	-1	user cancelled File Save dialog
				//	-2	could not create or open file for writing
				//	-3	(weird) unable to access DIB
				//	-4	writing to .BMP failed, maybe output device is full?
				if (result < -1) {
					LoadString(hInst, IDS_ERR_WRITE, szMessage, sizeof szMessage);
					MessageBox(hwnd, szMessage, szAppName, MB_ICONINFORMATION | MB_OK);
				}
				break;
			}

			case TW_APP_OPEN:
			{
                // free up current image and palette if any
				DiscardImage();
				// clear the window during/before Acquire dialog
				InvalidateRect(hwnd, NULL, TRUE);
				hdib = TWAIN_LoadNativeFromFilename(NULL);
				if (hdib) {
					// compute or guess a palette to use for display
				    hpal = TWAIN_CreateDibPalette(hdib);
				    // size the window to just contain the image
					ResizeWindow(hwnd, hdib);        
					// force repaint of window
					InvalidateRect(hwnd, NULL, TRUE);
				}
				break;
			}

			case TW_APP_QUIT:
				DestroyWindow(hwnd);
				break;

//-----------------------------------------------------------------
            case TW_APP_ABOUT:
		    {
                // bring up the about dialog box
                DLGPROC lpProcAbout = MakeProcInstance((DLGPROC)AboutDlgProc, hInst);
	            DialogBox (hInst, "TW_APP_ABOUTBOX", hwnd, lpProcAbout);
	            FreeProcInstance(lpProcAbout);
	            break;
	        }

//-----------------------------------------------------------------
            case TW_APP_BW:
            	wPixTypes ^= TWAIN_BW;
	            break;
	        case TW_APP_GRAYSCALE:
	        	wPixTypes ^= TWAIN_GRAY;
	        	break;
	        case TW_APP_RGB:
	        	wPixTypes ^= TWAIN_RGB;
	        	break;
	        case TW_APP_PALETTE:
	        	wPixTypes ^= TWAIN_PALETTE;
	        	break;
	        case TW_APP_ANYPIX:
	        	wPixTypes = TWAIN_ANYTYPE;
	        	break;

//-----------------------------------------------------------------

			case TW_APP_SHOWUI:
			case TW_APP_HIDEUI:
				fHideUI = (wP == TW_APP_HIDEUI);
				break;

//-----------------------------------------------------------------
		  default:
 	         break;
        }	/* switch */
        break;

	default:
		return DefWindowProc (hwnd, wMsg, wP, lP);
	}	/* switch */
	return 0L ;
}	// MainWndProc



//---------------------------------------------------------------------------

void ResizeWindow(HWND hwnd, HANDLE hdib)
{
	HDC	hDC = GetDC(hwnd);
	if (hDC) {
		int xMin = LOWORD(GetTabbedTextExtent(hDC, "Twerp Sample Title", 18, 0, NULL));
        RECT		Rectangle;
    	Rectangle.left = 0;
    	Rectangle.top  = 0;
    	Rectangle.right  = max(TWAIN_DibWidth(hdib), xMin);
    	Rectangle.bottom = TWAIN_DibHeight(hdib);

		// AdjustWindowRect fails if you have a multiline menu.
		AdjustWindowRect (&Rectangle,  WS_OVERLAPPEDWINDOW, TRUE);

    	SetWindowPos (hwnd, (HWND)NULL, 0, 0,
            		  Rectangle.right - Rectangle.left,
					  Rectangle.bottom - Rectangle.top,
					  SWP_NOMOVE | SWP_NOZORDER);

    	ReleaseDC(hwnd, hDC);
    }
} // end ResizeWindow


//---------------------------------------------------------------------------

BOOL FAR PASCAL AboutDlgProc(HWND hDlg, WORD message, WORD wP, LONG lParam)
// Call-back function (dialog procedure) for 'About' box.
// On OK or Cancel, closes the dialog.
{
	int nVer = TWAIN_EasyVersion();
	char szBuff[100];

	lParam=lParam;								// suppress no-use warning
	switch (message){
		case WM_INITDIALOG:						// message: initialize dialog box
			LoadString(hInst, IDS_EZT_VER, szMessage, sizeof szMessage);
			wsprintf(szBuff, szMessage, nVer/100, nVer % 100);
			SetDlgItemText(hDlg, IDEZT_VER, szBuff);    
			LoadString(hInst, (TWAIN_IsAvailable() ? IDS_TWAIN_PRESENT : IDS_NO_TWAIN),
			           szBuff, sizeof szBuff);
			SetDlgItemText(hDlg, IDTWAIN_AVAIL, szBuff); 
			return (TRUE);

		case WM_COMMAND:						// message: received a command
			if ((wP == IDOK) || (wP == IDCANCEL)) {
												// OK button or System menu close
				EndDialog(hDlg, TRUE);			// Exits the dialog box
				return (TRUE);
			}
			break;
		default:
			break;
	}

    return (FALSE);            // Didn't process a message
} // AboutDlgProc


//---------------------------------------------------------------------------

VOID DiscardImage (VOID)
// delete/free global palette, and dib, as necessary.
{

	if (hpal) {
		DeleteObject(hpal);
		hpal = NULL;
	}
	if (hdib) {
		TWAIN_FreeNative(hdib);
		hdib = NULL;
	}
} // DiscardImage




