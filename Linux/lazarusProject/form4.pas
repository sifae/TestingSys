unit form4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  file02,
  file01, file03;

type
  TForm4 = class(TForm)
    form1 : TForm1;
    form2 : TForm2;
    form3 : TForm3;
    procedure formcreate(sender: tobject);
  private

  public

  end;

var
  formUnite: TForm4;

implementation

//{$R *.lfm}

procedure TForm4.formcreate(sender: tobject);
  begin
    formUnite := Tform4.create(self);
    form1 := Tform1.create(self);
    form1.Show;
    //form2 := TForm2.create(self);
    formUnite.show;
  end;

end.

