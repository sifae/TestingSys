program Change_file_names_p;

uses
  Forms,
  change_file_names in 'change_file_names.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
