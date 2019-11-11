unit File_ExecuteScript;

interface

function executeScript(var handle : THandle; ShellScript : PChar) : Integer;
function readShellFile(var handle : THandle; ShellScript : PChar) : Integer;

implementation

uses
   Classes, SysUtils, Process, cthreads, cmem;

function executeScript(var handle : THandle; ShellScript : PChar) : Integer;
  var
    AProcess: TProcess;

  begin
    // Create object TProcess and assign it to AProcess var.
    AProcess := TProcess.Create(nil);

    // Set executable command
    //AProcess.Executable:= 'fpc';
    //AProcess.Executable := 'chmod +rwx ' + ShellScript + ' && ';
    //AProcess.Executable := AProcess.Executable + ShellScript;

    AProcess.Executable := '/usr/bin/bash ';
    AProcess.Parameters.Add(ShellScript);

    // We will define an option when the program
    // will be launched. This option ensures that our program
    // will not continue until the program we started,
    // will not stop working.
    AProcess.Options := AProcess.Options + [poWaitOnExit];

    // Execute script
    AProcess.Execute;

    handle := AProcess.ThreadHandle;
    //executeScript := AProcess.ProcessID;
    executeScript := handle;

    // This line run after script execution
    AProcess.Free;
  end;

function readShellFile(var handle : THandle; ShellScript : PChar) : Integer;
  var
    AProcess : TProcess;
  begin
    readShellFile := 1;
  end;
end.
