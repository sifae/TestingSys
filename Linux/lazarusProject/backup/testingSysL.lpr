program testingSysL;

{$mode objfpc}{$H+}

uses
  cthreads,
  cmem,
  //richmemo,
  Interfaces, // this includes the LCL widgetset
  Forms,
  file01,
  file02;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Form1.Show;
  Application.Run;
end.
