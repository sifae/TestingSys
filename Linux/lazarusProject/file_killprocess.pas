unit File_KillProcess;

interface


function KillProc(ss:string): integer;

implementation

uses
  LCLIntf, Classes,Variants,  Graphics, Controls, Forms, TlHelp32, messages,  dialogs,sysutils, StdCtrls, ExtCtrls, ComCtrls;//ansistring

function KillProc(ss:string): integer;
var i:integer;
  ContinueLoop: boolean;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  ExeFileName: string;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  ExeFileName :=ss;
              i:=0;

              //showmessage('We are here');
                while (Integer(ContinueLoop) <> 0)and(i<900) do
  begin inc(i);

    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
         UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
         UpperCase(ExeFileName))) then begin //showmessage(inttostr(i)+'Found!'+exefilename);
    Result := Integer(TerminateProcess(
        OpenProcess(PROCESS_TERMINATE,
        BOOL(0),
        FProcessEntry32.th32ProcessID),0));Application.processmessages; end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
  Application.processmessages; 

  end;

end.
