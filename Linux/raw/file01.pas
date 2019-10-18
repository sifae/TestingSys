unit file01;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses file00, file09, file02,file_killprocess;

{$R *.dfm}

{$I-}
var count_time:integer;
procedure TForm1.FormCreate(Sender: TObject);
var b:boolean;p:integer;s,s2:string;
begin

if fileexists('.\tmp\temp01.bat')then begin
s:='Программа уже выполняется. Если это не так, удалите все файлы из подкаталога TMP, кроме directory.txt и p.txt. Пoсле этого перезапустите программу.';
s2:=' The program is running already. If not, delete all files except directory.txt and p.txt in the subdirectory TMP and restart the program. ';
showmessage(s+s2); halt end;

count_time:=0;
determine_size(screen.Width, screen.height);
form1.width:=_width; form1.height:=_height;
left:=(screen.Width-_width)div 2;
top:=(screen.height-_height)div 2;
caption:='Cистема автоматического тестирования программ';
label1.Top:=round(_height/3.35);
label1.height:=_height div 13;
label1.left:=round(_width/3);
label1.width:=_width div 2;
label1.Visible:=true;
label1.Font.Size:=_width div 18;
label1.Font.Name:=_fontname;
label1.Caption:='Система ';
label2.Top:=label1.Top+label1.Height*8 div 7;
label2.height:=_height div 13;
label2.left:=_width div 8;
label2.width:=_width div 2;
label2.Visible:=true;
label2.Font.Size:=_width div 30;
label2.Font.Name:=label1.font.name;
label2.Caption:='автоматического тестирования программ';
label3.Top:=round(_height*0.83);
label3.height:=_height div 13;
label3.left:=round(_width/2.9);
label3.width:=_width div 2;
label3.Visible:=true;
label3.Font.Size:=_width div 50;
label3.Font.Name:=label1.font.name;
label3.Caption:=' Автор - Новиков М.Д.';
label4.Top:=round(_height/37);
label4.height:=_height div 13;
label4.left:=round(_width/10);
label4.width:=_width div 2;
label4.Visible:=true;
label4.Font.Size:=_width div 45;
label4.Font.Name:=label1.font.name;
label4.Caption:=' Московский государственный университет им. М.В.Ломоносова';
label5.Top:=round(_height/12);
label5.height:=_height div 13;
label5.left:=round(_width/6);
label5.width:=_width div 2;
label5.Visible:=true;
label5.Font.Size:=_width div 50;
label5.Font.Name:=label1.font.name;
label5.Caption:=' Факультет вычислительной математики и кибернетики';
label6.Top:=label2.Top+label2.Height*7 div 4;
label6.height:=_height div 13;
label6.left:=_width div 4;
label6.width:=_width div 2;
label6.Visible:=true;
label6.Font.Size:=_width div 45;
label6.Font.Name:=label1.font.name;
label6.Caption:=' (по материалам книги В.Н. Пильщикова';
label7.Top:=label6.Top+label6.Height*6 div 5;
label7.height:=_height div 13;
label7.left:=_width div 4;
label7.width:=_width div 2;
label7.Visible:=true;
label7.Font.Size:=_width div 45;
label7.Font.Name:=label1.font.name;
label7.Caption:=' "Язык Паскаль: упражнения и задачи")';
label8.Top:=round(_height*0.88);
label8.height:=_height div 15;
label8.left:=round(_width/4.1);
label8.width:=_width div 2;
label8.Visible:=true;
label8.Font.Size:=_width div 65;
label8.Font.Name:=label1.font.name;
label8.Font.Color:=$FFFFFF;
label8.Caption:='   Haжмите любую клавишу, ctrl+e - switch to English';
timer1.Enabled:=true;
timer1.Interval:=500;

if fileexists('temp1.exe') then begin b:=deletefile('temp1.exe');
if not b then begin showmessage('Невозможно удалить файл Temp1.exe. Возможно, открыто DOS- окно. Закройте его и перезапустите программу. '+chr(10)+'It is impossible to delete the file ''Temp1.exe''. A DOS window is probably opened. Close it and restart the program.');
halt;form1.close;end end end;

procedure TForm1.FormClick(Sender: TObject);
begin
timer1.Enabled:=false; form2.show;form1.hide;form2.button1.visible:=false;
form2.button2.visible:=false;initialize_screen
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
form1.Timer1.Enabled:=false;
if key=chr(27)then form1.close else begin
if key<>chr(5)then begin en_rus:=false; form2.button1.visible:=true;form2.button1.Click;form2.button1.visible:=false;
form2.button2.visible:=false;end else begin en_rus:=true;form2.button1.visible:=true;form2.button2.visible:=true;form2.button2.Click;end;
form2.show;form1.hide;initialize_screen;end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
delete_temp;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
width:=_width; height:=_height;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
inc(count_time); if count_time>35 then form1.Formclick(sender);
if label8.font.Color=$FFFFFF then label8.Font.color:=$FF5F3F else
if label8.font.color=$FF5F3F then label8.font.Color:=$FFDFAF else
label8.font.Color:=$FF5F3F ;
end;

procedure TForm1.FormDblClick(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
form1.formClick(sender);
end;


procedure TForm1.Label6click(Sender:Tobject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
form1.formClick(sender);
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
form1.formClick(sender);
end;

end.
