unit file02;

interface

uses
  file00, LCLIntf, Messages, SysUtils, Classes,Variants,  Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, RichMemo;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button3: TButton;
    Button5: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Button6: TButton;
    Button7: TButton;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    OpenDialog2: TOpenDialog;
    Memo5: TMemo;
    RichEdit1: TRichMemo;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action1: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button11KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

  procedure initialize_screen;
{procedure of initializing the encoded files: both tests.cde (b=true) and claims.cde (b=false)}
procedure initializef(var f:t_f; var i_n, i_c:integer; var s_n:Ts_n; b:boolean);

implementation
uses file09, file01, {shellapi,} file03, file101, file_killprocess;

{$R *.dfm}

{$I-,R+}
var low_pos:real;//position of button1 and buttons2 and label4
const engrus='abcdefghijklmnjpqrstuvwxyzабвгдежзиклмнопрстуфхцчшщъыьэюя';
const ruscapsmall='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя';
//These are contents of currents items of the combo- components.
var combo2text,combo1text:string;
var combo2index,combo1index:integer;
var binit:boolean;//False if form2 is activated for the first time, that is, after the first frame

//The procedure sorting the numerical data
procedure sorting (var sr:string);
var srr:string;k,i,n,p,j:integer;r:array[1..max_test_number]of real;s:real;
begin n:=0;
delete_blanks(sr);if sr='' then exit; if not(sr[1]in['0'..'9','-','+'])then exit;
srr:=sr;
repeat k:=pos(' ', srr); if k=0 then begin inc(n); val(srr,r[n],p);if p<>0 then exit; break end else begin inc(n); val(copy(srr,1,k-1),r[n],p); if p<>0 then exit; delete(srr,1,k)end;
until k=0;
if n>1 then for i:=1 to n-1 do for j:=1 to n-i do if(r[j]>r[j+1])then begin s:=r[j]; r[j]:=r[j+1]; r[j+1]:=s end;
sr:=''; for i:=1 to n do begin if sorts=1 then str(r[i]:1:8,srr) else str(r[i]:1:0,srr); sr:=sr+' '+srr;end;
delete_blanks(sr);

//showmessage(sr);

end;

//The procedure that outputs help information
procedure showhelp;
var s:string;
begin if en_rus then begin
s:='SOME PECULIARITIES OF MAKING PROGRAMS FOR THE AUTOMATED PROGRAM TESTING SYSTEM'+chr(13)+chr(10);
s:=s+'1. Do not use blank characters in file and directory names.'+chr(13)+chr(10);
s:=s+'2. Descriptions of tasks that are suggested in the System can be slightly different from those in the taskbook by Pilshchikov. Read the text to a task attentively before making a program for it.'+chr(13)+chr(10);
s:=s+'3. Output exactly the information that is specified for the task. In particular, do not output any prompts like ''Input the array:'', ''The result is:'' and others.';
s:=s+' However, if you still want to use an additional output, place it on a separate line beginning with the characters ''{I}''. The System ignores such program lines.'+chr(13)+chr(10);
s:=s+'4. Separate output numbers with blank characters. '+chr(13)+chr(10);
s:=s+'5. A complex number must be output as two real numbers without any brackets, characters ''+'' or ''i''.'+chr(13)+chr(10);
s:=s+'6. Elements of a one-dimensional array must be output in ascending order of their indeces if the task does not specify a different output.'+chr(13)+chr(10);
s:=s+'7. Elements of a matrix must be output in order of its rows if the task does not specify a different output.'+chr(13)+chr(10);
s:=s+'8. The amount of terms of a sequence, the amount of elements of a one-dimensional array and the order of a square matrix must be defined as an integer constant with a posuitive value.'+chr(13)+chr(10);
s:=s+'9. The amount of rows and columns of a rectangular matrix must be specified as two integer constants with positive values; the first constant denotes the amount of the rows and the second one denotes the amount of the columns.'+chr(13)+chr(10);
s:=s+'To guarantee a correct compilation of the program do not use any other constants for the tasks where these special constants are needed.'+chr(13)+chr(10);
s:=s+'10. For setting a chapter number and a task number automatically, use filenames of the type ''_<chapter number>_<task number>-<subtask number (a three-digit integer)>_<any text>''. Examples: _16_18-003_Petrov.pas, _15_47_Ivanov.pas.'
end else begin
s:='НЕКОТОРЫЕ ОСОБЕННОСТИ СОСТАВЛЕНИЯ ПРОГРАММ ДЛЯ СИСТЕМЫ АВТОМАТИЧЕСКОГО ТЕСТИРОВАНИЯ'+chr(13)+chr(10);
s:=s+'1. Не используйте пробелы в именах файлов и каталогов.'+chr(13)+chr(10);
s:=s+'2. Формулировки задач, предложенныx в Системе, могут немного отличаться от формулировок, приведенных в задачнике Пильщикова. Внимательно прочтите текст задачи перед составлением программы. '+chr(13)+chr(10);
s:=s+'3. Выводите в точности ту информацию, которая указана в формулировке задачи. В частности, не выводите никаких поясняющиx сообщений типа ''Введите x='', ''Ответ:'' и т.д.';
s:=s+' Oднако, если Вы всe же хотите использовать дополнительный вывод, разместите егo в отдельной строке и начните с комментария ''{I}''. Система автоматически удаляет такие строки.'+chr(13)+chr(10);
s:=s+'4. Выводимые числа разделяйте пробелами.'+chr(13)+chr(10);
s:=s+'5. Комлексное число должно быть выведено как совокупность двух вещественных чисeл без допoлнительных скобок, знаков ''+'' или ''i''.'+chr(13)+chr(10);
s:=s+'6. Элементы одномерного массива должны быть выведены в порядке возрастания их индексов, если иное не указано в формулировке задачи.'+chr(13)+chr(10);
s:=s+'7. Элементы матрицы должны быть выведены по строкам, если иное не указано в формулировке задачи.'+chr(13)+chr(10);
s:=s+'8. Количество элементов последовательности, количество элементов одномерного массива и порядок квадратной матрицы должны быть заданы целой положительной констaнтой.'+chr(13)+chr(10);
s:=s+'9. Koличества строк и столбцов прямоугольной матрицы должны быть заданы двумя целыми положительными константами; первая константа означает количество строк, вторая - количество столбцoв.'+chr(13)+chr(10);
s:=s+'Во избежание неправильной компиляции программы не следуeт описывать другие константы в задачах, требующих этих специальных констант.'+chr(13)+chr(10);
s:=s+'10. Для автоматического определения Системой номера главы и номера задачи используйте имена файлов вида ''_<номер главы>_<номер задачи>-<номер подзадачи (3 цифры)>_<произвольный текст>''. Примеры: _16_18-003_Petrov.pas, _15_47_Ivanov.pas.'+chr(13)+chr(10);
end;
showmessage(s);
end;

//The procedure fills the richedit-component
procedure richedit_fill;
var f2,f:textfile;s,sf:string;
var p1,p2:integer;label 1;
begin
form2.RichEdit1.clear; if chosen_task='' then exit;
sf:=current_dir+'\tests\'+directory_names[chosen_chapter]+'\'+chosen_task;
if en_rus then sf:=sf+'_e.rtf' else sf:=sf+'_r.rtf';
assign(f,sf);
//showmessage (sf);
reset(f); if ioresult<>0 then exit;
closefile(f);ioresult;reset(f); ioresult;
form2.richedit1.lines.LoadFromFile(sf);
closefile(f);ioresult;
if not en_rus then exit;
if func_proc0>0 then exit;
form2.richedit1.lines.savetofile(current_dir+'\tmp\addtext.txt');
assign(f,current_dir+'\tmp\addtext.txt');reset(f);
if ioresult<>0 then goto 1;
if (eof(f))then goto 1;
assign(f2,current_dir+'\tmp\addtext1.txt');rewrite(f2);
if ioresult<>0 then goto 1;
while not eof(f)  do begin readln(f,s); if s='' then goto 1; if s[1]='{' then writeln(f2,s) else break; end;
if eof(f) then goto 1;
p1:=pos(' ',s); p2:=pos('\''',s);
if (p1=0) and (p2=0) then goto 1;
if (p1=0)and(p2>0)then p1:=p2+1 else
if (p1>0)and(p2=0)then p2:=p1+1;

//showmessage('wait'+inttostr(p1)+'   '+inttostr(p2));

if (pos ('\''e0\''ef\''e8\''f1\''e0\''f2\''fc',s)>0)and(pos('\''ef\''f0\''ee\''e3\''f0\''e0\''ec\''ec',s)>0)then goto 1;
if p1<p2 then if en_rus then s:=copy(s,1,p1)+'WRITE A PASCAL PROGRAM. '+copy(s,p1+1,length(s)) else s:=copy(s,1,p1)+'Написать программу на Паскале. '+copy(s,p1+1,length(s));
if p1>p2 then if en_rus then s:=copy(s,1,p2-1)+'WRITE A PASCAL PROGRAM. '+copy(s,p2,length(s)) else s:=copy(s,1,p2-1)+'Напиcать программу на Паскале. '+copy(s,p2,length(s));
writeln(f2,s);
while not(eof(f)) do begin readln(f,s);writeln(f2,s) end;
closefile(f); ioresult; closefile(f2); ioresult; erase(f); ioresult;

//showmessage(inttostr(p1)+'  !! '+inttostr(p2));

form2.richedit1.lines.LoadFromFile(current_dir+'\tmp\addtext1.txt');
1:closefile(f); ioresult; closefile(f2); ioresult; erase(f);ioresult; erase(f2);ioresult;
end;

{procedure of initializing the encoded files: both tests.cde (b=true) and claims.cde (b=false)}
procedure initializef(var f:t_f; var i_n, i_c:integer; var s_n:Ts_n; b:boolean);
var k:byte;
begin closefile(f); ioresult;
reset(f);

k:=ioresult;
//showmessage(inttostr(k));
//showmessage(inttostr(filesize(f)));

if ((k<>0)or(filesize(f)<12))and b then begin showmessage('Fatal error in initializef'); halt;end;
read(f,k);read(f,k); read(f,k); i_n:=k mod 10;
//i_n:=0;
read(f,k); read(f,k); read(f,k); s_n:=[k mod 10, k div 10 mod 10];
//showmessage(inttostr(i_n)+' '+inttostr(k mod 10)+'  '+inttostr(k div 10 mod 10));
//s_n:=[];
read(f,k); read(f,k);read(f,k); read(f,k);
i_c:=10;
 end;

//It is a procedure that fills the array 'chapter_claims' containing claims to tasks of the chosen chapter
procedure claims_fill(var aclaim:Tclaims; var count:integer);
var b:boolean;s:string;f:t_f;p,i:integer;
begin
count:=0;
assignfile(f,current_dir+'\tests\'+directory_names[chosen_chapter]+'\claims.cde');
reset(f); if ioresult<>0 then exit;
initializef(f, i_n_2, i_c_2, s_n_2, false);
//showmessage('We are here!');

//showmessage(current_dir+'\tests\'+directory_names[chosen_chapter]+'\claims.cde');
//showmessage(inttostr(p));
i:=0;
while not(eof(f)) do begin
b:=readlnf2(f,s);
while(s<>'')and(s[1]=' ')do delete(s,1,1); while(s<>'')and(s[length(s)]=' ')do delete(s,length(s),1);
//showmessage(s);
if (length(s)<3)or(s[1]=' ') then break;
if (s[1] in ['w','W'])and(s[2]=' ') then begin
aclaim[i+1].b1:=true; delete(s,1,2) end
else aclaim[i+1].b1:=false;
aclaim[i+1].s1:=s; aclaim[i+1].b:=false;
if not b then readlnf2(f,s) else begin closefile(f); showmessage('Fatal error. Odd amount of lines in the file ''claims.txt'''); halt; end;
p:=pos('!',s); if p=0 then begin aclaim[i+1].s2:=s;aclaim[i+1].s3:=s end else
begin aclaim[i+1].s2:=copy(s,1,p-1);aclaim[i+1].s3:=copy(s,p+1,200);end;
inc(i);
end;
count:=i;
closefile(f); ioresult;
//showmessage(inttostr(count));
end;

{procedure of initializing the screen - the previous state is restored if the file 'test.ini' exists}
procedure initialize_screen;
var f:text;var b:boolean; var sender:tobject;p:integer; label 1;var s:string;
begin
//showmessage('we are here');
combo1text:='';combo2text:='';  b:=false;
combo1index:=-1;combo2index:=-1;
assign(f, current_dir+'\tmp\tests.ini'); reset(f);
p:=ioresult;
//showmessage(current_dir+'\test.ini'+'!'+inttostr(p));
if p<>0 then goto 1;
readln(f,s);b:=s='1';
if eof(f) then begin closefile(f); ioresult; goto 1 end;
readln(f,s);form2.CheckBox2.Checked:=s='1';
if eof(f) then begin closefile(f); ioresult; goto 1 end;
readln(f,chosen_chapter);
//showmessage(inttostr(chosen_chapter));
if ioresult<>0 then begin chosen_chapter:=0; goto 1 end; form2.combobox1click(sender);
if (eof(f)) or(chosen_chapter=0)then goto 1;
readln(f, chosen_task); if ioresult<>0 then begin chosen_task:=''; goto 1;end;
//showmessage(chosen_task);
form2.combobox2click(sender);
//showmessage(chosen_task);
if (eof(f)) or(chosen_task='')or(not initial)then goto 1;
readln(f,filename);
form2.Edit1.Text:=filename;
form2.Button7.Click;
1:  form2.CheckBox1.Checked:=b; initial:=false; closefile(f); ioresult;
end;

{Procedure of filling combobox1}
procedure task_chapters_fill;
var k,p,j:integer;f:textfile;i:integer;s2:string;
var searchresult:tsearchrec;
begin
combo1text:='';combo2text:='';
combo1index:=-1;combo2index:=-1;
pr_an:=false;
compi:=false;
chosen_task:=''; filename:='';chosen_chapter:=0;
form2.combobox1.clear;
form2.combobox2.clear;k:=0;setcurrentdir(current_dir);
p:=findfirst(current_dir+'\tests\*',fadirectory,searchresult); if p<>0 then begin showmessage('Fatal error. No subdirectories in the directory ''tests''');halt end;
if p=0 then begin  repeat  //if true or ((searchResult.attr and faDirectory) = faDirectory)
//showmessage(searchresult.name);
if (searchresult.name='')or(searchresult.Name[1]='.')then continue;
s2:=searchresult.name;

closefile(f); ioresult; assignfile(f,current_dir+'\tests\'+s2+'\tests.cde'); reset(f); if ioresult<>0 then continue;
j:=pos('!',s2);inc(k);
directory_names[k]:=s2;
if j>=2 then begin chapter_names[k,1]:=copy(s2,1,j-1); chapter_names[k,2]:=copy(s2,j+1,1111)end else
begin chapter_names[k,2]:=s2;chapter_names[k,1]:=s2;end;
form2.combobox1.items.add(chapter_names[k,1+byte(en_rus)]);
     closefile(f); ioresult;
     until (FindNext(searchResult)<> 0);
     findclose(searchresult);end;

if k=0 then begin showmessage('Fatal error. No testing files in the directory ''tests''');halt end;
     //showmessage('!!!'+inttostr(k));

//for i:=3 to 17 do begin assignfile(f, 'Tests_chapter_'+inttostr(i)+'.cde');
//reset(f); if (ioresult<>0) or(eof(f))then begin ioresult; closefile(f);ioresult;continue; end;
//form2.combobox1.items.add(inttostr(i)+'. '+chapter_names[i,2-byte(en_rus)]);closefile(f);ioresult;
end;

{procedure of correcting the names of chapters when switching from rus to en and vice versa }
procedure chapter_names_correct;
var p,j,i,m,k:integer; s:string;
begin

//k:=form2.ComboBox1.ItemIndex;
k:=combo1index;if k=-1 then exit;
m:=form2.ComboBox1.Items.Count;
//showmessage(inttostr(m));
for i:=1 to m do begin
s:=form2.ComboBox1.Items[i-1];
//showmessage(s+' '+inttostr(k));
//p:=pos('.',s); if p<2 then halt;j:=strtoint(copy(s,1,p-1));
//s:=copy(s,1,p)+' '+chapter_names[j,1+byte(en_rus)];
s:=chapter_names[i,1+byte(en_rus)];
//if i=1 then showmessage(inttostr(k)+' '+inttostr(i));
if i-1=k then begin combo1text:=s; end;
form2.ComboBox1.Items[i-1]:=s;end;
form2.ComboBox1.ItemIndex:=k;
end;

{procedure of filling or correcting combobox2 when choosing a chapter or
switching from rus to eng and back}
{the procedure uses the array 'task_names'}
procedure task_names_correct;
var p,L,k,i:integer;s:string;b:boolean;
begin
b:=form2.ComboBox2.Items.Count=0;
L:=combo2index;
//form2.ComboBox2.Clear;
for i:=1 to task_amount do
begin
s:=task_names[i];
//showmessage('!'+s+'!');
k:=pos('-',s); if (k>1)and(k<=length(s)-3) and(s[k+1]='0')then
begin
//showmessage(s+'!'+'@'+copy(s,k,3)+'#'+inttostr(k)+engrus[27]);
s:=copy(s,1,k)+engrus[26*byte(not(en_rus))+strtoint(copy(s,k+1,3))]+
copy(s,k+4,200);end;
//Additional correcting
p:=pos('_',s);
if (p>1)and(p<length(s))and(s[p-1]in['0'..'9'])and(s[p+1]in['0'..'9'])then
s:=copy(s,1,p-1)+'.'+copy(s,p+1,1000);
p:=pos('-',s);
if (p>1)and(p<length(s))and(s[p-1]in['0'..'9'])and(pos(s[p+1],engrus)>0)then
begin delete(s,p,1);insert(' ',s,p); end;


if b then form2.ComboBox2.items.add(s)
else form2.ComboBox2.Items[i-1]:=s;
if i-1=L then combo2text:=s;
end;
if l>=0 then form2.ComboBox2.ItemIndex:=l;
end;


//This procedure deletes all correct results from Memo1, remaining the wrong ones only
procedure delete_correct_results;
var j,p,j1,k1,k2,i:integer;s:string;b:boolean;
begin

//showmessage('We are here');


form2.Memo2.Clear;form2.memo2.width:=_width*2;//i2:=0;
for i:=1 to 2*max_test_number do begin
k1:=linetest[i]-1; k2:=linetest[i+1]-2;b:=k2<=0; if k2<=0 then k2:=form2.Memo1.Lines.Count-2;
while(k2>0)and((copy(form2.memo1.Lines[k2],1,2)='  ')or(form2.memo1.Lines[k2]=' ')or(copy(form2.memo1.Lines[k2],1,7)='Warning')or(copy(form2.memo1.Lines[k2],1,7)='Предупр'))
or(copy(form2.memo1.Lines[k2],1,5)='Hint:')or(copy(form2.memo1.Lines[k2],1,7)='Замечан')do dec(k2);

if (form2.Memo1.Lines[k2]<>'Ok')then
for j1:=k1 to k2 do begin s:=form2.Memo1.Lines[j1];//delete_blanks(s);
//p:=pos(' ',s); if p>0 then delete(s,p,1);
form2.Memo2.Lines.add(s);
end;
if  linetest[i+1]<=0 then break;
end;
j:=-1;
for i:=form2.Memo1.Lines.Count-1 downto form2.Memo1.Lines.Count div 2 do if (copy(form2.Memo1.Lines[i],1,7)='Warning')or(copy(form2.Memo1.Lines[i],1,7)='Предупр')
or(copy(form2.memo1.Lines[i],1,5)='Hint:')or(copy(form2.memo1.Lines[i],1,7)='Замечан')
then j:=i;
if j>-1 then for i:=j to form2.Memo1.Lines.Count-1 do form2.Memo2.Lines.Add(form2.Memo1.Lines[i]);
form2.Memo1.clear;
for i:=1 to form2.Memo2.Lines.Count do begin
s:=form2.Memo2.lines[i-1];
form2.memo1.Lines.Add(s);end;
Application.ProcessMessages;

end;


{Procedure of filling the array 'task_names'}
procedure task_names_fill;//(chosen:string);
var f:t_f;i:integer;s:string;b:boolean;
begin
task_amount:=0;
form2.combobox2.clear;
pr_an:=false;
compi:=false;
chosen_task:=''; filename:='';  closefile(f); ioresult;
assignfile(f,current_dir+'\tests\'+directory_names[chosen_chapter]+'\claims.cde');
initializef(f, i_n_2, i_c_2, s_n_2,false);
assignfile(f,current_dir+'\tests\'+directory_names[chosen_chapter]+'\tests.cde'); //..'Tests_chapter_'+chosen+'.cde');
//reset(f); if ioresult<>0 then showmessage(current_dir+'\tests'+directory_names[form2.ComboBox1.itemindex+1]+'\tests.cde');

b:=false;initializef(f,i_n, i_c, s_n,true);
//I wrote the next line for a safe reason because this error cannot occur
//if ioresult<>0 then begin form2.label1.caption:='!'+'Error! File not found _'+chosen+'.cde';exit end;
while not eof(f) and not b do begin b:=readlnf(f,s);
//showmessage('!'+s+'!');
if (s='')or(s[1]<>'_')or(length(s)>3)and(s[1]='_')and(not(s[2]in['0'..'9']))then continue;
i:=pos(';',s); if i>0 then s:=copy(s,1, i-1);//removal of a possible comment
inc(task_amount);task_names[task_amount]:=copy(s,2,200);
while (task_names[task_amount]<>'')and(task_names[task_amount,length(task_names[task_amount])]=' ')do
delete (task_names[task_amount], length(task_names[task_amount]),1);

end;closefile(f); ioresult;
task_names_correct;
end;

{procedure filling memo5 - it is the text of the chosen program}
procedure fill_file_text(s0:string);
var f:textfile;k:integer;s:string;
begin assignfile(f,s0);
//showmessage(s0+' !!!!! '+filename);
if filename='' then exit; reset(f);
if ioresult<>0 then exit;
form2.memo5.clear; k:=1; while not(eof(f)) do begin  inc(k); readln(f,s); if k=2 then delete_extra(s);
insert_blanks(s); form2.memo5.lines.add(s); end;
closefile(f); end;

{procedure filling memo5 if errors were found while compiling}
{s0 - the name of the program file, s1 - the name of the file where the results of the compilation were written}
procedure fill_file_text_err(s0,s1:string);
var r,p,q,m:integer;
var f,g:textfile; s3,s2,s:string;
begin form2.Memo5.clear;
assignfile(f,s0); reset(f); if ioresult<>0 then exit;
assignfile(g,s1); reset(g); if ioresult<>0 then exit;
m:=1; //the current line of the file f
while not(eof(g)) do begin readln(g,s);
p:=pos('Error',s); if p=0 then p:=pos('Fatal',s);
if p=0 then continue;
q:=pos('(', s);r:=pos(',',s);

//showmessage(inttostr(q)+'  '+inttostr(r));
if (q=0)or(r=0)or(q>r)then continue;
s2:=copy(s,q+1,r-q-1); if s2='' then continue; val(s2,p,q);

//showmessage('!'+s2+'!'+inttostr(p)+'  '+inttostr(q));
if q<>0 then continue;

while (m<p)and(not(eof(f))) do begin readln(f,s3); insert_blanks(s3); form2.Memo5.Lines.Add(s3); inc(m)end;
if eof(f)then break;
if m=p then begin readln(f,s3); inc(m); s3:=s3+'   //'+s;insert_blanks(s3); form2.Memo5.Lines.Add(s3);end;

end;
while not(eof(f)) do begin readln(f,s3);insert_blanks(s3); form2.Memo5.Lines.Add(s3);end;
closefile(f); closefile(g);
end;

{Procedure that fills the array varparam, that is, define types of actual parameters that can be passed by reference only}
procedure setvarparam(var s:string);
var p,p2,i:integer;s1:string;
begin i:=0;
//showmessage(s);
repeat p:=pos('var@',s);
if p>0 then begin s:=copy(s,1,p-1)+copy(s,p+4, length(s));s1:=copy(s,p,length(s)); p:=pos('=',s1); if (p<2)and(not program_sub) then begin showmessage('Fatal in setvarparam'); halt;end;
if p<2 then p:=pos(' ',s1); if p<2 then p:=length(s)+1;
inc(i); varparam[i]:=copy(s1,1,p-1); end until (p=0)or(length(s)<2);

varparam[i+1]:='';
for p:=1 to i do for p2:=1 to length(varparam[i])do if varparam[i,p2]in ['A'..'Z'] then varparam[i,p2]:=chr(ord(varparam[i,p2])+32);

end;

{procedure extracting tests from the file 'tests_chapter_<chosen number>' and forming files with the
initial data and correct results}
function extract_data:boolean;
//Attention! Integer variables xx21, xx22 and next are used for random tests!
var xx29,xx21,xx22,xx23,xx24,xx25,xx26,xx27,xx28: integer;sd:set of char;sa:array[1..5]of string;se,sf:string;
//Attention! Real variables xx31, xx32 and next are used for random tests!
var xx39,xx38,xx37,xx31,xx32,xx33,xx34,xx35,xx36: real;ss31,ss32:string;
//q1,q2,q3:integer;s5:string;
var auto:boolean;  jj3,jj5,jj6,jj7:boolean;
var ii4,dif,ii2i,p3,xx13:integer;xx16,xx17,xx18,xx19,xx14,xx15,xx9,xx10,xx11,xx12,xx3,xx4,xx5,xx6,xx7,xx8,xx1,yy1,xx2,yy2,yy,xx:real;var g1,g,f:textfile;b1,b:boolean;pp,kk,j,q,l,p,k,i:integer;s1,s:string;h:t_f;s7:ansistring;
begin extract_data:=false;
auto:=form2.checkbox1.Checked;form2.CheckBox1.Checked:=false;
jj3:=form2.button3.enabled;jj5:=form2.button5.enabled;jj6:=form2.button6.enabled;jj7:=form2.button7.enabled;
form2.button3.Enabled:=false; form2.button5.Enabled:=false; form2.button6.Enabled:=false; form2.button7.Enabled:=false;
//showmessage(inttostr(task_claims_amount));
for i:=1 to max_test_number do
begin
assignfile(f,current_dir+'\tmp\iii'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
assignfile(f,current_dir+'\tmp\ooo'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
assignfile(f,current_dir+'\tmp\rrr'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
assignfile(f,current_dir+'\tmp\iiii'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
assignfile(f,current_dir+'\tmp\oooo'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
assignfile(f,current_dir+'\tmp\rrrr'+inttostr(i));closefile(f); ioresult; erase(f); ioresult;
end; {of for}
b:=true; if chosen_task<>'' then begin assign(h,current_dir+'\tests\'+directory_names[chosen_chapter]+'\tests.cde');
initializef(h,i_n, i_c, s_n,true);// Is it necessary here?
  end else b:=false; if not b then begin closefile(f); ioresult;
showmessage('Fatal error 1!'); exit end;b:=false;
b1:=false;
while not eof(h)and(not b1) do
{while not eof}
begin b1:=readlnf(h,s); p:=pos(';',s); if p>0 then s:=copy(s,1,p-1);
while(s<>'')and(s[length(s)]=chr(32)) do s:=copy(s,1,length(s)-1);if s<>''then s:=copy(s,2,200);
if s=chosen_task then
{of chosen task}
begin

//First lines contain information about claims to the task - each odd line contains what words the program must contain and each next even line contains information that is output
//if the program does not satisfy the current claim

program_sub:=false;noclaims:=false; func_proc:=0;func_proc0:=0;task_claims_amount:=0; text_after:=''; text_before:='';text_after0:=''; text_before0:='';for xx21:=1 to 20 do varparam[xx21]:='';
while not eof(h) do begin
readlnf(h,s);
while(s<>'')and(s[1]=' ')do delete(s,1,1);
if (length(s)<3)or(s[1]=' ') then begin if en_rus then showmessage('Fatal error with claims to the chosen task or with amount of the tests. A line is too short or its first character is blank.')else
showmessage('Фатальная ошибка в строке, содержащей требования к задаче или количество тестов. '); exit end;

if (s[1]in['0'..'9'])or(eof(h))then break;
task_claims[task_claims_amount+1].b:=false;
if (s[1]in ['w','W'])and(s[2]=' ')then begin
task_claims[task_claims_amount+1].b1:=true;delete(s,1,2); end else
task_claims[task_claims_amount+1].b1:=false;task_claims[task_claims_amount+1].s1:=s;
readlnf(h,s);if (length(s)<3)or(s[1]=' ') then begin if en_rus then showmessage('Fatal error with claims to the chosen task.')
else showmessage('Фатальная ошибка в строке, содержащей требования к задаче.');exit; end;

pp:=pos('!',s); if pp=0 then begin task_claims[task_claims_amount+1].s2:=s;task_claims[task_claims_amount+1].s3:=s; end else
begin task_claims[task_claims_amount+1].s2:=copy(s,1,pp-1);task_claims[task_claims_amount+1].s3:=copy(s,pp+1,200);end;
inc(task_claims_amount);
end; //of While not eof(h)


if eof(h) then begin showmessage('Fatal error in claims to the task - unexpected end of file '); exit end;
//s - information about the chosen task - the first line after the claims to the task - contains number of tests and the results' types
ioresult;if (s<>'')and(pos(';',s)>0) then s:=copy(s,1,pos(';',s)-1);

//showmessage(s);
//showmessage(inttostr(task_claims_amount));

if (pos('program+sub',s)>0)and((pos('procedure',s)>0)or(pos('Procedure',s)>0)or (pos('function',s)>0)or (pos('Function',s)>0))
then begin if en_rus then showmessage('Error. The algorithm cannot be both a program and a subprogram.')else
showmessage('Ошибка. Алгоритм не может быть программой и подпрограммой одновременно.');exit end;
p:=pos('program+sub',s);program_sub:=p>0; number_of_tests:=0; number_of_subtests:=0;
if program_sub then s:=copy(s,1,p-1)+copy(s,p+11, length(s));
for xx29:=1 to 1+byte(program_sub) do begin
delete_blanks(s);
p:=pos(' ',s); if p<=1 then begin closefile(h); ioresult;if en_rus then showmessage('Error with amount of the tests - no number '+inttostr(xx29)+'.')
else showmessage('Ошибка в задании количества тестов - нет числа №'+inttostr(xx29)+'.');exit end;
//k - the current number of tests
val(copy(s,1,p-1),k,q);
if (q<>0)or not(k in [1..max_test_number])then begin closefile(h); ioresult;
if en_rus then showmessage('Error with amount of the tests.')else showmessage('Ошибка в количестве тестов.'); exit end;
if xx29=1 then Number_of_tests:=k else Number_of_subtests:=k;
s:=copy(s,p+1,200);
end;


//showmessage('We are here!'+inttostr(ord(noclaims)));

//showmessage(inttostr(number_of_tests)+' '+inttostr(number_of_subtests));
p:=pos('noclaims',s); if p=0 then p:=pos('Noclaims',s);
if p>0 then begin noclaims:=true; delete(s,p,8); delete_blanks(s) end;
//Some peculiarities of the input and output

//showmessage('We are here!'+inttostr(ord(noclaims)));


delete_blanks(s);
func_proc0:=0;
p:=pos('functionprocedure',s);
if p=0 then p:=pos('Functionprocedure',s);
if p=0 then p:=pos('Procedurefunction',s);
if p=0 then p:=pos('procedurefunction',s);
if p>0 then begin func_proc0:=3;delete(s,p,17);delete_blanks(s);end;
p:=pos('function',s);
if p=0 then p:=pos('Function',s);
if p>0 then begin func_proc0:=1; delete(s,p,8); delete_blanks(s);end;
p:=pos('procedure',s);
if p=0 then p:=pos('Procedure',s);
if p>0 then begin func_proc0:=2; delete(s,p,9); end; delete_blanks(s);
p:=pos('matrixin',s);
if p=0 then p:=pos('Matrixin',s);
if p=0 then begin matrixin:=0; matrixins:=0 end else begin if (length(s)<p+8)or(not(s[p+8]in['0'..'9']))then
begin if en_rus then showmessage('Error in line '+s+' . An amount of matrices in the input data must be specified after the word ''Matrixin''')
else showmessage('Oшибка в строке '+ s+' . После слова ''Matrixin'' должно быть указано количество матриц во входном потоке.'); exit;end;
if program_sub and(length(s)>p+8)and(s[p+9]in ['0'..'9'])then begin dif:=1;matrixin:=strtoint(s[p+8]); matrixins:=strtoint(s[p+9]);end else begin dif:=0; matrixin:=strtoint(s[p+8]); matrixins:=strtoint(s[p+8])end;
delete(s,p,9+dif);end;
delete_blanks(s);
p:=pos('matrixout',s);
if p=0 then p:=pos('Matrixout',s);
if p=0 then begin matrixout:=0; matrixouts:=0 end else begin if (length(s)<p+9)or(not(s[p+9]in['0'..'9']))then
begin if en_rus then showmessage('Error in line '+s+' . An amount of matrices in the output data must be specified after the word ''Matrixout''')
else showmessage('Oшибка в строке '+ s+' . После слова ''Matrixout'' должно быть указано количество матриц в выходном потоке.'); exit;end;
if program_sub and(length(s)>p+9)and(s[p+10]in ['0'..'9'])then begin dif:=1;matrixout:=strtoint(s[p+9]); matrixouts:=strtoint(s[p+10]);end else begin dif:=0;matrixout:=strtoint(s[p+9]); matrixouts:=strtoint(s[p+9])end;
delete(s,p,10+dif);end;
delete_blanks(s);

p:=pos('Arrayin',s);
if p=0 then p:=pos('arrayin',s);
if p=0 then begin arrayin:=0;arrayins:=0 end else begin if (length(s)<p+7)or(not(s[p+7]in['0'..'9']))then
begin if en_rus then showmessage('Error in line '+s+' . An amount of arrays (1 - 9) in the input data must be specified after the word ''Arrayin''')
else showmessage('Oшибка в строке '+ s+' . После слова ''Arrayin'' должно быть указано количество массивов (1 - 9) во входном потоке.'); exit;
end;
if program_sub and(length(s)>p+7)and(s[p+8]in ['0'..'9'])then begin dif:=1; arrayin:=strtoint(s[p+7]); arrayins:=strtoint(s[p+8]);end else begin dif:=0; arrayin:=strtoint(s[p+7]); arrayins:=strtoint(s[p+7])end;
delete(s,p,8+dif);end;
delete_blanks(s);

p:=pos('Arrayout',s);
if p=0 then p:=pos('arrayout',s);
if p=0 then begin arrayout:=0;arrayouts:=0 end else begin if (length(s)<p+8)or(not(s[p+8]in['0'..'9']))then
begin if en_rus then showmessage('Error in line '+s+' . An amount of arrays (1 - 9) in the output data must be specified after the word ''Arrayout''')
else showmessage('Oшибка в строке '+ s+' . После слова ''Arrayout'' должно быть указано количество массивов (1 - 9) в выходном потоке.'); exit;end;
if program_sub and(length(s)>p+8)and(s[p+9]in ['0'..'9'])then begin dif:=1; arrayout:=strtoint(s[p+8]); arrayouts:=strtoint(s[p+9]);end else begin dif:=0; arrayout:=strtoint(s[p+8]); arrayouts:=strtoint(s[p+8])end;
delete(s,p,9+dif);end;
delete_blanks(s);


p:=pos('Fileinc',s); if p=0 then p:=pos('fileinc',s);
if (p>0)and((arrayin>0)or(matrixin>0))then begin
if en_rus then showmessage('Error. Input data cannot be both a binary file and an array.' )
else showmessage('Ошибка. Входные данные не могут быть одновременно типизированным фaйлом и массивом.');
exit
end;
filein:=byte(p>0); if p>0 then begin delete(s,p,7); delete_blanks(s) end;

if filein=0 then begin p:=pos('Fileini',s); if p=0 then p:=pos('fileini',s);
if (p>0)and((arrayin>0)or(matrixin>0))then begin
if en_rus then showmessage('Error. Input data cannot be both a binary file and an array.' )
else showmessage('Ошибка. Входные данные не могут быть одновременно типизированным фaйлом и массивом.');
exit
end;
filein:=2*byte(p>0); if p>0 then begin delete(s,p,7); delete_blanks(s) end;
end;

p:=pos('Fileout',s); if p=0 then p:=pos('fileout',s);
if (p>0)and((arrayout>0)or(matrixout>0))then begin
if en_rus then showmessage('Error. Output data cannot be both a binary file and an array.' )
else showmessage('Ошибка. Выходные данные не могут быть одновременно типизированным фaйлом и массивом.');
exit
end;
fileout:=byte(p>0); if p>0 then begin delete(s,p,7); delete_blanks(s) end;


textsin:=0; p:=pos('textin',s); if p=0 then p:=pos('Textin',s);
if (p>0)and((arrayin>0)or(matrixin>0)or(filein>0))then begin
if en_rus then showmessage('Error. Input data cannot be both a text file and an array or a binary file.' )
else showmessage('Ошибка. Входные данные не могут быть одновременно текстовым фaйлом и массивом или типизированным файлом.');
exit
end;
textsin:=byte(p>0); if p>0 then begin delete(s,p,6); delete_blanks(s) end;

textsout:=0; p:=pos('textout',s); if p=0 then p:=pos('Textout',s);
if (p>0)and((arrayout>0)or(matrixout>0)or(fileout>0))then begin
if en_rus then showmessage('Error. Output data cannot be both a text file and an array or a binary file.' )
else showmessage('Ошибка. Выходные данные не могут быть одновременно текстовым фaйлом и массивом или типизированным файлом.');
exit
end;
textsout:=byte(p>0); if p>0 then begin delete(s,p,7); delete_blanks(s) end;


p:=pos('run_time_err',s);
if p=0 then p:=pos('Run_time_err',s);
run_time_err:=false;
if p>0 then begin delete(s,p,12);
delete_blanks(s);run_time_err:=true;
end;
p:=pos('Error',s);
if(arrayin>0)and((matrixin>0)or(matrixout>0))or(arrayout>0)and((matrixin>0)or(matrixout>0))then
begin if en_rus then showmessage('Error. Input or output data cannot be both a one-dimensional array and a matrix.' )
else showmessage('Ошибка. Входные или выходные данные не могут быть одновременно одномерным массивом и матрицей.');
exit end;

if p=0 then p:=pos('error',s);
if p=0 then errorr:=false else begin errorr:=true; delete (s,p-1,5);end;
p:=pos('Any_order',s);
if p=0 then p:=pos('any_order',s);
if p=0 then sorts:=0
else begin
delete(s,p-1,1000);if (pos('b',s)>0)or(pos('c',s)>0)or(pos('s',s)>0)or(pos('i',s)>0)and(pos('r',s)>0)then begin
if en_rus then showmessage('Error in line '+ s+' . Only numerical data of type either integer or real can be sorted.') else
showmessage('Oшибка в строке '+ s+' . Copтировать можно только данные либо вещественного, либо целого типа.'); exit;
end;
if pos('i', s)>0 then sorts:=2 else sorts:=1;
end;
while (s<>'')and(s[length(s)]=' ')do s:=copy(s,1,length(s)-1);
if s='' then begin closefile(h); ioresult;showmessage('Fatal error 7!'); exit end;
l:=1; while (s<>'')and(s[1]<>' ')do begin result_type[1,l]:=s[1]; s:=copy(s,2,200);l:=l+1;

//showmessage(s+'  '+inttostr(l));
//NO!!!! Read the next line! //The information to the right is outdated now. ATTENTION! TYPES OF RESULTS MAY BE DIFFERENT FOR ODD AND EVEN TESTS! I DO NOT USE IT NOW BUT IT IS POSSIBLE AND IT IS REALIZED HERE!!!
//It is different now. Elements of the first row are the tyies of results for the main program and elements of the second row are the types of results for the subprogram.
if l>max_results_number then begin closefile(h); ioresult;showmessage('Fatal error 10! Too many results.'); exit end;
 end;
for ii4:=L to max_results_number do result_type[1,ii4]:=result_type[1,L-1];
while (s<>'') and(s[1]=' ') do delete(s,1,1);

if s='' then begin
number_of_results[1]:=l-1; number_of_results[2]:=l-1; for i:=1 to max_results_number do result_type[2,i]:=result_type[1,i] end
else
begin number_of_results[1]:=l-1; l:=1; while (s<>'') do begin if s[1]<>' ' then begin
result_type[2,l]:=s[1]; l:=l+1;
if l>max_results_number then begin closefile(h); ioresult;showmessage('Fatal error 11!'); exit end;
end;s:=copy(s,2,200)
end;
number_of_results[2]:=l-1;
for ii4:=L to max_results_number do result_type[2,ii4]:=result_type[2,L-1];
end;

//showmessage(result_type[1,1]+result_type[1,2]+result_type[1,3]+result_type[1,4]+result_type[1,5]+result_type[1,6]);
//showmessage(result_type[2,1]+result_type[2,2]+result_type[2,3]+result_type[2,4]+result_type[2,5]+result_type[2,6]);

b:=true;
for i:=1 to number_of_results[1] do b:=b and(result_type[1,i]in ['s','i','r','c','b']);
for i:=1 to number_of_results[2] do b:=b and(result_type[2,i]in ['s','i','r','c','b']);
//showmessage(inttostr(number_of_results[1])+' '+inttostr(number_of_results[2])+' '+inttostr(byte(b)));
if not b  then begin closefile(h); ioresult;if en_rus then showmessage('Fatal error 4! Wrong type of data. Types s i r c b are allowed only.')else showmessage('Неверный тип данных. Допустимы только s i r c b.'); exit end;
readlnf(h,s);//Information about the current task - the second line - eight constants or 'N' if no constants are needed; can be the main program text (two lines, the first one begins with the word 'Text'
//if the algorithm must be presented as a procedure or a function
if (s='')or(s[1]=' ')then begin closefile(h); ioresult; showmessage('Fatal error 6!'); exit end;
for i:=1 to 4 do begin consts[i,1]:=0; consts[i,2]:=0 end;
while(s[length(s)]=' ')do s:=copy(s,1,length(s)-1);

if program_sub then if (copy(s,1,4)<>'Text')and (copy(s,1,4)<>'text')
then begin if en_rus then showmessage('Error. No program text was found after the first line.')else showmessage('Ошибкa. Не найден текст программы после первой строки.'); exit end;
if ((copy(s,1,4)='Text')or (copy(s,1,4)='text'))and((func_proc0>0)or program_sub) then begin
text_before:=copy(s,5,length(s)); delete_blanks(text_before); setvarparam(text_before);
readlnf(h,text_after);delete_blanks(text_after);
text_before0:=text_before;text_after0:=text_after;
if (text_after='')or(copy(text_after,length(text_after)-3,4)<>'end.') then begin
if en_rus then showmessage('Error in line '''+text_after+'''. It must end with ''end.''') else
showmessage('Oшибка в строке '+text_after+'; oна должна заканчиваться символами ''end.''');exit end;

p3:=pos('<name>',text_after); if (p3=0)then begin if en_rus then showmessage('Error in line '''+text_after+'''. No strings ''<name>'' were found. The string ''<name>'' must be present in the text; it is replaced by the function/procedure name.') else
showmessage('Ошибка в строке '+text_after+'. Не найденa пoдстрока ''<name>''. Такая подстрока должна присутствовать в тексте; она заменяется на имя процедуры/функции.'); exit end;

if text_after='' then begin
if en_rus then showmessage('Error. A part of the program to be inserted after the function/procedure is empty.')
else showmessage('Ошибкa. Часть программы, которая должна быть вставлена после процедуры/функции, является пустой.');exit end;
readlnf(h,s) end;

//showmessage(s);
delete_blanks(s);
if s[1]<>'N' then for i:=1 to 8 do begin p:=pos(' ',s);
if (i<8)and(p=0)or(i=8)and(p>0)then begin closefile(h); ioresult; showmessage('Fatal error 8! The line '''+s+''' must contain 8 constants or the capital letter N only if no constants are needed.'); exit end;
if p=0 then val(s,j,q) else val(copy(s,1,p-1),j,q); if p<>0 then s:=copy(s,p+1,200);
if q<>0 then begin closefile(h); ioresult; if en_rus then showmessage('Fatal error 9! The line '''+s+''' must contain 8 constants or the capital letter N only if no constants are needed.')
else showmessage('Fatal error 9! Строка '''+s+''' должна содержать 8 констант или заглавную букву N, если константы не нужны.')

; exit end;
consts[(i+1) div 2,2-i mod 2]:=j; if p=0 then break; end;
//showmessage(inttostr(consts[1]));
closefile(g);ioresult;closefile(f);ioresult;
s1:=getcurrentdir;

//showmessage(inttostr(k));
for ii2i:=1 to 1+byte(program_sub) do begin
if ii2i=1 then k:=number_of_tests else k:=number_of_subtests;
for i:=1 to k do begin
if ii2i=1 then assign(g,s1+'\tmp\iii'+inttostr(i))else assign(g,s1+'\tmp\iiii'+inttostr(i)); rewrite(g); readlnf(h,s7);ioresult;
j:=pos(';',s7);if j>0 then s7:=copy(s7,1,j-1);
//if (copy(chosen_task,1,4)='8_44') then begin
//kk:=pos(' ',s7); if kk>0 then begin writeln(g, copy(s7,1, kk-1)); writeln(g,copy(s7, kk+1,100)) end
//else writeln(g,s7);
//end
//else
repeat j:=pos(' \n', s7);
if j=0 then begin writeln(g,s7);break end else begin writeln(g,copy(s7,1,j-1)); delete(s7,1,j+2) end;
until j=0;
closefile(g);
if ii2i=1 then assign(g,s1+'\tmp\ooo'+inttostr(i))else assign(g,s1+'\tmp\oooo'+inttostr(i)); rewrite(g); readlnf(h,s7);ioresult;
j:=pos(';',s7);if j>0 then s7:=copy(s7,1,j-1); writeln(g,s7); closefile(g);
end; //of for from 1 to number of tests or subtests}
end; //of for from 1 to 1+byte(program+sub)
//A special random test for the task 4.12a
if chosen_task='4_12-001'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx14:=random(30)/10+3;
xx15:=-abs(xx14-1)/2/xx14;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx14:1:10);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, xx15:1:10); closefile(g);
end;
k:=number_of_tests;
//A special random test for the task 4.12-003
if chosen_task='4_12-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx14:=random(30)/10+3;
xx15:=random(30)/10+3;
xx16:=random(30)/10+3;
xx17:=xx14*2-0.1;
xx18:=xx15*2;
xx19:=xx16*2+2+random(10)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx14:1:5, '  ', xx15:1:5,'  ',xx16:1:5,'  ',xx17:1:5,'  ',xx18:1:5,'  ',xx19:1:5,' ');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, (xx16*xx18-xx19*xx15)/(xx14*xx18-xx17*xx15):1:10,'  ',(xx14*xx19-xx17*xx16)/(xx14*xx18-xx17*xx15):1:10); closefile(g);
end;
//A special random test for the task 4.12-006
if chosen_task='4_12-006'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx14:=random(30)/10+3;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx14:1:5,'  ',xx14-0.01:1:5,'  ',xx14+0.04:1:5  );closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, 1); closefile(g);
end;

//A random test for the task 4.12-007
if chosen_task='4_12-007'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random (10)+3;
xx22:=random (20)+3;
xx23:=random (20)+3;
xx24:=random(12)+4;
xx25:=random(12)+4;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx21,'  ',xx22,'  ',xx23,' ',xx24*60+xx25);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, xx21,' ', xx22+xx24,' ', xx23+xx25);
end;

//4 random tests for the task 4.12-009
if chosen_task='4_12-009'then begin
number_of_tests:=number_of_tests+4;
k:=k+4;randomize;
xx21:=(random (25)+25)*2+1;
xx22:=(xx21*xx21+7)div 8;
assign(g,s1+'\tmp\iii'+inttostr(k-3)); rewrite(g);writeln(g, xx22);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k-3)); rewrite(g); writeln(g, 1);closefile(g);
assign(g,s1+'\tmp\iii'+inttostr(k-2)); rewrite(g);writeln(g, 2+xx22);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k-2)); rewrite(g); writeln(g, 0);closefile(g);
assign(g,s1+'\tmp\iii'+inttostr(k-1)); rewrite(g);writeln(g, xx22-2);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k-1)); rewrite(g); writeln(g, 0);closefile(g);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g,((xx21+2)*(xx21+2)+7)div 8);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, 1);closefile(g);
end;

{A special random test for tasks 5.20...}
if copy(chosen_task,1,4)='5_20' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx:=(random(100)+20)/130;
if (chosen_task[6]='б')or(copy(chosen_task,6,3)='002') then yy:=(exp(xx)-exp(-xx))/2;
if (chosen_task[6]='в')or(copy(chosen_task,6,3)='003') then yy:=cos(xx);
if (chosen_task[6]='г')or(copy(chosen_task,6,3)='004') then yy:=ln(1+xx);
if (chosen_task[6]='д')or(copy(chosen_task,6,3)='005') then yy:=arctan(xx);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx:1:10);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, yy:1:10); closefile(g);
end;

{A randon testr for the task 5.52}
if chosen_task='5_52' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx21:=random(5)+4; xx22:=xx21+random(3)+1; xx23:=-random(5)-4;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, 1,' ',xx21+xx22+xx23,' ',xx21*xx22+(xx21+xx22)*xx23,' ',xx21*xx22*xx23);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, -xx22:1,' ',-xx21:1,' ',-xx23:1); closefile(g);
end;


{A special random test for the task 8.29в}
if chosen_task='8_29_в' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx1:1:1,' ',xx2:1:1);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, xx2:1:1,' ',xx1:1:1); closefile(g);
end;

{A special random test for the task 8.29д}
if chosen_task='8_29_д' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=(random(100)+20)/10; yy1:=(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx1:1:1,' ',xx2:1:1, ' ',yy1:1:1);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g); writeln(g, yy1:1:1, ' ', xx1:1:1,' ',xx2:1:1); closefile(g);
end;

{A special random test for the task 8.29е}
if chosen_task='8_29_е' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=(random(100)+20)/10; yy1:=(random(100)+20)/10;
xx:=(random(100)+20)/10; yy:=(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx1:1:1,' ',xx2:1:1, ' ',yy1:1:1, ' ',xx:1:1,' ',yy:1:1);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g, yy1:1:1, ' ', xx:1:1,' ',yy:1:1,' ',xx1:1:1,' ',xx2:1:1); closefile(g);
end;

{A special random test for the task 8.29ж}
if chosen_task='8_29_ж' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=(random(100)+20)/10; yy1:=(random(100)+20)/10;
xx:=(random(100)+20)/10; yy:=(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, '0 ', xx1:1:1,' 0 0 ',xx2:1:1, ' 0 ',yy1:1:1, ' ',xx:1:1,' ',yy:1:1);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g, xx1:1:1,' ',xx2:1:1, ' ',yy1:1:1, ' ',xx:1:1,' ',yy:1:1,' 0 0 0 0');
closefile(g);
end;

{A special random test for the task 8.30a}
if chosen_task='8_30_а' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=-(random(100)+20)/10; yy1:=(random(100)+20)/10;
xx:=(random(100)+20)/10; yy:=-(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);writeln(g, xx1:1:1,' 0 ',xx2:1:1, ' 0 ',yy1:1:1, ' ',xx:1:1,' ',yy:1:1);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g, xx2:1:1,' ', yy:1:1, ' ', xx1:1:1,' 0 0 ',yy1:1:1, ' ',xx:1:1);
closefile(g);
end;

{A special random test for the task 8.32}
if chosen_task='8_32' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20)/10;xx2:=xx1+(random(100)+20)/10; yy1:=xx2+(random(100)+20)/10;
yy2:=yy1+(random(100)+20)/10;xx:=yy2+(random(100)+20)/10;yy:=xx+(random(100)+20)/10;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
writeln(g, xx1:1:1,' ',xx2:1:1, ' ',yy1:1:1, ' ', yy2:1:1, ' ',xx:1:1,' ',yy:1:1,' ',
-xx1-xx2:1:1, ' ',xx+yy:1:1);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g, '6');
closefile(g);
end;

{A special random test for the task 8.35}
if chosen_task='8_35' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=(random(100)+20);xx2:=xx1+(random(100)+20); yy1:=xx2+(random(100)+20);
yy2:=yy1+(random(100)+20);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
if random(100)<50 then begin xx:=0;
writeln(g, xx1:1:0,' ',xx2:1:0, ' ',yy1:1:0, ' ', xx2:1:0, ' ',yy1:1:0,' ',yy2:1:0)
end else begin xx:=-1;
writeln(g, yy1:1:0,' ',xx2:1:0, ' ',yy1:1:0, ' ', xx2+3:1:0, ' ',xx1:1:0,' ',yy2:1:0);end;
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx=0 then writeln(g, '4')else writeln(g,'5');
closefile(g);
end;

{A special random test for the task 9.5-005}
if chosen_task='9_5-005' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize; xx1:=random(100)+20;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
if random(100)<50 then begin xx:=0;
writeln(g, xx1:1:0,' ',xx1+1:1:0, ' ',xx1+2:1:0, ' ', xx1+3:1:0, ' ',xx1+4:1:0,' ',xx1+5:1:0,' ',
xx1+7:1:0,' ',xx1+9:1:0, ' ',xx1+12:1:0, ' ', xx1+13:1:0, ' ',xx1+14:1:0,' ',xx1+17:1:0,' ',
xx1-3:1:0, ' ',xx1+11:1:0,' ', xx1+19:1:0, ' ', xx1+18:1:0);
end else begin xx:=-1;
writeln(g, xx1:1:0,' ',xx1+21:1:0, ' ',xx1+2:1:0, ' ', xx1+3:1:0, ' ',xx1-5:1:0,' ',xx1+5:1:0,' ',
xx1+7:1:0,' ',xx1+9:1:0, ' ',xx1+12:1:0, ' ', xx1+13:1:0, ' ',xx1+14:1:0,' ',xx1+17:1:0, ' ',
xx1-3:1:0, ' ',xx1+11:1:0,' ', xx1+19:1:0, ' ', xx1+18:1:0);end;
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx=0 then
writeln(g, xx1:1:0,' ',xx1+1:1:0, ' ',xx1+2:1:0, ' ', xx1+3:1:0, ' ',xx1+4:1:0,' ',xx1+5:1:0,' ',
xx1+7:1:0,' ',xx1+9:1:0, ' ',xx1+12:1:0, ' ', xx1+13:1:0, ' ',xx1+14:1:0,' ',xx1+17:1:0,    ' ',
xx1+19:1:0, ' ',xx1+11:1:0,' ', xx1-3:1:0, ' ', xx1+18:1:0)else
writeln(g, xx1:1:0,' ',xx1-5:1:0, ' ',xx1+2:1:0, ' ', xx1+3:1:0, ' ',xx1+21:1:0,' ',xx1+5:1:0,' ',
xx1+7:1:0,' ',xx1+9:1:0, ' ',xx1+12:1:0, ' ', xx1+13:1:0, ' ',xx1+14:1:0,' ',xx1+17:1:0,     ' ',
xx1-3:1:0, ' ',xx1+11:1:0,' ', xx1+19:1:0, ' ', xx1+18:1:0);
closefile(g);
end;

{A special random test for the tasks 9.17}
if copy(chosen_task,1,4)='9_17' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize;
xx1:=random(100)+20;xx2:=random (100)+35;
xx3:=random(100)+20;xx4:=random (100)+35;
xx5:=random(100)+20;xx6:=random (100)+35;
xx7:=random(100)+20;xx8:=random (100)+35;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
writeln(g, xx1,' ', xx2,' ', xx3,' ', xx4, ' ', xx5,' ', xx6,' ',xx7,' ',xx8,' ',xx3-0.1);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if chosen_task='9_17-002' then write(g,xx1+xx3+xx5+xx7+xx3-0.1:1:3);
if chosen_task='9_17-003' then write(g,xx1+xx2+xx3+xx5+xx7+xx8+xx3-0.1:1:3);
if chosen_task='9_17-004' then write(g,xx2+xx4+xx5+xx6+xx8:1:3);

closefile(g);
end;

{A special random test for the tasks 9.18-003 and 004}
if (chosen_task='9_18-003') or (chosen_task='9_18-004') then begin
number_of_tests:=number_of_tests+1;
k:=k+1;
randomize;
if chosen_task='9_18-003' then begin
xx1:=random(400)+20;xx3:=random(400)+20;xx2:=random(400)+20;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx1:1:0,' ', xx1+10:1:0,' ', xx1+34:1:0,' ', xx1+10:1:0,' ', xx1:1:0,' ');
write(g, xx2:1:0,' ', xx2:1:0,' ', xx2+1:1:0,' ', xx2:1:0,' ', xx2:1:0,' ');
write(g, xx3:1:0,' ', xx3+1:1:0,' ', xx3:1:0,' ', xx3+1:1:0,' ', xx3:1:0,' ');
xx1:=random(400)+20;xx3:=random(400)+20;xx2:=random(400)+20;
write(g, xx1:1:0,' ', xx1+1:1:0,' ', xx1+1:1:0,' ', xx1:1:0,' ', xx1:1:0,' ');
write(g, xx2:1:0,' ', xx2:1:0,' ', xx2+1:1:0,' ', xx2+1:1:0,' ', xx2:1:0,' ');
writeln(g, xx3:1:0,' ', -xx3:1:0,' ', xx3:1:0,' ', -xx3:1:0,' ', -xx3:1:0);
closefile(g);
end;

if chosen_task='9_18-004' then begin
xx1:=random(400)+20;xx3:=random(400)+20;xx2:=random(400)+20;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx1:1:0,' ', xx1+1:1:0,' ', xx1+2:1:0,' ', -xx1:1:0,' ', -xx1*2:1:0,' ');
write(g, xx2:1:0,' ', xx2-1:1:0,' ', xx2+1:1:0,' ', xx2-1:1:0,' ', -xx2:1:0,' ');
write(g, xx3:1:0,' ', xx3+1:1:0,' ', xx3:1:0,' ', xx3+1:1:0,' ', xx3:1:0,' ');
xx1:=random(400)+20;xx3:=random(400)+20;xx2:=random(400)+20;
write(g, xx1*2:1:0,' ', xx1+1:1:0,' ', xx1-1:1:0,' ', xx1:1:0,' ', xx1*2:1:0,' ');
write(g, xx2-2:1:0,' ', xx2-20:1:0,' ', xx2-32:1:0,' ', xx2+1:1:0,' ', xx2+1:1:0,' ');
writeln(g, xx3:1:0,' ', xx3:1:0,' ', xx3-1:1:0,' ', xx3-22:1:0,' ', xx3-24:1:0);
closefile(g);
end;
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if chosen_task='9_18-003' then write(g,'true true true false false false');
if chosen_task='9_18-004' then write(g,'false true true true true true');
closefile(g);
end;

{Special random tests for the tasks 9.19- 1 -3 }
if chosen_task='9_19-001'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx1:=random(100)-55; xx2:=random(100)-54;
xx3:=random(100)-55; xx4:=random(100)-54;
xx5:=random(100)-55; xx6:=random(100)-44;
xx7:=random(100)-45; xx8:=random(100)-44;
xx9:=random(100)-35; xx10:=random(100)-44;
xx11:=random(100)-55; xx12:=random(100)-44;
xx13:=0;
if (xx1>xx5+xx9)then inc (xx13);
if (xx5>xx1+xx9) then inc (xx13);
if (xx9>xx1+xx5)then inc (xx13);
if (xx2>xx6+xx10)then inc (xx13);
if (xx6>xx2+xx10)then inc (xx13);
if (xx10>xx2+xx6)then inc (xx13);
if (xx3>xx7+xx11)then inc (xx13);
if (xx7>xx3+xx11)then inc (xx13);
if (xx11>xx3+xx7)then inc (xx13);
if (xx4>xx8+xx12)then inc (xx13);
if (xx8>xx4+xx12)then inc (xx13);
if (xx12>xx4+xx8)then inc (xx13);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx1:1:0,' ', xx2:1:0,' ', xx3:1:0,' ', xx4:1:0,' ', xx5:1:0,' ', xx6:1:0,'  ');
writeln(g, xx7:1:0,' ', xx8:1:0,' ', xx9:1:0,' ', xx10:1:0,' ', xx11:1:0,' ', xx12:1:0);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g, xx13);
closefile(g);
end;

if chosen_task='9_19-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx1:=random(100)+25; xx2:=random(100)+24;
xx3:=random(100)+25; xx4:=random(100)+24;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx1:1:0,' ', xx1-1:1:0,' ', xx1+1:1:0,' ', xx1+12:1:0,' ', xx1+15:1:0,' ');
write(g, xx2-11:1:0,' ', xx2-9:1:0,' ', xx2+1:1:0,' ', xx2:1:0,' ', xx2+15:1:0,' ');
if xx3>xx4 then
writeln(g, xx3:1:0,' ', xx4:1:0,' ', xx3:1:0,' ', xx4:1:0,' ', xx3+xx4:1:0)
else
writeln(g, -xx3-1:1:0,' ', -xx3:1:0,' ', xx3:1:0,' ', xx4:1:0,' ', xx3:1:0);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx3>xx4 then writeln(g, '7')else writeln(g,'8');
closefile(g);
end;

if chosen_task='9_19-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx2:=random(100);
xx1:=random(100)+25;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
if xx2<50 then begin
write(g, xx1:1:0,' ', xx1+1:1:0,' ', xx1+1:1:0,' ', xx1+2:1:0,' ');
write(g, xx1+1:1:0,' ',xx1+1:1:0,' ',xx1+2:1:0,' ', xx1+1:1:0,'  ');
writeln(g, xx1:1:0,' ', xx1+10:1:0,' ', xx1:1:0,' ', xx1+15:1:0);
end
else
begin
write(g, xx1:1:0,' ', xx1+1:1:0,' ', xx1+1:1:0,' ', xx1+2:1:0,' ');
write(g, xx1+1:1:0,' ',xx1:1:0,' ',xx1+2:1:0,' ', xx1+1:1:0,' ');
writeln(g, xx1:1:0,' ', xx1+10:1:0,' ', xx1:1:0,' ', xx1+15:1:0);
end;
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx2<50 then writeln(g, '4')else writeln(g, '5');
closefile(g);
end;

{A special random test for the task 9.25}
if chosen_task='9_25'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx1:=random(1000)-250;
xx2:=random(1000)-250;
xx3:=random(1000)-250;
xx4:=random(1000)-250;
xx5:=random(1000)-250;
xx6:=random(1000)-250;
xx7:=random(1000)-250;
xx8:=random(1000)-250;
xx9:=random(1000)-250;
xx10:=random(1000)-250;
xx11:=random(1000)-250;
xx12:=random(1000)-250;
xx13:=random(1000)-250;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx1:1:0, ' ', xx2:1:0, ' ', xx3:1:0, ' ',xx4:1:0,' ', xx5:1:0,' ');
write(g, xx6+1:1:0, ' ', xx7:1:0, ' ', xx8:1:0, ' ',xx9:1:0,' ', xx10:1:0,' ');
write(g, xx11:1:0, ' ', xx12:1:0, ' ', -xx1:1:0, ' ',-xx2:1:0,' ', -xx3:1:0,' ');
write(g, -xx4:1:0, ' ', -xx5-1:1:0, ' ', -xx6+1:1:0, ' ',-xx7:1:0,' ', -xx8:1:0,' ');
writeln(g, -xx9-1:1:0, ' ', -xx10:1:0, ' ', -xx11:1:0, ' ',-xx12:1:0,' ', xx13:1,' ');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g, xx5:1:0, ' ', xx10:1:0, ' ', -xx3:1:0, ' ',-xx8:1:0,' ', xx13:1,' ');
write(g, xx4:1:0, ' ', xx9:1:0, ' ', -xx2:1:0, ' ',-xx7:1:0,' ', -xx12:1:0,' ');
write(g, xx3:1:0, ' ', xx8:1:0, ' ', -xx1:1:0, ' ',-xx6+1:1:0,' ', -xx11:1:0,' ');
write(g, xx2:1:0, ' ', xx7:1:0, ' ', xx12:1:0, ' ',-xx5-1:1:0,' ', -xx10:1:0,' ');
writeln(g, xx1:1:0, ' ', xx6+1:1:0, ' ', xx11:1:0, ' ',-xx4:1:0,' ', -xx9-1:1:0,' ');

closefile(g);
end;
{A special random test for the task 11.22-003}
if chosen_task='11_22-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=random(10)/10+5;
xx32:=random(10)/10+5;
xx33:=random(10)/10+5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:8, ' ', xx32:1:8, ' ', xx33:1:8, ' ');
closefile(g);
xx34:=0.5*sqrt(2*xx31*xx31+2*xx32*xx32-xx33*xx33);
xx35:=0.5*sqrt(2*xx31*xx31+2*xx33*xx33-xx32*xx32);
xx36:=0.5*sqrt(2*xx32*xx32+2*xx33*xx33-xx31*xx31);
xx31:=0.5*sqrt(2*xx34*xx34+2*xx35*xx35-xx36*xx36);
xx32:=0.5*sqrt(2*xx34*xx34+2*xx36*xx36-xx35*xx35);
xx33:=0.5*sqrt(2*xx35*xx35+2*xx36*xx36-xx34*xx34);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx31>xx32 then begin xx34:=xx31; xx31:=xx32; xx32:=xx34;end;
if xx32>xx33 then begin xx34:=xx32; xx32:=xx33; xx33:=xx34;end;
if xx31>xx32 then begin xx34:=xx31; xx31:=xx32; xx32:=xx34;end;
write(g, xx31:1:8, ' ', xx32:1:8, ' ', xx33:1:8, ' ');
closefile(g);
end;
{A special random test for the task 11.24}
if chosen_task='11_24'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(10)+5;
xx22:=random(10)+5;
xx23:=random(10)+5;
xx24:=random(10)+5;
xx25:=random(10)+5;
xx26:=random(10)+5;
xx27:=random(10)+5;
xx28:=random(10)+5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21:1, ' ', xx22:1, ' ', xx23:1, ' ',xx24:1, ' ', xx25:1, ' ', xx26:1, ' ',xx27:1, ' ', xx28:1,
' ', 12+xx24 div 7, xx21+xx22:1,' ',25-xx25 div 10,' ', 45+xx26 div 3,' ', xx23 div 5+122,' ', 766+xx21 div 2,' ',-135+xx21,' ',-201+xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g, xx21*xx21+xx22*xx22+xx23*xx23+xx24*xx24+xx25*xx25+xx26*xx26+xx27*xx27+xx28*xx28);
closefile(g);
end;

{A special random test for the task 11.29-003}
if chosen_task='11_29-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=random(10)/4+5;
xx32:=random(10)/4+5;
xx33:=random(10)/4+5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:4, ' ', xx31+1:1:4, ' ', xx31-3:1:4, ' ',xx31-4:1:4, ' ',
xx32+4:1:4, ' ', xx32+1:1:4, ' ', xx32-3:1:4, ' ',xx32-52:1:4, ' ',
xx33:1:4, ' ', xx33+1:1:4, ' ', xx33+3:1:4, ' ',xx33*2:1:4, ' ');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g, (xx31+1)*(xx33*4)+sqr(xx32+4):1:4);
closefile(g);
end;

{A spacial random test for the task 11.29-004}
if chosen_task='11_29-004'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(10)+5;
xx22:=random(10)+5;
xx23:=random(10)+5;
xx24:=random(10)+5;
xx25:=random(10)+5;
xx26:=random(10)+5;
xx27:=random(10)+5;
xx28:=random(2)+1;if (xx28<1)or(xx28>2)then xx28:=2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21, ' ', xx22, ' ', xx23,' ',  xx24, ' ',xx25, ' ', xx26, ' ', xx27, ' ',xx26+xx25, ' ',xx21+xx28,' ',xx28,' ', xx23+xx28,' ', xx24+xx25,' ', xx28);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx28=1 then
write(g, xx22, ' ', xx23,' ',  xx24, ' ',xx25, ' ', xx26, ' ', xx27, ' ',xx26+xx25, ' ',xx21+xx28,' ',xx28,' ', xx23+xx28,' ', xx24+xx25,' ',xx21)
else
write(g, xx23,' ',  xx24, ' ',xx25, ' ', xx26, ' ', xx27, ' ',xx26+xx25, ' ',xx21+xx28,' ',xx28,' ', xx23+xx28,' ', xx24+xx25,' ',xx21,' ', xx22);
closefile(g);
end;

{A special random test for the task 11.29-005}
if chosen_task='11_29-005'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=(random(100)+1)/4;
xx32:=(random(100)+1)/4;
xx33:=-(random(100)+1)/4;
xx34:=(random(100)+1)/4;
xx35:=-(random(100)+1)/4;
xx36:=(random(100)+1)/4;
xx21:=random(10)+50;
if xx21 mod 2=1 then xx36:=-xx36;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:4, ' ', xx32:1:4, ' ', xx33:1:4,' ',  xx34:1:4, ' ',xx35:1:4, ' ', xx36:1:4 );
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx36<0 then
write(g, xx33:1:4, ' ', xx35:1:4, ' ',xx36:1:4,' ', xx31:1:4, ' ',xx32:1:4, ' ', xx34:1:4, ' ')else
write(g, xx33:1:4, ' ', xx35:1:4, ' ', xx31:1:4, ' ',xx32:1:4, ' ', xx34:1:4, ' ',xx36:1:4);
closefile(g);
end;

{A special random test for the task 11.61}
if chosen_task='11_61'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=(random(8)-4)/2;xx32:=(random(10)-5)/2;xx33:=(random(10)-5)/2;xx34:=(random(10)-5)/2;xx35:=(random(10)-5)/2;xx36:=(random(10)-5)/2;
if xx31=0 then xx31:=0.5;if xx32=0 then xx32:=-0.5;
if xx33=0 then xx33:=-0.5;if xx34=0 then xx34:=-0.5;
if xx35=0 then xx35:=0.5;if xx36=0 then xx36:=-0.5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:1, ' 0 0 ', xx32:1:1, ' ', xx33:1:1, ' 0 0  ',xx34:1:1, ' ', xx35:1:1, ' 0 0 ', xx36:1:1,' 3');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g, sqr(xx31*xx33*xx35)*(xx31*xx33*xx35):1:9, ' 0 0 ', (xx32*xx34*xx36)*sqr(xx32*xx34*xx36):1:9);
closefile(g);
end;
{A special random test for the task 11.62}
if chosen_task='11_62'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=-random(20)-2;xx32:=random(20)+2;xx34:=-random(20)-2;xx33:=random(20)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,' 0 ',xx31:1:1, ' 0 0 0 0 0 0 0 0 0 0 ','0 0 0 0 0 0 0 0 0 0 ', xx32:1:1, ' 0  ',' 0 ',xx33:1:1, ' 0 0 0 0 ',xx34:1:1, ' 0 0 0 0 0 ');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
xx35:=xx32;
if abs(xx32)>abs(xx34)then xx32:=abs(xx32)else xx32:=abs(xx34);
write(g, (abs(xx31)+abs(xx35)+abs(xx33)+abs(xx34))/(abs(xx31+xx33)+xx32):1:9);
closefile(g);
end;
{A special random test for the task 12.5}
if chosen_task='12_5'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=random(20) /10+0.3;
xx21:=random(10);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:9,' ',2+xx21 mod 2);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21 mod 2=0 then xx31:=cos(cos(xx31))else xx31:=cos(cos(cos(xx31)));
write(g,xx31:1:9);
closefile(g);
end;
{A special random test for the task 12.7}
if chosen_task='12_7'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=random(20) /10+0.3;
xx21:=random(4)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx31:1:9,' ',xx21 mod 2+3);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21 mod 2=1 then xx31:=xx31*xx31*xx31*xx31/24 else xx31:=xx31*xx31*xx31/6;
write(g,xx31:1:9);
closefile(g);
end;
{A special random test for the task 12.12-1}
if chosen_task='12_12-001'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+80;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21<100 then writeln(g,2)else writeln(g,3);
closefile(g);
end;
{A special random test for the task 12.12-2}
if chosen_task='12_12-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+80;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21>=100 then writeln(g,1)else writeln(g,xx21 div 10);
closefile(g);
end;
{A special random test for the task 12.12-3}
if chosen_task='12_12-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+50;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21 mod 10>xx21 div 10 then writeln(g,xx21 mod 10)else writeln(g,xx21 div 10);
closefile(g);
end;
{A special random test for the task 12.12-4}
if chosen_task='12_12-004'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+50;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if (xx21 mod 10=5)or(xx21 div 10=5) then writeln(g,'true')else writeln(g,'false');
closefile(g);
end;
{A special random test for the task 12.12-5}
if chosen_task='12_12-005'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+50;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if (xx21 mod 10<>8)and(xx21 div 10<>8) then writeln(g,0)else if (xx21 mod 10=8)and(xx21 div 10=8)then writeln(g,2)else writeln(g,1);
closefile(g);
end;

{A special random test for the task 12.12-7}
if chosen_task='12_12-007'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(200)-100;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
writeln(g,xx21);
closefile(g);
end;

{A special random test for the task 12.12-8}
if chosen_task='12_12-008'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(200)+11;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21<100 then writeln(g,xx21 div 10)else writeln(g,xx21 div 100+xx21 mod 10);
closefile(g);
end;


{A special random test for the task 12.14}
if chosen_task='12_14'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(40)+5;xx22:=random(40)+5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21,' ',-xx21,' ', xx21 div 2, ' ', xx21*2, ' ', xx22,' ', -xx22,' ', xx22*3,' ',xx22*2,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21*2>xx22*3 then writeln(g,2*xx21)else writeln(g,xx22*3);
closefile(g);
end;

{A special random test for the task 12.17}
if chosen_task='12_17'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx25:=random(20)-10; if xx25=0 then xx25:=1; xx21:=random(40)+5;xx22:=random(40)+5;xx23:=random(40)+5;xx24:=random(40)+5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx25,' ',xx21,' ',-xx22,' ',xx23, ' ', -xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx25>0 then
write(g, -xx22,' ',-xx24,' ',xx23, ' ', xx21,' ', xx25)
else
write(g, xx25, ' ', -xx22,' ',-xx24,' ',xx23, ' ', xx21);
closefile(g);
end;

{A special random test for the task 12.hometask1}
if chosen_task='12_hometask1'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(6)+1; xx22:=random(6)+1;
xx23:=random(6)+1; xx24:=random(6)+1;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21*10+xx22,' ',xx23*10+xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21+xx22>=xx23+xx24 then
write(g, xx21*10+xx22)
else
write(g, xx23*10+xx24);
closefile(g);
end;

{A special random test for the task 12.hometask3}
if chosen_task='12_hometask3'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(3)+2; xx22:=random(3)+2;
xx23:=random(4)+2; xx24:=random(4)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21*10+xx22,' ',xx23*10+xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if (xx21<>xx22)and(xx23<>xx24)then
write(g, 2)
else if (xx21=xx22)and(xx23=xx24)then write(g,0) else write(g,1);
closefile(g);
end;

{A special random test for the task 12.hometask4}
if chosen_task='12_hometask4'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(3)+2; xx22:=random(3)+2;
xx23:=random(4)+2; xx24:=random(4)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21*10+xx21+xx22*100,' ', xx23*10+xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if (xx21<>xx22)and(xx23<>xx24)then
write(g, 0)
else if (xx21=xx22)and(xx23=xx24)then write(g,2) else write(g,1);
closefile(g);
end;

{A special random test for the task 12.hometask5}
if chosen_task='12_hometask5'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(4)+2; xx22:=random(4)+2;
xx23:=random(4)+2; xx24:=random(4)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21*10+xx22,' ', xx23*10+xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21*xx22>=xx23*xx24 then
write(g, xx21*10+xx22)
else write(g,xx23*10+xx24);
closefile(g);
end;

{A special random test for the task 12.hometask6}
if chosen_task='12_hometask6'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(7)+2; xx22:=random(7)+2;
xx23:=random(7)+2; xx24:=random(7)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21*10+xx22,' ', xx23*10+xx24,' 0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
xx25:=0;
if xx21 mod 2<>xx22 mod 2 then inc(xx25);
if xx23 mod 2<>xx24 mod 2 then inc(xx25);
write(g, xx25);
closefile(g);
end;
//A special random test for the task 13.12-2
if chosen_task='13_12-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(17)+2; xx22:=random(17)+2;
xx23:=random(17)+2; xx24:=random(17)+2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21,' ', xx22,' ',xx23,' ',xx24);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g, xx21*xx24+xx22*xx23,' ', xx22*xx24);
closefile(g);
end;
//A special random test for the task 13.12-3
if chosen_task='13_12-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(17)+2; xx22:=random(17)+2;
xx23:=random(17)+2; xx24:=random(17)+2;if xx21/xx22 = xx23/xx24 then inc(xx24);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, xx21,' ', xx22,' ',xx23,' ',xx24);
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21/xx22>xx23/xx24 then write(g, xx21, ' ',xx22) else write(g, xx23, ' ',xx24) ;
closefile(g);
end;

//A special random test for the task 14.15-2
if chosen_task='14_15-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(17)+98; xx22:=random(17)+98;//if xx21=xx22 then inc(xx22);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g, chr(xx21),chr(xx22),'.');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21>xx22 then write(g, chr(xx22),chr(xx21)) else if xx21=xx22 then write(g, chr(xx22)) else write(g, chr(xx21),chr(xx22));
closefile(g);
end;

//A special random test for the task 14.16
if chosen_task='14_16'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx31:=random(17)/2;xx32:=random(17)/2;xx33:=random(17)/2;xx34:=random(17)/2;xx35:=random(17)/2;xx36:=random(17)/2;xx37:=random(17)/2;xx38:=random(17)/2;xx35:=random(17)/2;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,xx31:1:2,' ',xx32:1:2,' ',xx33:1:2,' ',xx34:1:2,' ',xx35:1:2, ' ', xx36:1:2,' ',xx37:1:2,' ',xx38:1:2,' ',xx39:1:2,' ');
xx21:=random(3)+1; if not xx21 in [1..3] then xx21:=1; write(g,'1 2 3 0 ',xx21,'  0');
closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21=1 then write(g, xx31+xx34+xx37:1:7);if xx21=2 then write(g, xx32+xx35+xx38:1:7);if xx21=3 then write(g, xx33+xx36+xx39:1:7);
closefile(g);
end;

//A special random test for the task 14.26-002
if chosen_task='14_26-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(7)+1; if not(xx21 in [1..7]) then xx21:=5;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,xx21);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
for xx22:=0 to 9 do if xx21<>xx22 then write(g,xx22,' ');
closefile(g);
end;

//A special random test for the task 14.27-002
if chosen_task='14_27-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(17)+97; if not(xx21 in [97..122]) then xx21:=100;
xx22:=random(17)+97; if not(xx22 in [97..122]) then xx22:=100;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,chr(xx21),chr(xx21),chr(xx22),'.');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);write(g,chr(xx21));
closefile(g);
end;

//A special random test for the task 14.27-003
if chosen_task='14_27-003'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(17)+97; if not(xx21 in [97..122]) then xx21:=100;
xx22:=random(17)+97; if not(xx22 in [97..122]) then xx22:=100;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,chr(xx21),chr(xx22),chr(xx22),'.');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx22<>xx21 then write(g,chr(xx21));
closefile(g);
end;

//A special random test for the task 15.8
if chosen_task='15_8'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(177)+37; xx22:=random(17)+37; xx23:=random(177)+37; xx24:=random(17)+37; if xx23=xx21 then xx23:=xx21+1;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,xx21,' ',xx22,' ',xx23,' ',xx24,' 0 0 ');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21>xx23 then write(g,xx23,' ', xx24,' ')else write(g,xx21,' ',xx22,' ');
closefile(g);
end;

//A special random test for the task 15.9-002
if chosen_task='15_9-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(10)+98; assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,chr(xx21));xx23:=random(5)+3; for xx24:=1 to xx23 do begin xx22:=random(12)+100; write(g,chr(xx22)); end;write(g,'!');
xx22:=random(10)+98; if xx22=xx21 then inc(xx22);
write(g,chr(xx22));xx23:=random(5)+3; for xx24:=1 to xx23 do begin xx25:=random(12)+100; write(g,chr(xx25)); end;write(g,'!');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if xx21>xx22 then write(g,'False')else write(g,'True');  
closefile(g);
end;

//A special random test for the task 15.10-002
if chosen_task='15_10-002'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(10)+98; assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,chr(xx21));write(g,'!');
xx22:=random(10)+98;
write(g,chr(xx22));write(g,'!');
xx23:=random(10)+98;
write(g,chr(xx23));write(g,'!');closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
if (xx21=xx22)or(xx21=xx23) then write(g,'True')else write(g,'False');
closefile(g);
end;

//A special random test for the task 15.11
if chosen_task='15_11'then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(10)-5; assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
write(g,xx21,' ');
xx22:=random(10)+5;xx25:=0;
for xx23:=1 to xx22 do begin xx24:=random(10)-5;
if xx24=xx21 then inc(xx25);
write(g,xx24,' ')end;write(g,-32768); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k)); rewrite(g);
write(g,xx25);
closefile(g);
end;

//A special random test for the tasks 6.17 and 15.12-001
if (chosen_task='15_12-001')or(chosen_task='6_17')then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
xx21:=random(5)+3; assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx24:=0;
for xx22:=1 to xx21 do begin xx23:=random(3)+40;if xx23=40 then inc(xx24);
if xx23=41 then dec(xx24); if xx24<0 then xx24:=-1000;
write(g,chr(xx23))end; write(g,'.'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
if xx24=0 then write(g,'true') else write(g,'false');
closefile(g);
end;

//A special random test for the task 15.12-002
if chosen_task='15_12-002' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(15)+3;
for xx22:=1 to xx21 do write(g,'(');
for xx22:=1 to xx21 do write(g,')');
xx23:=random(15)+3;
for xx22:=1 to xx23 do write(g,'(');
for xx22:=1 to xx23 do write(g,')');
write(g,'.'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
if xx23>xx21 then write(g,xx23) else write(g,xx21);
closefile(g);
end;

//A special random test for the task 15.13-002
if chosen_task='15_13-002' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(15)+3;
xx23:=random(15)+3;
xx22:=random(2);
if xx22=0 then write(g, xx21, ' ', xx23,' ', xx23*2-xx21) else write(g, xx21, ' ', xx23, ' ', xx23*2-xx21-1);
write(g,' -32768'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
if xx22=0 then write(g,'true') else write(g,'false');
closefile(g);
end;

//A special random test for the task 15.13-003
if chosen_task='15_13-003' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(15)+3;
xx22:=random(2);
if xx22=0 then write(g, xx21, ' ', xx21*3,' ', xx21*9) else write(g, xx21, ' ', xx21+1, ' ', xx21+2);
write(g,' -32768'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
if xx22=0 then write(g,'true') else write(g,'false');
closefile(g);
end;


//A special random test for the task 15.14
if chosen_task='15_14' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+204;xx23:=0;
xx26:=1; for xx25:=1 to xx22 do begin xx21:=random(3)+65;write(g,chr(xx21));
if (xx21=66)and(xx26=65) then inc(xx23); xx26:=xx21 end;write(g,'.'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,xx23);
closefile(g);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+204;xx23:=0;
xx26:=1; for xx25:=1 to xx22 do begin xx21:=random(7)+65;write(g,chr(xx21));
if (xx21=66)and(xx26=65) then inc(xx23); xx26:=xx21 end;write(g,'.'); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,xx23);
closefile(g);
end;

//A special random test for the task 15.15
if chosen_task='15_15' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(44)+259;
for xx25:=1 to xx22 do begin xx21:=random(14)+65;write(g,xx21/2:1:1,' ');
if xx25=xx22-1 then xx33:=xx21/2;end; write(g,'-100000 '); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,xx33:1:1);
closefile(g);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+87;
for xx25:=1 to xx22 do begin xx21:=random(24)+65;write(g,xx21/4:1:2,' ');
if xx25=xx22-1 then xx33:=xx21/4;end; write(g,'-100000 '); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,xx33:1:2);
closefile(g);
end;

//A special random test for the task 15.16
if chosen_task='15_16' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+260;
for xx25:=1 to xx22 do write(g,xx25/10:1:2,' '); write(g,' -100000 '); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,xx22);
closefile(g);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+260; xx23:=random(14)+260;
write(g, xx22/2:1:2,' '); write(g,xx23/2:1:2); write(g,' -100000 '); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);if xx22<xx23 then write(g,2)else write(g,1);
closefile(g);
end;

//A special random test for the task 15.22
if chosen_task='15_22' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g1,s1+'\tmp\ooo'+inttostr(k));rewrite(g1);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(14)+260;
for xx25:=1 to xx22 do begin xx23:=random(20)+65; write(g,char(xx23)); write(g1,char(xx23)); end; write(g,'!');
xx22:=random(14)+260;
for xx25:=1 to xx22 do begin xx23:=random(20)+98; write(g,char(xx23)); write(g1,char(xx23)); end; write(g,'!');
closefile(g);closefile(g1);
end;

//A special random test for the task 15.23
if chosen_task='15_23' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(18)+60;
for xx25:=1 to xx22 do begin xx23:=random(20)+1; xx24:=random(12)+1; write(g,xx23, ' ', xx24,' '); end; write(g,' 0 0 ');
assign(g1,s1+'\tmp\ooo'+inttostr(k));rewrite(g1);
reset(g); while not eof(g) do begin read(g, xx26); read(g,xx27); if xx27 in [6..8] then write(g1, xx26,' ', xx27,' ');end; closefile(g);  write(g1,' -1 -1 ');
reset(g); while not eof(g) do begin read(g, xx26); read(g,xx27); if xx27 in [1,2,12] then write(g1, xx26,' ', xx27,' ');end; closefile(g);
closefile(g1);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(18)+60;
for xx25:=1 to xx22 do begin xx23:=random(20)+1; xx24:=random(12)+1; write(g,xx23, ' ', xx24,' '); end; write(g,'0 0');
assign(g1,s1+'\tmp\ooo'+inttostr(k));rewrite(g1);
reset(g); while not eof(g) do begin read(g, xx26); read(g,xx27); if xx27 in [6..8] then write(g1, xx26,' ', xx27,' ');end; closefile(g);write(g1,' -1 -1 ');
reset(g); while not eof(g) do begin read(g, xx26); read(g,xx27); if xx27 in [1,2,12] then write(g1, xx26,' ', xx27,' ');end; closefile(g);
closefile(g1);
end;

//A special random test for the task 15.24
if chosen_task='15_24' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g1,s1+'\tmp\ooo'+inttostr(k));rewrite(g1);
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
for xx26:=1 to 4 do begin xx22:=random(70)+270;
for xx25:=1 to xx22 do begin xx23:=random(21)+65; write(g,char(xx23)); write(g1,char(xx23)); end; write(g,'!'); write(g1,'!');end;
closefile(g);closefile(g1);
end;

//A special random test for the task 15.27
if chosen_task='15_27' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(12)+108; xx22:=random(3)+1;xx24:=random(3)-1;
for xx23:=1 to xx21 do write(g,xx23*xx22*3,' '); write(g,-10000,' ');
for xx23:=1 to xx21 do write(g,xx23*xx22*3+xx24,' '); write(g,-10000);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
for xx23:=1 to xx21 do if xx24=-1 then write(g,xx23*xx22*3-1,' ',xx23*xx22*3,' ')else write(g,xx23*xx22*3,' ',xx23*xx22*3+xx24,' ');
closefile(g);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(500)-250; xx22:=random(500)-250; write(g,xx21,' ',-10000,' ',xx22,' ', -10000);closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
if xx21<=xx22 then write(g, xx21,' ',xx22)else write(g, xx22,' ',xx21);closefile(g);
end;

//A special random test for the task 15.28-002
if chosen_task='15_28-002' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(5)-2;xx23:=random(5)-2;
write(g,xx23/2:1:1,' ');write(g,xx22/2:1:1,' ');
write(g,'-10000 '); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,1+byte(xx22=xx23));
closefile(g);
end;

//A special random test for the task 15.28-003
if chosen_task='15_28-003' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(25)+57;
for xx24:=1 to xx22*2 do begin xx21:=random(1000)-500;write(g,xx21/5:1:1,' ');end; write(g, -10000); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,'false');closefile(g);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx22:=random(25)+57;
for xx24:=1 to xx22*2-1 do begin xx21:=random(1000)-500;write(g,xx21/5:1:1,' ');if xx24=xx22 then xx23:=xx21; end; write(g, -10000); closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);write(g,'true',' ',xx23/5:1:1);closefile(g);
end;

//A special random test for the task 15.29
if chosen_task='15_29' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
xx21:=random(3);
case xx21 of 0: write(g,'Ethan 21, Jake 23.'); 1: write(g,'Mason 24.') else write(g,'Harrison 35, Jacob 34, Oliver 36.')end;closefile(g);
assign(g,s1+'\tmp\ooo'+inttostr(k));rewrite(g);
case xx21 of 0: write(g,'Ethan'); 1: write(g,'Mason') else write(g,'Jacob')end;
closefile(g);
end;

//A special random test for the task 15.32-002
if chosen_task='15_32-002' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(20)+67; write(g,chr(xx23));write(g1,chr(xx23))end;
xx23:=random(20)+98; write(g,'.'); write(g,chr(xx23)); write(g1,chr(xx23)); closefile(g); closefile(g1);
end;

//A special random test for the task 15.32-003
if chosen_task='15_32-003' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(30)+48; if xx23=59 then xx23:=58; write(g,chr(xx23));write(g1,chr(xx23)); if xx23 in [48..57] then write(g1,chr(xx23)); end;
write(g,'.'); closefile(g1);closefile(g);
end;

//A special random test for the task 15.32-004
if chosen_task='15_32-004' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(20)+67; write(g,chr(xx23)); if xx22<>xx21 then write(g1,chr(xx23))end;
xx23:=random(22)+97;write(g,'.'); write(g,chr(xx23)); write(g1,chr(xx23));
closefile(g); closefile(g1);
end;

//A special random test for the task 15.32-005
if chosen_task='15_32-005' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(30)+47; if xx23=59 then xx23:=58; write(g,chr(xx23));if xx23 in [48..56] then write(g1,chr(xx23+1))else if xx23=57 then write(g1,'0')else write(g1,chr(xx23))end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.32-006
if chosen_task='15_32-006' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+150;
for xx22:=1 to xx21 do begin xx23:=random(17)+40; if xx23=46 then xx23:=45; write(g,chr(xx23));if not(xx23 in [43,45]) then write(g1,chr(xx23))end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.32-007
if chosen_task='15_32-007' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(23)+65;  write(g,chr(xx23)); if xx22<>xx21-1 then write(g1,chr(xx23))end;
write(g,'.'); closefile(g); closefile(g1);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(23)+98; write(g,chr(xx23));  if xx22<>xx21-1 then write(g1,chr(xx23))end;
write(g,'.'); closefile(g); closefile(g1);
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+50;
for xx22:=1 to xx21 do begin xx23:=random(10)+48; write(g,chr(xx23));  if xx22<>xx21-1 then write(g1,chr(xx23))end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.32-008
if chosen_task='15_32-008' then begin sd:=[];
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(30)+90;
for xx22:=1 to xx21 do begin xx23:=random(28)+65; write(g,chr(xx23)); if not(chr(xx23) in sd) then begin write(g1,chr(xx23));sd:=sd+[chr(xx23)]end;end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.34
if chosen_task='15_34' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(9); xx22:=random(3); xx23:=random(9); write(g,'(',xx21:1);
if xx22=0 then write(g,'+');if xx22=1 then write(g,'-');if xx22=2 then write(g,'*');
write(g,xx23:1,').'); closefile(g);
if xx22=0 then xx24:=xx21+xx23;if xx22=1 then xx24:=xx21-xx23;if xx22=2 then xx24:=xx21*xx23;
write(g1,xx24);closefile(g1);
end;

//A special random test for the task 15.35
if chosen_task='15_35' then begin sd:=[];
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(3)+5;xx24:=0;
for xx22:=1 to xx21 do begin xx23:=random(23)+65; write(g,chr(xx23)); if not(chr(xx23) in sd) then sd:=sd+[chr(xx23)]else xx24:=1; end;
write(g,'.'); closefile(g); if xx24=0 then write(g1,'false')else write(g1,'true'); closefile(g1);
end;

//A special random test for the task 15.42-003
if chosen_task='15_42-003' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(3);
if xx21=1 then write(g1,'true')else write(g1,'false'); closefile(g1);
if xx21=1 then begin xx24:=random(20)+65; write(g,'wervc'+chr(xx24)+chr(2)+'.'+'wervc'+chr(xx24)+chr(2)+'.'); closefile(g) end else
begin
xx23:=random(30)+50;
for xx22:=1 to xx23 do begin xx24:=random(20)+65; write(g, chr(xx24)); end; write(g, chr(2)+'.');
xx25:=random(30)+50; if xx25=xx23 then inc(xx25);
for xx22:=1 to xx25 do begin xx24:=random(20)+65; write(g, chr(xx24)); end; write(g, chr(2)+'.');
closefile(g); 
end;
end;

//A special random test for the task 15.44-002
if chosen_task='15_44-002' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+300;
for xx23:=1 to xx22 do begin xx24:=random(30)+300; for xx25:=1 to xx24 do begin xx26:=-random(10)+122; write(g, chr(xx26)); end; if xx26=122 then inc(xx21); write(g,chr(2));end;
write(g,'.'); write(g1,xx21); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.44-003
if chosen_task='15_44-003' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+300;
for xx23:=1 to xx22 do begin xx24:=random(30)+300; for xx25:=1 to xx24 do begin xx26:=-random(10)+122; if xx25=1 then xx27:=xx26; write(g, chr(xx26)); end; if xx26=xx27 then inc(xx21); write(g,chr(2));end;
write(g,'.'); write(g1,xx21); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.44-004
if chosen_task='15_44-004' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+300;
for xx23:=1 to xx22 do begin xx24:=random(30)+300; xx27:=0; xx29:=0;
for xx25:=1 to xx24 do begin xx26:=random(100); if xx26=90 then write(g, chr(xx24 mod 17 +66))else write(g,chr(xx24 mod 17 +67)); if xx26=90 then xx27:=1 else xx29:=1; end; if xx27*xx29=0 then inc(xx21); write(g,chr(2));end;
write(g,'.'); write(g1,xx21); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.45
if chosen_task='15_45' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+300; xx27:=0;
for xx23:=1 to xx22 do begin xx24:=random(30);if xx24=3 then begin for xx29:=1 to random(13)+5 do write(g, chr(random(23)+65)); xx27:=1; end; write(g,chr(2));if xx27=0 then inc(xx21); end;
write(g,'.'); write(g1,xx21); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.47
if chosen_task='15_47' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+30;
for xx23:=1 to xx22 do begin  xx24:=random(30)+300; xx27:=random(10); if xx27<3 then write(g,chr(2)); for xx25:=1 to xx24 do begin xx29:=random(20)+65; write(g,chr(xx29)); write(g1,chr(xx29)); end;
write(g,chr(2)); write(g1,chr(2));end;
write(g,'.'); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.48
if chosen_task='15_48' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=0; xx22:=random(30)+30;
for xx23:=1 to xx22 do begin  xx24:=random(30)+65; for xx25:=1 to xx24 do begin xx29:=random(20)+97; write(g,chr(xx29)); if xx25<=80 then write(g1,chr(xx29));end;
if xx24<80 then for xx25:=xx24+1 to 80 do write(g1,'_');
write(g,chr(2)); write(g1,chr(2));end;
write(g,'.'); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.50-001
if chosen_task='15_50-001' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(10)+10;
for xx22:=1 to xx21 do begin  xx23:=random(12)+65; xx24:=random(112)+34; if odd(xx22)then xx23:=xx23+32; for xx25:=1 to xx24 do write(g,chr(xx23));write(g1, ' ',xx24,' ',chr(xx23)); end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.50-002
if chosen_task='15_50-002' then begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(10)+10;
for xx22:=1 to xx21 do begin  xx23:=random(12)+65; xx24:=random(112)+34; if odd(xx22)then xx23:=xx23+32; for xx25:=1 to xx24 do write(g1,chr(xx23));write(g, ' ',xx24,' ',chr(xx23)); end;
write(g,' 1 .'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.54
if chosen_task='15_54' then begin
for xx28:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(10)+300;
for xx27:=1 to xx26 do begin
xx21:=random(1000)-500; xx22:=random(1000)-500;
write(g,xx21,' ',xx22,chr(2)); if xx21>0 then write(g1, xx21,' ');if xx22>0 then write(g1, xx22,' ');end;
write(g,'.'); closefile(g); closefile(g1);
end end;

//A special random test for the task 15.55
if chosen_task='15_55' then begin
sa[1]:='When was the museum opened?';
sa[2]:='What collections does the museum display?';
sa[3]:='What institute is there?';
sa[4]:='What is the central hall like?';
sa[5]:='When were several of the galleries destroyed?';
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(25)+1100;
for xx27:=1 to xx26 do begin
xx21:=random(5)+1;
write(g,sa[xx21]); write(g,chr(2)); if xx27<10 then write(g1,'000')else if xx27<100 then write(g1,'00')else if xx27<1000 then write(g1,'0'); write(g1,xx27:1); write(g1,' '); write(g1,sa[xx21]);write(g1,chr(2)); end;
write(g,'.'); closefile(g); closefile(g1);
end;

//A special random test for the task 15.58
if chosen_task='15_58' then begin
for xx29:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(25)+25;
for xx27:=1 to xx26 do begin
sf:='';se:='';xx25:=random(16);
for xx24:=1 to xx25 do begin xx28:=random(1000)-500;
write(g,' ',xx28); if xx28>0 then sf:=sf+' '+inttostr(xx28) else se:=se+' '+inttostr(xx28); end;
write(g,chr(2)); write(g1,sf+se+chr(2)); end;
write(g,'.'); closefile(g); closefile(g1);
end;
end;

//A special random test for the task 15.59
if chosen_task='15_59' then begin
sa[1]:='Why is it so cold now?';
sa[2]:='When will the weather improve?';
sa[3]:='Do you like rainy weather?';
sa[4]:='Do you like to live in the capital?';
sa[5]:='What time does this train leave?';
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(25)+260;ss31:=''; ss32:='';
for xx27:=1 to xx26 do begin
xx21:=random(6);
if xx21>0 then ss31:=ss31+sa[xx21];ss31:=ss31+chr(2);end;
ss31:=ss31+'.';
xx26:=random(25)+260;
for xx27:=1 to xx26 do begin
xx21:=random(6);
if xx21>0 then ss32:=ss32+sa[xx21];ss32:=ss32+chr(2);end;
ss32:=ss32+'.';
write(g,ss31,ss32); write(g1,ss32,ss31);
closefile(g); closefile(g1);
end;

//A special random test for the task 15.61
if chosen_task='15_61' then begin
sa[1]:='Bull';
sa[2]:='Cow';
sa[3]:='Goat';
sa[4]:='Whale';
sa[5]:='Walrus';
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(25)+260;
for xx27:=1 to xx26 do begin
xx21:=random(100); if odd(xx21) then write(g,'It is an experimental text.'+chr(2)) else write(g,'It contains lines of different lengths.'+chr(2))end;
xx25:=random(5)+1;
write(g,sa[xx25]+chr(2));
xx21:=random(100); if odd(xx21) then write(g,'It is an experimental text.'+chr(2)) else write(g,'It contains lines of different lengths.'+chr(2));
xx21:=random(100); if odd(xx21) then write(g,'It is an experimental text.'+chr(2)) else write(g,'It contains lines of different lengths.'+chr(2));
xx21:=random(100); if odd(xx21) then write(g,'It is an experimental text.'+chr(2));
xx21:=random(100); if odd(xx21) then else write(g,'It contains lines of different length.'+chr(2));
write(g1,sa[xx25]);write(g,'#');
closefile(g); closefile(g1);
end;

//A special random test for the task 15.62
if chosen_task='15_62' then begin
for xx29:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(257)+25;
for xx27:=1 to xx26 do begin
xx28:=random(1000)-500;write(g,' ',xx28);xx28:=random(1000)-500;write(g,' ',xx28);
write(g,chr(2)); end;
if xx29=2 then begin xx28:=random(1000)-500;if odd(xx28) then write(g,'Bull  ')else write(g,'  Cow  '); write(g,chr(2)); end;
write(g,'#');
if xx29=1 then write(g1,'0')else if odd(xx28)then write(g1,4) else write(g1,3);
closefile(g); closefile(g1);
end;
end;

//A special random test for the task 15.61
if chosen_task='15_62' then begin
sa[1]:='Bull';
sa[2]:='Cow';
sa[3]:='Goat';
sa[4]:='Whale';
sa[5]:='Walrus';
number_of_tests:=number_of_tests+1;
xx21:=0; k:=k+1;randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx26:=random(280)+26;
for xx27:=1 to xx26 do begin
 xx25:=random(5)+1;
write(g,sa[xx25]+chr(2));xx21:=xx21+length(sa[xx25]);end;
write(g1,xx21/xx26:1:8);write(g,'#');
closefile(g); closefile(g1);
end;

//Special random tests for the tasks 16.15 and 16.18
if (chosen_task='16_15-001')or(chosen_task='16_18-003')or(chosen_task='16_18-004') then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(1000)-444;
xx22:=random(1000)-444;
write(g,xx21,' ',xx22);
if chosen_task='16_18-003' then write(g1, (xx21+xx22)/2:1:8) else
if xx21>xx22 then write(g1,xx21)else write(g1,xx22);
if (copy(chosen_task,1,5)='16_18')then write(g,'  1E20');
closefile(g); closefile(g1);
end;

if chosen_task='16_15-003' then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(4)+14;
xx22:=random(4)+14;
write(g,xx21,' ',xx22);
if xx21<>xx22 then write(g1,'False')else write(g1,'True');
closefile(g); closefile(g1);
end;

if chosen_task='16_16-001' then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx24:=random(10)+5;
for xx21:=1 to 12*xx24 do begin
xx22:=random(20)+98; write(g, chr(xx22));end;
write(g,'.');write(g1, xx24);  
closefile(g); closefile(g1);

end;

if (chosen_task='16_18-006') then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx24:=random(10)+5;xx31:=random(1000)/5-90;xx32:=random(1000)/5-90;
write(g, xx31:1:3,' '); write(g1, xx32:1:3,' ');
for xx21:=1 to xx24 do begin xx33:=random(1000)/5-90;
write(g, xx33:1:3,' '); write(g1, xx33:1:3,' '); end;
write(g1, xx31:1:3,' '); write(g, xx32:1:3,' ');
write(g,'1E20');
closefile(g); closefile(g1);
end;

if (chosen_task='16_18-008') then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx31:=random(1000)/5-90;xx32:=random(1000)/5-90;
write(g, xx31:1:3,' '); write(g, (xx31+xx32)/2:1:3,' ');
write(g1, xx32:1:3,' '); write(g1, (xx31+xx32)/2:1:3,' ');
write(g1, xx31:1:3,' ');  write(g, xx32:1:3,' ');
write(g,'1E20');
closefile(g); closefile(g1);
end;

if (chosen_task='16_18-010') then begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx21:=random(1000)-90;xx22:=random(1000)-90; if xx21=xx22 then xx21:=xx21+1;
write(g, xx21,' '); write(g, (xx21+xx22)div 2,' ');write(g, xx22,' ');
write(g,'1E20'); if (xx21+xx22) mod 2=0 then write(g1,'True') else write(g1,'False');
closefile(g); closefile(g1);
end;

if (chosen_task='16_18-011') then begin
for xx21:=1 to 3 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx24:=random(15)+12;
for xx25:=1 to xx24 do begin xx31:=random(1000)/4-90;write(g,xx31:1:3,' ');end;
xx31:=random(1000)/5-90;write(g,xx31:1:3,' ');
xx32:=random(1000)/5-90;write(g,xx32:1:3,' '); write(g1,xx31+xx32:1:3,' ');
write(g,'1E20');
closefile(g); closefile(g1);
end; end;

if (chosen_task='16_18-012') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx31:=random(4)-2;write(g,xx31:1:3,' ');
xx32:=random(4)-2;write(g,xx32:1:3,' '); if xx31=xx32 then write(g1,2)else write(g1,1);
write(g,'1E20');
closefile(g); closefile(g1);
end; end;

//Special random tests for the tasks 16.20 and next

if (chosen_task='16_20-002') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=random(10000)+24;
write(g,xx22); write(g1,'1 1 '); xx23:=1; xx24:=1;
repeat xx24:=xx24+xx23; xx23:=xx24-xx23; if xx24<=xx22 then write(g1,xx24,' ')else break; until false;
closefile(g); closefile(g1);
end; end;

if (chosen_task='16_20-004') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=250+random(2000);write(g,xx22);
xx23:=xx22 div 1000; xx24:=xx22 mod 1000 div 100;
xx25:=xx22 mod 100 div 10; xx26:=xx22 mod 10;
if xx23>0 then write(g1, xx23,' ');
write(g1,xx24,' ');write(g1,xx25,' ');write(g1,xx26,' ');
closefile(g); closefile(g1);
end; end;

if (chosen_task='16_20-005') or (chosen_task='16_29-009') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx31:=random(1000)/10-50;
xx32:=random(1000)/10-50;
xx33:=random(1000)/10-50;
xx34:=random(1000)/10-50;
xx35:=random(1000)/10-50;
write(g, xx31:1:3,' ', xx32:1:3,' ',xx33:1:3,' ',xx34:1:3,' ',xx35:1:3,' 1E20');
write(g1, xx35:1:3,' ', xx34:1:3,' ',xx33:1:3,' ',xx32:1:3,' ',xx31:1:3);
closefile(g); closefile(g1);
end; end;


if (chosen_task='16_23-007') then begin
for xx21:=1 to 3 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=random(20)+5;
for xx23:=1 to xx22 do begin
xx31:=(random(200)-100)/5;
write(g,xx31:1:3,' '); if xx31>=0 then write(g1,xx31:1:3,' '); end;
write(g, ' 1E20 '); closefile(g); closefile(g1);
end; end;

if (chosen_task='16_29-005') then begin
for xx21:=1 to 3 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=random(20)+5; xx32:=(random(200)-100)/5; write(g, xx32:1:3,' ');
for xx23:=1 to xx22 do begin
xx31:=(random(200)-100)/5;
write(g,xx31:1:3,' '); write(g1,xx31:1:3,' '); end;
write(g, ' 1E20 '); write(g1, xx32:1:3,' '); closefile(g); closefile(g1);
end; end;

if (chosen_task='16_29-006') then begin
for xx21:=1 to 3 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=random(20)+5; xx32:=(random(200)-100)/5; write(g1, xx32:1:3,' ');
for xx23:=1 to xx22 do begin
xx31:=(random(200)-100)/5;
write(g,xx31:1:3,' '); write(g1,xx31:1:3,' '); end;
write(g, xx32:1:3,' '); write(g, ' 1E20 '); closefile(g); closefile(g1);
end; end;

if (chosen_task='16_29-010') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx22:=random(20)+15;
for xx23:=1 to xx22 do begin
xx24:=random(3);write(g,xx24,' ');
if (xx23=1)or(xx24<>xx25)then write(g1,xx24,' ');xx25:=xx24
end;
write(g, ' 1E20 '); closefile(g); closefile(g1);
end; end;

if (chosen_task='16_31-002') then begin
for xx21:=1 to 2 do begin
number_of_tests:=number_of_tests+1;
k:=k+1; randomize;
assign(g,s1+'\tmp\iii'+inttostr(k)); rewrite(g);
assign(g1,s1+'\tmp\ooo'+inttostr(k)); rewrite(g1);
xx24:=random(3)+98;write(g,chr(xx24));
xx25:=random(3)+98;write(g,chr(xx25));
if xx24=xx25 then write(g1,'True') else write(g1,'False');  
write(g, '.'); closefile(g); closefile(g1);
end; end;

//Insert random tests for next tasks here
end;{of chosen task}

if b then break; end;{of while}
closefile(h);ioresult; closefile(g);ioresult;closefile(f);ioresult;
if not b then showmessage('Fatal error 5!');extract_data:=b;
if b then begin form2.CheckBox1.Checked:=auto;form2.button3.Enabled:=jj3; form2.button5.Enabled:=jj5; form2.button6.Enabled:=jj6; form2.button7.Enabled:=jj7;end;
end;

{function checking if the chosen file exists}
function fileexistsf(s:string):boolean;
var f:textfile;
begin assign(f, s); closefile(f); ioresult; //form2.button3.enabled:=false;
//form2.button4.enabled:=false; form2.button5.enabled:=false;
reset(f); if (ioresult<>0)or(eof(f))then
begin closefile(f);ioresult;fileexistsf:=false;
if en_rus then messagedlg('The file does not exist.',mtinformation,[mbOK],0)else
messagedlg('Файл не существует.',mtinformation,[mbOK],0);end
else begin fileexistsf:=true;form2.button3.enabled:=true;
form2.button8.enabled:=true;
form2.button9.enabled:=true;closefile(f); ioresult;
//if form2.button3.Enabled and form2.CheckBox1.Checked then form2.Button3.Click;
end;
closefile(f); ioresult; end;

{Function counting the number of apostrophes in the string's part}
function count_ap(var s:string;i:integer):integer;
{The number is counted in the part s[1]..s[i] }
var k,j:integer;
begin
k:=0;
for j:=1 to i do if s[j]=chr(39)then inc(k);
count_ap:=k
end;

{Procedures performing the preliminary analysis}
procedure preliminary_analysis0;
var {s1,}s2:string;fi,fo:textfile;k,j,i:integer;
b_comm1,b_comm2, b_str:boolean;{true if we are within a comment or a string, respectively}
begin
//b_comm1:=false; b_comm2:=false;b_str:=false;
form2.memo1.clear;
//s1:=getcurrentdir;
setcurrentdir(current_dir);

assignfile(fi, filename);
assignfile(fo, current_dir+'\tmp\Temp0.pas');
reset(fi); if ioresult<>0 then begin showmessage('The input file cannot be opened'); exit end;
rewrite(fo); if ioresult<>0 then begin showmessage('The output file cannot be opened'); closefile(fi); ioresult; exit end;
k:=0; while not(eof(fi))do begin inc(k);
readln(fi,s2);

//deletion of 3 first extra characters that ABC-pascal adds to the beginning of a file
if k=1 then delete_extra(s2);
if s2='' then continue;
while (s2<>'')and (s2[1]=' ')do s2:=copy(s2,2,255);
if s2='' then continue;
if (length(s2)>3)and((copy(s2,1,3)='{I}')or(copy(s2,1,3)='{i}')) then s2:='//'+s2; 
while (s2<>'')and (s2[length(s2)]=' ')do s2:=copy(s2,1,length(s2)-1);
if s2='' then continue;
writeln(fo,s2);
end;

//showmessage('we are here');

closefile(fi);ioresult;closefile(fo);ioresult;
assign(fi, current_dir+'\tmp\Temp0.pas');reset(fi);
assign(fo, current_dir+'\tmp\Temp1.pas'); rewrite(fo);
b_comm1:=false; b_comm2:=false;b_str:=false;
while not(eof(fi))do
begin
readln(fi,s2);i:=1;j:=1;
repeat
j:=j+1; {for a safe reason}
if not(b_comm1)and not(b_comm2)and not b_str then

begin {1}
if s2[i] in ['A'..'Z'] then s2[i]:=chr(ord(s2[i])+32);
if (s2[i]=' ')and((i<length(s2))and(not(s2[i+1]in alphadigit))or(i=1)or(i=length(s2)))
then begin s2:=copy(s2,1,i-1)+copy(s2,i+1,255);continue end;
if (not(s2[i]in alphadigit+[chr(39)]))and(i<length(s2))and(s2[i+1]=' ')
then begin s2:=copy(s2,1,i)+copy(s2,i+2,255);continue end;

if s2[i]='{' then b_comm1:=true;
if copy(s2,i,2)='(*'then b_comm2:=true;
if copy(s2,i,2)='//' then begin s2:=copy(s2,1,i-1);break end;
end;{1}

if b_comm1 and(s2[i]='}') then begin b_comm1:=false;
if (i=1)or(i=length(s2))
or (not(s2[i+1]in alphadigit))or(not(s2[i-1]in alphadigit)) then
delete(s2,i,1)else s2[i]:=chr(32);continue end;
if b_comm2 and(copy(s2,i,2)='*)') then begin b_comm2:=false;if (i=1)or(i=length(s2)-1)
or (not(s2[i+2]in alphadigit))or(not(s2[i-1]in alphadigit)) then
delete(s2,i,2)else begin s2[i]:=chr(32);delete(s2,i+1,1)end;continue end;
if (s2[i]=chr(39))and not(b_comm1)and not(b_comm2) then b_str:=not(b_str);
if b_comm1 or b_comm2 then begin s2:=copy(s2,1,i-1)+copy(s2,i+1,255);continue

end;
i:=i+1;
until (i>length(s2))or(j>1000);
if s2<>'' then writeln(fo,s2);
end;
closefile(fi);ioresult; closefile(fo);ioresult; //erase(fi);ioresult;
//setcurrentdir(s1);
end;

procedure preliminary_analysis1;
var s7,s2:string;fi,fo:textfile;k1,i1,j,k,i:integer;bc:boolean;
begin
//s1:=getcurrentdir;
//setcurrentdir(current_dir);
bc:=not((textsin<>0)or(textsout<>0)); //not((chosen_task='15_38')or(copy(chosen_task,1,4)='15_4')or(copy(chosen_task,1,4)='15_5')or(copy(chosen_task,1,4)='15_6'));
assignfile(fi,current_dir+'\tmp\Temp1.pas');reset(fi); assignfile(fo,current_dir+'\tmp\Temp0.pas');rewrite(fo);
k:=0; j:=0; while not(eof(fi)) do begin readln(fi,s2);
//removal all read; readln; write; and writeln;
i:=1;inc(j);
repeat
if (copy(s2,i,5)='const')and(count_ap(s2,i)mod 2=0)and((i=1)or(not(s2[i-1]in alphadigit)))
and ((i+4=length(s2))or(not(s2[i+5]in alphadigit)))
then begin
if i>1 then begin writeln(fo,copy(s2,1,i-1)); inc(j); s2:=copy(s2,i,255);i:=1; end;
//showmessage(inttostr(k)+'@@@');

k:=k+1; i1:=j;if (i+4 = length(s2))or (pos('=',copy(s2,i,200))=0)or (pos(';',copy(s2,i,200))=0)
then begin readln(fi,s7); ioresult; if (i+4)=length(s2) then s2:=s2+' '+s7 else s2:=s2+s7;
if (pos('=', s2)=0)or(pos(';', s2)=0)then begin readln(fi,s7); ioresult;s2:=s2+s7 end;
if pos(';', s2)=0 then begin readln(fi,s7);ioresult;s2:=s2+s7 end;
if pos(';', s2)=0 then begin readln(fi,s7);ioresult;s2:=s2+s7 end;
end;
if (k=1)and(consts[2,1]<>0)then begin k1:=pos(';',s2);if k1=0 then break;
//showmessage('k=1we are here ');

writeln(fo, copy(s2,1,k1)); s2:=copy(s2,k1+1,200);i:=1;
if s2='' then readln(fi,s2); ioresult;
//showmessage('!'+s2+'!');

if not((copy(s2,1,4)='type')and((length(s2)=4) or (length(s2)>4) and(not(s2[5] in alphadigit)))
or(copy(s2,1,5)='label')and((length(s2)=5) or (length(s2)>5)and(not(s2[6] in alphadigit)))
or(copy(s2,1,5)='begin')and((length(s2)=5) or (length(s2)>5)and(not(s2[6] in alphadigit)))
or(copy(s2,1,8)='function')and((length(s2)=8) or (length(s2)>8)and(not(s2[9] in alphadigit)))
or(copy(s2,1,9)='procedure')and((length(s2)=9) or (length(s2)>9)and(not(s2[10] in alphadigit)))
or(copy(s2,1,3)='var')and((length(s2)=3) or (length(s2)>3)and(not(s2[4] in alphadigit)))
or(copy(s2,1,5)='const')and((length(s2)=5) or (length(s2)>5)and(not(s2[6] in alphadigit))))
then s2:='const '+s2;
//showmessage('@'+s2+'!');
end;end;


if (copy(s2,i,7)='readln;')and(count_ap(s2,i)mod 2=0)and((i=1)or(not(s2[i-1]in alphadigit)))
then begin delete(s2,i,7);continue end;
if (copy(s2,i,5)='read;')and(count_ap(s2,i)mod 2=0)and((i=1)or(not(s2[i-1]in alphadigit)))
then begin delete(s2,i,5);continue end;
if (copy(s2,i,6)='write;')and(count_ap(s2,i)mod 2=0)and((i=1)or(not(s2[i-1]in alphadigit)))
then begin delete(s2,i,6);continue end;

i:=i+1;
until i>=length(s2);

i:=1;{j:=1; variable j is used for a safe reason}
repeat
{readln}
if (copy(s2,i,6)='readln')and bc and(count_ap(s2,i)mod 2=0)and((i=1)or(not(s2[i-1]in alphadigit)))
and((i+5=length(s2))or(not(s2[i+6]in alphadigit)))and(count_ap(s2,i)mod 2=0)
then begin delete(s2,i+4,2); continue end;
{read}
{let us not use it now}
{if (copy(s2,i,4)='read')and((i=1)or(not(s2[i-1]in alphadigit)))
and((i+3=length(s2))or(not(s2[i+4]in alphadigit)))and(count_ap(s2,i)mod 2=0)
then begin
s3:=copy(s2,1,i-1); if(s3<>'')and(s3[length(s3)]=' ')then s3:=copy(s3,1,length(s3)-1);
if s3<>'' then writeln(fo,s3);
s4:=copy(s2,i,255);
repeat k:=pos(')',s4); if (k>0)or(eof(fi))then begin s5:=copy(s4,1,k);
if (length(s4)>k)and(s4[k+1]=';')then begin k:=k+1; s5:=s5+';';end;
s5:='read('+'__fi,'+copy(s5,6,255);
writeln(fo,s5);writeln(fo,'if ioresult<>0 then begin writeln(__fo,''!!!''); halt end;');
s2:=copy(s4,k+1,255);
if k>0 then i:=0;
break;end else begin readln(fi,s2); s4:=s4+s2; end until false;
end;   }
{write}
{if (copy(s2,i,5)='write')and((i=1)or(not(s2[i-1]in alphadigit)))
and((i+4=length(s2))or(not(s2[i+5]in alphadigit)))and (count_ap(s2,i)mod 2=0)
then begin
s3:=copy(s2,1,i-1);if(s3<>'')and(s3[length(s3)]=' ')then s3:=copy(s3,1,length(s3)-1);
if s3<>'' then writeln(fo,s3);s4:=copy(s2,i,255);
writeln(fo,'write(__fo,');if (length(s4)=5)
then begin if not(eof(fi))then readln(fi,s2)else break; if s2<>'' then s2:=copy(s2,2,255); i:=0;end
else begin s2:=copy(s4,7,255);i:=0 end
end;
}
i:=i+1;
until i>length(s2); if s2<>'' then writeln(fo,s2);
end;
closefile(fi);closefile(fo);

end;

procedure preliminary_analysis2;
var s2{,s1}:string;fi,fo:textfile;i,l,m,n,k{,j}:integer;
begin
//s1:=getcurrentdir;
//setcurrentdir(current_dir);
assignfile(fi,current_dir+'\tmp\Temp0.pas');reset(fi); assignfile(fo,current_dir+'\tmp\Temp1.pas');rewrite(fo);
{Search the last 'begin' with zero balance; n is the line number, m is the position of the 'begin' in the found line,
l is the current balance}
k:=0;l:=0;m:=0; n:=0;
while not(eof(fi)) do begin
k:=k+1;readln(fi,s2);i:=1;
repeat
if (copy(s2,i,5)='begin') and((i=1)or(not(s2[i-1] in alphadigit)))and(count_ap(s2,i)mod 2=0)and((length(s2)=i+4)or
(not(s2[i+5] in alphadigit)))
then begin if l=0 then begin n:=k; m:=i end; l:=l+1; end;
if (copy(s2,i,3)='end') and((i=1)or(not(s2[i-1] in alphadigit)))and(count_ap(s2,i)mod 2=0) and((length(s2)=i+2)or
(not(s2[i+3] in alphadigit)))
then l:=l-1;
i:=i+1; until i>=length(s2);
end;
//showmessage(inttostr(n)+'  '+inttostr(m));
closefile(fi); reset(fi);
writeln(fo,'{$I+,R+}');
//writeln(fo,'var __fi,__fo:text;');
k:=0;
while not(eof(fi)) do begin
k:=k+1; readln(fi,s2);if (k<>n)or true then begin writeln(fo,s2); continue end;
writeln(fo,copy(s2,1,m+4)+' assign(__fi,''initial_data.txt'');reset(__fi); assign(__fo,''result_data.txt'');rewrite(__fo);');
s2:=copy(s2,m+5,255); if(s2<>'')and(s2[1]=' ')then s2:=copy(s2,2,255); if s2<>'' then write(fo, s2);
end;
closefile(fi);closefile(fo);erase(fi);
//setcurrentdir(s1);
end;

function preliminary_analysis3:boolean;
var i9,ii,i:integer;an_res:t_an_res;s8,ss3,ss4,ss2:string;bba,bb,bbb:boolean;
begin preliminary_analysis3:=true;
incorrect_boolean:=checkboolean;

//Analysis of the task 8_29-007
if chosen_task='8_29-007' then
begin bbb:=nested_loops;
if bbb then begin preliminary_analysis3:=false;
if en_rus then
form2.Memo1.lines.add('Error. Nested loops or loops within conditional statements are not allowed for this task.')else
form2.Memo1.lines.add('Ошибка. Вложенные циклы и циклы внутри уcлoвных операторов в этой задаче не допускаются.');
exit end;end;
//Analysis of the tasks 15_32- from 2 to 8 - only a file with the name 'temp15_2' can be assigned; a temporary file can be renamed to 'temp15_1' only; the corresponding replacements are made in the pascal program
if (copy(chosen_task,1,5)='15_32') or(copy(chosen_task,1,5)='15_49')or(copy(chosen_task,1,5)='15_50') then replace15_32_and_others;
//A special analysis for the task 6.30 - only write(chr... is allowed for it.
if chosen_task='6_30' then begin
if not(char_output) then begin preliminary_analysis3:=false;
if en_rus then
form2.Memo1.lines.add('Error. Only output of a character or of the type ''writeln(chr(...))'' is allowed in this task.')else
form2.Memo1.lines.add('Ошибка. В этой задаче допускается только вывод символа или вывод вида write(chr(...)).');
exit end;
end;

//Global variables are not allowed; rather, we check absence of any variable declarations before subroutine definition
//showmessage('We are here 1 ');
if (copy(chosen_task,1,2)='11') or (copy(chosen_task,1,2)='12')or(copy(chosen_task,1,2)='16')then
if findglobal then begin preliminary_analysis3:=false;
if en_rus then form2.memo1.lines.add('Error: variable declarations are not allowed before procedure of function definitions for this task.')else
form2.memo1.lines.add('Oшибкa. Описание переменных перед описанием функции или процедуры в этой задаче не допускается.');exit;end;

for i:=1 to css do ns[i]:=0;
an_res:=analysis;
warnings_amount:=0;
form2.memo1.clear;
bb:=check_beginend;
if not bb then begin preliminary_analysis3:=false;exit;end;

//Analysis for the tasks processing external files, that is, 15.58 and the next.
if (chosen_task='15_58')or (chosen_task='15_59')or(chosen_task='15_60')or(chosen_task='15_61')or(chosen_task='15_62')or(copy(chosen_task,1,5)='15_63')then begin bba:=external_files;
if not bba then begin preliminary_analysis3:=false; exit;end;end;

//if func_proc=0 then begin
join(ss3); ss4:=func_names(ss3);if length(ss4)>=2 then begin add_parentheses(ss3,ss4); breaks(ss3,false) end;
//end;
if func_proc>0 then begin i9:=add_main_block;
if i9<>0 then preliminary_analysis3:=false;
//Different results of add_main_block
//i9=-1 means that no additional information must be output
if i9=1 then begin        //no subroutines were found
if func_proc=1 then begin if en_rus then form2.Memo1.lines.add('Error. No functions were found.')else form2.Memo1.lines.add('Ошибка. Фукнция не найдена.'); exit end;
if func_proc=2 then begin if en_rus then form2.Memo1.lines.add('Error. No procedures were found.')else form2.Memo1.lines.add('Ошибка. Пpoцедура не найдена.');exit end;
end;
if i9=2 then begin //a wrong type of the subroutine
if func_proc=1 then begin if en_rus then form2.Memo1.lines.add('Error. A procedure was found instead of a function.')else form2.Memo1.lines.add('Ошибка. Найдена процедура вместо функции.'); exit end;
if func_proc=2 then begin if en_rus then form2.Memo1.lines.add('Error. A function was found instead of a procedure.')else form2.Memo1.lines.add('Ошибка. Найдена функция вместо пpoцедуры.');exit end;
end;
if i9=3 then begin //global variables were found
if func_proc=1 then begin
if en_rus then form2.Memo1.lines.add('Error. Variable declaration is not allowed before the function.')else form2.Memo1.lines.add('Ошибка. Oписание переменных перед функцией не допускается.'); exit end;
if func_proc=2 then begin
if en_rus then form2.Memo1.lines.add('Error. Variable declaration is not allowed before the procedure.')else form2.Memo1.lines.add('Ошибка. Oписание переменных перед процедурой не допускается.'); exit end;
end;
if i9=4 then begin //integer or real output in task 12.12.7
if en_rus then
form2.Memo1.lines.add('Error. Only output of a character or of the type ''writeln(chr(...))'' is allowed in this task.')else
form2.Memo1.lines.add('Ошибка. В этой задаче допускается только вывод символа или вывод вида write(chr(...)).'); exit end;
end;

//showmessage('Beginning of analysis3');

if program_sub then begin i9:=formsubroutine;
if i9<>0 then preliminary_analysis3:=false;
if i9=1 then begin
if en_rus then form2.Memo1.lines.add('Syntax errors were found in the program. Please, check your program.') else form2.Memo1.lines.add('В программе были найдены синтаксические oшибки. Провepьте ее.'); exit end;
end;
//check for inadmissible output of the form write(6,x);
//if chosen_task='5_6-010' then begin
//if not check56010 then begin
//preliminary_analysis3:=false;
//if en_rus then form2.Memo1.Lines.add('Error. An output of only one integer expression is allowed for this task.') else
//form2.Memo1.Lines.add('Ошибка. В этой задаче допускается вывод только одного целочисленного выражения.');
//exit end;
//end;
if chosen_task='11_55'then begin
ii:=callsp;
if ii<0 then preliminary_analysis3:=false;
if ii=0 then begin preliminary_analysis3:=false;
if en_rus then form2.Memo1.Lines.Add('Error: no function calls were found.')
else form2.Memo1.Lines.Add('Oшибкa: нет обращений к функции.')
end;
if ii>1 then begin
form2.Memo1.Lines.Add('  ');preliminary_analysis3:=false;
if en_rus then form2.Memo1.Lines.Add('Error: two or more calls of a function or a procedure are not allowed for this task.')
else form2.Memo1.Lines.Add('Oшибкa: в этой задаче допускается нe болee oднoгo oбpащения к прoцeдурe или функции.')
end;
end;

//Analysis of the results
for i:=1 to chapter_claims_amount do
begin
if chapter_claims[i].b then
if not chapter_claims[i].b1 then begin
form2.Memo1.Lines.Add('  ');preliminary_analysis3:=false;
if en_rus then form2.Memo1.Lines.Add('Error: '+chapter_claims[i].s3)
else form2.Memo1.Lines.Add('Oшибкa: '+chapter_claims[i].s2)
end
else begin
form2.Memo1.Lines.Add('  ');//preliminary_analysis3:=false;
if en_rus then ss2:='Warning: '+chapter_claims[i].s3 else ss2:='Предупреждение: '+chapter_claims[i].s2;
form2.Memo1.Lines.Add(ss2);inc(warnings_amount);warnings[warnings_amount]:=ss2
end;
end;

//showmessage(inttostr(task_claims_amount ));
for i:=1 to task_claims_amount do
begin
//showmessage('Here'+inttostr(i)+task_claims[i].s1);
if task_claims[i].b then
if not task_claims[i].b1 then begin
form2.Memo1.Lines.Add('  ');preliminary_analysis3:=false;
if en_rus then form2.Memo1.Lines.Add('Error: '+task_claims[i].s3)
else form2.Memo1.Lines.Add('Oшибкa: '+task_claims[i].s2)
end
else
begin
form2.Memo1.Lines.Add('  ');//preliminary_analysis3:=false;
if en_rus then ss2:='Warning: '+task_claims[i].s3 else ss2:='Предупреждение: '+task_claims[i].s2;
form2.Memo1.Lines.Add(ss2);inc(warnings_amount);warnings[warnings_amount]:=ss2
end
end;

//This is old analysis when no 'claims.txt' files existed
if an_res[1]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{arrays or strings in tasks of chapters 5 or 6}
if en_rus then begin form2.memo1.lines.add('Error: arrays are not allowed  ');
form2.memo1.lines.add('for this task.')end
else begin form2.memo1.lines.add('Ошибка: использование массивов ');
form2.memo1.lines.add('в этой задачe не допускается.');end;end;

if an_res[7]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{arrays or strings in tasks of chapters 5 or 6}
if en_rus then begin form2.memo1.lines.add('Error: strings are not allowed  ');
form2.memo1.lines.add('for this task.')end
else begin form2.memo1.lines.add('Ошибка: использование строк ');
form2.memo1.lines.add('в этой задачe не допускается.');end;end;

//showmessage(inttostr(an_res[2]));

if an_res[2]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{No constants in tasks connected with sequences '}
if en_rus then begin if copy(chosen_task,1,4)='5_20'then
form2.memo1.lines.add('Error: the accuracy ''eps'' must ')else
form2.memo1.lines.add('Error: amount of numbers must ');
form2.memo1.lines.add('be defined as a constant ');
form2.memo1.lines.add('for this task.' );end
else begin if copy(chosen_task,1,4)='5_20'
then begin form2.memo1.lines.add('Ошибка: точность eps');
form2.memo1.lines.add('в этой задаче должнa быть ');
form2.memo1.lines.add('заданa константой.')end
else begin
form2.memo1.lines.add('Ошибка: количество чисел ');;
form2.memo1.lines.add('в этой задаче должно быть ');
form2.memo1.lines.add('задано константой.');end;
end; end;
if an_res[3]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{More than 1 loop in tasks 5_20'}
if en_rus then begin form2.memo1.lines.add('Error: more than one loop ');
form2.memo1.lines.add('or nested loops are not ');
form2.memo1.lines.add('allowed for this task.' );end
else begin form2.memo1.lines.add('Ошибка: более одного цикла или ');
form2.memo1.lines.add('вложенные циклы в этой задаче ');
form2.memo1.lines.add('не допускаются. ');
end; end;
if an_res[4]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{Standard functions in tasks 5_20'}
if en_rus then begin form2.memo1.lines.add('Error: standard functions (except abs) are not');
form2.memo1.lines.add('allowed for this task.' );end
else begin form2.memo1.lines.add('Ошибка: стандартные функции (кpoмe abs) в этой');
form2.memo1.lines.add('задаче не допускаются. ');
end end;
if an_res[5]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{Standard functuion in tasks 5_20'}
if en_rus then begin form2.memo1.lines.add('Error: procedures or functions are');
form2.memo1.lines.add('not allowed for this task.' );end
else begin form2.memo1.lines.add('Ошибка: процедуры и функции ');
form2.memo1.lines.add('в этой задаче не допускаются. ');
end end;
if an_res[6]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{Not enough constants for a rectangular matrix'}
if en_rus then begin form2.memo1.lines.add('Error: number of rows and ');
form2.memo1.lines.add('columns of the matrix ');
form2.memo1.lines.add('must be defined as two ' );
form2.memo1.lines.add('different constants.' );
end
else begin form2.memo1.lines.add('Ошибка: число строк и столбцов ');
form2.memo1.lines.add('матрицы должно быть задано ');
form2.memo1.lines.add('двумя разными константами.');
end end;

if an_res[8]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
{No loops in tasks from chapters 5,6,8,9,10}
if en_rus then begin form2.memo1.lines.add('Error: no loop statements ');
form2.memo1.lines.add('were found in the program.');
end else begin form2.memo1.lines.add('Ошибка: в программе отсутствуют ');
form2.memo1.lines.add('операторы цикла.');
end end;

if an_res[9]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
//No constants in tasks connected with arrays
if en_rus then begin
form2.memo1.lines.add('Error: amount of array elements must ');
form2.memo1.lines.add('be defined as a constant ');
form2.memo1.lines.add('for this task.' );end
else begin
form2.memo1.lines.add('Ошибка: количество элементов');;
form2.memo1.lines.add('массива в этой задаче должно');
form2.memo1.lines.add('быть задано константой.');
end end;

if an_res[10]=1 then begin form2.memo1.lines.add(' ');preliminary_analysis3:=false;
if en_rus then begin
form2.memo1.lines.add('Error: the order of the square matrix ');
form2.memo1.lines.add('must be defined as a constant ');
form2.memo1.lines.add('for this task.' );end
else begin
form2.memo1.lines.add('Ошибка: порядок квадратной ');;
form2.memo1.lines.add('матрицы в этой задаче должен');
form2.memo1.lines.add('быть задан константой.');
end
end;

if an_res[11]=1 then begin {form2.memo1.lines.add(' ');//preliminary_analysis3:=false;
if en_rus then begin
s8:='Warning: no break, repeat, while or goto statements were found in the program.';
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='Warning: no break, repeat, while or goto statements were found in the program.';

if (chosen_task='9_20')or(chosen_task='9_27')or(chosen_task='9_30') or(chosen_task='9_31')  then
begin s8:=s8+' Note that the program must be terminated ');
warnings[warnings_amount]:='Note that the program must be terminated ' end
else
begin form2.memo1.lines.add('Note that the inner loop must be terminated ');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='Note that the inner loop must be terminated ' end;
form2.memo1.lines.add('when the result of the calculation becomes known.');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='when the result of the calculation becomes known.' end
else begin
form2.memo1.lines.add('Предупреждение: в программе отсутствует оператор break, repeat, while или goto.');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='Предупреждение: в программе отсутствует оператор break, repeat, while или goto.';

if (chosen_task='9_20')or(chosen_task='9_27')or(chosen_task='9_30') or(chosen_task='9_31')   then
begin form2.memo1.lines.add('Oбратите внимание, что выполнение программы ');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='Oбратите внимание, что выполнение программы ';
end
else
begin
form2.memo1.lines.add('Oбратите внимание, что выполнение  внутреннего цикла');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='Oбратите внимание, что выполнение внутреннего циклa ';
end;
form2.memo1.lines.add('должно завершаться, как только peзультат вычисления известен.');
warnings_amount:=warnings_amount+1;
warnings[warnings_amount]:='должно завершаться, как только peзультат вычисления известен. ';
end }
end;

if an_res[12]=1 then begin form2.memo1.lines.add(' ');//preliminary_analysis3:=false;
if en_rus then begin
form2.memo1.lines.add('Warning: no array definitions were found in the task. ');
end  else begin
form2.memo1.lines.add('Предупреждение: в задаче отсутствуют массивы. ');
end
end;
end;


procedure set_initial_text(memo:Tmemo);//the procedure replaces the changed text of the program in the Memo5 by its initial text if the compilation was successful
var k:integer;s:string;f:text;
begin
memo.clear; assign(f,filename);
reset(f); if (ioresult<>0)or(eof(f)) then begin showmessage('Fatal error. File '+filename+' not found.'); form1.close end;
memo.clear;
if en_rus then
begin memo.lines.add('All comments are removed from the tested program.');
memo.lines.add('The directive {I+,R+} is added to its beginning.');memo.Lines.Add('  ') end else
begin memo.lines.add('Все комментарии из тестируемой программы удаляются. ');
memo.lines.add('Дирeктивa {I+,R+} добавляется в ee начало. ');memo.Lines.Add('  ')end;
k:=0; while not eof(f) do begin inc(k); readln(f,s);if k=1 then delete_extra(s);
memo.lines.add(s); end; closefile(f);
end;

procedure precompile;//this procedure forms files temp2.pas, temp3.pas, temp4.pas and temp5.pas from temp1.pas and files temp20.pas, temp30.pas, temp40.pas and temp50.pas from temp10.pas
var f,g,h,g1,h1:textfile;s8,s4,s5,s6,s7,s:string;k1,p,q,i2:integer;
begin

for i2:=1 to 2-byte(not(program_sub)) do begin

case i2 of
1: s4:='';
2: s4:='0'
end;
assign(f,current_dir+'\tmp\temp1'+s4+'.pas');reset(f); if ioresult<>0 then begin showmessage('Fatal error 14');halt;end;
assign(g,current_dir+'\tmp\temp2'+s4+'.pas');rewrite(g); if ioresult<>0 then begin showmessage('Fatal error 15');halt;end;
assign(h,current_dir+'\tmp\temp3'+s4+'.pas');rewrite(h); if ioresult<>0 then begin showmessage('Fatal error 16');halt;end;
assign(g1,current_dir+'\tmp\temp4'+s4+'.pas');rewrite(g1); if ioresult<>0 then begin showmessage('Fatal error 17');halt;end;
assign(h1,current_dir+'\tmp\temp5'+s4+'.pas');rewrite(h1); if ioresult<>0 then begin showmessage('Fatal error 18');halt;end;

if consts[1,1]=0 then begin
while not eof(f) do begin readln(f,s); writeln(g,s); writeln(h,s);writeln(g1,s); writeln(h1,s)  end;
closefile(f); closefile(g); closefile(h); closefile(g1); closefile(h1); continue end;
{case when different constants are used in tests with numbers having different remainders after its division by 4}
k1:=0;
while not eof(f) do begin
readln(f,s); if (copy(s,1,5)='const')and((k1<=1)and(consts[1,2]<>0)or(k1<1)and(consts[1,2]=0))then begin k1:=k1+1;
p:=pos('=', s); q:=pos(';',s);if (q>0)and(p>0)and(p<length(s))then
begin
s4:=copy(s,1,p)+inttostr(consts[1,k1])+copy(s,q,200);
s5:=copy(s,1,p)+inttostr(consts[2,k1])+copy(s,q,200);
s6:=copy(s,1,p)+inttostr(consts[3,k1])+copy(s,q,200);
s7:=copy(s,1,p)+inttostr(consts[4,k1])+copy(s,q,200);end;
writeln(g,s4); writeln(h,s5);writeln(g1,s6); writeln(h1,s7);;end
else begin writeln(g,s); writeln(h,s);writeln(g1,s); writeln(h1,s)end
end;

//of while the lower
closefile(f); closefile(g); closefile(h); closefile(g1); closefile(h1);


//showmessage(inttostr(i2));

end;//of for i2 from 1 to 2
end;{of procedure}

{Compilation}
function compilation(handle:hwnd):boolean;
var b:boolean;i2,p3,p2,ii,ii2,pp,k6,k7,k8,k9,m,k:integer;s45,s46,s44,s3,s4,s2,s1:string;f,g:textfile;
begin
setcurrentdir(current_dir);form2.button5.enabled:=false;
form2.button10.enabled:=false;
form2.button11.enabled:=false;
//form2.memo1.clear;
deletefile(current_dir+'\tmp\temp1.exe');deletefile(current_dir+'\tmp\temp10.exe');
deletefile(current_dir+'\tmp\temp2.exe');deletefile(current_dir+'\tmp\temp3.exe');
deletefile(current_dir+'\tmp\temp4.exe');deletefile(current_dir+'\tmp\temp5.exe');
deletefile(current_dir+'\tmp\temp20.exe');deletefile(current_dir+'\tmp\temp30.exe');
deletefile(current_dir+'\tmp\temp40.exe');deletefile(current_dir+'\tmp\temp50.exe');
deletefile(current_dir+'\tmp\temp1.o');deletefile(current_dir+'\tmp\temp10.o');
deletefile(current_dir+'\tmp\temp2.o');deletefile(current_dir+'\tmp\temp3.o');
deletefile(current_dir+'\tmp\temp4.o');deletefile(current_dir+'\tmp\temp5.o');
deletefile(current_dir+'\tmp\temp20.o');deletefile(current_dir+'\tmp\temp30.o');
deletefile(current_dir+'\tmp\temp40.o');deletefile(current_dir+'\tmp\temp50.o');
//showmessage('we are here');
compilation:=false;

assignfile(f,current_dir+'\tmp\temp2.exe'); closefile(f); ioresult; rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp2.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp2.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp3.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp3.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp3.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp4.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp4.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp4.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp5.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp5.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp5.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp20.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp20.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp20.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp30.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp30.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp30.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp40.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp40.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp40.exe. Перезагрузите компьютер.');exit end else closefile(f);

assignfile(f,current_dir+'\tmp\temp50.exe'); rewrite(f); k:=ioresult;
if k<>0 then begin if en_rus then showmessage('Fatal error. It is impossible to delete ''temp50.exe''. Restart your computer.')else
showmessage('Ошибка. Невозможно удалить файл temp50.exe. Перезагрузите компьютер.');exit end else closefile(f);

deletefile(current_dir+'\tmp\temp2.exe');ioresult;deletefile(current_dir+'\tmp\temp3.exe');ioresult;
deletefile(current_dir+'\tmp\temp4.exe');ioresult;deletefile(current_dir+'\tmp\temp5.exe');ioresult;
deletefile(current_dir+'\tmp\temp20.exe');ioresult;deletefile(current_dir+'\tmp\temp30.exe');ioresult;
deletefile(current_dir+'\tmp\temp40.exe');ioresult;deletefile(current_dir+'\tmp\temp50.exe');ioresult;
deletefile(current_dir+'\tmp\result.txt');ioresult;
//Creation of the files temp0.bat and temp00.bat
assign(f,current_dir+'\tmp\directory.txt');closefile(f); ioresult;
reset(f); if (ioresult=0) and(not(eof(f))) then readln(f,s3)else s3:=chr(1); closefile(f); ioresult;
for i2:=1 to 2 do begin
case i2 of
1:begin assign(f,'.\tmp\temp0.bat');rewrite(f);s4:='';end;
2:begin assign(f,'.\tmp\temp00.bat');rewrite(f);s4:='0' end;
end; //of case
if s3=chr(1)then begin
writeln(f,'.\pascal_compiler_2.6.4\free_pascal_2_6_4\bin\i386-win32\fpc.exe'+' -vu -Sg w '+current_dir+'\tmp\temp2'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f, '.\pascal_compiler_2.6.4\free_pascal_2_6_4\bin\i386-win32\fpc.exe'+' -vu -Sg w '+current_dir+'\tmp\temp3'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f, '.\pascal_compiler_2.6.4\free_pascal_2_6_4\bin\i386-win32\fpc.exe'+' -vu -Sg w '+current_dir+'\tmp\temp4'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f, '.\pascal_compiler_2.6.4\free_pascal_2_6_4\bin\i386-win32\fpc.exe'+' -vu -Sg w '+current_dir+'\tmp\temp5'+s4+'.pas > '+current_dir+'\tmp\result.txt');
end
else begin
writeln(f,s3+' -vu -Sg w '+current_dir+'\tmp\temp2'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s3+' -vu -Sg w '+current_dir+'\tmp\temp3'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s3+' -vu -Sg w '+current_dir+'\tmp\temp4'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s3+' -vu -Sg w '+current_dir+'\tmp\temp5'+s4+'.pas > '+current_dir+'\tmp\result.txt');
end;
closefile(f);ioresult;
end;

assignfile(f,current_dir+'\tmp\temp0.bat'); closefile(f); ioresult; reset(f);
b:=(ioresult=0)and not eof(f);
if not b then begin closefile(f); ioresult end else
begin readln(f,s1); k:=pos(' ',s1);
if k=0 then s2:='!!' else s2:=copy(s1,1,k-1);
b:=fileexists(s2);
closefile(f); ioresult;
end;

//Is it necessary to add the next line?
//if b then if en_rus then showmessage ('Press any key to continue.')else showmessage('Для продолжения нажмите любую клавишу.');
if not b then begin //not b
if en_rus then m:=messagedlg('FPC-compiler was not found. Do you want to find it? ',mterror, [mbyes, mbno],0)
else m:=messagedlg('FPC- компилятор не найден. Вы хотите найти его сами? ',mterror, [mbyes, mbno],0);
closefile(f);ioresult; if m<>6 then begin setcurrentdir(current_dir);exit;end;
b:=form2.OpenDialog2.Execute;if not b then exit else s1:=form2.OpenDialog2.filename;
if pos(' ',s1)>0 then if en_rus then begin showmessage('The path to the files contains blank characters. It is not allowed. Rename the directories.');form1.close end
else begin
showmessage('Путь к файлам содержит пробелы, что недопустимо. Переименуйте подкаталоги.'); form1.close
end;
setcurrentdir(current_dir);
for p2:=1 to length(s1) do if s1[p2]in ['A'..'Z']then s1[p2]:=chr(ord(s1[p2])+32);
if (length(s1)<4)or(copy(s1,length(s1)-2,3)<>'exe')then exit;
closefile(f);ioresult;setcurrentdir(current_dir);
assign(g,'.\tmp\directory.txt');rewrite(g);

//showmessage(current_dir+'!!!!'+s1);
//showmessage(s1);
p2:=1; for p3:=1 to length(current_dir) do begin

//showmessage(inttostr(p3));

if p3>length(s1)then begin p2:=0; break end;

if (current_dir[p3]<>s1[p3])and(not(s1[p3] in ['A'..'Z','a'..'z']))then begin p2:=0; break end;
if ((current_dir[p3]<>s1[p3])and(abs(ord(current_dir[p3])-ord(s1[p3]))<>32))and(s1[p3] in ['A'..'Z','a'..'z'] )then begin

//showmessage(inttostr(p3));

p2:=0; break end;
end;
//p2:=pos(current_dir,s1);
//showmessage(inttostr(p2));

if p2<>1 then write(g,s1)else write(g,'.'+copy(s1,length(current_dir)+1,1000));
closefile(g);ioresult;
closefile(f);ioresult;
for i2:=1 to 2 do begin
case i2 of
1:begin assign(f,'.\tmp\temp0.bat');rewrite(f);s4:='';end;
2:begin assign(f,'.\tmp\temp00.bat');rewrite(f);s4:='0';end;
end; //of case
closefile(f); ioresult; rewrite(f); if ioresult<>0 then exit;
writeln(f,s1+' -vu -Sg w '+current_dir+'\tmp\temp2'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s1+' -vu -Sg w '+current_dir+'\tmp\temp3'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s1+' -vu -Sg w '+current_dir+'\tmp\temp4'+s4+'.pas > '+current_dir+'\tmp\result.txt');
writeln(f,s1+' -vu -Sg w '+current_dir+'\tmp\temp5'+s4+'.pas > '+current_dir+'\tmp\result.txt'); closefile(f); ioresult;
end;//of i2:=1 to 2
end; //of not b
closefile(f);ioresult;

for k:=1 to max_test_number do deletefile(current_dir+'\tmp\rrr'+inttostr(k));
for k:=1 to max_test_number do deletefile(current_dir+'\tmp\rrrr'+inttostr(k));

compilation:=false;//form2.memo2.clear; form2.memo3.clear;
for i2:=1 to 2-byte(not(program_sub))do begin
if i2=1 then k:=ShellExecute(Handle, 'open',pchar(current_dir+'\tmp\temp0.bat'), nil, nil,sw_hide);
if i2=2 then k:=ShellExecute(Handle, 'open',pchar(current_dir+'\tmp\temp00.bat'), nil, nil,sw_hide);
if en_rus then begin form3.caption:='Compilation';
if program_sub then if i2=1 then form3.label1.caption:='The main file is being compiled.'+chr(10)+'Please, wait.'
else form3.label1.caption:='The file with the subprogram is being compiled.'+chr(10)+'Please, wait.'else
form3.label1.caption:='The file is being compiled.'+chr(10)+'Please, wait.'end else
begin form3.caption:='Компиляция';
if program_sub then if i2=1 then form3.label1.caption:='Основной файл компилируется. Ждите.'
else form3.label1.caption:='Файл с подпрограммой компилируется. Ждите.'else
form3.label1.caption:='Файл компилируется. Ждите.'end;
form3.showmodal;
closefile(f); ioresult;
//showmessage(inttostr(byte(compi)));
if compi then begin assignfile(f,current_dir+'\tmp\result.txt'); closefile(f); ioresult; reset(f); k:=ioresult;
//showmessage(inttostr(k));

if k=0 then begin while not eof(f) do begin
readln(f,s1); //form2.memo1.lines.add(s1)

end; closefile(f) end;end
else
begin closefile(f); ioresult;
//if en_rus then showmessage('The compilation failed. Check your compiler.')else
//showmessage('Компиляция невозможна. Проверьте компилятор.');
//deletefile(current_dir+'\tmp\temp0.bat');halt
end;
closefile(f);ioresult;
if i2=1 then begin
assignfile(f,'.\tmp\temp2.exe'); closefile(f); ioresult; reset(f); k6:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp3.exe'); closefile(f); ioresult; reset(f); k7:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp4.exe'); closefile(f); ioresult; reset(f); k8:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp5.exe'); closefile(f); ioresult; reset(f); k9:=ioresult;closefile(f); ioresult;end
else begin
//showmessage('We are here');
assignfile(f,'.\tmp\temp20.exe'); closefile(f); ioresult; reset(f); k6:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp30.exe'); closefile(f); ioresult; reset(f); k7:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp40.exe'); closefile(f); ioresult; reset(f); k8:=ioresult;closefile(f); ioresult;
assignfile(f,'.\tmp\temp50.exe'); closefile(f); ioresult; reset(f); k9:=ioresult;closefile(f); ioresult;

end;
//showmessage(inttostr(k));
if i2=1 then if en_rus then s45:=' of the main file ' else s45:=' основного файла ';
if i2=2 then if en_rus then s45:=' of the file with the subprogram ' else s45:=' файла с подпрограммой ';
if not program_sub then s45:=' ';

//k6:=0; k7:=0; k8:=0; k9:=0;
//if (k6<>0)or(k7<>0)or(k8<>0)or(k9<>0)then
//showmessage(inttostr(k6)+' '+inttostr(k7)+' '+inttostr(k8)+inttostr(k9));

if (k6=0)and(k7=0)and(k8=0)and(k9=0) then begin set_initial_text(form2.Memo5);
if not en_rus then form2.memo1.lines.add('Компиляция'+s45+'прошла успешно.') else
form2.memo1.lines.add('The compilation'+s45+'was successful.')end
else begin
if i2=1 then if en_rus then s45:='main file'else s45:=' ocновного файла';
if i2=2 then if en_rus then s45:='file with the subprogram'else s45:=' файла с подпрoграммой';
if not program_sub then if en_rus then s45:='program' else s45:='';

if i2=1 then s44:=''else s44:='0';
fill_file_text_err(current_dir+'\tmp\temp1'+s44+'.pas', current_dir+'\tmp\result.txt');
if en_rus then showmessage (' Errors were found while compiling the '+s45+'. It cannot be executed.')else
showmessage('Были ошибки при компиляции'+s45+'. Выполнение пpограммы невозможно. ')end;
if (k6<>0)or(k7<>0)or(k8<>0)or(k9<>0)then break;
end;//of i2 from 1 to 2
compilation:=(k6=0)and(k7=0)and(k8=0)and(k9=0);
end;

{Testing}
procedure testing(handle:hwnd);

//Break and output the input or output files; the exclamation mark is the separator; i=1,2,3 - input, received, correct respectively.
procedure output_multifiles(si:string;k:integer);
var ar,ae:array[1..10]of string[30];j,i:integer;sa,sb:string;
begin i:=1;if en_rus then sb:='file: ' else sb:='фaйл: ';delete_blanks(si);
ar[1]:='первый ';ar[2]:='второй ';
ar[3]:='трeтий ';ar[4]:='четвертый ';
ar[5]:='пятый ';ar[6]:='шeстой ';
ar[7]:='ceдьмой ';ar[8]:='вocьмой ';
ar[9]:='девятый ';ar[10]:='десятый ';
ae[1]:='the first ';ae[2]:='the second ';
ae[3]:='the third ';ae[4]:='the fourth ';
ae[5]:='the fifth ';ae[6]:='the sixth ';
ae[7]:='the seventh ';ae[8]:='the eighth ';
ae[9]:='the ninth ';ae[10]:='the tenth ';
if k=1 then
if en_rus then form2.Memo1.Lines.Add('Initial data: ') else form2.Memo1.Lines.Add('Исходные данные: ');
if k=2 then
if en_rus then form2.Memo1.Lines.Add('Obtained result: ') else form2.Memo1.Lines.Add('Полученный результат: ');
if k=3 then
if en_rus then form2.Memo1.Lines.Add('Correct result: ') else form2.Memo1.Lines.Add('Правильный результат: ');
if (chosen_task='15_32-002')or(chosen_task='15_32-004') then begin if si[1]='.' then si:='-'+si;
if en_rus then form2.memo1.Lines.Add('the file: '+copy(si,1,length(si)-2)) else form2.memo1.Lines.Add('файл: '+copy(si,1,length(si)-2));
if en_rus then form2.memo1.Lines.Add('the character: '+si[length(si)])else form2.memo1.Lines.Add('символ: '+si[length(si)]);
exit; end;

if chosen_task='15_11' then begin j:=pos(' ',si);
if en_rus then form2.memo1.lines.add('the key: '+copy(si,1,j-1))
else form2.Memo1.Lines.add('ключ: '+copy(si,1,j-1));  delete(si,1,j); delete_blanks(si); if si='' then si:='-';
end;
if chosen_task='15_10-002' then begin j:=pos('!',si); if j=1 then begin inc(j); si:='-'+si; end;if j>0 then begin if en_rus then form2.memo1.lines.add('the file for comparing: '+copy(si,1,j-1))
else form2.Memo1.Lines.add('файл для сравнения: '+copy(si,1,j-1)); delete(si,1,j); end;end;
repeat
delete_blanks(si); if (si<>'')and((si[1]='!')and((filein=1)or(k>1))or(copy(si,1,6)='-10000')and(filein=2))then si:='-'+si;

if (k=1)and(filein=2) then j:=pos('-10000',si) else j:=pos('!',si);

if j>0 then begin sa:=copy(si,1,j-1); delete(si,1,j+ord(filein=2)*5)end else begin sa:=si; si:='' end;
if (i=1)and(si='')then begin ar[1]:=''; ae[1]:='the ' end;
if en_rus then form2.memo1.lines.add(ae[i]+sb+sa)else form2.memo1.lines.add(ar[i]+sb+sa);
inc(i); until si='';
end;

//An output of the text file in order of its rows
//s - the text; k=1,2,3 - input, output, correct

//!!Attention! Points or semicolons are not allowed!! They are special characters!

procedure outputtextfile(s:string;k:integer);
procedure addblanks(var s:string);
var i,q:integer;s2,s1:string;
begin s1:=''; s2:=s1;
q:=pos(' ',s); if q=0 then exit;
s1:=copy(s,1,q); delete(s,1,q); for i:=q to 13 do s1:=s1+' ';
q:=pos(' ',s); if (s='')or(q=0)or(not(s[1] in ['A'..'Z']))then begin s:=s1+s; exit;end;
s2:=copy(s,1,q); delete(s,1,q); for i:=q to 11 do s2:=s2+' ';
if (s<>'')and(s[1]='f')then s[1]:='F';
if (s<>'')and(s[1]='m')then s[1]:='M';
s:=s1+s2+s;
end;

var q1,q2,q,p:integer;bc:boolean;s1,s2:string;
begin
if (copy(chosen_task,1,5)='15_63')and(k=3)and(s='Too many records.') then begin if not en_rus then s:='Количество записей больше максимально допустимого.';end;
//if (s<>'')and(s[1]=' ')then delete(s,1,1);

//if (length(s)<40)and(length(s)>10)  then begin q:=pos('.',s); showmessage(copy(s,1,q)+' '+inttostr(length(copy(s,1,q)))+' '+copy(s,q+1,1000)+' '+inttostr(length(copy(s,q+1,10000))));end;

if (s<>'')and (s[length(s)]='.')
//and (chosen_task<>'15_55')or (s<>'')and (s[length(s)]=chr(6))and (chosen_task='15_55')
then delete(s,length(s),1);
if copy(chosen_task,1,4)<>'15_6'then
q1:=pos('.',s)else q1:=0;
//else q1:=0;
;bc:=q1>0;

if chosen_task='15_60' then for q2:=1 to length(s) do begin if s[q2]='~' then s[q2]:=';'; if s[q2]='#' then begin delete(s,q2,1);break end end;
if ((chosen_task='15_61')or (chosen_task='15_62'))and(s<>'')and(s[length(s)]='#')then delete(s,length(s),1);

s1:=s; if bc then begin s2:=copy(s1,q1+1, length(s1)); s1:=copy(s1,1,q1-1) end;
//showmessage(s1+'   '+s2);
form2.Memo1.Font.Name:='Courier New';
//showmessage('!'+s+'!');
if k=1 then
if en_rus then form2.Memo1.Lines.Add('Initial data: ') else form2.Memo1.Lines.Add('Исходные данные: ');
if k=2 then
if en_rus then form2.Memo1.Lines.Add('Obtained result: ') else form2.Memo1.Lines.Add('Полученный результат: ');
if k=3 then
if en_rus then form2.Memo1.Lines.Add('Correct result: ') else form2.Memo1.Lines.Add('Правильный результат: ');
for q2:=1 to 1+byte(bc) do begin
if q2=1 then s:=s1 else s:=s2;
case q2 of
2:begin if en_rus then form2.Memo1.Lines.Add('The second file: ') else form2.Memo1.Lines.Add('Втоpoй файл: ')end;
1:begin if bc then if en_rus then form2.Memo1.Lines.Add('The first file: ') else form2.Memo1.Lines.Add('Первый файл: ')end;
end;{of case}

if s='' then if en_rus then form2.Memo1.Lines.add('<Empty file>') else form2.Memo1.Lines.add('<Пустoй фaйл>')else
repeat
p:=pos(chr(2),s);
if p=1 then begin if en_rus then form2.Memo1.Lines.add('<Empty line>') else form2.Memo1.Lines.add('<Пустая строка>');
delete(s,1,1);continue end;
if copy(chosen_task,1,5)='15_63' then begin
if not((pos('Too',s)>0)and(pos('many',s)>0)and(pos('records',s)>0) or
(pos('записей',s)>0)and(pos('больше',s)>0)and(pos('максимально',s)>0))
then addblanks(s)else if k=3 then s:=s+'.'else if length(s)>2 then s:=copy(s,1,length(s)-1)+'.'+s[length(s)];
p:=pos(chr(2),s); end;
if p=0 then begin form2.memo1.Lines.Add(s); s:='' end else begin
form2.memo1.Lines.Add(copy(s,1,p-1)); delete(s,1,p)end;
until s='';
end;
end;

//A special correction of the output for the task 14_15-002 and 14_27-002-003. All blanks are deleted.
procedure correct14_15_27(var sr:string);
var p:integer;
begin repeat p:=pos(' ',sr); if p>0 then delete(sr,p,1) until p=0 end;

//A special correction of the result for the task 8.47-002. It is possible to obtain XY(Z-1)99999 instead of XYZ00000 that is correct too.
procedure correct847(var sr,so:string);
var i:integer;k:boolean;
var srr,soo:string;
begin k:=false;srr:=sr; soo:=so;

if length(sr)<>length(so)then exit;
for i:=1 to length(srr)-4 do
begin
if (srr[i]=' ')and(soo[i]=' ')then continue;
if (ord(srr[i])=ord(soo[i])-1)and not k then begin k:=true;srr[i]:=chr(ord(srr[i])+1);continue end;
if not k and (srr[i]<>soo[i]) then exit;
if k then if not (srr[i]='9') and(soo[i]='0')then exit else srr[i]:='0';
end;
sr:=srr; so:=soo;
end;

//A special correction of the result such as Error, No roots and some others. The first letter is converted to uppercase; the other letters are converted to lowercase;
procedure correctcapitalsmall(var sr:string);
var p,i:integer;b:boolean; label 1;
begin b:=false;
//showmessage(sr);
delete_blanks(sr);if sr='' then exit;
if (pos(sr[1],ruscapsmall)>0)or(chosen_task='7_24')or(copy(chosen_task,1,5)='15_63') then goto 1;
if (length(sr)=5) and (sr[1] in ['e','E']) and (sr[2] in ['r','R'])and( sr[3] in ['r','R'])and( sr[4] in ['o','O'])and( sr[5] in ['r','R'])then b:=true;
if (length(sr)=8) and (sr[1] in ['n','N']) and (sr[2] in ['o','O'])and( sr[3] =' ')and( sr[4] in ['R','r'])and( sr[5] in ['o','O'])
and( sr[6] in ['o','O'])and( sr[7] in ['t','T'])and( sr[8] in ['s','S'])then b:=true;
if not b then exit;
1:for i:=1 to length(sr) do begin
if (i=1)and(sr[1]in ['a'..'z'])or(i>1)and(sr[i]in ['A'..'Z']) then sr[i]:=chr(ord(sr[i])+32-64*ord(i=1));
p:=pos(sr[i],ruscapsmall);
if (i=1)and(p in [34..66])or(i>1)and(p in [1..33]) then sr[i]:=ruscapsmall[p+33-66*ord(i=1)];
end;
//showmessage(sr);
end;

//A special correction of the result for the task 8.46. All capital letters are replaced by the corresponding small letters;
//A blank is inserted between the last letter and the following digit.
procedure correct846(var sr:string);
var i:integer;
begin
for i:=1 to length(sr) do if sr[i] in ['A'..'Z'] then sr[i]:=char(ord(sr[i])+32);
for i:=1 to length(sr)-1 do if (sr[i]in ['a'..'z'])and (sr[i+1] in ['0'..'9'])then
begin sr:=copy(sr,1,i)+' '+copy(sr,i+1,length(sr)-i);break;end;
end;

//Analyzing of the result of the task 8.29- 008
function analysis_8_29_8(si,sr,so:string):integer;
const maxo=100; var a,b,d:array[1..maxo]of real;c:array[1..maxo] of boolean; k5,i,j,k3,q,k4,p,k1,k2:integer;s:real;b1:boolean;
begin
delete_blanks(si);delete_blanks(sr);delete_blanks(so);
analysis_8_29_8:=1;k1:=0; k5:=0;k2:=0;for p:=1 to maxo do c[p]:=false;

repeat p:=pos(' ',si); inc(k1); if k1=maxo then exit; if p=0 then begin val(si,a[k1],q);
if q<>0 then exit;break; end else begin val(copy(si,1,p-1),a[k1],q); delete(si,1,p); if q<>0 then exit; end until false;
repeat p:=pos(' ',sr); inc(k2); if k2=maxo then exit; if p=0 then begin val(sr,b[k2],q);
if q<>0 then exit;break; end else begin val(copy(sr,1,p-1),b[k2],q); delete(sr,1,p); if q<>0 then exit; end until false;
if k1<k2 then begin analysis_8_29_8:=3;exit end;
if k1>k2 then begin analysis_8_29_8:=4;exit end;

repeat p:=pos(' ',so); inc(k5); if k5=maxo then exit; if p=0 then begin val(so,d[k5],q);
if q<>0 then exit;break; end else begin val(copy(so,1,p-1),d[k5],q); delete(so,1,p); if q<>0 then exit; end until false;

for p:=1 to k1 do for q:=p+1 to k1 do if b[p]=b[q] then exit;
s:=a[1];k3:=0; for i:=1 to k1 do if b[i]=s then begin k3:=i; break end; if k3=0 then exit;
for i:=1 to k1 do begin if (i<k3)and(b[i]>=b[k3])or (i>k3)and(b[i]<=b[k3])then exit;
k4:=0; for j:=1 to k1 do if a[j]=b[i]then begin if c[j] then exit; c[j]:=true; k4:=1; break end; if k4=0 then exit;
end;



b1:=false; for i:=1 to k2 do if b[i]<>d[i]then b1:=true;
analysis_8_29_8:=byte(b1)*5;

end;

//A special correction of the output data for the tasks 14.38. All blanks between letters are deleted.
procedure correct14_38(var s:string);
var p:integer;
begin
//if s<>'' then showmessage('!!!  '+s+'    '+s[1]);
if s='' then exit; repeat p:=pos(' ',s);if p=0 then exit;
s:=copy(s,1,p-1)+copy(s,p+1,length(s)); until s='';
//showmessage(s);
end;

//A special correction of the result for the task 8.56 and 8.59. A blank character is inserted between each pair of Latin letters.
procedure correct856_59(var sr:string);
var i:integer; b:boolean;
begin
b:=false; while not b do begin b:=true;
for i:=1 to length (sr)-1 do if (sr[i] in ['A'..'Z','a'..'z']) and
(sr[i+1] in ['A'..'Z','a'..'z'])then begin sr:=copy(sr,1,i)+' '+copy(sr,i+1,200);
b:=false; break end;end;
end;

//A special correction of the input data for the task 11.22a. Two initial strings are output at different lines if it is a test for the main block;
//ii5=1/2 - then main block/the function is tested.
var string_out:array[1..100]of string;number_of_lines:integer;
procedure correct11_22a(s:string; ii5:integer);
var p:integer;
begin
if en_rus then string_out[1]:='Initial data:' else string_out[1]:='Исходные данные:';
if ii5=1 then begin
if en_rus then string_out[2]:='the first string: ' else string_out[2]:='первaя строка: ';
string_out[2]:=string_out[2]+copy(s,1,length(s) div 2);
if en_rus then string_out[3]:='the second string: ' else string_out[3]:='вторая строка: ';
string_out[3]:=string_out[3]+copy(s,length(s) div 2+1,length(s));end
else begin p:=pos(chr(10),s);if p=0 then begin showmessage('Error! No ''\n'' in tests for the subroutine.'); p:=1 end;
if en_rus then string_out[2]:='the string: '+copy(s,1,p-1)else string_out[2]:='строка: '+copy(s,1,p-1);s:=copy(s,p+1,length(s));
p:=pos(chr(10),s);if p=0 then begin showmessage('Error! No ''\n'' in tests for the subroutine.'); p:=1 end;
if length(s)<p+2 then s:=s+'!!!!!!!!';
if en_rus then string_out[3]:='substring bounds: '+copy(s,1,p-1)else string_out[3]:='грaницы пoдстpoки: '+copy(s,1,p-1);
if en_rus then string_out[4]:='character range: '+s[p+1]+' '+s[p+2]else string_out[4]:='диапазон символов: '+s[p+1]+' '+s[p+2];

//string_out[3]:=copy(s,p+1,length(s));

end;end;
//A special correction of the output for the task 11_24 when the subprogram is tested.
procedure correct11_24(si:string;it:integer);//si - the input string; it - the number of the current test
var p,i:integer;s:string;
begin s:='';
for i:=1 to consts[it,1] do begin p:=pos(' ',si);if p=0 then begin s:=s+si; si:='';break end else begin s:=s+' '+copy(si,1,p-1); delete(si,1,p);
if si=''then break end;end;
if en_rus then string_out[1]:='The first array: '+s else string_out[1]:='Первый массив: '+s;
s:='';
for i:=1 to consts[it,1] do begin p:=pos(' ',si);if p=0 then begin s:=s+si; si:='';break end else begin s:=s+' '+copy(si,1,p-1); delete(si,1,p);
if si=''then break end;end;
if en_rus then string_out[2]:='The second array: '+s else string_out[2]:='Втоpoй массив: '+s;
if en_rus then string_out[3]:='The range of indices: '+si else string_out[3]:='Диапазон индексов : '+si;
end;

//A special correction of input and output data for the tasks 6_24, 15_25 and 15_49 - all blanks are replaced by '_' and all tab characters are replaced by '~'.
procedure correct6_24_15_25(var s:string);
var i:integer;
begin
for i:=1 to length(s) do if s[i]=' ' then s[i]:='_';
for i:=1 to length(s) do if s[i]=chr(9) then s[i]:='~';
end;

//A special correction of the result for the task 13_12-002
procedure correct13_12_2(var sr,so:string);
var pp,q,p,i1,j1,i2,j2:integer;
begin
//showmessage(sr);
//showmessage(so);

p:=pos(' ',sr);
q:=pos(' ',so);
if (p=0)or(q=0)then exit;
val(copy(sr,1,p-1),i1,pp);if pp<>0 then exit;
val(copy(sr,p+1,100),j1,pp);if pp<>0 then exit;
val(copy(so,1,q-1),i2,pp);if pp<>0 then exit;
val(copy(so,q+1,100),j2,pp);if pp<>0 then exit;
if i1*j2=i2*j1 then begin
//showmessage('!!!!');
sr:=inttostr(i2)+' '+inttostr(j2);end;

//showmessage('!!! '+sr);
end;

//A special correction of the result for the tasks 10_21 and 10_22
procedure correct10_21_22(var sr:string);
var p:integer;
begin
repeat
p:=pos(' ',sr);
if (p=0)then exit;
delete(sr,p,1)
until false;
end;

//A special analysis if the pointers were changed in the tasks 16_16
procedure correct_16_16(var s:string);
var i:integer;
begin
i:=pos('!',s);
if (s<>'') and(i>0)and((chosen_task='16_16-001')or(chosen_task='16_16-004')or(chosen_task='16_16-007'))  then begin
if en_rus then s:=copy(s,1,i-2)+'.'+
' The pointers to the strings were changed. It is not allowed.' else
s:=copy(s,1,i-2)+'.'+' Были изменены указатели в массиве ссылок, что недопустимо.'
end;
if (s<>'') and(i>0)and(chosen_task<>'16_16-001')and (chosen_task<>'16_16-007')and (chosen_task<>'16_16-004')then begin
if en_rus then s:=copy(s,1,i-2)+'.'+
' The subroutine changed pointers to the strings incorrectly.' else
s:=copy(s,1,i-2)+'.'+' В подпрограмме были некорректно изменены значения указателeй в массиве ссылок.'
end;
end;


//A special correction for the tasks 16_18 and others removal of the last number equal to 1E20 and analysis if the pointer was changed.
procedure correct_16_1E20(var s:string);
var i:integer;
begin i:=pos('1E',s); if i>0 then begin delete(s,i,4);exit end;
i:=pos('!',s); if i>0 then if en_rus then s:=copy(s,1,i-2)+'.'+
' The pointer to the first node of the list was changed. It is not allowed.' else
s:=copy(s,1,i-2)+'.'+' Была изменена ссылка на первое звено списка, что недопустимо.'
end;

//A special correction for the tasks 16_19 - removal of the last @ and analysis if the pointer was changed.
procedure correct_16_19(var s:string);
var i:integer;
begin i:=pos('@',s); if i>0 then begin delete(s,i,1);exit end;
i:=pos(' !',s); if i>0 then if en_rus then s:=copy(s,1,i-1)+'.'+
' The pointer to the first node of the list was changed. It is not allowed.' else
s:=copy(s,1,i-1)+'.'+' Была изменена ссылка на первое звено списка, что недопустимо.'
end;


//A special procedure that checks if the amount of calls of New or Dispose procedure was incorrect.
procedure checknewdispose(var s:string);
var p1,p2:integer;s1:string;
begin
p1:=pos(' !',s);

//showmessage('We are here'+inttostr(p1)+'    '+s);



if check_new and not check_dispose and (p1>0) then begin
s:=copy(s,1,p1-1);s1:=s;delete_blanks(s1);
if s1<>'' then s:=s+'.';
if en_rus then s:=s+' The New procedure was called a wrong number of times.' else
s:=s+' Было зафиксировано неверное количество обращений к процедуре New.';end;
if check_dispose and not check_new and (p1>0) then begin
s:=copy(s,1,p1-1);s1:=s; delete_blanks(s1);
if s1<>'' then s:=s+'.';
if en_rus then s:=s+' The Dispose procedure was called a wrong number of times.' else
s:=s+' Было зафиксировано неверное количество обращений к процедуре Dispose.';end;
if check_dispose and check_new and (p1>0) then begin
s:=copy(s,1,p1-1);s1:=s;delete_blanks(s1);
if s1<>'' then s:=s+'.';
if en_rus then s:=s+' The New and Dispose procedures were called a wrong number of times.' else
s:=s+' Было зафиксировано неверное количество обращений к процедурaм New и Dispose.';end;
end;


//A special correction for the task 15_58
function correct_15_58(var s:string):integer;
var s1:string;k:integer;
begin delete_blanks(s); s1:=''; while s<>'' do begin if s[1]<>chr(2) then s1:=s1+s[1]else begin inc(k); s1:=s1+' 0 '; end; delete(s,1,1) end; delete_blanks(s1); s:=s1;
//showmessage(inttostr(k));
correct_15_58:=k end;

//A procedure that replaces the numbers of months by their names.
procedure month_num_name(p1:integer; var s3:string);
begin
if en_rus then
case p1 of 1: s3:='January'; 2:s3:='February'; 3: s3:='March'; 4:s3:='April'; 5:s3:='May'; 6:s3:='June'; 7:s3:='July'; 8:s3:='August'; 9:s3:='September'; 10:s3:='October'; 11:s3:='November'; 12:s3:='December';end
else
case p1 of 1: s3:='января'; 2:s3:='фeвраля'; 3: s3:='мартa'; 4:s3:='aпреля'; 5:s3:='мaя'; 6:s3:='июня'; 7:s3:='июля'; 8:s3:='aвгуcтa'; 9:s3:='ceнтября'; 10:s3:='oктябpя'; 11:s3:='нoябpя'; 12:s3:='дeкабpя';end;
end;

//A special correction of the input data (removing two last zeroes and inserting pairs of square brackets, replacing numbers by month names) for the task 15.8 and 15.23
procedure correct15_8_23(var s:string);
var p2,p1,p:integer;s2,s1,s3:ansistring;
begin delete_blanks(s);s2:=''; s3:='';
if (length(s)>=3) and (s[length(s)]='0')then delete(s,length(s)-2,3);
if chosen_task='15_8' then begin s1:=''; while s<>'' do begin s1:=s1+'[';p:=pos(' ',s); s1:=s1+copy(s,1,p); delete(s,1,p); p:=pos(' ',s); s1:=s1+copy(s,1,p-1)+']  '; delete(s,1,p); end;
s:=s1; end;
if chosen_task='15_23' then begin s1:=''; while s<>'' do begin p:=pos(' ',s); s2:=copy(s,1,p-1); delete(s,1,p); p:=pos(' ',s);s3:=copy(s,1,p-1); delete(s,1,p); val(s3,p1,p2);
month_num_name(p1,s3);
if en_rus then s1:=s1+' '+s3+' '+s2+',' else s1:=s1+' '+s2+' '+s3+',';end;
delete_blanks(s1); if (s1<>'')then delete(s1,length(s1),1); if s1<>''then s1:=s1+'.'; s:=s1 end;

//showmessage(s);
end;

//A special output for the task 15_23 - numbers of months are converted into its names.
procedure output15_23(var s:string; k:integer);
var b3:boolean;s4,s5, s2,s3,s1:string;p2,p1,p:integer;      b1,b2:boolean;
begin
b1:=false; b2:=false;
b3:=false; s1:='';delete_blanks(s);
if k=1 then
if en_rus then form2.Memo1.Lines.Add('Obtained result:')else form2.Memo1.Lines.Add('Полученный результат:')
else
if en_rus then form2.Memo1.Lines.Add('Correct result:')else form2.Memo1.Lines.Add('Правильный результат:');
if en_rus then s1:='summer dates: 'else s1:='лeтниe дaты: ';
if en_rus then s4:='winter dates: 'else s4:='зимние дaты: ';

while s<>'' do begin p:=pos(' ',s); s2:=copy(s,1,p-1); delete(s,1,p); p:=pos(' ',s);if p>0 then begin s3:=copy(s,1,p-1); delete(s,1,p)end else begin s3:=s; s:='' end; delete_blanks(s);
val(s3,p1,p2);         //if p2<>0 then showmessage('Error!');
if p1<1 then begin b3:=true;continue end;
month_num_name(p1,s3);
if p1 in [1,2,12] then b2:=true;
if p1 in [6,7,8] then b1:=true;

if b3 then if en_rus then s4:=s4+' '+s3+' '+s2+',' else s4:=s4+' '+s2+' '+s3+','
else if en_rus then s1:=s1+' '+s3+' '+s2+',' else s1:=s1+' '+s2+' '+s3+','; end;//of while s<>''
delete_blanks(s4);delete_blanks(s1);

if not b1 then form2.memo1.lines.add(s1+' -')else form2.memo1.lines.add(copy(s1,1,length(s1)-1)+'.');
if not b2 then form2.memo1.lines.add(s4+' -')else form2.memo1.lines.add(copy(s4,1,length(s4)-1)+'.');
end;

//A special output for the tasks 10_21 and 10_22 - a chessboard is output as a 8*8 matrix
procedure output10_21_22(sa:string;p:integer);
var i,j:integer;s:string;
begin
correct10_21_22(sa); form2.memo1.Font.Name:='Courier New';
//showmessage('!!');
if length(sa)<64 then for i:=1 to 64 do sa:=sa+' ';
if p=1 then
if en_rus then form2.Memo1.Lines.Add('Obtained result:')else form2.Memo1.Lines.Add('Полученный результат:')
else
if en_rus then form2.Memo1.Lines.Add('Correct result:')else form2.Memo1.Lines.Add('Правильный результат:');
for i:=1 to 8 do begin s:=''; for j:=1 to 8 do s:=s+' '+sa[(i-1)*8+j]; form2.Memo1.Lines.Add(s);end;
if length(sa)>64 then form2.Memo1.Lines.Add(copy(sa,65,length(sa)))
//showmessage('@@');
end;

//A special correction of the input data (removing the last integer) for the task 15.11, 15.13, 15.15, 15.16 and others that use a file of real or integer
procedure correct15_1int(var s:string);
var p:integer;
begin delete_blanks(s);
while (s<>'')and(s[length(s)]<>' ') do delete(s,length(s),1);
end;

//A special correction of the outout string for the task 15_63-005 - all digits after the decimal point are deleted except for the left one
procedure correct15_63_005(var sr:string);
var p,i,k:integer;
begin i:=1; k:=0; if length(sr)<2 then exit;
repeat inc(k); if (sr[i]in['2'..'5'])and(length(sr)>i)and not (sr[i+1]='.') and(i>1) and not(sr[i-1]='.') then begin insert ('.0',sr, i+1);end;
if (sr[i]in['0'..'9'])and(length(sr)>i)and(sr[i+1]='0')then begin delete(sr,i+1,1); dec(i) end;
inc(i) until (i>length(sr))or(k=9000);
end;

//A special correction of the input data (removing the final point) for the task 15.12, 15.14 and others that use a file of char
procedure correct15_1char(var s:string);
var p:integer;
begin delete_blanks(s);
if(s<>'')and(s[length(s)]='.') then delete(s,length(s),1);
if (chosen_task='15_50-002')and(s<>'') then delete(s, length(s)-1,2);
end;

//A special correction of the input data (removing the final point and inserting blanks) for the task 16.31-002
procedure correct16_31(var s:string);
var s1:string;
begin delete_blanks(s);
if(s<>'')and(s[length(s)]='.') then delete(s,length(s),1);
s1:=' '; while s<>'' do begin s1:=s1+s[1]+' '; delete(s,1,1) end;
s:=s1 end; 

//A special correction of the data containing two or more one-dimensional arrays.
procedure correct_multi_arrays(s:string;n,t,ntest:integer);
//s - data, n - the amount of arrays ; t=0,1,2 - initial, obtained, correct; ntest - the number of the current test
var m,k,p,q,i:integer;s1:string;
begin
delete_blanks(s);
case t of
0:if en_rus then string_out[1]:='Initial data: ' else string_out[1]:='Исходные данные: ';
1:if en_rus then string_out[1]:='Obtained result: ' else string_out[1]:='Полученный результат: ';
2:if en_rus then string_out[1]:='Correct result: ' else string_out[1]:='Правильный результат: ';
end;{case}
for i:=2 to n+1 do string_out[i]:='';
m:=consts[1+(ntest-1) mod 4,1]*n;
//if ntest <5 then showmessage(inttostr(m)+' '+inttostr(ntest));
k:=0;q:=0;s1:='';
while (s<>'') do
begin p:=pos(' ',s); if p=0 then begin s1:=s1+s+' ';s:='';end else
begin s1:=s1+copy(s,1,p-1)+' '; delete(s,1,p)end;
inc(k);if (k=m div n)or (s='') then begin k:=0;inc(q);
case q of
1: if en_rus then s1:='the first array: '+s1 else s1:='первый массив: '+s1;
2: if en_rus then s1:='the second array: '+s1 else s1:='второй массив: '+s1;
3: if en_rus then s1:='the third array: '+s1 else s1:='третий массив: '+s1;
4: if en_rus then s1:='the fourth array: '+s1 else s1:='четвертый массив: '+s1;
end;
if q=n then begin string_out[1+q]:=s1+s;s:=''end else string_out[1+q]:=s1;s1:='' end;
end //of while
end;

procedure correct_matrices(s:string;n,t,ntest,ii5:integer;var number_of_lines:integer);
//s - data, n - amount of martices, t=0,1,2 - input, output, correct (respectively), ntest - number of the current test, ii5=1(2) if the main program (the subpregram) is beign tested;
// output number_of_lines - how many lines were formed
var j,j0, matcols, matrows, p,j3,j1,j2,ii2:integer; rr2:real; si2,si1,s1:string;bi:integer;
begin
j:=1; //current line of the array string_out
case t of
0:if en_rus then string_out[1]:='Initial data: ' else string_out[1]:='Исходные данные: ';
1:if en_rus then string_out[1]:='Obtained result: ' else string_out[1]:='Полученный результат: ';
2:if en_rus then string_out[1]:='Correct result: ' else string_out[1]:='Правильный результат: ';
end;{case}
delete_blanks(s);
matrows:=consts[(ntest-1)mod 4+1,1];
matcols:=consts[(ntest-1)mod 4+1,2];
if matcols=0 then matcols:=matrows;
si1:=s;
bi:=-1;
if result_type[ii5,1]='r' then bi:=0;  //it is one but not L
if result_type[ii5,1]='i' then bi:=1;
if bi=-1 then bi:=ord(pos('.',s)=0);
//bi=0 (1) if elements of the matrix are of type real (integer).
//It is the forming of an array for the future output.
for j0:=1 to n do begin //j0 - the currect matrix
if n>1 then begin
case j0 of
1: if en_rus then s1:='the first matrix: ' else s1:='первая матрица: ';
2: if en_rus then s1:='the second matrix: ' else s1:='вторая матрица: ';
3: if en_rus then s1:='the third matrix: ' else s1:='третья матрица: ';
4: if en_rus then s1:='the fourth matrix: ' else s1:='четвертая матрица: ';
end;
inc(j); string_out[j]:=s1;
end;

for j1:=1 to matrows do begin inc(j); string_out[j]:='';
for j2:=1 to matcols do
begin
delete_blanks(si1);
j3:=pos(' ', si1); if (j3>0)then begin si2:=copy(si1,1,j3-1);if bi=1 then val(copy(si1, 1, j3-1),ii2,p)else val(copy(si1, 1, j3-1),rr2,p);
si1:=copy(si1,j3+1,10000) end else begin si2:=si1; if bi=1 then val(si1,ii2,p)else val(si1,rr2,p);si1:='' end;
if bi=1 then begin if p=0 then str(ii2:7, si2) end else if p=0 then str(rr2:16+3*byte(j2>matcols):5,si2);
string_out[j]:=string_out[j]+si2;
end;{of j2} end;{of j2}
end; {of j0}
if si1<>'' then begin inc(j); string_out[j]:=si1 end;
number_of_lines:=j;

//showmessage(form2.Memo1.Font.Name);

end;

var bloop,b:boolean;ii5,iii,k1,k2,ii,kk,m,l,n,j,k,i,i11:integer; ff,h,f,g:textfile;mr,mo:real;sv,sw,st,so1,sr1,si,so,sr,s:ansistring;n_err,n_err1:integer;
function diff(n_test:integer):integer;//evaluation the accuracy of the result; n_test - number of the current test
//k=0 - Ok, k=1 - error, k=2 - inaccurate result; k=3 - excessive output; k=4 - not enough output
const eps=0.000001;
var r3,r1,r2,accuracy:real; ia1,ic1,pb, pp,l,p1,p2,j,i,i1,i2:integer; sf,s1,s2:string;iii:integer;bbb:boolean;
begin diff:=0;

//if length(sr)<500 then begin
//if  sr<>'' then showmessage('!'+sr);
//if  so<>'' then showmessage('!'+so);
//end;

//application.ProcessMessages;
//if (chosen_task[1]='1') and (chosen_task[2] in ['5'..'7']) then begin
//i41:=length(sr);
//showmessage(sr+' '+inttostr(i41));
//if (i41>=21) and (copy(sr,i41-20,21)='!unclosed!files!left!') then begin sr:=copy(sr,1,i41-21);
//diff:=6;exit; end; end;


if (chosen_task<>'6_24')and(chosen_task<>'15_25')and(textsout=0)then begin
delete_blanks(so);
delete_blanks(sr);end;
if (chosen_task='15_54')or(chosen_task='15_58') or(copy(chosen_task,1,5)='15_63') then begin delete_blanks(so);delete_blanks(sr);end;
//showmessage(sr);
if chosen_task='8_29-008' then begin diff:=analysis_8_29_8(si,sr,so);exit end;

//Arranging the output data in nondescending order if their order does not matter.
if sorts>0 then sorting (sr);

//A special correction for words 'error', 'no roots' and others that can be typed both in small and capital letters.
if (chosen_task='7_24')or (errorr)// and ((copy(sr,1,5)='error')or(copy(sr,1,8)='no roots')))
then begin correctcapitalsmall(sr);//showmessage(sr);
end;

if (run_time_err)and(pos('untime error ',sr)>0)and(pos(' at ',sr)>10)then begin
sf:=sr; pp:=0; repeat inc(pp); until (length(sf)<pp)or(sf[pp]in['1'..'9']);

//showmessage(sf+'    !  '+inttostr(pp));

if sf[pp]in['1'..'9']then begin sf:=copy(sf,pp,10); i11:=1; while(i11<length(sf))and (sf[i11]<>' ')do inc(i11);
val(copy(sf,1,i11-1),pb,pp);

//showmessage(sf+'  '+inttostr(pb)+'  '+inttostr(i11));

if ((so='Runtime error '+inttostr(pb))or(so='runtime error '+inttostr(pb))) and (pos('Runtime error '+inttostr(pb), sr)>0) then begin
diff:=0;exit end;
end;end;

if errorr
then if (so='Error')and ((sr='Error')or(sr='Ошибка'))then begin
diff:=0;exit end;

if chosen_task='4_12-005' then begin
if ((sr='No roots')or(copy(sr,1,3)='Нет'))and(so='No roots') then begin
diff:=0;
//if en_rus then sr:='No roots' else begin sr:='Нет корней'; so:=sr end;
exit end;
if ((sr='Error')or(sr='Ошибка'))and(so='Error') then begin
diff:=0;
//if en_rus then sr:='Error' else begin sr:='Ошибка'; so:=sr ;end;
exit end
end;

//A special correction for the tasks 14.38
if copy(chosen_task,1,5)='14_38' then correct14_38(sr);

//A special correction of the result for the task 8_47_б
if chosen_task='8_47-002' then correct847(sr,so);

//A special correction of the result for the task 8_46_б
if chosen_task='8_46' then correct846(sr);

//A special correction of the result for the task 8_56 and 8_59
if (chosen_task='8_56')or(chosen_task='8_59') then correct856_59(sr);

//A special correction of the result for the tesk 13_12-002
if chosen_task='13_12-002'then
correct13_12_2(sr,so);

//A special correction for the results of the tasks 10_21 and 10_22
if (chosen_task='10_21') or (chosen_task='10_22')
then correct10_21_22(sr);

//A special correction for the results of the tasks 14_15-002
if (chosen_task='14_15-002') or(chosen_task='14_27-002')or (chosen_task='14_27-003') then correct14_15_27(sr);

if chosen_task='15_58' then begin ic1:=correct_15_58(so);ia1:=correct_15_58(sr);
//showmessage('!!!'+inttostr(ic1));
//if ic1>10 then showmessage(inttostr(ic1)+'!'+inttostr(ia1));
//showmessage('@@@@'+inttostr(ic1));

if ia1<>ic1 then begin
diff:=1; exit end;
end;

l:=0;{the current number of the output data}

//showmessage(sr+'@@@'+inttostr(length(sr)));
if (sr<>'')and(so='') and(pos('!',sr)>0)and(check_new or check_dispose) then begin  diff:=1; exit end;
if (sr<>'')and(so='') and(pos('!',sr)>0)and(copy(chosen_task,1,5)='16_16') then begin  diff:=1; exit end;


if (so<>'')and(sr='') then begin diff:=4; exit end;
if (sr<>'')and(so='') then begin diff:=3; exit end;
while (sr<>'')and(so<>'')do begin l:=l+1;

//showmessage(sr);
//showmessage(so);

//Blank characters are not separators for the tasks 6.24, 15.25 and 15.49 and 15.55
if (chosen_task<>'6_24')and(chosen_task<>'15_25') and((textsout=0)or(chosen_task='15_54')or(chosen_task='15_58'))
then begin i:=pos(' ',so); j:=pos(' ',sr);end else begin i:=0; j:=0 end;

if chosen_task='15_63-005'then correct15_63_005(sr);

if (copy(chosen_task,1,5)='15_63') and (so='Too many records.') then begin
//showmessage(sr);

correctcapitalsmall(sr);

//showmessage(sr);

if (pos('Too',sr)>0)and(pos('many',sr)>0)and(pos('records',sr)>0)and(length(sr)<60) or
(pos('записей',sr)>0)and(pos('больше',sr)>0)and(pos('максимально',sr)>0)and(length(sr)<60)
then begin diff:=0; exit end;

end;

//A special exit for the tasks 16.18 if the pointer to the first node of the list was changed
if (i=0)and(j<>0)and ((copy(chosen_task,1,5)='16_18')or(copy(chosen_task,1,5)='16_19'))and(pos('!',sr)>0) then begin diff:=1; exit end;

if (i=0)and(j<>0)and(pos(' !',sr)>0)and (check_new or check_dispose) then begin diff:=1; exit end;

if (i=0)and(j<>0) and(pos(' !',sr)>0)and(copy(chosen_task,1,5)='16_16') then begin  diff:=1; exit end;

if (i=0)and(j<>0)then begin diff:=3;exit end;
if (i<>0)and(j=0)then begin diff:=4;exit end;
if (i=0)and(j=0)then begin s1:=so; s2:=sr ; sr:=''; so:='' end else
begin
s1:=copy(so,1,i-1); so:=copy(so, i+1,10000);
s2:=copy(sr,1,j-1); sr:=copy(sr,j+1,10000);
end;

//A special correction for the task 11.50
//if (chosen_task='11_50')and (s1='=')and(s2='=')then begin s1:='0'; s2:='0' end;

//ii5 =1 (2) - the main program (the subroutine) is being tested
//if N_test=7 then showmessage(inttostr(L));

//showmessage(s1);
//if  (s1<>s2) then begin
//if s1<>'' then showmessage(inttostr(length(s1))+'!'+inttostr(ord(s1[length(s1)])));

//showmessage(s2);
//if s2<>'' then showmessage(inttostr(length(s2))+'!'+inttostr(ord(s2[length(s2)])));

//for j:=1 to length(s1) do if s1[j]<>s2[j]then begin showmessage(inttostr(j)+'@'+inttostr(ord(s1[j]))+'#'+inttostr(ord(s2[j]))); break end;
//end;

case result_type[ii5,L]of
's':begin if s1<>s2 then begin diff:=1; exit end else diff:=0;end;
'c':begin if(length(s1)<>1)or(length(s2)<>1)or(s1<>s2)then begin diff:=1; exit end;end;
'i':begin val(s1,i1,p1);val(s2,i2,p2);if (p1<>0)or(p2<>0)or(i1<>i2)then begin diff:=1; exit end;end;
'b':begin while (s2<>'')and(s2[1]=' ') do s2:=copy(s2,2,100);delete_blanks(s2); if length(s2)>5 then begin diff:=1; exit end;
if (s1='true')or(s1='True') then iii:=integer(pos(s2[1],'YyДдTt')=0)
else if (s1='false')or(s1='False')then iii:=integer(pos(s2[1],'НнFfNn')=0) else begin diff:=1;exit end;
diff:=iii; if iii<>0 then exit;
end;
'r':begin val(s1,r1,p1);val(s2,r2,p2);if (p1<>0)or(p2<>0) then begin diff:=1;

//if (p1<>0) or(p2<>0)then showmessage(s1+'  '+s2);

exit end;
if(r1*r2<0)or(r1=0)and(r2<>0)or(r2=0)and(r1<>0)then begin

//showmessage(floattostr(r1)+'  '+floattostr(r2));

diff:=1; exit end else
begin r1:=abs(r1);r2:=abs(r2); r3:=sqrt(r1)+sqrt(r2);
if (abs(r3)<1e-15)then accuracy:=abs(r1-r2) else accuracy:=2*abs(r1-r2)/r3;
//showmessage (floattostr(accuracy));
//showmessage (floattostr(r1));
//showmessage (floattostr(r2));
//showmessage (floattostr(r3));
if (accuracy<100*eps)and(accuracy>eps)then begin diff:=2;exit end else
if (accuracy>=100*eps)then begin diff:=1;exit end;
end;end
else showmessage('Wrong type of result for the test '+inttostr(n_test)+'.');halt

end;{of case}
end;{of while}
//showmessage(floattostr(r1)+'  '+floattostr(r2)+type_of_result);
end;{of diff}

var outmatr:array[1..100]of string;matcols, matrows:integer;//rows of the matrix and their amount

{procedure that outputs the initial texts for the tasks 16_16}
//This procedure uses a global variable I that is the number of the current test.
procedure output16_16input(s:string);
var p,j:integer;s2,s1:string;
begin
form2.Memo1.Font.Name:='Courier New';if s='' then exit;
if en_rus then form2.memo1.lines.add('Initial data:')
else  form2.memo1.lines.add('Исходные данные:');
if chosen_task='16_16-001' then begin
//showmessage(s);
if (s<>'')and(s[1]='.')then begin form2.memo1.lines.add('-');exit end;
if s[length(s)]='.'then delete(s,length(s),1);
end;

if (chosen_task='16_16-003')or(chosen_task='16_16-005')or(chosen_task='16_16-004')or (chosen_task='16_16-006')or (chosen_task='16_16-007') then
if en_rus then form2.Memo1.Lines.Add('The text:')
else form2.Memo1.Lines.Add('Teкcт:');

if (chosen_task='16_16-003')or(chosen_task='16_16-004')or(chosen_task='16_16-005')or(chosen_task='16_16-006')or (chosen_task='16_16-007')
then begin
if (s<>'')and(s[1]='.')then if en_rus then form2.memo1.lines.add('<Empty text>')else form2.memo1.lines.add('<Пустой текст>');
p:=pos('.',s); delete(s,p,1);
p:=pos(' ',s); if p=0 then exit; s1:=copy(s,p+1,100); delete_blanks(s1); delete(s,p+1,100);end;

//if i<5 then showmessage(s1);

for j:=1 to length(s) div consts[(i-1)mod 4+1,2] do
form2.Memo1.Lines.Add(copy(s,1+(j-1)*consts[(i-1)mod 4+1,2],consts[(i-1)mod 4+1,2]));

if (chosen_task='16_16-003')or(chosen_task='16_16-004')or(chosen_task='16_16-005') then
begin
if en_rus then s2:='I=' else s2:='i=';
p:=pos(' ',s1);if p=0 then exit;
form2.Memo1.Lines.Add(s2+copy(s1,1,p-1));
delete(s1,1,p);
if en_rus then s2:='J=' else s2:='j=';
form2.Memo1.Lines.Add(s2+s1);
end;
//Insert 16_16-006 and 007 here!
end;

{procedure that outputs the result and correct texts for the tasks 16_16}
procedure output16_16output(s:string;kkk:integer);
//This procedure uses a global variable I that is the number of the current test.
var j,p:integer;s2:string;
begin
delete_blanks(s);

//if i=32 then showmessage(s);
//if (i=32) and (s[2]=' ') then showmessage('@@@@@@@@@@@@@');

form2.Memo1.Font.Name:='Courier New';
case kkk of
2:begin if en_rus then form2.memo1.lines.add('Obtained result:')
else  form2.memo1.lines.add('Полученный результат:')end;
3:begin if en_rus then form2.memo1.lines.add('Correct result:')
else  form2.memo1.lines.add('Правильный результат:')end
end;
p:=pos(' ',s);if p>0 then begin s2:=copy(s,p+1,1000); delete(s,p,1000) end else s2:='';
delete_blanks(s);

//if i=32 then showmessage(s+'@'+inttostr(length(s)));

if (s='')or(s='.')then begin if en_rus then form2.Memo1.Lines.Add('<Empty text>')else form2.Memo1.Lines.Add('<Пустoй тeкст>')end else
for j:=1 to length(s) div consts[(i-1)mod 4+1,2] do
form2.Memo1.Lines.Add(copy(s,1+(j-1)*consts[(i-1)mod 4+1,2],consts[(i-1)mod 4+1,2]));
if s2<>'' then form2.Memo1.Lines.Add(s2);
end;

{procedure of forming the array outmatr for output of a matrix in ascending order of its rows}
procedure forminout(sf:string;b:boolean);
//sf - initial string; b=true (false) - it is input (output).
//This procedure uses a global variable I that is the number of the current test.
var p,j3,j1,j2,ii2:integer; rr2:real; si1,si2,si3:string;bi:integer;
begin
while (sf<>'') and(sf[1]=' ') do sf:=copy(sf,2,10000);
while (sf<>'')and(sf[length(sf)]=' ')do sf:=copy(sf,1,length(sf)-1);

//showmessage (inttostr(consts[1])+' '+inttostr(consts[2])+inttostr(consts[3])+inttostr(consts[4]));

matrows:=consts[(i-1)mod 4+1,1];
matcols:=consts[(i-1)mod 4+1,2];
//showmessage(inttostr(matrows)+'  '+inttostr(matcols));
if b then
if (consts[1,1]<>0)and(consts[1,2]=0) then
if en_rus then form2.memo1.lines.add('N='+inttostr(consts[(i-1)mod 4+1,1]))else
form2.memo1.lines.add('n='+inttostr(consts[(i-1)mod 4+1,1]));
if b then
if (consts [1,1]<>0)and(consts[1,2]<>0) then
if en_rus then form2.memo1.lines.add('N='+inttostr(consts[(i-1)mod 4+1,1])+' M='+inttostr(consts[(i-1)mod 4+1,2]))else
form2.memo1.lines.add('n='+inttostr(consts[(i-1)mod 4+1,1])+' m='+inttostr(consts[(i-1)mod 4+1,2]));

if matcols=0 then matcols:=matrows;
for j1:=1 to matrows do outmatr[j1]:='';
si1:=sf;

bi:=byte((copy(chosen_task,1,3)='9_5')or(copy(chosen_task,1,4)='9_18')or(copy(chosen_task,1,4)='9_19')
or (chosen_task='9_25') or (chosen_task='9_27') or(chosen_task='9_31')
)
+2*byte((chosen_task='9_20')or (chosen_task='9_21'));
//bi=0,1,2, if elements of the matrix are of type real, integer , char, respectively.
//It is the output of a matrix, rather the forming of an array for the future output.
if bi<2 then begin
for j1:=1 to matrows do begin si3:=''; for j2:=1 to matcols+byte(chosen_task='9_33')
do begin while (si1<>'')and(si1[1]=' ') do si1:=copy(si1,2,10000);
if (chosen_task='9_33')and(j2<j1)then si2:='              'else
begin
j3:=pos(' ', si1); if j3>0 then begin si2:=copy(si1,1,j3-1);if bi=1 then val(copy(si1, 1, j3-1),ii2,p)else val(copy(si1, 1, j3-1),rr2,p);
si1:=copy(si1,j3+1,10000) end else begin si2:=si1; if bi=1 then val(si1,ii2,p)else val(si1,rr2,p);si1:='' end;
if bi=1 then begin if p=0 then str(ii2:7, si2)end else if p=0 then str(rr2:15+3*byte(j2>matcols):5,si2);
end;
si3:=si3+si2;
if si1='' then break; end; outmatr[j1]:=si3;
if si1='' then break; end;
if si1<>'' then begin inc(matrows); outmatr[matrows]:=si1; end;
end
else begin while true do begin j3:=pos(' ', sf); if j3=0 then break else sf:=copy(sf,1,j3-1)+copy(sf,j3+1,10000)end;{of while}
j3:=1; while j3<length(sf) do begin sf:=copy(sf,1,j3)+' '+copy(sf,j3+1,10000); j3:=j3+2;end;

//showmessage(sf);

sf:=' '+sf; for j1:=1 to matrows do if j1<matrows then begin outmatr[j1]:=copy(sf,1,2*matcols); sf:=copy(sf, 2*matcols+1, 10000) end
else outmatr[j1]:=sf;
end;
end;

//TESTING BEGIN!
var bb:boolean; i43,i42,ppb,pq,nummm,n_err2,ii6,ppa,pa,ii3,ii4,ii2,pp1,pp,ppa1,ppa2,arrayin1,xx1,xx2:integer;sp,si2:string;cc2,cc1,ccc:string[20];time_tests:integer;time_test:tdatetime;f1:text;f2:text;sro:string;s7,S8,se:string;
var arrayin0,matrixin0,arrayout0,matrixout0,amount_of_loops:integer;
begin
//begin of testing

//showmessage(result_type[1,1]+result_type[1,2]+result_type[1,2]+'   '+result_type[2,1]+result_type[2,2]+result_type[2,3]+result_type[2,4]);

form2.memo1.clear; bb:=false;

n_err:=0;n_err1:=0; //It is amount of errors in tests for the main program and for the subroutine respectively

time_tests:=0;

if (matrixin>0)or(matrixout>0)or(matrixins>0)or(matrixouts>0)or (chosen_task='6_24')or(chosen_task='15_25') or(copy(chosen_task,1,5)='15_49') then form2.Memo1.Font.Name:='Courier new' else form2.Memo1.Font.Name:=_fontname;
for ii5:=1 to 1+byte(program_sub) do begin
if ii5=1 then ii6:=number_of_tests else ii6:=number_of_subtests;
Amount_of_loops:=0;

for i:=1 to ii6 do
begin

bloop:=false;
if ii5=1 then assignfile(h,current_dir+'\tmp\iii'+inttostr(i))
else assignfile(h,current_dir+'\tmp\iiii'+inttostr(i));
closefile(h); ioresult;

reset(h); si:=''; if (ioresult<>0)then begin showmessage('Fatal!'+inttostr(i)); halt; end;


//Replacing all blanks by '_', all tabs by '~' for the tasks 6_24, 15_25.
if (chosen_task='15_25')or(chosen_task='6_24')then begin if not eof(h)then readln(h,si); correct6_24_15_25(si) end else
if (textsin>0)or(chosen_task='15_38') then begin if not(eof(h)) then readln(h,si)end else
begin
if eof(h)then si:=' ' else repeat readln(h,si2); si:=si+si2; if (matrixin>0)or(arrayin>0)then si:=si+' ';
if (not eof(h))and(matrixin=0)and(arrayin=0)then si:=si+chr(10);until eof(h); end;



closefile(h);

if (textsin=0)and(chosen_task<>'15_38')then
delete_blanks(si);

//A special correction for the tasks 16_18 and others - removal of the end 1E20
if (chosen_task='16_20-005')or(copy(chosen_task,1,5)='16_18')or(copy(chosen_task,1,5)='16_23')or(copy(chosen_task,1,5)='16_29')then correct_16_1E20(si);

//A special correction for the tasks 16_19 - removal of the @
if copy(chosen_task,1,5)='16_19' then begin correct_16_19(si);form2.memo1.Font.Name:='Courier New'; end;

if ii5=1 then
begin assignfile(f,current_dir+'\tmp\ooo'+inttostr(i));assignfile(g,current_dir+'\tmp\rrr'+inttostr(i));end else
begin assignfile(f,current_dir+'\tmp\oooo'+inttostr(i));assignfile(g,current_dir+'\tmp\rrrr'+inttostr(i));end;

closefile(f); ioresult; closefile(g); ioresult;
setcurrentdir(current_dir+'\tmp\');
time_test:=now;
cc1:=timetostr(time_test);if cc1[2]=':' then cc1:='0'+cc1;
application.processmessages;

if ii5=1 then
k:=ShellExecute(Handle, 'open',pchar('temp0'+inttostr(i)+'.bat'), nil, nil,sw_hide)
else
k:=ShellExecute(Handle, 'open',pchar('temp00'+inttostr(i)+'.bat'), nil, nil,sw_hide);

application.processmessages;
setcurrentdir(current_dir);
time_test:=now;
cc2:=timetostr(time_test);
if cc2[2]=':' then cc2:='0'+cc2;
//if (length(cc1)<>8) or(length(cc2)<>8)then begin showmessage('Fatal! Wrong time'); halt end;
xx1:=0; //xx1:=strtoint(copy(cc1,1,2))*3600+strtoint(copy(cc1,4,2))*60+strtoint(copy(cc1,7,2));
xx2:=0; //xx2:=strtoint(copy(cc2,1,2))*3600+strtoint(copy(cc2,4,2))*60+strtoint(copy(cc2,7,2));
time_tests:=time_tests+xx2-xx1;
application.ProcessMessages;
setcurrentdir(current_dir);
closefile(f); ioresult; closefile(g); ioresult;
application.ProcessMessages;
if k<33 then exit;
form2.Timer1.Interval:=300-120*byte(i>4)-130*byte(amount_of_loops>4);form2.Timer1.Enabled:=true;
number_of_intervals:=0;bloop:=true;
repeat application.ProcessMessages;
reset(g); if ioresult=0 then begin bloop:=false;closefile(g); break end;
until number_of_intervals>=75;
form2.Timer1.Enabled:=false;
number_of_intervals:=0;
application.ProcessMessages;
//if bloop then  begin j:=FindWindow(nil, 'c:\windows\system32\cmd.exe');
//  SendMessage(j, WM_CLOSE, 0, 0);end;
if bloop then begin inc(amount_of_loops);
if ii5=1 then
case i mod 4 of
1: killproc('temp2.exe');
2: killproc('temp3.exe');
3: killproc('temp4.exe');
0: killproc('temp5.exe')
end
else
case i mod 4 of
1: killproc('temp20.exe');
2: killproc('temp30.exe');
3: killproc('temp40.exe');
0: killproc('temp50.exe')
end;

form2.Timer1.Enabled:=false;
application.ProcessMessages;
number_of_intervals:=0;
//showmessage('Possibly infinite loop for the test  ');
//bloop:=false
end;

//if bloop then begin if en_rus then showmessage('Time is out. Possible infinite loop. Please, close the dos window and restart the program.') else
//showmessage ('Время истекло. Возможно зацикливание. Закройте DOS-окно и запустите программу вновь.'); delete_temp; form2.Close;end;

//showmessage(inttostr(i));
if not program_sub then
if en_rus then s:='Test number '+inttostr(i)+'. ' else s:='Тест номер '+inttostr(i)+'. '
else
if ii5=1 then
if en_rus then s:='Test number '+inttostr(i)+' for the main program. ' else s:='Тест номер '+inttostr(i)+' для основной программы. '
else
if en_rus then s:='Test number '+inttostr(i)+' for the subprogram. ' else s:='Тест номер '+inttostr(i)+' для подпрограммы. ';
form2.Memo1.Lines.add(s);
if not program_sub or (ii5=1)then begin linetest[i]:=form2.Memo1.Lines.Count; linetest[i+1]:=0 end else
begin linetest[i+number_of_tests]:=form2.Memo1.Lines.Count; linetest[i+number_of_tests+1]:=0;end;

//showmessage(inttostr(i)+'  '+inttostr(linetest[i]));

if not bloop then begin

if (chosen_task='6_24')or(chosen_task='15_25')
or (textsout<>0)

then begin reset(f); so:=''; if not eof(f)then readln(f,so); closefile(f); reset(g); sr:=''; if not eof(g)then readln(g,sr); closefile(g) ;


//showmessage(sr);

//Replacing of all blanks by '_' for the tasks 6_24, 15_25.
if (copy(chosen_task,1,4)='6_24')or(copy(chosen_task,1,5)='15_25') then correct6_24_15_25(so);
if (copy(chosen_task,1,4)='6_24')or(copy(chosen_task,1,5)='15_25')or(copy(chosen_task,1,5)='15_49')  then correct6_24_15_25(sr);end

else begin so:='';reset(f); if (ioresult<>0)then halt; if eof(f)then so:=' ' else repeat readln(f,so1);so:=so+' '+so1;until eof(f); closefile(f);
sr:='';reset(g); if (ioresult<>0)then halt; if eof(g)then sr:=' ' else repeat readln(g,sr1);sr:=sr+' '+sr1;until eof(g); closefile(g);end;

//showmessage(inttostr(length(so)));

//if i in [1,7,13] then showmessage(inttostr(i)+'Enter diff'+'!'+so+'!'+sr+'!');

end
else begin so:='   '; sr:=so end;
; //of not bloop

//Removal of the last two zeroes and insertion of square brackets in the input data for the task 15.8 and 15.23
if (chosen_task='15_8')or(chosen_task='15_23') then correct15_8_23(si);

//Removal of the last integer in the input data for the task 15.11 and other task using a file of integer or real
if (chosen_task='15_11')or(copy(chosen_task,1,5)='15_13')or(chosen_task='15_16')or(chosen_task='15_15')or(copy(chosen_task,1,5)='15_28')  then correct15_1int(si);

//Removal of the final point in the input data for the task 15.12 and other tasks using a file of char
if (copy(chosen_task,1,5)='15_12')or(chosen_task='15_14')or(chosen_task='15_25')or(chosen_task='15_29')or(chosen_task='15_30')or(chosen_task='15_31')or(copy(chosen_task,1,5)='15_32')
or(chosen_task='15_34')or(chosen_task='15_35')or(copy(chosen_task,1,5)='15_50')then correct15_1char(si);
//The same for the task 16_31-002
if chosen_task='16_31-002' then begin correct16_31(si); form2.Memo1.Font.Name:='Courier New' end;


if notblank(si)and
(copy(chosen_task,1,4)='8_44')or (chosen_task='8_46')
then si:=copy(si,1,length(si) div 2)+'  '+copy(si,length(si)div 2+1,100);

if notblank(si)and
(chosen_task='8_47_а')
then si:=copy(si,1,length(si)-4)+'  '+copy(si,length(si)-3,10);

if notblank(si)and (length(si)>1)and
(chosen_task='8_54')
then begin
kk:=0; for ii:=1 to length(si) do if si[ii]=' ' then begin inc(kk);
if (kk=9) and (i mod 2=1)or (kk=8)and (i mod 2=0) then begin si:=copy(si,1,ii)+'  '+copy(si,ii+1,100); break end end;
 end;

if (chosen_task[1]='9')and(chosen_task<>'9_32') then begin form2.Memo1.Font.Name:='Courier New'; forminout(si,true);
if notblank(si) then if en_rus then form2.memo1.lines.add('Initial data: ')
else form2.memo1.lines.add('Исходные данные: ');
if (chosen_task='9_20')or(chosen_task='9_26') then begin
if en_rus then form2.memo1.lines.add('The matrix : ')
else form2.memo1.lines.add('Maтрица: ');
//showmessage(outmatr[matrows]);
if chosen_task='9_20' then begin ccc:=outmatr[matrows,length(outmatr[matrows])];
outmatr[matrows]:=copy(outmatr[matrows],1, length(outmatr[matrows])-2)end;
if chosen_task='9_26' then begin matrows:=matrows-1;ccc:=outmatr[matrows+1]; end;
end;//of 9-20 or 9-26

for ii:=1 to matrows do form2.Memo1.Lines.add(outmatr[ii]);

if chosen_task='9_20'then
if en_rus then form2.memo1.lines.add('The checked character: '+ccc)
else form2.memo1.lines.add('Проверяемый символ: '+ccc);

if chosen_task='9_26'then
if en_rus then form2.memo1.lines.add('The power: '+ccc)
else form2.memo1.lines.add('Cтепень: '+ccc);

end //of chapter 9
else begin
//form2.Memo1.Font.Name:=_fontname;
if (consts[1,1]<>0)and(consts[1,2]=0) then
if en_rus then form2.memo1.lines.add('N='+inttostr(consts[(i-1)mod 4+1,1]))else
form2.memo1.lines.add('n='+inttostr(consts[(i-1)mod 4+1,1]));
if (consts [1,1]<>0)and(consts[1,2]<>0) then
if en_rus then form2.memo1.lines.add('N='+inttostr(consts[(i-1)mod 4+1,1])+' M='+inttostr(consts[(i-1)mod 4+1,2]))else
form2.memo1.lines.add('n='+inttostr(consts[(i-1)mod 4+1,1])+' m='+inttostr(consts[(i-1)mod 4+1,2]));

//It is arrayin>0
if (arrayin>0)and(ii5=1)or(arrayins>0)and(ii5=2)then begin
if ii5=1 then arrayin0:=arrayin else arrayin0:=arrayins;correct_multi_arrays(si,arrayin0,0,i);
for iii:=1 to 1+arrayin0 do
form2.Memo1.Lines.Add(string_out[iii]);
end {of arrayin>0}
else
//It is matrixin>0
if (matrixin>0)and(ii5=1)or(matrixins>0)and(ii5=2)
then begin
form2.Memo1.Font.Name:='Courier New';
if ii5=1 then matrixin0:=matrixin else matrixin0:=matrixins;correct_matrices(si,matrixin0,0,i,ii5,number_of_lines);
//A special correction of the input data for the task 11_61
if (chosen_task='11_61')and(ii5=1) then begin
if en_rus then string_out[number_of_lines]:='The power P='+string_out[number_of_lines]+'.' else
string_out[number_of_lines]:='Степень P='+string_out[number_of_lines]+'.'
end;
//A special correction of the input data for the task 14_16
if chosen_task='14_16' then begin
se:=string_out[number_of_lines];delete_blanks(se);
pq:=pos('0', se);if pq=0 then pq:=1;
se:=copy(se,pq+1, length(se));delete_blanks(se);
delete(string_out[number_of_lines],pq, length(string_out[number_of_lines]));if string_out[number_of_lines]='' then string_out[number_of_lines]:=' - ';
inc(number_of_lines); pq:=pos('0',se); if pq=0 then pq:=1; string_out[number_of_lines]:=copy(se,1,pq-1);if string_out[number_of_lines]='' then string_out[number_of_lines]:=' - ';
if en_rus then begin string_out[number_of_lines-1]:='The set of rows: '+string_out[number_of_lines-1];string_out[number_of_lines]:='The set of columns: '+string_out[number_of_lines] end else
begin string_out[number_of_lines-1]:='Множество стpoк: '+string_out[number_of_lines-1];string_out[number_of_lines]:='Мнoжествo cтoлбцoв: '+string_out[number_of_lines]
end; end;

for iii:=1 to number_of_lines do
form2.Memo1.Lines.Add(string_out[iii]);
end
{of matrixin>0}

else
if (chosen_task='11_24')and(ii5=2) then //ii5=1/2 - the main program/subroutine is tested
begin
correct11_24(si,i);
form2.Memo1.Lines.Add(string_out[1]);
form2.Memo1.Lines.Add(string_out[2]);
form2.Memo1.Lines.Add(string_out[3]);
end else
if chosen_task='11_22-001' then
begin
correct11_22a(si,ii5);
form2.Memo1.Lines.Add(string_out[1]);
form2.Memo1.Lines.Add(string_out[2]);
form2.Memo1.Lines.Add(string_out[3]);
if ii5=2 then form2.Memo1.Lines.Add(string_out[4])
end {of 11_22-001}
else
if chosen_task='11_57' then begin
arrayin1:=arrayin;arrayin:=3-byte(ii5=2);inc(consts[(i-1)mod 4+1,1]);

//showmessage(inttostr(arrayin));

correct_multi_arrays(si,arrayin,0,i);
for pp1:=2 to 3-byte(ii5=2) do begin
if ii5=1 then begin
pp:=pos('array',string_out[pp1]);
if pp>0 then begin delete(string_out[pp1],pp,5);
insert('polinomial',string_out[pp1],pp);end;
pp:=pos('массив',string_out[pp1]);
if pp>0 then begin delete(string_out[pp1],pp,6);
insert('полином',string_out[pp1],pp);end;end;
if ii5=2 then begin
pp:=pos('first array',string_out[pp1]);
if pp>0 then begin delete(string_out[pp1],pp,11);
insert('polinomial',string_out[pp1],pp);end;
pp:=pos('первый массив',string_out[pp1]);
if pp>0 then begin delete(string_out[pp1],pp,13);
insert('полином',string_out[pp1],pp);end;
end;
end;
pp:=pos(':',string_out[4-byte(ii5=2)]);
if pp>0 then
if en_rus then string_out[4-byte(2=ii5)]:='the point'+copy(string_out[4-byte(2=ii5)],pp,1000)else
string_out[4-byte(ii5=2)]:='тoчка'+copy(string_out[4-byte(ii5=2)],pp,1000);
for iii:=1 to 1+arrayin do
form2.Memo1.Lines.Add(string_out[iii]);
arrayin:=arrayin1;dec(consts[(i-1)mod 4+1,1]);
end //of 11_57
//A special correction of the input data for the task 11.29-004
else if chosen_task='11_29-004' then begin
ppa:=length(si); ppa2:=0; for ppa1:=ppa downto 1 do if si[ppa1]=' ' then begin ppa2:=ppa1; break end;
if ppa2>0 then begin if en_rus then
form2.memo1.lines.add('Initial array: '+copy(si,1,ppa2-1))else
form2.memo1.lines.add('Исходный массив: '+copy(si,1,ppa2-1));
if en_rus then form2.memo1.lines.add('Amount of positions of the shift: '+copy(si,ppa2+1,100))else
form2.memo1.lines.add('Koличествo пoзиций cдвигa: '+copy(si,ppa2+1,100));
end;
end //of 11_29-004
//A special correction of the input data for the tasks where more than one input file is needed
else
if filein>0 then output_multifiles(si,1)
//of Chapter 15 - multifiles

else
if textsin>0 then outputtextfile(si,1)
//if (copy(chosen_task,1,5)='15_42')or(copy(chosen_task,1,5)='15_44') or(copy(chosen_task,1,5)='15_45')or(copy(chosen_task,1,5)='15_47')or(copy(chosen_task,1,5)='15_48')then outputtextfile(si,1)

else
if copy(chosen_task,1,5)='16_16' then
begin output16_16input(si) end



////////INSERT A SPECIAL INPUT HERE!!!!!!!!!!!!!!!!!


else
if notblank(si) then begin if pos(chr(10),si)=0then if en_rus then form2.memo1.lines.add('Initial data: '+si)
else  form2.memo1.lines.add('Исходные данные: '+si) else
begin
if en_rus then form2.memo1.lines.add('Initial data: ')else
form2.memo1.lines.add('Исходные данные: ');
repeat if si='' then pa:=0 else pa:=pos(chr(10), si); if pa>0 then begin sp:=copy(si,1,pa-1);delete_blanks(sp);
//if i<10 then showmessage(sp);
if sp='' then if en_rus then sp:='<Empty line>' else sp:='<Пустая строка>'; end;
if pa<>0 then begin form2.Memo1.Lines.add(sp);delete(si,1,pa) end else
begin
delete_blanks(si); if si='' then if en_rus then si:='<Empty line>' else si:='<Пустая строка>';
form2.Memo1.Lines.add(si);
end;
//if i=51 then showmessage('!'+si+'!'+inttostr(pa));
until(pa=0);
end //of pos(chr(10),si)<>0
end //of not blank si
else //of not blank si
if en_rus then if (chosen_task<>'6_24')and(chosen_task<>'15_25')and(chosen_task<>'15_32-006')then form2.memo1.lines.add('Initial data: -')else form2.memo1.lines.add('Initial data: <Empty line>')
else if (chosen_task<>'6_24')and(chosen_task<>'15_25')then form2.memo1.lines.add('Исходные данные: -')else form2.memo1.lines.add('Исходные данные: <Пуcтая стpoка>')
end;

//{of else from chapter 9
//i42:=0; if (length(sr)>=21)and(copy(sr,length(sr)-20,21)='!unclosed!files!left!')and (chosen_task[1]='1')and(chosen_task[2] in ['5'..'7']) then
//begin i42:=1; sr:=copy(sr,1,length(sr)-21) end;
//The case of existing temporary files
i43:=0; if (length(sr)>=1)and(copy(sr,length(sr),1)=chr(5))and (chosen_task[1]='1')and(chosen_task[2] in ['5'..'7']) then
begin i43:=1; delete(sr,length(sr),1) end;
//The case of unclosed files
i42:=0; if (length(sr)>=1)and(copy(sr,length(sr),1)=chr(4))and (chosen_task[1]='1')and(chosen_task[2] in ['5'..'7']) then
begin i42:=1; delete(sr,length(sr),1) end;


if notblank(sr)and
(chosen_task='8_47_б')
then sr:=copy(sr,1,length(sr)-4)+'  '+copy(sr,length(sr)-3,10);
if notblank(so)and
(chosen_task='8_47_б')
then so:=copy(so,1,length(so)-4)+'  '+copy(so,length(so)-3,10);
if notblank(sr)and(chosen_task='9_32') then
for k2:=1 to length(sr)-1 do if (sr[k2]<>' ')and(sr[k2+1]<>' ')then begin
sr:=copy(sr,1,k2)+' '+copy(sr,k2+1,1000);break end;


st:=so;while true do begin k2:=pos ('||',st);
if (chosen_task='7_24')
//numbers of other tasks will probably be added here; it is a case when the first answer is in English but the second one is in Russian the choice depends on the current language
then begin
if en_rus then
begin so:=copy(st, 1, k2-1); st:='' end
else begin so:=copy(st, k2+2, 2222); st:=''end;k2:=0;sw:=so; sv:=sr; end else begin

if k2=0 then begin so:=st; st:='' end else begin
so:=copy(st, 1, k2-1); st:=copy(st,k2+2,10000)end;
sw:=so; sv:=sr;

end;

//if length(sr)<100 then begin
//showmessage(sr+'!'+inttostr(length(sr)));
//showmessage(so+'!'+inttostr(length(so))); end;



if not bloop then
 m:=diff(i)
 else m:=25; {infinite loop}
if i42*i43>0 then begin i42:=0; i43:=0; m:=8 end;
if i42=1 then begin i42:=0; m:=6 end;
if i43=1 then begin i43:=0; m:=7 end;

//A special words error, no roots...that must be converted to the current language

//if (sr<>'')and(sr[1]>':') then showmessage(sr+'!'+so);

if ((sr='Ошибка')and(so='Error')or(sr='Нет корней')and(so='No roots'))and not en_rus and (m=0)and errorr then so:=sr else begin

sr:=sv; so:=sw;

end;

if (m=0)or(k2=0) then break;
end;//of while true


//showmessage('here');

if not bloop then begin
//It is arrayout>0
if (arrayout>0)and(ii5=1)or(arrayouts>0)and(ii5=2) then begin
if ii5=1 then arrayout0:=arrayout else arrayout0:=arrayouts; correct_multi_arrays(sr,arrayout0,1,i);

//showmessage(inttostr(ii5));
//showmessage(inttostr(arrayout0));

for iii:=1 to 1+arrayout0 do
form2.Memo1.Lines.Add(string_out[iii]);
end {of arrayout>0}
else
if (matrixout>0)and(ii5=1)or(matrixouts>0)and(ii5=2)
then begin
//A special correction of the output data for the task 11_60
if chosen_task='11_60' then begin
ii2:=consts[(i-1)mod 4+1,1]*consts[(i-1)mod 4+1,2];
sro:=so;
delete_blanks(sro);
ii4:=0;
for ii3:=1 to length(sro) do if sro[ii3]=' ' then inc(ii4);
inc(ii4); ii4:=ii4 div ii2;
//showmessage(inttostr(ii2)+' '+inttostr(ii4)+'    '+sro);
if ii4=0 then inc(ii4);
matrixout:=ii4;
end;
if ii5=2 then matrixout0:=matrixouts else matrixout0:=matrixout;
correct_matrices(sr,matrixout0,1,i,ii5,number_of_lines);
for iii:=1 to number_of_lines do
form2.Memo1.Lines.Add(string_out[iii]);
end {of matrixout>0}
else
if (chosen_task='9_5-005')or(chosen_task='9_11')
or(copy(chosen_task,1,4)='9_13')
or(copy(chosen_task,1,4)='9_25')
or(copy(chosen_task,1,4)='9_26')

// we shall add other tasks here
then begin forminout (sr,false);
if notblank(sr) then begin if en_rus then form2.memo1.lines.add('Obtained result: ')
else form2.memo1.lines.add('Полученный результат: ');
for ii:=1 to matrows do form2.Memo1.Lines.add(outmatr[ii]);end else
if en_rus then form2.memo1.lines.add('Obtained result: -')
else form2.memo1.lines.add('Полученный результат: -');
end
else
if chosen_task='15_23'then output15_23(sr,1)
else
//A special correction of the output data for the tasks where more than one output file is needed
if fileout>0 then output_multifiles(sr,2)
else
//if (chosen_task='15_38')or (chosen_task='15_47')or (chosen_task='15_48')then outputtextfile(sr,2)
if textsout>0 then outputtextfile(sr,2)
else
if (chosen_task='16_16-003')or(chosen_task='16_16-004')or(chosen_task='16_16-005')or(chosen_task='16_16-006')
then begin 
correct_16_16(sr);form2.memo1.Font.Name:='Courier New';
output16_16output(sr,2)
end
else
if ((chosen_task='10_21')or(chosen_task='10_22'))and(pos('rror',so)=0)then
output10_21_22(sr,1)

////////INSERT A SPECIAL OUTPUT HERE!!!!!!!!!!!!!!!!!
//END OF SPECIAL OUTPUT!!!!!!!!!!!!!!!

else begin
if copy(chosen_task,1,5)='16_19'then correct_16_19(sr);
if copy(chosen_task,1,5)='16_16' then begin correct_16_16(sr);form2.memo1.Font.Name:='Courier New'; end;
if copy(chosen_task,1,5)='16_18'then correct_16_1E20(sr);
if check_new or check_dispose then checknewdispose(sr);

if (chosen_task='15_8')and(notblank(sr))then begin delete_blanks(sr); sr:='['+sr+']';end;
if notblank(sr)then
if en_rus then form2.memo1.lines.add('Obtained result: '+sr) else form2.memo1.lines.add('Полученный результат: '+sr)
else if en_rus then if (chosen_task<>'6_24')and(chosen_task<>'15_25')and(chosen_task<>'15_32-006') then form2.memo1.lines.add('Obtained result: -')else
form2.memo1.lines.add('Obtained result: <Empty line>')
else if (chosen_task<>'6_24')and(chosen_task<>'15_25') then form2.memo1.lines.add('Полученный результат: -')else form2.memo1.lines.add('Полученный результат: <Пустая строка>');
end;

if (arrayout>0)and(ii5=1)or(arrayouts>0)and(ii5=2) then begin
if ii5=1 then arrayout0:=arrayout else arrayout0:=arrayouts;correct_multi_arrays(so,arrayout0,2,i);
for iii:=1 to 1+arrayout0 do
form2.Memo1.Lines.Add(string_out[iii]);
end {of arrayout>0}
else
if (matrixout>0)and(ii5=1)or(matrixouts>0)and(ii5=2)
then begin
if ii5=1 then matrixout0:=matrixout else matrixout0:=matrixouts;
correct_matrices(so,matrixout0,2,i,ii5,number_of_lines);
for iii:=1 to number_of_lines do
form2.Memo1.Lines.Add(string_out[iii]);
end {of matrixout>0}
else

if (chosen_task='9_5-005')or(chosen_task='9_11')
or(copy(chosen_task,1,4)='9_13')
or(copy(chosen_task,1,4)='9_25')
or(copy(chosen_task,1,4)='9_26')

// we shall add other tasks here
then begin forminout (so,false);
if notblank(so) then begin if en_rus then form2.memo1.lines.add('Correct result: ')
else form2.memo1.lines.add('Правильный результат: ');
for ii:=1 to matrows do form2.Memo1.Lines.add(outmatr[ii]);end else
if en_rus then form2.memo1.lines.add('Correct result: -')
else form2.memo1.lines.add('Правильный результат: -');
end
else
if chosen_task='15_23' then output15_23(so,2)
else
//A special correction of the output data for the tasks where more than one output file is needed
if fileout>0 then output_multifiles(so,3)
else
//if (chosen_task='15_38')or (chosen_task='15_47')or (chosen_task='15_48')then outputtextfile(so,3)
if textsout>0 then outputtextfile(so,3)
else
if(chosen_task='16_16-003')or(chosen_task='16_16-004')or(chosen_task='16_16-005')
or(chosen_task='16_16-006')
then output16_16output(so,3) else
////////INSERT A SPECIAL OUTPUT HERE!!!!!!!!!!!!!!!!!
if ((chosen_task='10_21')or(chosen_task='10_22'))and(pos('rror',so)=0)then
output10_21_22(so,2)
else begin
if(chosen_task='15_8')and(notblank(so))then begin delete_blanks(so); so:='['+so+']';end;
if notblank(so)then
if en_rus then form2.memo1.lines.add('Correct result: '+so) else form2.memo1.lines.add('Правильный результат: '+so)
else if en_rus then if (chosen_task<>'6_24')and(chosen_task<>'15_25') and (chosen_task<>'15_32-006')then form2.memo1.lines.add('Correct result: -') else form2.memo1.lines.add('Correct result: <Empty line>')
else if (chosen_task<>'6_24')and(chosen_task<>'15_25') then form2.memo1.lines.add('Правильный результат: -')else form2.memo1.lines.add('Правильный результат: <Пустая строка>')
end;
//l:=1;m:=0;//l - the number of received/correct value; m - the final result of the current testing

//if chosen_task='11_63' then m:=1;


case m of
8:begin if en_rus then s:='A temporary file has not been deleted and some files have not been closed.' else s:='Вpeменный файл не был удалeн и некоторые файлы не были закрыты.'end;
7:begin if en_rus then s:='A temporary file has not been deleted.'else s:='Вpeменный файл не был удалeн.' end;
6:begin if en_rus then s:='Some of the files have not been closed.' else s:='Некоторые файлы не были закрыты.' end;
5:begin if en_rus then s:='An admissible permutation.'else s:='Допустимая перестановка.';bb:=true; m:=0 end;
3:if en_rus then s:='Excessive output.' else s:='Избыточный вывод.';
4:if en_rus then s:='Not enough output data.' else s:='Мало результирующих данных.';
2:if en_rus then s:='Accuracy is not reached.' else s:='Точность не достигнута.';
1:if en_rus then s:='ERROR.'else s:='ОШИБKA.';
0:s:='Ok';end;//of case
if ii5=1 then n_err:=n_err+byte(m<>0)else n_err1:=n_err1+byte(m<>0);

//if m>0 then  form2.Memo1.Font.Color:=clred else form2.Memo1.Font.Color:=clblack;
closefile(f);closefile(g); form2.memo1.lines.add(s);

//if m>0 then form2.memo1.Lines.Add(chr(33));

end

else begin
if en_rus then s:='Time is out. Possible infinite loop.' else s:='Истекло время. Возможно зацикливание.';
closefile(f);closefile(g);//form2.memo1.lines.add('   ');
form2.Memo1.Lines.Add(s);if ii5=1 then n_err:=n_err+1 else n_err1:=n_err1+1;
//assignfile(f1,current_dir+'\tmp\temp2.exe'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
//assignfile(f1,current_dir+'\tmp\temp3.exe'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
//assignfile(f1,current_dir+'\tmp\temp4.exe'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
//assignfile(f1,current_dir+'\tmp\temp5.exe'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
was_loop:=true;
end;

closefile(h); ioresult; closefile(f); ioresult;closefile(g); ioresult;
//killproc('temp2.exe');
application.ProcessMessages;
//killproc('temp3.exe');
application.ProcessMessages;
//killproc('temp4.exe');
application.ProcessMessages;
//killproc('temp5.exe');
application.ProcessMessages;

end;//of for from 1 to number of tests
end;//of for external from 1 to 1+byte(program_sub)
//It is blocked now
//if en_rus then form2.memo1.Lines.Add('The total tests execution time is '+inttostr(time_tests)+' sec.')
//else
//form2.memo1.Lines.Add('Общее время выполнения тестов -  '+inttostr(time_tests)+' сек.');

form2.Memo1.Lines.Add('  ');
for i:=1 to warnings_amount do form2.memo1.lines.add(warnings[i]);
if incorrect_boolean then if en_rus then form2.Memo1.Lines.Add('Hint: an expression <variable>=true or <variable>=false was found in the program.')else
form2.Memo1.Lines.Add('Замечание: в программе найдено выражение <переменная>=true or <переменнaя>=false.');
form2.Memo1.Lines.Add('  ');


for ii5:=1 to 1+byte(program_sub) do begin
if ii5=1 then n_err2:=n_err else n_err2:=n_err1;
if ii5=1 then nummm:=number_of_tests else nummm:=number_of_subtests;
if ii5=1 then s8:='' else s8:=s8+chr(10);
if not program_sub then s7:='' else if ii5=1 then if en_rus then s7:=' for the main program' else s7:=' для основной программы' else
if en_rus then s7:=' for the subprogram' else s7:=' для пoдпрограммы';
if (n_err2>0)then begin if en_rus then if n_err2=1 then s8:=s8+inttostr(n_err2)+' wrong result out of '+inttostr(nummm)+s7+'.'else
s8:=s8+inttostr(n_err2)+' wrong results out of '+inttostr(nummm)+s7+'.'
else if (n_err2=1)or(n_err2>20)and(n_err2 mod 10=1)then
s8:=s8+inttostr(n_err2)+' ошибочный ответ из '+inttostr(nummm)+s7+'.'else if (n_err2<5)
or(n_err2>20)and(n_err2 mod 10 in [2..4]) then
s8:=s8+inttostr(n_err2)+' ошибочных ответa из '+inttostr(nummm)+s7+'.'else
s8:=s8+inttostr(n_err2)+' ошибочных ответoв из '+inttostr(nummm)+s7+'.'end
else if en_rus then s8:=s8+'All the results are correct'+s7+'.' else s8:=s8+'Bce ответы '+s7+' правильные.';
//showmessage('We are here'+inttostr(ii5));
end;
if bb and (n_err=0)and(n_err1=0)then if en_rus then s8:=s8+' Admissible permutations of elements in the resulting array were found.' else
s8:=s8+' Были найдены допустимые перестановки элементов в результирующем массиве.';
showmessage(s8);
closefile(f); ioresult;closefile(g); ioresult;closefile(h); ioresult;
if (form2.checkbox2.checked)then delete_correct_results;

//showmessage('after the testing');

//form2.memo1.lines.add('  ');

end;

procedure TForm2.FormCreate(Sender: TObject);
var i,ii:integer;f,ff:textfile;
begin

width:=_width; height:=_height;
current_width:=_width;current_height:=_height;
left:=(screen.Width-_width)div 2;
top:=(screen.height-_height)div 2;
//Initializing of the array with the chapters' names - it is done before the choosing of a chapter
{chapter_names[3,1]:='Ввод и вывод';
chapter_names[3,2]:='Input and output';
chapter_names[4,1]:='Условный оператор ';
chapter_names[4,2]:='Conditional statement';
chapter_names[5,1]:='Oператоры цикла';
chapter_names[5,2]:='Loop statements';
chapter_names[6,1]:='Тип char ';
chapter_names[6,2]:='Character type';
chapter_names[7,1]:='Оператор case ';
chapter_names[7,2]:='Selection statement';
chapter_names[8,1]:='Одномерные массивы ';
chapter_names[8,2]:='One-dimensional arrays';
chapter_names[9,1]:='Матрицы ';
chapter_names[9,2]:='Matrices';
chapter_names[10,1]:='Строки ';
chapter_names[10,2]:='Strings';
chapter_names[11,1]:='Процедуры и функции ';
chapter_names[11,2]:='Procedures and functions';
chapter_names[12,1]:='Рекурсия ';
chapter_names[12,2]:='Recursion';
chapter_names[13,1]:='Записи ';
chapter_names[13,2]:='Records ';
chapter_names[14,1]:='Множества ';
chapter_names[14,2]:='Sets ';
chapter_names[15,1]:='Файлы ';
chapter_names[15,2]:='Files ';
chapter_names[16,1]:='Списки ';
chapter_names[16,2]:='Lists ';
chapter_names[17,1]:='Деревья ';
chapter_names[17,2]:='Trees ';}
{RU}
low_pos:=0.92;
if _height<1000 then low_pos:=0.92-(1000-_height)/10000;
//showmessage(floattostr(low_pos));
if low_pos<0.87 then low_pos:=0.87;
button1.Top:=round(_height*low_pos);
button1.left:=round(_width*0.86);
button1.width:=round(_width/23);
button1.height:=round(_height/35);
button1.font.Size:=_width div 115;if button1.font.Size<8 then button1.font.Size:=8;
button1.Font.Name:=_fontname;
button1.caption:='РУС';
{ENG}
button2.Top:=button1.top;
button2.left:=round(_width*0.92);
button2.width:=button1.width;
button2.height:=button1.height;
button2.font.Size:=button1.Font.Size;
button2.Font.Name:=button1.Font.name;
button2.caption:='EN';
{Choosing a chapter}
label1.top:=round(_height/68);
label1.Left:=_width div 35;
label1.font.Size:=_width div 80;if label1.font.Size<10 then label1.font.Size:=10;
label1.font.Name:=_fontname;
{Choosing a task}
label2.top:=label1.Top+round(label1.Height*1.4);
label2.Left:=label1.left;
label2.font.Size:=label1.Font.Size;
label2.font.Name:=label1.font.name;
{Choosing a file name}
label3.top:=label2.Top+round(label1.Height*1.5);
label3.Left:=label1.left;
label3.font.Size:=label1.Font.Size;
label3.font.Name:=label1.font.name;
label3.Enabled:=false;

label4.Top:=button1.top;
label4.Left:=label1.left;
label4.font.Size:=round(label1.Font.Size*0.85);
//label4.font.color:=$FF0000;
label4.font.Name:=label1.font.name;
label4.Enabled:=true;

//comboboxes
combobox1.Left:=label1.Left+round(_width*0.15);
combobox1.Top:=label1.Top-height div 250;
//combobox1.height:=_height div 5;
combobox1.Font.Name:=_fontname;
combobox1.Font.Size:=label1.font.Size;
combobox1.Clear;
combobox1.Width:=_width div 2;
combobox2.Left:=combobox1.left;
combobox2.Top:=label2.Top-height div 250;
//combobox2.height:=combobox1.Height;
combobox2.Font.Name:=_fontname;
combobox2.Font.Size:=combobox1.Font.Size;
combobox2.Clear;
combobox2.Width:=combobox1.Width;
{Edit1 is for a file name}
edit1.clear;
edit1.top:=label3.Top-height div 250;
edit1.Left:=combobox2.left;//+width div 35;
edit1.font.Size:=label3.Font.Size;
edit1.font.Name:=label3.font.name;
edit1.width:=_width div 3;
{Buttton7 is Ok for a file name}
button7.Left:=edit1.Left+edit1.Width+_width div 50;
button7.top:=edit1.top+_height div 200;
button7.Width:=round(_width*0.1);
button7.height:=round(_height/28);
button7.font.Size:=label3.font.size;
button7.font.Name:=label3.font.Name;
button7.Caption:='Load';
{Button6 is the browse for a file name}
button6.Left:=button7.left+button7.Width+_width div 50;
button6.top:=button7.top;
button6.Width:=round(_width*0.09);
button6.font.Size:=label3.font.size;
button6.font.Name:=label3.font.Name;
button6.Caption:='Browse';
button6.height:=button7.height;

{The text of the task}
//scrollbox1.Left:=round(_width/45);
//scrollbox1.width:=round(_width*42.5/45);
//scrollbox1.top:=button6.top+button6.height+_height div 75;
//scrollbox1.height:=round(height/6.5);
//image2.Left:=0;
//image2.top:=0;
//image2.Height:=height div 2;
//image2.Width:=scrollbox1.Width-width div 50;
//image_clear;
richedit1.Left:=round(_width/45);
richedit1.width:=round(_width*0.9);
richedit1.top:=button6.top+button6.height+_height div 75;
//richedit1.height:=round(height/6.5);
richedit1.height:=round(height/5.8);
richedit1.BorderWidth:=12; //It is indent
richedit1.ScrollBars:=ssboth;
{The text of the program}
memo5.Left:=richedit1.left;
memo5.width:=richedit1.width;
memo5.top:=richedit1.Top+richedit1.height+_height div 70;
memo5.height:=_height div memo5height;//see file00 for the definition
memo5.Font.Size:=label3.Font.Size;
memo5.Font.name:='Courier New'; //_fontname;
memo5.ScrollBars:=ssvertical;
memo5.readonly:=true;
memo5.clear;
//memo5.BevelKind:=bktile;
{A button that increases and decreases the size of Memo5}
button8.Top:=memo5.Top;
button8.Width:=_width div 35;
button8.height:=button8.Width;
button8.left:=memo5.Left+memo5.Width+_width div 100;
button8.Caption:='+';
button8.font.Size:=button7.Font.size;
button8.Font.Style:=[fsbold];
button8.font.Name:=button7.font.Name;
button8.Visible:=true;
button8.Enabled:=false;

{A button that increases and decreases the size of Richedit1}
button9.Top:=richedit1.Top;
button9.Width:=_width div 35;
button9.height:=button9.Width;
button9.left:=richedit1.Left+richedit1.Width+_width div 98;
button9.Caption:='+';
button9.font.Size:=button7.Font.size;
button9.Font.Style:=[fsbold];
button9.font.Name:=button7.font.Name;
button9.Visible:=true;
button9.Enabled:=false;

{Preliminary analysis and compilation}
button3.Left:=round(_width/9);
button3.top:=memo5.Top+memo5.Height+_height div 100;
button3.Width:=round(_width/2.6);
button3.font.Size:=label1.Font.Size;
button3.font.Size:=_width div 80;
button3.font.Name:=_fontname;
button3.height:=button7.height;

{Checkbox 1 and 2 - autotesting and showing wrong results only}
checkbox1.Enabled:=true;
checkbox2.Enabled:=true;
checkbox1.font.Size:=_width div 80;
checkbox1.font.Name:=_fontname;
checkbox2.font.Size:=_width div 80;
checkbox2.font.Name:=_fontname;
checkbox1.Left:=combobox1.Left+round(combobox1.width*1.17);
checkbox2.Left:=checkbox1.left;
checkbox1.width:=_width div 5;
checkbox2.width:=checkbox1.width;
checkbox1.Top:=combobox1.Top;
checkbox2.Top:=combobox2.Top;
checkbox1.Height:=combobox1.Height;
checkbox2.Height:=combobox2.Height;
checkbox1.Checked:=false;
checkbox2.Checked:=false;

{compilation}
//button4.Left:=button3.Left+button3.width+round(_width/45);
//button4.top:=button3.top;
//button4.Width:=button3.width+width div 18;
//button4.font.Size:=button3.font.size;
//button4.font.Name:=button3.font.Name;
//button4.height:=button7.height;

{testing}
button5.Left:=button3.Left+button3.width+round(_width/15);
button5.top:=button3.top;
button5.Width:=button3.width-_width div 14;
button5.font.Size:=button3.font.size;
button5.font.Name:=button3.font.Name;
button5.height:=button7.height;

{memo-components}
memo1.Clear;
memo1.Top:=button3.top+button3.Height+(_height div 125);
memo1.Left:=round(_width/45);
memo1.Height:=button1.Top-memo1.Top-_height div 250;
memo1.Width:=richedit1.Width;
memo1.ScrollBars:=ssboth;
memo1.Font.size:=memo5.Font.Size;if memo1.Font.size<10 then memo1.Font.Size:=10;
memo1.Font.Name:=_fontname;
{memo2.Clear;
memo2.Top:=memo1.Top;
memo2.Left:=button4.Left;
memo2.Height:=memo1.Height;
memo2.Width:=button4.width;
memo2.ScrollBars:=ssboth;
memo2.Font.size:=_width div 100;
memo2.Font.Name:=_fontname;
memo3.Clear;
memo3.Top:=memo1.top;
memo3.Left:=button5.Left;
memo3.Height:=memo1.Height;
memo3.Width:=round(button5.width);
memo3.ScrollBars:=ssboth;
memo3.Font.size:=_width div 100;
memo3.Font.Name:='Courier New';
}
{Two buttons that increase and decrease the size of Memo3, respectively - now it is not used}
button10.Top:=memo1.Top;
button10.Width:=_width div 35;
button10.height:=button10.Width;
button10.left:=richedit1.Left+richedit1.Width-button8.width;
button10.Caption:='+';
button10.font.Size:=button7.Font.size;
button10.Font.Style:=[fsbold];
button10.font.Name:=button7.font.Name;
button10.Visible:=true;
button10.Enabled:=false;
button10.Visible:=false;
//Note: if the property visible is false, the property enabled is ignored.
button11.Top:=memo1.Top+button10.Height+_height div 55;
button11.Width:=_width div 35;
button11.height:=button11.Width;
button11.left:=richedit1.Left+richedit1.Width-button9.width;
button11.Caption:='-';
button11.font.Size:=button7.Font.size;
button11.Font.Style:=[fsbold];
button11.font.Name:=button7.font.Name;
button11.Visible:=true;
button11.Enabled:=false;
button11.visible:=false;
task_size:=false; 
text_size:=false;
//test_size:=false;
chosen_task:='';
filename:='';
current_dir:=getcurrentdir;
//task_chapters_fill;
//en_rus:=false;
chapter_claims_amount:=0;
task_claims_amount:=0;
button3.Enabled:=false;
//button4.Enabled:=false;
button5.Enabled:=false;
button6.Enabled:=true;
button7.Enabled:=false;
button8.Enabled:=false;
button9.Enabled:=false;
button10.Enabled:=false;
button11.Enabled:=false;

edit1.ReadOnly:=true;
memo1.ReadOnly:=true;
//memo2.ReadOnly:=true;
//memo3.ReadOnly:=true;
memo5.ReadOnly:=true;
richedit1.clear;
richedit1.ReadOnly:=true;
timer1.Enabled:=false;
ioresult;chosen_task:=''; filename:=''; chosen_chapter:=0;task_amount:=0;
button1.click; initial:=true;
//current_dir:=getcurrentdir;
createdir('tmp');ioresult;
//creation of files temp01, temp02,...  in the directory tmp
for i:=1 to max_test_number do begin
assignfile(f,current_dir+'\tmp\temp0'+inttostr(i)+'.bat'); rewrite(f); ioresult;
writeln(f,'temp'+inttostr(2+(i-1)mod 4)+'.exe <iii'+inttostr(i)+' >rrr'+inttostr(i));closefile(f);
assignfile(f,current_dir+'\tmp\temp00'+inttostr(i)+'.bat'); rewrite(f); ioresult;
writeln(f,'temp'+inttostr(2+(i-1)mod 4)+'0.exe <iiii'+inttostr(i)+' >rrrr'+inttostr(i));closefile(f);
deletefile(current_dir+'\tmp\iii'+inttostr(i));
deletefile(current_dir+'\tmp\ooo'+inttostr(i));
deletefile(current_dir+'\tmp\rrr'+inttostr(i));
deletefile(current_dir+'\tmp\iiii'+inttostr(i));
deletefile(current_dir+'\tmp\oooo'+inttostr(i));
deletefile(current_dir+'\tmp\rrrr'+inttostr(i));
end;
//forming of the file temp0.bat - let us remove it for quite a while
{assignfile(f,current_dir+'\temp0.bat'); rewrite(f);
writeln(f, current_dir+'\Pascal_compiler\2.0.4\bin\i386-win32\fpc.exe '+current_dir+'\tmp\temp2.pas '+current_dir+'\tmp\result.txt');
writeln(f, current_dir+'\Pascal_compiler\2.0.4\bin\i386-win32\fpc.exe '+current_dir+'\tmp\temp3.pas '+current_dir+'\tmp\result.txt');
closefile(f);}
//showmessage(inttostr(ioresult)+' '+current_dir);
assignfile(ff,current_dir+'\tmp\p.txt'); reset(ff); ii:=ioresult; closefile(ff);ioresult;
form1.label6.Visible:=ii=0;
form1.label7.Visible:=ii=0;
sorts:=0;
errorr:=false;
binit:=false;//false if the form2 was never activated yet; true, otherwise
//It is an auxuliary component
memo2.Visible:=false;

end;

procedure TForm2.FormActivate(Sender: TObject);
var p:integer;
begin
if not binit then begin
task_chapters_fill;binit:=true end;
p:=pos(' ',current_dir);
if p>0 then if en_rus then begin showmessage('The path to the current directory contains blank characters. It is not allowed. Rename the directories.'); form1.close; end
else begin
showmessage('Путь к текущему каталогу содержит пробелы, что недопустимо. Переименуйте каталоги.'); Form1.close;
end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var f:textfile;label 1;
begin
deletefile('.\tmp\temp0.bat');
assignfile(f, current_dir+'\tmp\tests.ini'); rewrite(f);
if form2.checkbox1.checked then writeln(f,'1')else writeln(f,'0');
if form2.checkbox2.checked then writeln(f,'1')else writeln(f,'0');
//showmessage(inttostr(ioresult));
if combo1index>=0 then writeln(f, 1+combo1index)else begin closefile(f); ioresult; goto 1 end;
if chosen_task<>'' then writeln(f,chosen_task);
if filename<>'' then writeln(f, filename);
1:closefile(f); ioresult; form1.close;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
en_rus:=false;
if task_amount>0 then richedit_fill;
form2.Button8.Hint:='Увеличение / уменьшение размеров окна с программой ';
form2.Button9.Hint:='Увеличение / уменьшение размеров окна с тeкcтoм задачи ';
form2.Button8.ShowHint:=true;
form2.Button9.ShowHint:=true;
form2.Button10.Hint:='Увеличение размеров окна с тестами ';
form2.Button11.Hint:='Уменьшение размеров окна с тестами ';
form2.Button10.ShowHint:=true;
form2.Button11.ShowHint:=true;
form2.CheckBox2.Caption:='Выводить только ошибки';
form2.CheckBox1.Caption:='Aвтотестирование';


form2.Button6.Caption:='Обзор';
form2.Button7.Caption:='Зaгрузить';
form2.OpenDialog1.title:='Открытие файла ';
form2.OpenDialog2.title:='Выбор компилятора';
form2.Caption:='Cистема автоматического тестирования программ';
label1.Caption:='Выберите раздел: ';
label2.Caption:='Выберите зaдaчу: ';
label3.Caption:='Введите имя файла ';
label4.Caption:='F1 - помощь       Свои замечания присылайте по электронному адресу: Novikov_57@mail.ru';
button3.Caption:='Предварительный анализ и кoмпиляция';
//button4.Caption:='Компиляция';
button5.Caption:='Тестирование';
chapter_names_correct;
if task_amount>0 then task_names_correct;
end;
{
procedure test1;
var i:integer;searchresult:tsearchrec;
begin
//it is an experimental part we will delete it after it ends

if FindFirst('*', faDirectory, searchResult) = 0 then
   begin
     repeat
      // show only directories
       if (searchResult.attr and faDirectory) = faDirectory
       then ShowMessage('Directory = '+searchResult.Name);
     until FindNext(searchResult) <> 0;


 end;
findclose(searchresult);
end;
}

procedure TForm2.Button2Click(Sender: TObject);
begin
{test1;}

en_rus:=true;
if task_amount>0 then richedit_fill;
form2.Button8.Hint:='Increasing / decreasing the size of the window with the program';
form2.Button9.Hint:='Increasing / decreasing the size of the window with the text of the task';
form2.Button8.ShowHint:=true;
form2.Button9.ShowHint:=true;
form2.Button10.Hint:='Increasing the size of the window with the tests';
form2.Button11.Hint:='Decreasing the size of the window with the tests';
form2.Button10.ShowHint:=true;
form2.Button11.ShowHint:=true;
form2.CheckBox2.Caption:='Wrong results only';
form2.CheckBox1.Caption:='Autotesting';


form2.Button6.Caption:='Browse';
form2.Button7.Caption:='Load';
form2.OpenDialog1.title:='Opening a file ';
form2.OpenDialog2.title:='Choosing of a compiler';
form2.Caption:='Automated program testing system';
label1.Caption:='Choose a group: ';
label2.Caption:='Choose a task: ';
label3.caption:='Enter your file name ';
label4.Caption:='F1 - Help      Send your reports to the email address: Novikov_57@mail.ru';
button3.Caption:='Preliminary analysis and compilation';
//button4.Caption:='Compilation';
button5.Caption:='Testing';

chapter_names_correct;

if task_amount>0 then task_names_correct;
end;

//Choosing a chapter
procedure TForm2.ComboBox1Click(Sender: TObject);
var q,p:integer;s:string;
begin
combo2text:='';combo2index:=-1;
if text_size then button8.click;
if task_size then button9.click;

//button9.Click;
//button11.Click;
//property 'text' is the text of the chosen item
setcurrentdir(current_dir);
if initial then if (chosen_chapter=0)then exit;
if initial then combobox1.Itemindex:=chosen_chapter-1;
s:=form2.ComboBox1.Text;combo1text:=s;combo1index:=combobox1.Itemindex;
if length(s)<2 then begin chosen_chapter:=0; exit;end;
//q:=pos('.',s);
//if q<2 then begin
//showmessage ('Fatal error. Wrong name of the chapter'); halt end;
//val(copy(form2.ComboBox1.Text,1,q-1),chosen_chapter,p);
//if p<>0 then begin
//showmessage ('Fatal error. Wrong name of the chapter'); halt end;
//showmessage('We are here');
//task_names_fill(copy(form2.ComboBox1.Text,1,q-1));
chosen_chapter:=form2.ComboBox1.Itemindex+1;
task_names_fill;//(form2.ComboBox1.Text);
task_claims_amount:=0;
chapter_claims_amount:=0;
claims_fill(chapter_claims,chapter_claims_amount);
edit1.ReadOnly:=true;
edit1.clear;
memo1.clear;
//memo3.clear;memo2.clear;
memo5.clear;richedit1.Clear;
label3.enabled:=false;
button3.Enabled:=false;
//button4.Enabled:=false;
button5.Enabled:=false;
button6.Enabled:=true;
button7.Enabled:=false;
button8.Enabled:=false;
button9.Enabled:=false;
button10.Enabled:=false;
button11.Enabled:=false;

chosen_task:='';
pr_an:=false;
compi:=false;
filename:='';
end;

//Choosing a task
procedure TForm2.ComboBox2Click(Sender: TObject);
var b:boolean;i1,p,i,k,j:integer;
begin
if text_size then button8.click;
if task_size then button9.click;

//button9.Click;
//button11.Click;
setcurrentdir(current_dir);
edit1.ReadOnly:=true;
sorts:=0;
errorr:=false;
arrayin:=0;
arrayout:=0;
matrixin:=0;
matrixout:=0;
func_proc0:=0;
program_sub:=false;
incorrect_boolean:=false;
task_claims_amount:=0;
warnings_amount:=0;
text_after:='';
text_before:='';
check_new:=false;
check_dispose:=false; 
edit1.clear;
memo1.clear;
//memo3.clear;memo2.clear;
richedit1.clear;memo5.clear;
label3.enabled:=false;
button3.Enabled:=false;
//button4.Enabled:=false;
button5.Enabled:=false;
button6.Enabled:=true;
button7.Enabled:=false;
button8.Enabled:=false;
button9.Enabled:=true;
button10.Enabled:=false;
button11.Enabled:=false;
//showmessage(chosen_task);
if initial then begin combobox2.ItemIndex:=-1;


//showmessage('###'+inttostr(task_amount));
//showmessage('!! '+chosen_task+' @@  '+task_names[3]);

for i1:=1 to task_amount do
if chosen_task=task_names[i1]then begin


//showmessage('ssacscdasc');

combobox2.ItemIndex:=i1-1; combo2text:=combobox2.Text; combo2index:=i1-1 end;
if combobox2.ItemIndex=-1 then begin chosen_task:=''; exit end end
else begin
chosen_task:=combobox2.Text;
combo2text:=combobox2.Text; combo2index:=combobox2.itemindex;
//Back correction
p:=pos(' ',chosen_task);
if p>0 then chosen_task:=copy(chosen_task,1,p-1)+'-'+copy(chosen_task,p+1,200);
p:=pos('.',chosen_task);
if p>0 then chosen_task:=copy(chosen_task,1,p-1)+'_'+copy(chosen_task,p+1,200);
end;
//end of the back correction
j:=pos('-',chosen_task);
if (j>1)and (j<length(chosen_task))then begin k:=pos(chosen_task[j+1],engrus);
if k>26 then k:=k-26;
for i:=1 to task_amount do if (copy(task_names[i],1,j)=copy(chosen_task,1,j))
and(strtoint(copy(task_names[i],j+1,3))=k)
then begin chosen_task:=task_names[i];
break end;end;
while(chosen_task<>'')and(chosen_task[length(chosen_task)]=' ') do chosen_task:=copy(chosen_task,1,length(chosen_task)-1);
//showmessage(chosen_task+' before the extract');
b:=extract_data;
//showmessage('!!!!'); 
if not b and initial then initial:=false;//error in extract_data while initializing; the further initialization must be stopped in this case
//showmessage('1939 after the extract data');
if not b then begin button6.Enabled:=false; button7.Enabled:=false; button3.Enabled:=false; button5.Enabled:=false; exit end;
pr_an:=false;
compi:=false;
filename:='';
edit1.clear;
edit1.ReadOnly:=false;
label3.Enabled:=true;
button3.Enabled:=false;
//button4.Enabled:=false;
button5.Enabled:=false;
button6.Enabled:=true;
button7.Enabled:=true;
button8.enabled:=false;
button9.enabled:=true;
button10.Enabled:=false;
button11.Enabled:=false;

memo1.clear;//memo3.clear;memo2.clear;
richedit_fill;
end;

{Preliminary analysis and compilation}
procedure TForm2.Button3Click(Sender: TObject);
var i:integer;
begin
if task_size then button9.Click;
//button11.Click;
setcurrentdir(current_dir);
form2.Memo1.Font.Name:=_fontname;
for i:=1 to max_test_number do deletefile('current_dir'+'\tmp\rrr'+inttostr(i));
button5.Enabled:=false;memo1.Clear; //memo2.Clear; memo3.clear;
button10.Enabled:=false;
button11.Enabled:=false;
timer1.Enabled:=false;form3.Timer1.Enabled:=false;
if chosen_task='' then begin
if en_rus then messagedlg('You have not chosen a task.',mtinformation,[mbOK],0)else
messagedlg('Вы не выбрали задачу.',mtinformation,[mbOK],0);exit end;
if filename='' then
if en_rus then messagedlg('You have not entered a file name.',mtinformation,[mbOK],0)else
messagedlg('Вы не ввели имя файла.',mtinformation,[mbOK],0);
preliminary_analysis0;
preliminary_analysis1;
preliminary_analysis2;
pr_an:=preliminary_analysis3;
//if pr_an then if en_rus then memo1.Lines.Add('No errors have been found.')else
//memo1.Lines.Add('Ошибoк не обнаружeнo.');
//button4.Enabled:=pr_an;
if pr_an then fill_file_text(current_dir+'\tmp\temp1.pas');
//showmessage('Before precompile!');
//if pr_an then showmessage('!!!!!!!!!!!!!!');
if pr_an then precompile else exit;
//showmessage('After precompile!');
//It is compilation
compi:=compilation(handle);
button5.Enabled:=compi;
if (checkbox1.Checked)and(button5.Enabled)then button5.Click;
end;

{Compilation}
procedure TForm2.Button4Click(Sender: TObject);
//We block it because button3.click perform the compilatoion too
begin
//button9.Click;
//button11.Click;
{if chosen_task='' then begin
if en_rus then messagedlg('You have not chosen a task.',mtinformation,[mbOK],0)else
messagedlg('Вы не выбрали задачу.',mtinformation,[mbOK],0);exit end;

if filename='' then begin
if en_rus then messagedlg('You have not entered a file name.',mtinformation,[mbOK],0)else
messagedlg('Вы не ввели имя файла.',mtinformation,[mbOK],0);exit end;

if not(pr_an) then
if en_rus then messagedlg('You have not made a preliminary analysis.',mtinformation,[mbOK],0)else
messagedlg('Вы не cделали предварительный анализ.',mtinformation,[mbOK],0);
memo2.clear; memo3.clear;
compi:=compilation(handle);
button5.Enabled:=compi;
button10.Enabled:=compi;
button11.Enabled:=compi;
}
end;

{Testing}
procedure TForm2.Button5Click(Sender: TObject);
begin
//memo1.clear;
if task_size then button9.Click;
button5.Enabled:=false;
button1.Enabled:=false;
button2.Enabled:=false;
button3.Enabled:=false;
button6.Enabled:=false;
button7.Enabled:=false;
button8.Enabled:=false;
button9.Enabled:=false;

if chosen_task='' then begin
if en_rus then messagedlg('You have not chosen a task.',mtinformation,[mbOK],0)else
messagedlg('Вы не выбрали задачу.',mtinformation,[mbOK],0);exit end;

if filename='' then begin
if en_rus then messagedlg('You have not entered a file name.',mtinformation,[mbOK],0)else
messagedlg('Вы не ввели имя файла.',mtinformation,[mbOK],0);exit end;

if not(pr_an) then begin
if en_rus then messagedlg('You have not made a preliminary analisis.',mtinformation,[mbOK],0)else
messagedlg('Вы не cделали предварительный анализ.',mtinformation,[mbOK],0) ;exit;end;

if not(compi) then
if en_rus then messagedlg('You have not compiled your program.',mtinformation,[mbOK],0)else
messagedlg('Вы не cкомпилировали программу.',mtinformation,[mbOK],0);
was_loop:=false;
testing(handle);
button1.Enabled:=true;
button2.Enabled:=true;
button3.Enabled:=true;
button6.Enabled:=true;
button7.Enabled:=true;
button8.Enabled:=true;
button9.Enabled:=true;

if (not was_loop)and((chosen_task[1]<>'1')or(chosen_task[2]<>'5'))then
 button5.Enabled:=true;
 memo1.SetFocus;

end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
end;

//Button "Browse"
procedure TForm2.Button6Click(Sender: TObject);
var b:boolean;i:integer;s3,nt, s:string;nc:integer;
begin
setcurrentdir(current_dir);
b:=form2.opendialog1.execute;
if b then begin s:=form2.opendialog1.filename;
if pos(' ',s)>0 then begin
if en_rus then begin showmessage('Warning: the path to the tested file contains blank characters. The file may not be compiled correctly.'); end
else begin showmessage('Путь к тестируемому файлу содержит пробелы. Возможны ошибки при компиляции.'); end;
end;
end;
if b then begin if text_size then button8.click;if task_size then button9.click;
s3:=form2.opendialog1.filename;

if not initial then begin b:=decrypt(s3,nc,nt);
if b then begin initial:=true;chosen_chapter:=nc+1;
//showmessage(inttostr(chosen_chapter));
form2.ComboBox1click(sender);
chosen_task:=nt;
form2.ComboBox2click(sender); initial:=false;
if not form2.Button6.enabled then exit;
end;

end;

//showmessage('!!!');

if (form2.ComboBox1.ItemIndex=-1)or(form2.ComboBox2.ItemIndex=-1)then begin if en_rus then showmessage('You have not chosen a task.')else showmessage('Bы не выбрaли зaдaчу. ');exit;end;

//showmessage(current_dir);
for i:=1 to max_test_number do deletefile(current_dir+'\tmp\rrr'+inttostr(i));
//button4.Enabled:=false;
button5.Enabled:=false;

//;showmessage('!!;');
setcurrentdir(current_dir);
if s3<>''then begin b:=fileexistsf(s3); if not b then exit;end;
filename:=s3;
deletefile('.\tmp\temp1.pas');
deletefile('.\tmp\temp2.pas');
deletefile('.\tmp\temp3.pas');
deletefile('.\tmp\temp4.pas');
deletefile('.\tmp\temp5.pas');
deletefile('.\tmp\temp10.pas');
deletefile('.\tmp\temp20.pas');
deletefile('.\tmp\temp30.pas');
deletefile('.\tmp\temp40.pas');
deletefile('.\tmp\temp50.pas');
if filename<>'' then begin memo1.Clear; memo5.clear;func_proc:=func_proc0; fill_file_text(filename);edit1.text:=filename;
if form2.checkbox1.Checked then form2.Button3.click;

end;
end;
end;

//Button Load when we are choosing a file
procedure TForm2.Button7Click(Sender: TObject);
var b:boolean;s,s1:string;
begin
setcurrentdir(current_dir);
if task_size then button9.click;
if text_size then button8.Click;
s:=edit1.text;s1:=s; delete_blanks(s1);
if (s1='')or(s1[1]=' ')then begin button6.click; exit end;
if pos(' ',s)>0 then begin
if en_rus then begin showmessage('Warning: the path to the tested file contains blank characters. The file may not be compiled correctly.'); end
else begin showmessage('Путь к тестируемому файлу содержит пробелы. Возможны ошибки при компиляции.'); end;
end;
if s<>''then begin b:=fileexistsf(s);
if b then begin //button4.Enabled:=false;
button5.Enabled:=false;
button8.Enabled:=true;button3.Enabled:=true;
button9.Enabled:=true;
button10.Enabled:=false;
button11.Enabled:=false;
memo5.clear; memo1.clear;
deletefile('.\tmp\temp1.pas');
deletefile('.\tmp\temp2.pas');
deletefile('.\tmp\temp3.pas');
deletefile('.\tmp\temp4.pas');
deletefile('.\tmp\temp5.pas');
deletefile('.\tmp\temp10.pas');
deletefile('.\tmp\temp20.pas');
deletefile('.\tmp\temp30.pas');
deletefile('.\tmp\temp40.pas');
deletefile('.\tmp\temp50.pas');
deletefile(current_dir+'\tmp\temp1.exe');deletefile(current_dir+'\tmp\temp10.exe');
deletefile(current_dir+'\tmp\temp2.exe');deletefile(current_dir+'\tmp\temp3.exe');
deletefile(current_dir+'\tmp\temp4.exe');deletefile(current_dir+'\tmp\temp5.exe');
deletefile(current_dir+'\tmp\temp20.exe');deletefile(current_dir+'\tmp\temp30.exe');
deletefile(current_dir+'\tmp\temp40.exe');deletefile(current_dir+'\tmp\temp50.exe');
deletefile(current_dir+'\tmp\temp1.o');deletefile(current_dir+'\tmp\temp10.o');
deletefile(current_dir+'\tmp\temp2.o');deletefile(current_dir+'\tmp\temp3.o');
deletefile(current_dir+'\tmp\temp4.o');deletefile(current_dir+'\tmp\temp5.o');
deletefile(current_dir+'\tmp\temp20.o');deletefile(current_dir+'\tmp\temp30.o');
deletefile(current_dir+'\tmp\temp40.o');deletefile(current_dir+'\tmp\temp50.o');
filename:=s;func_proc:=func_proc0;fill_file_text(filename);

if form2.checkbox1.Checked then form2.Button3.click;

end;end;
//setcurrentdir(dir_1);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
//showmessage('!!!###'+inttostr(number_of_intervals));
//application.ProcessMessages;
Number_of_intervals:=number_of_intervals+1;

end;

procedure TForm2.Button8Click(Sender: TObject);
begin
if not text_size and task_size then exit;
if not text_size then begin //memo5.Height:=memo5.Height*3;
memo5.Height:=round(form2.Height*low_pos)-memo5.Top;
text_size:=true; button8.Caption:='-';
button3.Visible:=false;button5.Visible:=false; memo1.Visible:=false;
if en_rus then form2.Button8.Hint:='Decreasing the size of the window with the program'
else form2.Button8.Hint:='Уменьшение размеров окна с программой ';
end
else begin
//memo5.Height:=memo5.Height div 3;
text_size:=false; button8.Caption:='+';
memo5.Height:=_height div memo5height;//see file00 for the definition
button3.Visible:=true;button5.Visible:=true; memo1.Visible:=true;
//if en_rus then form2.Button8.Hint:='Increasing / cecreasthe size of the window with the program'
//else form2.Button8.Hint:='Увеличение размеров окна с программой ';
end;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
if not task_size and text_size then exit;
if not task_size then begin //memo5.Height:=memo5.Height*3;
richedit1.Height:=memo5.Top+memo5.Height-richedit1.top;
task_size:=true; button9.Caption:='-';
//button3.Visible:=false;button5.Visible:=false; memo1.Visible:=false;
//if en_rus then form2.Button9.Hint:='Decreasing the size of the window with the program'
//else form2.Button9.Hint:='Уменьшение размеров окна с программой ';
end
else begin
//memo5.Height:=memo5.Height div 3;
task_size:=false; button9.Caption:='+';
richedit1.Height:=round(_height / 5.8);
//button3.Visible:=true;button5.Visible:=true; memo1.Visible:=true;
//if en_rus then form2.Button8.Hint:='Increasing the size of the window with the program'
//else form2.Button8.Hint:='Увеличение размеров окна с программой ';
end;


end;

procedure TForm2.Button11Click(Sender: TObject);
begin
//if test_size then begin memo3.Left:=button5.left;memo3.Width:=button5.Width; test_size:=false;
//button4.Visible:=true;button3.Visible:=true;
//end;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
//if not test_size and not text_size then begin
//memo3.Top:=memo3.Top div 2; memo3.left:=memo1.Left; memo3.Width:=button5.Left-button3.left+button5.Width; test_size:=true;
//button4.Visible:=false;button3.Visible:=false;
//end;
end;

procedure TForm2.FormResize(Sender: TObject);
var k1,k2,k3:integer;
const _interval=1;
begin
//exit;


k1:=form2.Width; k2:=form2.height;

//showmessage('Resize!! '+inttostr(k1)+' '+inttostr(k2)+' '+inttostr(_width)+'  '+inttostr(_height)+' '+inttostr(current_width)+' '+inttostr(current_height));


if k1<_width*0.8 then begin form2.Width:=round(_width*0.8); exit end; if k2<_height*0.8 then begin form2.height:=round(_height*0.8); exit end;
if k1>current_width+_interval then begin
k3:=_interval; while form2.width-current_width>k3 do k3:=k3+_interval;k3:=k3-_interval;
memo5.Width:=memo5.Width+k3;button8.Left:=button8.left+k3;button9.Left:=button9.left+k3;
richedit1.Width:=richedit1.Width+k3;
memo1.Width:=memo1.Width+k3;current_width:=current_width+k3 end else
if (k1<current_width-_interval){and(k1>_width)}then begin


//showmessage('!!!');

k3:=_interval; while current_width-form2.width>k3 do k3:=k3+_interval;k3:=k3-_interval;
memo5.Width:=memo5.Width-k3;button8.Left:=button8.left-k3;button9.Left:=button9.left-k3;
richedit1.Width:=richedit1.Width-k3;
memo1.Width:=memo1.Width-k3;current_width:=current_width-k3 end;
if k2>current_height+_interval
then begin k3:=_interval;
while form2.height-current_height>k3 do k3:=k3+_interval;k3:=k3-_interval;
memo1.height:=memo1.height+k3;
if text_size then memo5.Height:=memo5.Height+k3;
button1.Top:=button1.Top+k3;button2.Top:=button2.Top+k3;label4.top:=label4.top+k3;
current_height:=current_height+k3 end else
if (k2<current_height-_interval){and(k2>_height)}then
begin k3:=_interval;
while current_height-form2.height>k3 do k3:=k3+_interval;k3:=k3-_interval;
memo1.height:=memo1.height-k3;current_height:=current_height-k3;
button1.Top:=button1.Top-k3;button2.Top:=button2.Top-k3;label4.top:=label4.top-k3;
if text_size then memo5.Height:=memo5.Height-k3;
end;
application.ProcessMessages;


//width:=_width; height:=_height;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=chr(13)then form2.Button7.click;
end;

procedure TForm2.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Memo5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button11KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Button2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then showhelp;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
combobox1.Text:=combo1text;
combobox1.ItemIndex:=combo1index;
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
combobox2.Text:=combo2text;
combobox2.ItemIndex:=combo2index;
end;

end.

