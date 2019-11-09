unit file03;

interface

uses
  LCLIntf, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var action1: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  {$I-}

implementation


{$R *.dfm}

uses file09, file00, file02;

var
  Number_of_intervals: integer;

const
  i_max = 149;//maximal number of time intervals 

procedure TForm3.FormCreate(Sender: TObject);
begin
  left := screen.Width div 4;
  top := screen.Height div 3;
  Width := _width div 2;
  Height := _height div 3;
  label1.Top := Height div 8;
  label1.left := left div 6;
  label1.Height := Height div 4 * 3;
  label1.Width := Width * 3 div 4;
  label1.Caption := '';
  label1.Font.Size := _width div 70;
  label1.Font.Name := 'Times New Roman';
  Caption := '';
  bordericons := [];
  timer1.Enabled := False;
end;

procedure TForm3.FormActivate(Sender: TObject);
var
  f: textfile;
begin
  Timer1.Interval := 400;
  number_of_intervals := 0;
  timer1.Enabled := True;
  compi := False;
  assignfile(f, 'result.txt');
  closefile(f);
  //showmessage(current_dir+'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

  ioresult;
end;

procedure TForm3.FormClose(Sender: TObject; var action1: TCloseAction);
var
  f: textfile;
begin
  assignfile(f, 'result.txt');
  closefile(f);
  ioresult;
  timer1.Enabled := False;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
var
  f: textfile;
  i: integer;
begin
  number_of_intervals := number_of_intervals + 1;
  if number_of_intervals > i_max then
  begin
    timer1.Enabled := False;
    if number_of_intervals > i_max + 9 then
    begin
      compi := False;


      closefile(f);
      ioresult;
      form3.Close;
      halt;
    end;
    if en_rus then
      ShowMessage('The compilation failed. Check your compiler and restart the computer.')
    else
      ShowMessage(
        'Компиляция невозможна. Проверьте компилятор и перезапустите компьютер.');
    //deletefile(current_dir+'/tmp/temp0.bat');ioresult; assignfile(f,'result.txt'); closefile(f); ioresult;
    //erase(f); ioresult;
    deletefile(current_dir + '/tmp/directory.txt');
    delete_temp;
    halt;
  end;
  closefile(f);
  ioresult;
  assignfile(f, current_dir + '/tmp/' + 'result.txt');
  reset(f);
  i := ioresult;
  //showmessage(inttostr(i));
  if i <> 0 then
  begin
    closefile(f);
    ioresult;
    exit;
  end;
  if EOF(f) then
  begin
    closefile(f);
    ioresult;
    exit;
  end;
  closefile(f);
  compi := True;
  form3.Close;
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: char);
var
  f: textfile;
begin
  if key = chr(27) then
  begin
    timer1.Enabled := False;
    assignfile(f, current_dir + '/tmp/' + 'result.txt');
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    delete_temp;
    form2.Close;
  end;
end;

end.
