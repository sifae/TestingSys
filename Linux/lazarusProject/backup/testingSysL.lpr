program testingSysL;

{$mode objfpc}{$H+}

uses
  cthreads,
  Interfaces, // this includes the LCL widgetset
  Forms,
  cmem,
  file02,
  file01;

{$R *.res}

begin
  RequireDerivedFormResource := False;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
