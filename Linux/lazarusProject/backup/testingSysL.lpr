program testingSysL;

{$mode objfpc}{$H+}

uses
  cthreads,
  cmem,  Dialogs,
  //richmemo,
  Interfaces, // this includes the LCL widgetset
  Forms, file01, file02, file00, file09, file101, file03, File_KillProcess,
  testing_main, testing_utils,form4;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  try
    Application.CreateForm(TForm1, Form1);
  except
    begin
     ShowMessage('A');
     Application.Terminate;
     exit;
    end;
  end;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Form1.Show;
  Application.Run;
end.
