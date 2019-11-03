unit form3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  file02,
  file01;

type
  TForm3 = class(TForm)
    form1 : TForm1;
    form2 : TForm2;
    procedure formcreate(sender: tobject);
  private

  public

  end;

var
  formUnite: TForm3;

implementation

//{$R *.lfm}

procedure TForm3.formcreate(sender: tobject);
  begin
    formUnite := Tform3.create(self);
    form1 := Tform1.create(self);
    //form2 := TForm2.create(self);
    formUnite.show;
  end;

end.

