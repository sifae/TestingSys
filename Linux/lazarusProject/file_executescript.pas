unit File_ExecuteScript;

interface

function executeScript(var handle : THandle; ShellScript : PChar) : Integer;
function readShellFile(var handle : THandle; ShellScript : PChar) : Integer;

implementation

uses
   Classes, SysUtils, Process;

function executeScript(var handle : THandle; ShellScript : PChar) : Integer;
  var
    AProcess: TProcess;

  begin
    // Create object TProcess and assign it to AProcess var.
    AProcess := TProcess.Create(nil);

    // Set executable command
    //AProcess.Executable:= 'fpc';
    AProcess.Executable := ShellScript;

    // Set command parameters to '-vu -Sg w'. In fact, it run 'fpc -vu -Sg w':
    //AProcess.Parameters.Add(' -vu -Sg w');

    // We will define an option when the program
    // will be launched. This option ensures that our program
    // will not continue until the program we started,
    // will not stop working.
    AProcess.Options := AProcess.Options + [poWaitOnExit];

    // Execute script
    AProcess.Execute;

    executeScript := AProcess.ProcessID;
    handle := AProcess.ThreadHandle;

    // This line run after script execution
    AProcess.Free;
  end;

function readShellFile(var handle : THandle; ShellScript : PChar) : Integer;
  var
    AProcess : TProcess;
  begin

  end;
end.
