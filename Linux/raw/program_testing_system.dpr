program program_testing_system;

uses
  Forms,
  file01 in 'file01.pas' {Form1},
  file00 in 'file00.pas',
  file02 in 'file02.pas' {Form2},
  file09 in 'file09.pas',
  file03 in 'file03.pas' {Form3},
  File_KillProcess in 'File_KillProcess.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
