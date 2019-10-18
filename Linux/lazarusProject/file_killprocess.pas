unit File_KillProcess;

interface


function KillProc(ExeName: string): integer;

implementation

{$define UseCThreads}
uses
  cthreads, cmem, LCLIntf, Classes, Variants, Graphics, Controls,
  Forms, Messages, Dialogs, SysUtils, StdCtrls, ExtCtrls, ComCtrls, Process;//ansistring

function KillProc(ExeName: string): integer;
  var
    t: TProcess;
    s: TStringList;

  begin
    Result := 0;

    t := tprocess.Create(nil);
    t.CommandLine := 'ps -C ' + ExeName;
    t.Options := [poUsePipes, poWaitonexit];

    try
      t.Execute;
      s := TStringList.Create;
        try
          s.LoadFromStream(t.Output);
          Result := Pos(ExeName, s.Text);
        finally
          s.Free;
          Application.ProcessMessages;
        end;
    finally
        t.Free;
        Application.ProcessMessages;
    end;
  end;
end.
