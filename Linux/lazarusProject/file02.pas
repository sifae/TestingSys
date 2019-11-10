unit file02;

interface

uses
cthreads, cmem, file00, LCLIntf, Messages, SysUtils, Classes, Variants,
Graphics, Controls, Forms,
Dialogs, StdCtrls, ExtCtrls, ComCtrls, RichMemo, RichMemoUtils, RichMemoRtf, Process;//;

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
  procedure Edit1KeyPress(Sender: TObject; var Key: char);
  procedure ComboBox1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure ComboBox2KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Memo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Memo5KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure RichEdit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button10KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button3KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button5KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button6KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button7KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button8KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button9KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button11KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Button2KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  procedure ComboBox1Change(Sender: TObject);
  procedure ComboBox2Change(Sender: TObject);
private
  { Private declarations }
public
  { Public declarations }
end;

var
Form2: TForm2;


const
engrus =
  'abcdefghijklmnjpqrstuvwxyzабвгдежзиклмнопрстуфхцчшщъыьэюя';

const
ruscapsmall =
  'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя';

procedure initialize_screen;
{procedure of initializing the encoded files: both tests.cde (b=true) and claims.cde (b=false)}
procedure initializef(var f: t_f; var i_n, i_c: integer; var s_n: Ts_n; b: boolean);

implementation

uses file09, file01, file03, file_executeScript, testing_main, Data;

{$R *.dfm}

{$I-,R+}
//These are contents of currents items of the combo- components
var
combo2text, combo1text: string;

var
combo2index, combo1index: integer;

var
binit: boolean;//False if form2 is activated for the first time, that is, after the first frame

var
low_pos: real;//position of button1 and buttons2 and label4

//The procedure that outputs help information
procedure showhelp;
var
  s: string;
begin
  if en_rus then
  begin
    s := 'SOME PECULIARITIES OF MAKING PROGRAMS FOR THE AUTOMATED PROGRAM TESTING SYSTEM'
      + chr(13) + chr(10);
    s := s + '1. Do not use blank characters in file and directory names.' +
      chr(13) + chr(10);
    s := s +
      '2. Descriptions of tasks that are suggested in the System can be slightly different from those in the taskbook by Pilshchikov. Read the text to a task attentively before making a program for it.' + chr(13) + chr(10);
    s := s +
      '3. Output exactly the information that is specified for the task. In particular, do not output any prompts like ''Input the array:'', ''The result is:'' and others.';
    s := s +
      ' However, if you still want to use an additional output, place it on a separate line beginning with the characters ''{I}''. The System ignores such program lines.' + chr(13) + chr(10);
    s := s + '4. Separate output numbers with blank characters. ' + chr(13) + chr(10);
    s := s +
      '5. A complex number must be output as two real numbers without any brackets, characters ''+'' or ''i''.'
      +
      chr(13) + chr(10);
    s := s +
      '6. Elements of a one-dimensional array must be output in ascending order of their indeces if the task does not specify a different output.'
      +
      chr(13) + chr(10);
    s := s +
      '7. Elements of a matrix must be output in order of its rows if the task does not specify a different output.'
      +
      chr(13) + chr(10);
    s := s +
      '8. The amount of terms of a sequence, the amount of elements of a one-dimensional array and the order of a square matrix must be defined as an integer constant with a posuitive value.' + chr(13) + chr(10);
    s := s +
      '9. The amount of rows and columns of a rectangular matrix must be specified as two integer constants with positive values; the first constant denotes the amount of the rows and the second one denotes the amount of the columns.' + chr(13) + chr(10);
    s := s +
      'To guarantee a correct compilation of the program do not use any other constants for the tasks where these special constants are needed.'
      +
      chr(13) + chr(10);
    s := s +
      '10. For setting a chapter number and a task number automatically, use filenames of the type ''_<chapter number>_<task number>-<subtask number (a three-digit integer)>_<any text>''. Examples: _16_18-003_Petrov.pas, _15_47_Ivanov.pas.';
  end
  else
  begin
    s := 'НЕКОТОРЫЕ ОСОБЕННОСТИ СОСТАВЛЕНИЯ ПРОГРАММ ДЛЯ СИСТЕМЫ АВТОМАТИЧЕСКОГО ТЕСТИРОВАНИЯ' + chr(13) + chr(10);
    s := s +
      '1. Не используйте пробелы в именах файлов и каталогов.'
      +
      chr(13) + chr(10);
    s := s +
      '2. Формулировки задач, предложенныx в Системе, могут немного отличаться от формулировок, приведенных в задачнике Пильщикова. Внимательно прочтите текст задачи перед составлением программы. ' + chr(13) + chr(10);
    s := s +
      '3. Выводите в точности ту информацию, которая указана в формулировке задачи. В частности, не выводите никаких поясняющиx сообщений типа ''Введите x='', ''Ответ:'' и т.д.';
    s := s +
      ' Oднако, если Вы всe же хотите использовать дополнительный вывод, разместите егo в отдельной строке и начните с комментария ''{I}''. Система автоматически удаляет такие строки.' + chr(13) + chr(10);
    s := s + '4. Выводимые числа разделяйте пробелами.'
      +
      chr(13) + chr(10);
    s := s +
      '5. Комлексное число должно быть выведено как совокупность двух вещественных чисeл без допoлнительных скобок, знаков ''+'' или ''i''.' + chr(13) + chr(10);
    s := s +
      '6. Элементы одномерного массива должны быть выведены в порядке возрастания их индексов, если иное не указано в формулировке задачи.' + chr(13) + chr(10);
    s := s +
      '7. Элементы матрицы должны быть выведены по строкам, если иное не указано в формулировке задачи.' + chr(13) + chr(10);
    s := s +
      '8. Количество элементов последовательности, количество элементов одномерного массива и порядок квадратной матрицы должны быть заданы целой положительной констaнтой.' + chr(13) + chr(10);
    s := s +
      '9. Koличества строк и столбцов прямоугольной матрицы должны быть заданы двумя целыми положительными константами; первая константа означает количество строк, вторая - количество столбцoв.' + chr(13) + chr(10);
    s := s +
      'Во избежание неправильной компиляции программы не следуeт описывать другие константы в задачах, требующих этих специальных констант.' + chr(13) + chr(10);
    s := s +
      '10. Для автоматического определения Системой номера главы и номера задачи используйте имена файлов вида ''_<номер главы>_<номер задачи>-<номер подзадачи (3 цифры)>_<произвольный текст>''. Примеры: _16_18-003_Petrov.pas, _15_47_Ivanov.pas.' + chr(13) + chr(10);
  end;
  ShowMessage(s);
end;

//The procedure fills the richedit-component
procedure richedit_fill;
var
  f2, f: textfile;
  s, rtfFilePath: string;
  stream : TFileStream;
var
  p1, p2: integer;
label
  1;
begin
  form2.RichEdit1.Clear;
  if chosen_task = '' then
    exit;
  rtfFilePath := current_dir + '/tests/' + directory_names[chosen_chapter] + '/' + chosen_task;
  if en_rus then
    rtfFilePath := rtfFilePath + '_e.rtf'
  else
    rtfFilePath := rtfFilePath + '_r.rtf';
  //Assign(f, rtfFilePath);
  //showmessage (sf);
  //reset(f);
  //if ioresult <> 0 then
  //  exit;
  //closefile(f);
  //ioresult;
  //reset(f);
  //ioresult;
  //form2.richedit1.Lines.LoadFromFile(rtfFilePath);
  //closefile(f);
  //ioresult;

  //Write the file into a stream
  stream := nil;
  stream := TFileStream.Create(Utf8ToAnsi(rtfFilePath), fmOpenRead or fmShareDenyNone);

  //Load the stream into the RichEdit
  //form2.richedit1.PlainText := False;
  try
    registerRtfLoader;
    //MVCParserLoadStream(form2.RichEdit1, stream);
    form2.richedit1.LoadRichText(stream);
  except
    //
  end;
  stream.Free;

  if not en_rus then
    exit;
  if func_proc0 > 0 then
    exit;

  //Write the file into a stream
  stream := nil;
  stream := TFileStream.Create(Utf8ToAnsi(current_dir + '/tmp/addtext.txt'), fmOpenWrite or fmShareDenyNone);

  //Load the stream into the RichEdit
  //form2.richedit1.PlainText := False;
  try
    registerRtfSaver;
    //MVCParserLoadStream(form2.RichEdit1, stream);
    form2.richedit1.SaveRichText(stream);
  except
    //
  end;
  stream.Free;

  Assign(f, current_dir + '/tmp/addtext.txt');
  reset(f);
  if ioresult <> 0 then
    goto 1;
  if (EOF(f)) then
    goto 1;
  Assign(f2, current_dir + '/tmp/addtext1.txt');
  rewrite(f2);
  if ioresult <> 0 then
    goto 1;
  while not EOF(f) do
  begin
    readln(f, s);
    if s = '' then
      goto 1;
    if s[1] = '{' then
      writeln(f2, s)
    else
      break;
  end;
  if EOF(f) then
    goto 1;
  p1 := pos(' ', s);
  p2 := pos('/''', s);
  if (p1 = 0) and (p2 = 0) then
    goto 1;
  if (p1 = 0) and (p2 > 0) then
    p1 := p2 + 1
  else
    if (p1 > 0) and (p2 = 0) then
      p2 := p1 + 1;

  //showmessage('wait'+inttostr(p1)+'   '+inttostr(p2));

  if (pos('/''e0/''ef/''e8/''f1/''e0/''f2/''fc', s) > 0) and
    (pos('/''ef/''f0/''ee/''e3/''f0/''e0/''ec/''ec', s) > 0) then
    goto 1;
  if p1 < p2 then
    if en_rus then
      s := copy(s, 1, p1) + 'WRITE A PASCAL PROGRAM. ' + copy(s, p1 + 1, length(s))
    else
      s := copy(s, 1, p1) + 'Написать программу на Паскале. ' +
        copy(s, p1 + 1, length(s));
  if p1 > p2 then
    if en_rus then
      s := copy(s, 1, p2 - 1) + 'WRITE A PASCAL PROGRAM. ' + copy(s, p2, length(s))
    else
      s := copy(s, 1, p2 - 1) +
        'Напиcать программу на Паскале. ' +
        copy(s, p2, length(s));
  writeln(f2, s);
  while not (EOF(f)) do
  begin
    readln(f, s);
    writeln(f2, s);
  end;
  closefile(f);
  ioresult;
  closefile(f2);
  ioresult;
  erase(f);
  ioresult;

  //showmessage(inttostr(p1)+'  !! '+inttostr(p2));

  //Write the file into a stream
  stream := nil;
  stream := TFileStream.Create(Utf8ToAnsi(current_dir + '/tmp/addtext1.txt'), fmOpenRead or fmShareDenyNone);

  try
    registerRtfLoader;
    //MVCParserLoadStream(form2.RichEdit1, stream);
    form2.richedit1.LoadRichText(stream);
  except
    //
  end;
  stream.Free;

  1:
    closefile(f);
    ioresult;
    closefile(f2);
    ioresult;
    erase(f);
    ioresult;
    erase(f2);
    ioresult;
end;

{procedure of initializing the encoded files: both tests.cde (b=true) and claims.cde (b=false)}
procedure initializef(var f: t_f; var i_n, i_c: integer; var s_n: Ts_n; b: boolean);
var
  k: byte;
begin
  closefile(f);
  ioresult;
  reset(f);

  k := ioresult;
  //showmessage(inttostr(k));
  //showmessage(inttostr(filesize(f)));

  if ((k <> 0) or (filesize(f) < 12)) and b then
  begin
    ShowMessage('Fatal error in initializef');
    halt;
  end;
  Read(f, k);
  Read(f, k);
  Read(f, k);
  i_n := k mod 10;
  //i_n:=0;
  Read(f, k);
  Read(f, k);
  Read(f, k);
  s_n := [k mod 10, k div 10 mod 10];
  //showmessage(inttostr(i_n)+' '+inttostr(k mod 10)+'  '+inttostr(k div 10 mod 10));
  //s_n:=[];
  Read(f, k);
  Read(f, k);
  Read(f, k);
  Read(f, k);
  i_c := 10;
end;

//It is a procedure that fills the array 'chapter_claims' containing claims to tasks of the chosen chapter
procedure claims_fill(var aclaim: Tclaims; var Count: integer);
var
  b: boolean;
  s: string;
  f: t_f;
  p, i: integer;
begin
  Count := 0;
  assignfile(f, current_dir + '/tests/' + directory_names[chosen_chapter] +
    '/claims.cde');
  reset(f);
  if ioresult <> 0 then
    exit;
  initializef(f, i_n_2, i_c_2, s_n_2, False);
  //showmessage('We are here!');

  //showmessage(current_dir+'/tests/'+directory_names[chosen_chapter]+'/claims.cde');
  //showmessage(inttostr(p));
  i := 0;
  while not (EOF(f)) do
  begin
    b := readlnf2(f, s);
    while (s <> '') and (s[1] = ' ') do
      Delete(s, 1, 1);
    while (s <> '') and (s[length(s)] = ' ') do
      Delete(s, length(s), 1);
    //showmessage(s);
    if (length(s) < 3) or (s[1] = ' ') then
      break;
    if (s[1] in ['w', 'W']) and (s[2] = ' ') then
    begin
      aclaim[i + 1].b1 := True;
      Delete(s, 1, 2);
    end
    else
      aclaim[i + 1].b1 := False;
    aclaim[i + 1].s1 := s;
    aclaim[i + 1].b := False;
    if not b then
      readlnf2(f, s)
    else
    begin
      closefile(f);
      ShowMessage('Fatal error. Odd amount of lines in the file ''claims.txt''');
      halt;
    end;
    p := pos('!', s);
    if p = 0 then
    begin
      aclaim[i + 1].s2 := s;
      aclaim[i + 1].s3 := s;
    end
    else
    begin
      aclaim[i + 1].s2 := copy(s, 1, p - 1);
      aclaim[i + 1].s3 := copy(s, p + 1, 200);
    end;
    Inc(i);
  end;
  Count := i;
  closefile(f);
  ioresult;
  //showmessage(inttostr(count));
end;

{procedure of initializing the screen - the previous state is restored if the file 'test.ini' exists}
procedure initialize_screen;
var
  f: Text;
var
  b: boolean;
var
  Sender: TObject;
  p: integer;
label
  1;
var
  s: string;
begin
  //showmessage('we are here');
  Sender := TObject.newInstance;
  combo1text := '';
  combo2text := '';
  b := False;
  combo1index := -1;
  combo2index := -1;
  //chosen_chapter := 1;
  Assign(f, current_dir + '/tmp/tests.ini');
  reset(f);
  p := ioresult;
  //showmessage(current_dir+'/test.ini'+'!'+inttostr(p));
  if p <> 0 then
    goto 1;
  readln(f, s);
  b := s = '1';
  if EOF(f) then
  begin
    closefile(f);
    ioresult;
    goto 1;
  end;
  readln(f, s);
  form2.CheckBox2.Checked := s = '1';
  if EOF(f) then
  begin
    closefile(f);
    ioresult;
    goto 1;
  end;
  readln(f, chosen_chapter);
  //ShowMessage(IntToStr(chosen_chapter));
  if ioresult <> 0 then
  begin
    chosen_chapter := 0;
    goto 1;
  end;
  form2.combobox1click(Sender);
  if (EOF(f)) or (chosen_chapter = 0) then
    goto 1;
  readln(f, chosen_task);
  if ioresult <> 0 then
  begin
    chosen_task := '';
    goto 1;
  end;
  //showmessage(chosen_task);
  form2.combobox2click(Sender);
  //showmessage(chosen_task);
  if (EOF(f)) or (chosen_task = '') or (not initial) then
    goto 1;
  readln(f, filename);
  form2.Edit1.Text := filename;
  form2.Button7.Click;
  1:
    form2.CheckBox1.Checked := b;
  initial := False;
  closefile(f);
  ioresult;
end;

{Procedure of filling combobox1}
procedure task_chapters_fill;
var
  k, p, j: integer;
  f: textfile;
  i: integer;
  s2: string;
var
  searchresult: tsearchrec;
begin
  combo1text := '';
  combo2text := '';
  combo1index := -1;
  combo2index := -1;
  pr_an := False;
  compi := False;
  chosen_task := '';
  filename := '';
  chosen_chapter := 0;
  form2.combobox1.Clear;
  form2.combobox2.Clear;
  k := 0;
  setcurrentdir(current_dir);
  p := findfirst(current_dir + '/tests/*', fadirectory, searchresult);
  if p <> 0 then
  begin
    ShowMessage('Fatal error. No subdirectories in the directory ''tests''');
    halt;
  end;
  if p = 0 then
  begin
    repeat  //if true or ((searchResult.attr and faDirectory) = faDirectory)
      //showmessage(searchresult.name);
      if (searchresult.Name = '') or (searchresult.Name[1] = '.') then
        continue;
      s2 := searchresult.Name;

      closefile(f);
      ioresult;
      assignfile(f, current_dir + '/tests/' + s2 + '/tests.cde');
      reset(f);
      if ioresult <> 0 then
        continue;
      j := pos('!', s2);
      Inc(k);
      directory_names[k] := s2;
      if j >= 2 then
      begin
        chapter_names[k, 1] := copy(s2, 1, j - 1);
        chapter_names[k, 2] := copy(s2, j + 1, 1111);
      end
      else
      begin
        chapter_names[k, 2] := s2;
        chapter_names[k, 1] := s2;
      end;
      form2.combobox1.items.add(chapter_names[k, 1 + byte(en_rus)]);
      closefile(f);
      ioresult;
      //showmessage(form2.combobox1.items[k-1]);
      //form2.combobox1.text := form2.combobox1.items[k-1];
    until (FindNext(searchResult) <> 0);
    findclose(searchresult);
  end;

  if k = 0 then
  begin
    ShowMessage('Fatal error. No testing files in the directory ''tests''');
    halt;
  end;
  //showmessage('!!!'+inttostr(k));

  //for i:=3 to 17 do begin assignfile(f, 'Tests_chapter_'+inttostr(i)+'.cde');
  //reset(f); if (ioresult<>0) or(eof(f))then begin ioresult; closefile(f);ioresult;continue; end;
  //form2.combobox1.items.add(inttostr(i)+'. '+chapter_names[i,2-byte(en_rus)]);closefile(f);ioresult;
end;

{procedure of correcting the names of chapters when switching from rus to en and vice versa }
procedure chapter_names_correct;
var
  p, j, i, m, k: integer;
  s: string;
begin

  //k:=form2.ComboBox1.ItemIndex;
  k := combo1index;
  if k = -1 then
    exit;
  m := form2.ComboBox1.Items.Count;
  //showmessage(inttostr(m));
  for i := 1 to m do
  begin
    s := form2.ComboBox1.Items[i - 1];
    //showmessage(s+' '+inttostr(k));
    //p:=pos('.',s); if p<2 then halt;j:=strtoint(copy(s,1,p-1));
    //s:=copy(s,1,p)+' '+chapter_names[j,1+byte(en_rus)];
    s := chapter_names[i, 1 + byte(en_rus)];
    //if i=1 then showmessage(inttostr(k)+' '+inttostr(i));
    if i - 1 = k then
    begin
      combo1text := s;
    end;
    form2.ComboBox1.Items[i - 1] := s;
  end;
  form2.ComboBox1.ItemIndex := k;
end;

{procedure of filling or correcting combobox2 when choosing a chapter or
switching from rus to eng and back}
{the procedure uses the array 'task_names'}
procedure task_names_correct;
var
  p, L, k, i: integer;
  s: string;
  b: boolean;
begin
  b := form2.ComboBox2.Items.Count = 0;
  L := combo2index;
  //form2.ComboBox2.Clear;
  for i := 1 to task_amount do
  begin
    s := task_names[i];
    //showmessage('!'+s+'!');
    k := pos('-', s);
    if (k > 1) and (k <= length(s) - 3) and (s[k + 1] = '0') then
    begin
      //showmessage(s+'!'+'@'+copy(s,k,3)+'#'+inttostr(k)+engrus[27]);
      s := copy(s, 1, k) + engrus[26 * byte(not (en_rus)) +
        StrToInt(copy(s, k + 1, 3))] + copy(s, k + 4, 200);
    end;
    //Additional correcting
    p := pos('_', s);
    if (p > 1) and (p < length(s)) and (s[p - 1] in ['0'..'9']) and
      (s[p + 1] in ['0'..'9']) then
      s := copy(s, 1, p - 1) + '.' + copy(s, p + 1, 1000);
    p := pos('-', s);
    if (p > 1) and (p < length(s)) and (s[p - 1] in ['0'..'9']) and
      (pos(s[p + 1], engrus) > 0) then
    begin
      Delete(s, p, 1);
      insert(' ', s, p);
    end;


    if b then
      form2.ComboBox2.items.add(s)
    else
      form2.ComboBox2.Items[i - 1] := s;
    if i - 1 = L then
      combo2text := s;
  end;
  if l >= 0 then
    form2.ComboBox2.ItemIndex := l;
end;

{Procedure of filling the array 'task_names'}
procedure task_names_fill;//(chosen:string);
var
  f: t_f;
  i: integer;
  s: string;
  b: boolean;
begin
  //showmessage('Task_names_fill');
  task_amount := 0;
  form2.combobox2.Clear;
  pr_an := False;
  compi := False;
  chosen_task := '';
  filename := '';
  closefile(f);
  ioresult;
  assignfile(f, current_dir + '/tests/' + directory_names[chosen_chapter] +
    '/claims.cde');
  initializef(f, i_n_2, i_c_2, s_n_2, False);
  assignfile(f, current_dir + '/tests/' + directory_names[chosen_chapter] +
    '/tests.cde');
  //..'Tests_chapter_'+chosen+'.cde');
  //reset(f); if ioresult<>0 then showmessage(current_dir+'/tests'+directory_names[form2.ComboBox1.itemindex+1]+'/tests.cde');

  b := False;
  initializef(f, i_n, i_c, s_n, True);
  //I wrote the next line for a safe reason because this error cannot occur
  //if ioresult<>0 then begin form2.label1.caption:='!'+'Error! File not found _'+chosen+'.cde';exit end;
  while not EOF(f) and not b do
  begin
    b := readlnf(f, s);
    //showmessage('!'+s+'!');
    if (s = '') or (s[1] <> '_') or (length(s) > 3) and (s[1] = '_') and
      (not (s[2] in ['0'..'9'])) then
      continue;
    i := pos(';', s);
    if i > 0 then
      s := copy(s, 1, i - 1);//removal of a possible comment
    Inc(task_amount);
    task_names[task_amount] := copy(s, 2, 200);
    while (task_names[task_amount] <> '') and
      (task_names[task_amount, length(task_names[task_amount])] = ' ') do
      Delete(task_names[task_amount], length(task_names[task_amount]), 1);

  end;
  closefile(f);
  ioresult;
  task_names_correct;
end;

{procedure filling memo5 - it is the text of the chosen program}
procedure fill_file_text(s0: string);
var
  f: textfile;
  k: integer;
  s: string;
begin
  assignfile(f, s0);
  //showmessage(s0+' !!!!! '+filename);
  if filename = '' then
    exit;
  reset(f);
  if ioresult <> 0 then
    exit;
  form2.memo5.Clear;
  k := 1;
  while not (EOF(f)) do
  begin
    Inc(k);
    readln(f, s);
    if k = 2 then
      delete_extra(s);
    insert_blanks(s);
    form2.memo5.Lines.add(s);
  end;
  closefile(f);
end;

{procedure filling memo5 if errors were found while compiling}
{s0 - the name of the program file, s1 - the name of the file where the results of the compilation were written}
procedure fill_file_text_err(s0, s1: string);
var
  r, p, q, m: integer;
var
  f, g: textfile;
  s3, s2, s: string;
begin
  form2.Memo5.Clear;
  assignfile(f, s0);
  reset(f);
  if ioresult <> 0 then
    exit;
  assignfile(g, s1);
  reset(g);
  if ioresult <> 0 then
    exit;
  m := 1; //the current line of the file f
  while not (EOF(g)) do
  begin
    readln(g, s);
    p := pos('Error', s);
    if p = 0 then
      p := pos('Fatal', s);
    if p = 0 then
      continue;
    q := pos('(', s);
    r := pos(',', s);

    //showmessage(inttostr(q)+'  '+inttostr(r));
    if (q = 0) or (r = 0) or (q > r) then
      continue;
    s2 := copy(s, q + 1, r - q - 1);
    if s2 = '' then
      continue;
    val(s2, p, q);

    //showmessage('!'+s2+'!'+inttostr(p)+'  '+inttostr(q));
    if q <> 0 then
      continue;

    while (m < p) and (not (EOF(f))) do
    begin
      readln(f, s3);
      insert_blanks(s3);
      form2.Memo5.Lines.Add(s3);
      Inc(m);
    end;
    if EOF(f) then
      break;
    if m = p then
    begin
      readln(f, s3);
      Inc(m);
      s3 := s3 + '   //' + s;
      insert_blanks(s3);
      form2.Memo5.Lines.Add(s3);
    end;

  end;
  while not (EOF(f)) do
  begin
    readln(f, s3);
    insert_blanks(s3);
    form2.Memo5.Lines.Add(s3);
  end;
  closefile(f);
  closefile(g);
end;

{function checking if the chosen file exists}
function fileexistsf(s: string): boolean;
var
  f: textfile;
begin
  Assign(f, s);
  closefile(f);
  ioresult; //form2.button3.enabled:=false;
  //form2.button4.enabled:=false; form2.button5.enabled:=false;
  reset(f);
  if (ioresult <> 0) or (EOF(f)) then
  begin
    closefile(f);
    ioresult;
    fileexistsf := False;
    if en_rus then
      messagedlg('The file does not exist.', mtInformation, [mbOK], 0)
    else
      messagedlg('Файл не существует.', mtInformation, [mbOK], 0);
  end
  else
  begin
    fileexistsf := True;
    form2.button3.Enabled := True;
    form2.button8.Enabled := True;
    form2.button9.Enabled := True;
    closefile(f);
    ioresult;
    //if form2.button3.Enabled and form2.CheckBox1.Checked then form2.Button3.Click;
  end;
  closefile(f);
  ioresult;
end;

{Function counting the number of apostrophes in the string's part}
function count_ap(var s: string; i: integer): integer;
  {The number is counted in the part s[1]..s[i] }
var
  k, j: integer;
begin
  k := 0;
  for j := 1 to i do
    if s[j] = chr(39) then
      Inc(k);
  count_ap := k;
end;

{Procedures performing the preliminary analysis}
procedure preliminary_analysis0;
var
  {s1,}s2: string;
  fi, fo: textfile;
  k, j, i: integer;
  b_comm1, b_comm2, b_str: boolean;
  {true if we are within a comment or a string, respectively}
begin
  //b_comm1:=false; b_comm2:=false;b_str:=false;
  form2.memo1.Clear;
  //s1:=getcurrentdir;
  setcurrentdir(current_dir);

  assignfile(fi, filename);
  assignfile(fo, current_dir + '/tmp/temp0.pas');
  reset(fi);
  if ioresult <> 0 then
  begin
    ShowMessage('The input file cannot be opened');
    exit;
  end;
  rewrite(fo);
  if ioresult <> 0 then
  begin
    ShowMessage('The output file cannot be opened');
    closefile(fi);
    ioresult;
    exit;
  end;
  k := 0;
  while not (EOF(fi)) do
  begin
    Inc(k);
    readln(fi, s2);

    //deletion of 3 first extra characters that ABC-pascal adds to the beginning of a file
    if k = 1 then
      delete_extra(s2);
    if s2 = '' then
      continue;
    while (s2 <> '') and (s2[1] = ' ') do
      s2 := copy(s2, 2, 255);
    if s2 = '' then
      continue;
    if (length(s2) > 3) and ((copy(s2, 1, 3) = '{I}') or (copy(s2, 1, 3) = '{i}')) then
      s2 := '//' + s2;
    while (s2 <> '') and (s2[length(s2)] = ' ') do
      s2 := copy(s2, 1, length(s2) - 1);
    if s2 = '' then
      continue;
    writeln(fo, s2);
  end;

  //showmessage('we are here');

  closefile(fi);
  ioresult;
  closefile(fo);
  ioresult;
  Assign(fi, current_dir + '/tmp/temp0.pas');
  reset(fi);
  Assign(fo, current_dir + '/tmp/temp1.pas');
  rewrite(fo);
  b_comm1 := False;
  b_comm2 := False;
  b_str := False;
  while not (EOF(fi)) do
  begin
    readln(fi, s2);
    i := 1;
    j := 1;
    repeat
      j := j + 1; {for a safe reason}
      if not (b_comm1) and not (b_comm2) and not b_str then

      begin {1}
        if s2[i] in ['A'..'Z'] then
          s2[i] := chr(Ord(s2[i]) + 32);
        if (s2[i] = ' ') and ((i < length(s2)) and (not (s2[i + 1] in alphadigit)) or
          (i = 1) or (i = length(s2))) then
        begin
          s2 := copy(s2, 1, i - 1) + copy(s2, i + 1, 255);
          continue;
        end;
        if (not (s2[i] in alphadigit + [chr(39)])) and (i < length(s2)) and
          (s2[i + 1] = ' ') then
        begin
          s2 := copy(s2, 1, i) + copy(s2, i + 2, 255);
          continue;
        end;

        if s2[i] = '{' then
          b_comm1 := True;
        if copy(s2, i, 2) = '(*' then
          b_comm2 := True;
        if copy(s2, i, 2) = '//' then
        begin
          s2 := copy(s2, 1, i - 1);
          break;
        end;
      end;{1}

      if b_comm1 and (s2[i] = '}') then
      begin
        b_comm1 := False;
        if (i = 1) or (i = length(s2)) or (not (s2[i + 1] in alphadigit)) or
          (not (s2[i - 1] in alphadigit)) then
          Delete(s2, i, 1)
        else
          s2[i] := chr(32);
        continue;
      end;
      if b_comm2 and (copy(s2, i, 2) = '*)') then
      begin
        b_comm2 := False;
        if (i = 1) or (i = length(s2) - 1) or (not (s2[i + 2] in alphadigit)) or
          (not (s2[i - 1] in alphadigit)) then
          Delete(s2, i, 2)
        else
        begin
          s2[i] := chr(32);
          Delete(s2, i + 1, 1);
        end;
        continue;
      end;
      if (s2[i] = chr(39)) and not (b_comm1) and not (b_comm2) then
        b_str := not (b_str);
      if b_comm1 or b_comm2 then
      begin
        s2 := copy(s2, 1, i - 1) + copy(s2, i + 1, 255);
        continue;

      end;
      i := i + 1;
    until (i > length(s2)) or (j > 1000);
    if s2 <> '' then
      writeln(fo, s2);
  end;
  closefile(fi);
  ioresult;
  closefile(fo);
  ioresult; //erase(fi);ioresult;
  //setcurrentdir(s1);
end;

procedure preliminary_analysis1;
var
  s7, s2: string;
  fi, fo: textfile;
  k1, i1, j, k, i: integer;
  bc: boolean;
begin
  //s1:=getcurrentdir;
  //setcurrentdir(current_dir);
  bc := not ((textsin <> 0) or (textsout <> 0));
  //not((chosen_task='15_38')or(copy(chosen_task,1,4)='15_4')or(copy(chosen_task,1,4)='15_5')or(copy(chosen_task,1,4)='15_6'));
  assignfile(fi, current_dir + '/tmp/temp1.pas');
  reset(fi);
  assignfile(fo, current_dir + '/tmp/temp0.pas');
  rewrite(fo);
  k := 0;
  j := 0;
  while not (EOF(fi)) do
  begin
    readln(fi, s2);
    //removal all read; readln; write; and writeln;
    i := 1;
    Inc(j);
    repeat
      if (copy(s2, i, 5) = 'const') and (count_ap(s2, i) mod 2 = 0) and
        ((i = 1) or (not (s2[i - 1] in alphadigit))) and
        ((i + 4 = length(s2)) or (not (s2[i + 5] in alphadigit))) then
      begin
        if i > 1 then
        begin
          writeln(fo, copy(s2, 1, i - 1));
          Inc(j);
          s2 := copy(s2, i, 255);
          i := 1;
        end;
        //showmessage(inttostr(k)+'@@@');

        k := k + 1;
        i1 := j;
        if (i + 4 = length(s2)) or (pos('=', copy(s2, i, 200)) = 0) or
          (pos(';', copy(s2, i, 200)) = 0) then
        begin
          readln(fi, s7);
          ioresult;
          if (i + 4) = length(s2) then
            s2 := s2 + ' ' + s7
          else
            s2 := s2 + s7;
          if (pos('=', s2) = 0) or (pos(';', s2) = 0) then
          begin
            readln(fi, s7);
            ioresult;
            s2 := s2 + s7;
          end;
          if pos(';', s2) = 0 then
          begin
            readln(fi, s7);
            ioresult;
            s2 := s2 + s7;
          end;
          if pos(';', s2) = 0 then
          begin
            readln(fi, s7);
            ioresult;
            s2 := s2 + s7;
          end;
        end;
        if (k = 1) and (consts[2, 1] <> 0) then
        begin
          k1 := pos(';', s2);
          if k1 = 0 then
            break;
          //showmessage('k=1we are here ');

          writeln(fo, copy(s2, 1, k1));
          s2 := copy(s2, k1 + 1, 200);
          i := 1;
          if s2 = '' then
            readln(fi, s2);
          ioresult;
          //showmessage('!'+s2+'!');

          if not ((copy(s2, 1, 4) = 'type') and ((length(s2) = 4) or
            (length(s2) > 4) and (not (s2[5] in alphadigit))) or
            (copy(s2, 1, 5) = 'label') and ((length(s2) = 5) or
            (length(s2) > 5) and (not (s2[6] in alphadigit))) or
            (copy(s2, 1, 5) = 'begin') and ((length(s2) = 5) or
            (length(s2) > 5) and (not (s2[6] in alphadigit))) or
            (copy(s2, 1, 8) = 'function') and ((length(s2) = 8) or
            (length(s2) > 8) and (not (s2[9] in alphadigit))) or
            (copy(s2, 1, 9) = 'procedure') and ((length(s2) = 9) or
            (length(s2) > 9) and (not (s2[10] in alphadigit))) or
            (copy(s2, 1, 3) = 'var') and ((length(s2) = 3) or
            (length(s2) > 3) and (not (s2[4] in alphadigit))) or
            (copy(s2, 1, 5) = 'const') and ((length(s2) = 5) or
            (length(s2) > 5) and (not (s2[6] in alphadigit)))) then
            s2 := 'const ' + s2;
          //showmessage('@'+s2+'!');
        end;
      end;


      if (copy(s2, i, 7) = 'readln;') and (count_ap(s2, i) mod 2 = 0) and
        ((i = 1) or (not (s2[i - 1] in alphadigit))) then
      begin
        Delete(s2, i, 7);
        continue;
      end;
      if (copy(s2, i, 5) = 'read;') and (count_ap(s2, i) mod 2 = 0) and
        ((i = 1) or (not (s2[i - 1] in alphadigit))) then
      begin
        Delete(s2, i, 5);
        continue;
      end;
      if (copy(s2, i, 6) = 'write;') and (count_ap(s2, i) mod 2 = 0) and
        ((i = 1) or (not (s2[i - 1] in alphadigit))) then
      begin
        Delete(s2, i, 6);
        continue;
      end;

      i := i + 1;
    until i >= length(s2);

    i := 1;{j:=1; variable j is used for a safe reason}
    repeat
      {readln}
      if (copy(s2, i, 6) = 'readln') and bc and (count_ap(s2, i) mod 2 = 0) and
        ((i = 1) or (not (s2[i - 1] in alphadigit))) and
        ((i + 5 = length(s2)) or (not (s2[i + 6] in alphadigit))) and
        (count_ap(s2, i) mod 2 = 0) then
      begin
        Delete(s2, i + 4, 2);
        continue;
      end;
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
      i := i + 1;
    until i > length(s2);
    if s2 <> '' then
      writeln(fo, s2);
  end;
  closefile(fi);
  closefile(fo);

end;

procedure preliminary_analysis2;
var
  s2{,s1}: string;
  fi, fo: textfile;
  i, l, m, n, k{,j}: integer;
begin
  //s1:=getcurrentdir;
  //setcurrentdir(current_dir);
  assignfile(fi, current_dir + '/tmp/temp0.pas');
  reset(fi);
  assignfile(fo, current_dir + '/tmp/temp1.pas');
  rewrite(fo);
  {Search the last 'begin' with zero balance; n is the line number, m is the position of the 'begin' in the found line,
  l is the current balance}
  k := 0;
  l := 0;
  m := 0;
  n := 0;
  while not (EOF(fi)) do
  begin
    k := k + 1;
    readln(fi, s2);
    i := 1;
    repeat
      if (copy(s2, i, 5) = 'begin') and ((i = 1) or (not (s2[i - 1] in alphadigit))) and
        (count_ap(s2, i) mod 2 = 0) and ((length(s2) = i + 4) or
        (not (s2[i + 5] in alphadigit))) then
      begin
        if l = 0 then
        begin
          n := k;
          m := i;
        end;
        l := l + 1;
      end;
      if (copy(s2, i, 3) = 'end') and ((i = 1) or (not (s2[i - 1] in alphadigit))) and
        (count_ap(s2, i) mod 2 = 0) and ((length(s2) = i + 2) or
        (not (s2[i + 3] in alphadigit))) then
        l := l - 1;
      i := i + 1;
    until i >= length(s2);
  end;
  //showmessage(inttostr(n)+'  '+inttostr(m));
  closefile(fi);
  reset(fi);
  writeln(fo, '{$I+,R+}');
  //writeln(fo,'var __fi,__fo:text;');
  k := 0;
  while not (EOF(fi)) do
  begin
    k := k + 1;
    readln(fi, s2);
    if (k <> n) or True then
    begin
      writeln(fo, s2);
      continue;
    end;
    writeln(fo, copy(s2, 1, m + 4) +
      ' assign(__fi,''initial_data.txt'');reset(__fi); assign(__fo,''result_data.txt'');rewrite(__fo);');
    s2 := copy(s2, m + 5, 255);
    if (s2 <> '') and (s2[1] = ' ') then
      s2 := copy(s2, 2, 255);
    if s2 <> '' then
      Write(fo, s2);
  end;
  closefile(fi);
  closefile(fo);
  erase(fi);
  //setcurrentdir(s1);
end;

function preliminary_analysis3: boolean;
var
  i9, ii, i: integer;
  an_res: t_an_res;
  s8, ss3, ss4, ss2: string;
  bba, bb, bbb: boolean;
begin
  preliminary_analysis3 := True;
  incorrect_boolean := checkboolean;

  //Analysis of the task 8_29-007
  if chosen_task = '8_29-007' then
  begin
    bbb := nested_loops;
    if bbb then
    begin
      preliminary_analysis3 := False;
      if en_rus then
        form2.Memo1.Lines.add(
          'Error. Nested loops or loops within conditional statements are not allowed for this task.')
      else
        form2.Memo1.Lines.add(
          'Ошибка. Вложенные циклы и циклы внутри уcлoвных операторов в этой задаче не допускаются.');
      exit;
    end;
  end;
  //Analysis of the tasks 15_32- from 2 to 8 - only a file with the name 'temp15_2' can be assigned; a temporary file can be renamed to 'temp15_1' only; the corresponding replacements are made in the pascal program
  if (copy(chosen_task, 1, 5) = '15_32') or (copy(chosen_task, 1, 5) = '15_49') or
    (copy(chosen_task, 1, 5) = '15_50') then
    replace15_32_and_others;
  //A special analysis for the task 6.30 - only write(chr... is allowed for it.
  if chosen_task = '6_30' then
  begin
    if not (char_output) then
    begin
      preliminary_analysis3 := False;
      if en_rus then
        form2.Memo1.Lines.add(
          'Error. Only output of a character or of the type ''writeln(chr(...))'' is allowed in this task.')
      else
        form2.Memo1.Lines.add(
          'Ошибка. В этой задаче допускается только вывод символа или вывод вида write(chr(...)).');
      exit;
    end;
  end;

  //Global variables are not allowed; rather, we check absence of any variable declarations before subroutine definition
  //showmessage('We are here 1 ');
  if (copy(chosen_task, 1, 2) = '11') or (copy(chosen_task, 1, 2) = '12') or
    (copy(chosen_task, 1, 2) = '16') then
    if findglobal then
    begin
      preliminary_analysis3 := False;
      if en_rus then
        form2.memo1.Lines.add(
          'Error: variable declarations are not allowed before procedure of function definitions for this task.')
      else
        form2.memo1.Lines.add(
          'Oшибкa. Описание переменных перед описанием функции или процедуры в этой задаче не допускается.');
      exit;
    end;

  for i := 1 to css do
    ns[i] := 0;
  an_res := analysis;
  warnings_amount := 0;
  form2.memo1.Clear;
  bb := check_beginend;
  if not bb then
  begin
    preliminary_analysis3 := False;
    exit;
  end;

  //Analysis for the tasks processing external files, that is, 15.58 and the next.
  if (chosen_task = '15_58') or (chosen_task = '15_59') or
    (chosen_task = '15_60') or (chosen_task = '15_61') or
    (chosen_task = '15_62') or (copy(chosen_task, 1, 5) = '15_63') then
  begin
    bba := external_files;
    if not bba then
    begin
      preliminary_analysis3 := False;
      exit;
    end;
  end;

  //if func_proc=0 then begin
  join(ss3);
  ss4 := func_names(ss3);
  if length(ss4) >= 2 then
  begin
    add_parentheses(ss3, ss4);
    breaks(ss3, False);
  end;
  //end;
  if func_proc > 0 then
  begin
    i9 := add_main_block;
    if i9 <> 0 then
      preliminary_analysis3 := False;
    //Different results of add_main_block
    //i9=-1 means that no additional information must be output
    if i9 = 1 then
    begin        //no subroutines were found
      if func_proc = 1 then
      begin
        if en_rus then
          form2.Memo1.Lines.add('Error. No functions were found.')
        else
          form2.Memo1.Lines.add('Ошибка. Фукнция не найдена.');
        exit;
      end;
      if func_proc = 2 then
      begin
        if en_rus then
          form2.Memo1.Lines.add('Error. No procedures were found.')
        else
          form2.Memo1.Lines.add('Ошибка. Пpoцедура не найдена.');
        exit;
      end;
    end;
    if i9 = 2 then
    begin //a wrong type of the subroutine
      if func_proc = 1 then
      begin
        if en_rus then
          form2.Memo1.Lines.add('Error. A procedure was found instead of a function.')
        else
          form2.Memo1.Lines.add(
            'Ошибка. Найдена процедура вместо функции.');
        exit;
      end;
      if func_proc = 2 then
      begin
        if en_rus then
          form2.Memo1.Lines.add('Error. A function was found instead of a procedure.')
        else
          form2.Memo1.Lines.add(
            'Ошибка. Найдена функция вместо пpoцедуры.');
        exit;
      end;
    end;
    if i9 = 3 then
    begin //global variables were found
      if func_proc = 1 then
      begin
        if en_rus then
          form2.Memo1.Lines.add(
            'Error. Variable declaration is not allowed before the function.')
        else
          form2.Memo1.Lines.add(
            'Ошибка. Oписание переменных перед функцией не допускается.');
        exit;
      end;
      if func_proc = 2 then
      begin
        if en_rus then
          form2.Memo1.Lines.add(
            'Error. Variable declaration is not allowed before the procedure.')
        else
          form2.Memo1.Lines.add(
            'Ошибка. Oписание переменных перед процедурой не допускается.');
        exit;
      end;
    end;
    if i9 = 4 then
    begin //integer or real output in task 12.12.7
      if en_rus then
        form2.Memo1.Lines.add(
          'Error. Only output of a character or of the type ''writeln(chr(...))'' is allowed in this task.')
      else
        form2.Memo1.Lines.add(
          'Ошибка. В этой задаче допускается только вывод символа или вывод вида write(chr(...)).');
      exit;
    end;
  end;

  //showmessage('Beginning of analysis3');

  if program_sub then
  begin
    i9 := formsubroutine;
    if i9 <> 0 then
      preliminary_analysis3 := False;
    if i9 = 1 then
    begin
      if en_rus then
        form2.Memo1.Lines.add(
          'Syntax errors were found in the program. Please, check your program.')
      else
        form2.Memo1.Lines.add(
          'В программе были найдены синтаксические oшибки. Провepьте ее.');
      exit;
    end;
  end;
  //check for inadmissible output of the form write(6,x);
  //if chosen_task='5_6-010' then begin
  //if not check56010 then begin
  //preliminary_analysis3:=false;
  //if en_rus then form2.Memo1.Lines.add('Error. An output of only one integer expression is allowed for this task.') else
  //form2.Memo1.Lines.add('Ошибка. В этой задаче допускается вывод только одного целочисленного выражения.');
  //exit end;
  //end;
  if chosen_task = '11_55' then
  begin
    ii := callsp;
    if ii < 0 then
      preliminary_analysis3 := False;
    if ii = 0 then
    begin
      preliminary_analysis3 := False;
      if en_rus then
        form2.Memo1.Lines.Add('Error: no function calls were found.')
      else
        form2.Memo1.Lines.Add(
          'Oшибкa: нет обращений к функции.');
    end;
    if ii > 1 then
    begin
      form2.Memo1.Lines.Add('  ');
      preliminary_analysis3 := False;
      if en_rus then
        form2.Memo1.Lines.Add(
          'Error: two or more calls of a function or a procedure are not allowed for this task.')
      else
        form2.Memo1.Lines.Add(
          'Oшибкa: в этой задаче допускается нe болee oднoгo oбpащения к прoцeдурe или функции.');
    end;
  end;

  //Analysis of the results
  for i := 1 to chapter_claims_amount do
  begin
    if chapter_claims[i].b then
      if not chapter_claims[i].b1 then
      begin
        form2.Memo1.Lines.Add('  ');
        preliminary_analysis3 := False;
        if en_rus then
          form2.Memo1.Lines.Add('Error: ' + chapter_claims[i].s3)
        else
          form2.Memo1.Lines.Add('Oшибкa: ' + chapter_claims[i].s2);
      end
      else
      begin
        form2.Memo1.Lines.Add('  ');//preliminary_analysis3:=false;
        if en_rus then
          ss2 := 'Warning: ' + chapter_claims[i].s3
        else
          ss2 := 'Предупреждение: ' + chapter_claims[i].s2;
        form2.Memo1.Lines.Add(ss2);
        Inc(warnings_amount);
        warnings[warnings_amount] := ss2;
      end;
  end;

  //showmessage(inttostr(task_claims_amount ));
  for i := 1 to task_claims_amount do
  begin
    //showmessage('Here'+inttostr(i)+task_claims[i].s1);
    if task_claims[i].b then
      if not task_claims[i].b1 then
      begin
        form2.Memo1.Lines.Add('  ');
        preliminary_analysis3 := False;
        if en_rus then
          form2.Memo1.Lines.Add('Error: ' + task_claims[i].s3)
        else
          form2.Memo1.Lines.Add('Oшибкa: ' + task_claims[i].s2);
      end
      else
      begin
        form2.Memo1.Lines.Add('  ');//preliminary_analysis3:=false;
        if en_rus then
          ss2 := 'Warning: ' + task_claims[i].s3
        else
          ss2 := 'Предупреждение: ' + task_claims[i].s2;
        form2.Memo1.Lines.Add(ss2);
        Inc(warnings_amount);
        warnings[warnings_amount] := ss2;
      end;
  end;

  //This is old analysis when no 'claims.txt' files existed
  if an_res[1] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {arrays or strings in tasks of chapters 5 or 6}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: arrays are not allowed  ');
      form2.memo1.Lines.add('for this task.');
    end
    else
    begin
      form2.memo1.Lines.add(
        'Ошибка: использование массивов ');
      form2.memo1.Lines.add('в этой задачe не допускается.');
    end;
  end;

  if an_res[7] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {arrays or strings in tasks of chapters 5 or 6}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: strings are not allowed  ');
      form2.memo1.Lines.add('for this task.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: использование строк ');
      form2.memo1.Lines.add('в этой задачe не допускается.');
    end;
  end;

  //showmessage(inttostr(an_res[2]));

  if an_res[2] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {No constants in tasks connected with sequences '}
    if en_rus then
    begin
      if copy(chosen_task, 1, 4) = '5_20' then
        form2.memo1.Lines.add('Error: the accuracy ''eps'' must ')
      else
        form2.memo1.Lines.add('Error: amount of numbers must ');
      form2.memo1.Lines.add('be defined as a constant ');
      form2.memo1.Lines.add('for this task.');
    end
    else
    begin
      if copy(chosen_task, 1, 4) = '5_20' then
      begin
        form2.memo1.Lines.add('Ошибка: точность eps');
        form2.memo1.Lines.add('в этой задаче должнa быть ');
        form2.memo1.Lines.add('заданa константой.');
      end
      else
      begin
        form2.memo1.Lines.add('Ошибка: количество чисел ');
        ;
        form2.memo1.Lines.add('в этой задаче должно быть ');
        form2.memo1.Lines.add('задано константой.');
      end;
    end;
  end;
  if an_res[3] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {More than 1 loop in tasks 5_20'}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: more than one loop ');
      form2.memo1.Lines.add('or nested loops are not ');
      form2.memo1.Lines.add('allowed for this task.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: более одного цикла или ');
      form2.memo1.Lines.add('вложенные циклы в этой задаче ');
      form2.memo1.Lines.add('не допускаются. ');
    end;
  end;
  if an_res[4] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {Standard functions in tasks 5_20'}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: standard functions (except abs) are not');
      form2.memo1.Lines.add('allowed for this task.');
    end
    else
    begin
      form2.memo1.Lines.add(
        'Ошибка: стандартные функции (кpoмe abs) в этой');
      form2.memo1.Lines.add('задаче не допускаются. ');
    end;
  end;
  if an_res[5] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {Standard functuion in tasks 5_20'}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: procedures or functions are');
      form2.memo1.Lines.add('not allowed for this task.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: процедуры и функции ');
      form2.memo1.Lines.add('в этой задаче не допускаются. ');
    end;
  end;
  if an_res[6] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {Not enough constants for a rectangular matrix'}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: number of rows and ');
      form2.memo1.Lines.add('columns of the matrix ');
      form2.memo1.Lines.add('must be defined as two ');
      form2.memo1.Lines.add('different constants.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: число строк и столбцов ');
      form2.memo1.Lines.add('матрицы должно быть задано ');
      form2.memo1.Lines.add('двумя разными константами.');
    end;
  end;

  if an_res[8] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    {No loops in tasks from chapters 5,6,8,9,10}
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: no loop statements ');
      form2.memo1.Lines.add('were found in the program.');
    end
    else
    begin
      form2.memo1.Lines.add(
        'Ошибка: в программе отсутствуют ');
      form2.memo1.Lines.add('операторы цикла.');
    end;
  end;

  if an_res[9] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    //No constants in tasks connected with arrays
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: amount of array elements must ');
      form2.memo1.Lines.add('be defined as a constant ');
      form2.memo1.Lines.add('for this task.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: количество элементов');
      ;
      form2.memo1.Lines.add('массива в этой задаче должно');
      form2.memo1.Lines.add('быть задано константой.');
    end;
  end;

  if an_res[10] = 1 then
  begin
    form2.memo1.Lines.add(' ');
    preliminary_analysis3 := False;
    if en_rus then
    begin
      form2.memo1.Lines.add('Error: the order of the square matrix ');
      form2.memo1.Lines.add('must be defined as a constant ');
      form2.memo1.Lines.add('for this task.');
    end
    else
    begin
      form2.memo1.Lines.add('Ошибка: порядок квадратной ');
      ;
      form2.memo1.Lines.add('матрицы в этой задаче должен');
      form2.memo1.Lines.add('быть задан константой.');
    end;
  end;

  if an_res[11] = 1 then
  begin {form2.memo1.lines.add(' ');//preliminary_analysis3:=false;
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

  if an_res[12] = 1 then
  begin
    form2.memo1.Lines.add(' ');//preliminary_analysis3:=false;
    if en_rus then
    begin
      form2.memo1.Lines.add('Warning: no array definitions were found in the task. ');
    end
    else
    begin
      form2.memo1.Lines.add(
        'Предупреждение: в задаче отсутствуют массивы. ');
    end;
  end;
end;


procedure set_initial_text(memo: Tmemo);
//the procedure replaces the changed text of the program in the Memo5 by its initial text if the compilation was successful
var
  k: integer;
  s: string;
  f: Text;
begin
  memo.Clear;
  Assign(f, filename);
  reset(f);
  if (ioresult <> 0) or (EOF(f)) then
  begin
    ShowMessage('Fatal error. File ' + filename + ' not found.');
    form1.Close;
  end;
  memo.Clear;
  if en_rus then
  begin
    memo.Lines.add('All comments are removed from the tested program.');
    memo.Lines.add('The directive {I+,R+} is added to its beginning.');
    memo.Lines.Add('  ');
  end
  else
  begin
    memo.Lines.add(
      'Все комментарии из тестируемой программы удаляются. ');
    memo.Lines.add('Дирeктивa {I+,R+} добавляется в ee начало. ');
    memo.Lines.Add('  ');
  end;
  k := 0;
  while not EOF(f) do
  begin
    Inc(k);
    readln(f, s);
    if k = 1 then
      delete_extra(s);
    memo.Lines.add(s);
  end;
  closefile(f);
end;

procedure precompile;
//this procedure forms files temp2.pas, temp3.pas, temp4.pas and temp5.pas from temp1.pas and
//files temp20.pas, temp30.pas, temp40.pas and temp50.pas from temp10.pas
var
  f, g, h, g1, h1: textfile;
  s8, s4, s5, s6, s7, s: string;
  k1, p, q, i2: integer;
begin

  for i2 := 1 to 2 - byte(not (program_sub)) do
  begin

    case i2 of
      1: s4 := '';
      2: s4 := '0'
    end;
    Assign(f, current_dir + '/tmp/temp1' + s4 + '.pas');
    reset(f);
    if ioresult <> 0 then
    begin
      ShowMessage('Fatal error 14');
      halt;
    end;
    Assign(g, current_dir + '/tmp/temp2' + s4 + '.pas');
    rewrite(g);
    if ioresult <> 0 then
    begin
      ShowMessage('Fatal error 15');
      halt;
    end;
    Assign(h, current_dir + '/tmp/temp3' + s4 + '.pas');
    rewrite(h);
    if ioresult <> 0 then
    begin
      ShowMessage('Fatal error 16');
      halt;
    end;
    Assign(g1, current_dir + '/tmp/temp4' + s4 + '.pas');
    rewrite(g1);
    if ioresult <> 0 then
    begin
      ShowMessage('Fatal error 17');
      halt;
    end;
    Assign(h1, current_dir + '/tmp/temp5' + s4 + '.pas');
    rewrite(h1);
    if ioresult <> 0 then
    begin
      ShowMessage('Fatal error 18');
      halt;
    end;

    if consts[1, 1] = 0 then
    begin
      while not EOF(f) do
      begin
        readln(f, s);
        writeln(g, s);
        writeln(h, s);
        writeln(g1, s);
        writeln(h1, s);
      end;
      closefile(f);
      closefile(g);
      closefile(h);
      closefile(g1);
      closefile(h1);
      continue;
    end;
    {case when different constants are used in tests with numbers having different remainders after its division by 4}
    k1 := 0;
    while not EOF(f) do
    begin
      readln(f, s);
      if (copy(s, 1, 5) = 'const') and ((k1 <= 1) and (consts[1, 2] <> 0) or
        (k1 < 1) and (consts[1, 2] = 0)) then
      begin
        k1 := k1 + 1;
        p := pos('=', s);
        q := pos(';', s);
        if (q > 0) and (p > 0) and (p < length(s)) then
        begin
          s4 := copy(s, 1, p) + IntToStr(consts[1, k1]) + copy(s, q, 200);
          s5 := copy(s, 1, p) + IntToStr(consts[2, k1]) + copy(s, q, 200);
          s6 := copy(s, 1, p) + IntToStr(consts[3, k1]) + copy(s, q, 200);
          s7 := copy(s, 1, p) + IntToStr(consts[4, k1]) + copy(s, q, 200);
        end;
        writeln(g, s4);
        writeln(h, s5);
        writeln(g1, s6);
        writeln(h1, s7);
        ;
      end
      else
      begin
        writeln(g, s);
        writeln(h, s);
        writeln(g1, s);
        writeln(h1, s);
      end;
    end;

    //of while the lower
    closefile(f);
    closefile(g);
    closefile(h);
    closefile(g1);
    closefile(h1);


    //showmessage(inttostr(i2));

  end;//of for i2 from 1 to 2
end;{of procedure}

{Compilation}
function compilation(handle: THandle): boolean;
var
  b: boolean;
  i2, p3, p2, ii, ii2, pp, k6, k7, k8, k9, m, k: integer;
  s45, s46, s44, s3, s4, s2, s1: string;
  f, g: textfile;

begin
  setcurrentdir(current_dir);
  form2.button5.Enabled := False;
  form2.button10.Enabled := False;
  form2.button11.Enabled := False;
  //form2.memo1.clear;
  deletefile(current_dir + '/tmp/temp1');
  deletefile(current_dir + '/tmp/temp10');
  deletefile(current_dir + '/tmp/temp2');
  deletefile(current_dir + '/tmp/temp3');
  deletefile(current_dir + '/tmp/temp4');
  deletefile(current_dir + '/tmp/temp5');
  deletefile(current_dir + '/tmp/temp20');
  deletefile(current_dir + '/tmp/temp30');
  deletefile(current_dir + '/tmp/temp40');
  deletefile(current_dir + '/tmp/temp50');
  deletefile(current_dir + '/tmp/temp1.o');
  deletefile(current_dir + '/tmp/temp10.o');
  deletefile(current_dir + '/tmp/temp2.o');
  deletefile(current_dir + '/tmp/temp3.o');
  deletefile(current_dir + '/tmp/temp4.o');
  deletefile(current_dir + '/tmp/temp5.o');
  deletefile(current_dir + '/tmp/temp20.o');
  deletefile(current_dir + '/tmp/temp30.o');
  deletefile(current_dir + '/tmp/temp40.o');
  deletefile(current_dir + '/tmp/temp50.o');
  //showmessage('we are here');
  compilation := False;

  assignfile(f, current_dir + '/tmp/temp2');
  closefile(f);
  ioresult;
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp2''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp2. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp3');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp3''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp3. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp4');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp4''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp4. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp5');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp5''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp5. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp20');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp20''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp20. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp30');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp30''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp30. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp40');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp40''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp40. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  assignfile(f, current_dir + '/tmp/temp50');
  rewrite(f);
  k := ioresult;
  if k <> 0 then
  begin
    if en_rus then
      ShowMessage('Fatal error. It is impossible to delete ''temp50''. Restart your computer.')
    else
      ShowMessage(
        'Ошибка. Невозможно удалить файл temp50. Перезагрузите компьютер.');
    exit;
  end
  else
    closefile(f);

  deletefile(current_dir + '/tmp/temp2');
  ioresult;
  deletefile(current_dir + '/tmp/temp3');
  ioresult;
  deletefile(current_dir + '/tmp/temp4');
  ioresult;
  deletefile(current_dir + '/tmp/temp5');
  ioresult;
  deletefile(current_dir + '/tmp/temp20');
  ioresult;
  deletefile(current_dir + '/tmp/temp30');
  ioresult;
  deletefile(current_dir + '/tmp/temp40');
  ioresult;
  deletefile(current_dir + '/tmp/temp50');
  ioresult;
  deletefile(current_dir + '/tmp/result.txt');
  ioresult;
  //Creation of the files temp0.sh and temp00.sh
  Assign(f, current_dir + '/tmp/directory.txt');
  closefile(f);
  ioresult;
  reset(f);
  if (ioresult = 0) and (not (EOF(f))) then
    readln(f, s3)
  else
    s3 := chr(1);
  closefile(f);
  ioresult;
  for i2 := 1 to 2 do
  begin
    case i2 of
      1:
      begin
        Assign(f, current_dir + '/tmp/temp0.sh');
        rewrite(f);
        s4 := '';
      end;
      2:
      begin
        Assign(f, current_dir + '/tmp/temp00.sh');
        rewrite(f);
        s4 := '0';
      end;
    end; //of case
    if s3 = chr(1) then
    begin
      writeln(f, 'fpc' + ' -vu -Sg w ' + current_dir + '/tmp/temp2' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, 'fpc' + ' -vu -Sg w ' + current_dir + '/tmp/temp3' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, 'fpc' + ' -vu -Sg w ' + current_dir + '/tmp/temp4' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, 'fpc' + ' -vu -Sg w ' + current_dir + '/tmp/temp5' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
    end
    else
    begin
      writeln(f, s3 + ' -vu -Sg w ' + current_dir + '/tmp/temp2' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s3 + ' -vu -Sg w ' + current_dir + '/tmp/temp3' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s3 + ' -vu -Sg w ' + current_dir + '/tmp/temp4' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s3 + ' -vu -Sg w ' + current_dir + '/tmp/temp5' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
    end;
    closefile(f);
    ioresult;
  end;

  assignfile(f, current_dir + '/tmp/temp0.sh');
  closefile(f);
  ioresult;
  reset(f);
  b := (ioresult = 0) and not EOF(f);
  if not b then
  begin
    closefile(f);
    ioresult;
  end
  else
  begin
    readln(f, s1);
    k := pos(' ', s1);
    if k = 0 then
      s2 := '!!'
    else
      s2 := copy(s1, 1, k - 1);
    b := fileexists(s2);
    closefile(f);
    ioresult;
  end;

  //Is it necessary to add the next line?
  //if b then if en_rus then showmessage ('Press any key to continue.')else showmessage('Для продолжения нажмите любую клавишу.');
  if not b then
  begin //not b
    if en_rus then
      m := messagedlg('FPC-compiler was not found. Do you want to find it? ',
        mtError, [mbYes, mbNo], 0)
    else
      m := messagedlg(
        'FPC- компилятор не найден. Вы хотите найти его сами? ',
        mtError, [mbYes, mbNo], 0);
    closefile(f);
    ioresult;
    if m <> 6 then
    begin
      setcurrentdir(current_dir);
      exit;
    end;
    b := form2.OpenDialog2.Execute;
    if not b then
      exit
    else
      s1 := form2.OpenDialog2.filename;
    if pos(' ', s1) > 0 then
      if en_rus then
      begin
        ShowMessage('The path to the files contains blank characters. It is not allowed. Rename the directories.');
        form1.Close;
      end
      else
      begin
        ShowMessage(
          'Путь к файлам содержит пробелы, что недопустимо. Переименуйте подкаталоги.');
        form1.Close;
      end;
    setcurrentdir(current_dir);
    for p2 := 1 to length(s1) do
      if s1[p2] in ['A'..'Z'] then
        s1[p2] := chr(Ord(s1[p2]) + 32);
    if (length(s1) < 4) or (copy(s1, length(s1) - 2, 3) <> 'exe') then
      exit;
    closefile(f);
    ioresult;
    setcurrentdir(current_dir);
    Assign(g, './tmp/directory.txt');
    rewrite(g);

    //showmessage(current_dir+'!!!!'+s1);
    //showmessage(s1);
    p2 := 1;
    for p3 := 1 to length(current_dir) do
    begin

      //showmessage(inttostr(p3));

      if p3 > length(s1) then
      begin
        p2 := 0;
        break;
      end;

      if (current_dir[p3] <> s1[p3]) and (not (s1[p3] in ['A'..'Z', 'a'..'z'])) then
      begin
        p2 := 0;
        break;
      end;
      if ((current_dir[p3] <> s1[p3]) and
        (abs(Ord(current_dir[p3]) - Ord(s1[p3])) <> 32)) and
        (s1[p3] in ['A'..'Z', 'a'..'z']) then
      begin

        //showmessage(inttostr(p3));

        p2 := 0;
        break;
      end;
    end;
    //p2:=pos(current_dir,s1);
    //showmessage(inttostr(p2));

    if p2 <> 1 then
      Write(g, s1)
    else
      Write(g, '.' + copy(s1, length(current_dir) + 1, 1000));
    closefile(g);
    ioresult;
    closefile(f);
    ioresult;
    for i2 := 1 to 2 do
    begin
      case i2 of
        1:
        begin
          Assign(f, './tmp/temp0.sh');
          rewrite(f);
          s4 := '';
        end;
        2:
        begin
          Assign(f, './tmp/temp00.sh');
          rewrite(f);
          s4 := '0';
        end;
      end; //of case
      closefile(f);
      ioresult;
      rewrite(f);
      if ioresult <> 0 then
        exit;
      writeln(f, s1 + ' -vu -Sg w ' + current_dir + '/tmp/temp2' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s1 + ' -vu -Sg w ' + current_dir + '/tmp/temp3' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s1 + ' -vu -Sg w ' + current_dir + '/tmp/temp4' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      writeln(f, s1 + ' -vu -Sg w ' + current_dir + '/tmp/temp5' +
        s4 + '.pas > ' + current_dir + '/tmp/result.txt');
      closefile(f);
      ioresult;
    end;//of i2:=1 to 2
  end; //of not b
  closefile(f);
  ioresult;

  for k := 1 to max_test_number do
    deletefile(current_dir + '/tmp/rrr' + IntToStr(k));
  for k := 1 to max_test_number do
    deletefile(current_dir + '/tmp/rrrr' + IntToStr(k));

  compilation := False;//form2.memo2.clear; form2.memo3.clear;
  for i2 := 1 to 2 - byte(not (program_sub)) do
  begin
    //if i2=1 then k:=ShellExecute(Handle, 'open',pchar(current_dir+'/tmp/temp0.sh'), nil, nil,sw_hide);
    //if i2=2 then k:=ShellExecute(Handle, 'open',pchar(current_dir+'/tmp/temp00.sh'), nil, nil,sw_hide);
    if i2 = 1 then
      k := executeScript(handle, PChar(current_dir + '/tmp/temp00.sh'));
    if i2 = 2 then
      k := executeScript(handle, PChar(current_dir + '/tmp/temp00.sh'));

    if en_rus then
    begin
      form3.Caption := 'Compilation';
      if program_sub then
        if i2 = 1 then
          form3.label1.Caption :=
            'The main file is being compiled.' + chr(10) + 'Please, wait.'
        else
          form3.label1.Caption :=
            'The file with the subprogram is being compiled.' + chr(10) + 'Please, wait.'
      else
        form3.label1.Caption :=
          'The file is being compiled.' + chr(10) + 'Please, wait.';
    end
    else
    begin
      form3.Caption := 'Компиляция';
      if program_sub then
        if i2 = 1 then
          form3.label1.Caption :=
            'Основной файл компилируется. Ждите.'
        else
          form3.label1.Caption :=
            'Файл с подпрограммой компилируется. Ждите.'
      else
        form3.label1.Caption := 'Файл компилируется. Ждите.';
    end;
    form3.showmodal;
    closefile(f);
    ioresult;
    //showmessage(inttostr(byte(compi)));
    if compi then
    begin
      assignfile(f, current_dir + '/tmp/result.txt');
      closefile(f);
      ioresult;
      reset(f);
      k := ioresult;
      //showmessage(inttostr(k));

      if k = 0 then
      begin
        while not EOF(f) do
        begin
          readln(f, s1); //form2.memo1.lines.add(s1)

        end;
        closefile(f);
      end;
    end
    else
    begin
      closefile(f);
      ioresult;
      //if en_rus then showmessage('The compilation failed. Check your compiler.')else
      //showmessage('Компиляция невозможна. Проверьте компилятор.');
      //deletefile(current_dir+'/tmp/temp0.sh');halt
    end;
    closefile(f);
    ioresult;
    if i2 = 1 then
    begin
      assignfile(f, './tmp/temp2');
      closefile(f);
      ioresult;
      reset(f);
      k6 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp3');
      closefile(f);
      ioresult;
      reset(f);
      k7 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp4');
      closefile(f);
      ioresult;
      reset(f);
      k8 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp5');
      closefile(f);
      ioresult;
      reset(f);
      k9 := ioresult;
      closefile(f);
      ioresult;
    end
    else
    begin
      //showmessage('We are here');
      assignfile(f, './tmp/temp20');
      closefile(f);
      ioresult;
      reset(f);
      k6 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp30');
      closefile(f);
      ioresult;
      reset(f);
      k7 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp40');
      closefile(f);
      ioresult;
      reset(f);
      k8 := ioresult;
      closefile(f);
      ioresult;
      assignfile(f, './tmp/temp50');
      closefile(f);
      ioresult;
      reset(f);
      k9 := ioresult;
      closefile(f);
      ioresult;

    end;
    //showmessage(inttostr(k));
    if i2 = 1 then
      if en_rus then
        s45 := ' of the main file '
      else
        s45 := ' основного файла ';
    if i2 = 2 then
      if en_rus then
        s45 := ' of the file with the subprogram '
      else
        s45 := ' файла с подпрограммой ';
    if not program_sub then
      s45 := ' ';

    //k6:=0; k7:=0; k8:=0; k9:=0;
    //if (k6<>0)or(k7<>0)or(k8<>0)or(k9<>0)then
    //showmessage(inttostr(k6)+' '+inttostr(k7)+' '+inttostr(k8)+inttostr(k9));

    if (k6 = 0) and (k7 = 0) and (k8 = 0) and (k9 = 0) then
    begin
      set_initial_text(form2.Memo5);
      if not en_rus then
        form2.memo1.Lines.add('Компиляция' + s45 +
          'прошла успешно.')
      else
        form2.memo1.Lines.add('The compilation' + s45 + 'was successful.');
    end
    else
    begin
      if i2 = 1 then
        if en_rus then
          s45 := 'main file'
        else
          s45 := ' ocновного файла';
      if i2 = 2 then
        if en_rus then
          s45 := 'file with the subprogram'
        else
          s45 := ' файла с подпрoграммой';
      if not program_sub then
        if en_rus then
          s45 := 'program'
        else
          s45 := '';

      if i2 = 1 then
        s44 := ''
      else
        s44 := '0';
      fill_file_text_err(current_dir + '/tmp/temp1' + s44 + '.pas',
        current_dir + '/tmp/result.txt');
      if en_rus then
        ShowMessage(' Errors were found while compiling the ' + s45 +
          '. It cannot be executed.')
      else
        ShowMessage('Были ошибки при компиляции' +
          s45 + '. Выполнение пpограммы невозможно. ');
    end;
    if (k6 <> 0) or (k7 <> 0) or (k8 <> 0) or (k9 <> 0) then
      break;
  end;//of i2 from 1 to 2
  compilation := (k6 = 0) and (k7 = 0) and (k8 = 0) and (k9 = 0);
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i, ii: integer;
  f, ff: textfile;
begin

  Width := _width;
  Height := _height;
  current_width := _width;
  current_height := _height;
  left := (screen.Width - _width) div 2;
  top := (screen.Height - _height) div 2;
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
  low_pos := 0.92;
  if _height < 1000 then
    low_pos := 0.92 - (1000 - _height) / 10000;
  //showmessage(floattostr(low_pos));
  if low_pos < 0.87 then
    low_pos := 0.87;
  button1.Top := round(_height * low_pos);
  button1.left := round(_width * 0.86);
  button1.Width := round(_width / 23);
  button1.Height := round(_height / 35);
  button1.font.Size := _width div 115;
  if button1.font.Size < 8 then
    button1.font.Size := 8;
  button1.Font.Name := _fontname;
  button1.Caption := 'РУС';
  {ENG}
  button2.Top := button1.top;
  button2.left := round(_width * 0.92);
  button2.Width := button1.Width;
  button2.Height := button1.Height;
  button2.font.Size := button1.Font.Size;
  button2.Font.Name := button1.Font.Name;
  button2.Caption := 'EN';
  {Choosing a chapter}
  label1.top := round(_height / 68);
  label1.Left := _width div 35;
  label1.font.Size := _width div 80;
  if label1.font.Size < 10 then
    label1.font.Size := 10;
  label1.font.Name := _fontname;
  {Choosing a task}
  label2.top := label1.Top + round(label1.Height * 2.5);
  label2.Left := label1.left;
  label2.font.Size := label1.Font.Size;
  label2.font.Name := label1.font.Name;
  {Choosing a file name}
  label3.top := label2.Top + round(label1.Height * 2.6);
  label3.Left := label1.left;
  label3.font.Size := label1.Font.Size;
  label3.font.Name := label1.font.Name;
  label3.Enabled := False;

  label4.Top := button1.top;
  label4.Left := label1.left;
  label4.font.Size := round(label1.Font.Size * 0.85);
  //label4.font.color:=$FF0000;
  label4.font.Name := label1.font.Name;
  label4.Enabled := True;

  //comboboxes
  combobox1.Left := label1.Left + round(_width * 0.15);
  combobox1.Top := label1.Top - Height div 250;
  //combobox1.height:=_height div 10;
  combobox1.Font.Name := _fontname;
  combobox1.Font.Size := label1.font.Size;
  combobox1.Clear;
  combobox1.Width := _width div 2;
  combobox2.Left := combobox1.left;
  combobox2.Top := label2.Top - Height div 250;
  //combobox2.Height:=combobox1.Height;
  combobox2.Font.Name := _fontname;
  combobox2.Font.Size := combobox1.Font.Size;
  combobox2.Clear;
  combobox2.Width := combobox1.Width;
  {Edit1 is for a file name}
  edit1.Clear;
  edit1.top := label3.Top - Height div 250;
  edit1.Left := combobox2.left;//+width div 35;
  edit1.font.Size := label3.Font.Size;
  edit1.font.Name := label3.font.Name;
  edit1.Width := _width div 3;
  {Buttton7 is Ok for a file name}
  button7.Left := edit1.Left + edit1.Width + _width div 50;
  button7.top := edit1.top + _height div 200;
  button7.Width := round(_width * 0.1);
  button7.Height := round(_height / 28);
  button7.font.Size := label3.font.size;
  button7.font.Name := label3.font.Name;
  button7.Caption := 'Load';
  {Button6 is the browse for a file name}
  button6.Left := button7.left + button7.Width + _width div 50;
  button6.top := button7.top;
  button6.Width := round(_width * 0.09);
  button6.font.Size := label3.font.size;
  button6.font.Name := label3.font.Name;
  button6.Caption := 'Browse';
  button6.Height := button7.Height;

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
  richedit1.Left := round(_width / 45);
  richedit1.Width := round(_width * 0.9);
  richedit1.top := button6.top + button6.Height + _height div 75;
  //richedit1.height:=round(height/6.5);
  richedit1.Height := round(Height / 5.8);
  richedit1.BorderWidth := 12; //It is indent
  richedit1.ScrollBars := ssboth;
  {The text of the program}
  memo5.Left := richedit1.left;
  memo5.Width := richedit1.Width;
  memo5.top := richedit1.Top + richedit1.Height + _height div 70;
  memo5.Height := _height div memo5height;//see file00 for the definition
  memo5.Font.Size := label3.Font.Size;
  memo5.Font.Name := 'Courier New'; //_fontname;
  memo5.ScrollBars := ssvertical;
  memo5.ReadOnly := True;
  memo5.Clear;
  //memo5.BevelKind:=bktile;
  {A button that increases and decreases the size of Memo5}
  button8.Top := memo5.Top;
  button8.Width := _width div 35;
  button8.Height := button8.Width;
  button8.left := memo5.Left + memo5.Width + _width div 100;
  button8.Caption := '+';
  button8.font.Size := button7.Font.size;
  button8.Font.Style := [fsbold];
  button8.font.Name := button7.font.Name;
  button8.Visible := True;
  button8.Enabled := False;

  {A button that increases and decreases the size of Richedit1}
  button9.Top := richedit1.Top;
  button9.Width := _width div 35;
  button9.Height := button9.Width;
  button9.left := richedit1.Left + richedit1.Width + _width div 98;
  button9.Caption := '+';
  button9.font.Size := button7.Font.size;
  button9.Font.Style := [fsbold];
  button9.font.Name := button7.font.Name;
  button9.Visible := True;
  button9.Enabled := False;

  {Preliminary analysis and compilation}
  button3.Left := round(_width / 9);
  button3.top := memo5.Top + memo5.Height + _height div 100;
  button3.Width := round(_width / 2.6);
  button3.font.Size := label1.Font.Size;
  button3.font.Size := _width div 80;
  button3.font.Name := _fontname;
  button3.Height := button7.Height;

  {Checkbox 1 and 2 - autotesting and showing wrong results only}
  checkbox1.Enabled := True;
  checkbox2.Enabled := True;
  checkbox1.font.Size := _width div 80;
  checkbox1.font.Name := _fontname;
  checkbox2.font.Size := _width div 80;
  checkbox2.font.Name := _fontname;
  checkbox1.Left := combobox1.Left + round(combobox1.Width * 1.17);
  checkbox2.Left := checkbox1.left;
  checkbox1.Width := _width div 5;
  checkbox2.Width := checkbox1.Width;
  checkbox1.Top := combobox1.Top;
  checkbox2.Top := combobox2.Top;
  checkbox1.Height := combobox1.Height;
  checkbox2.Height := combobox2.Height;
  checkbox1.Checked := False;
  checkbox2.Checked := False;

  {compilation}
  //button4.Left:=button3.Left+button3.width+round(_width/45);
  //button4.top:=button3.top;
  //button4.Width:=button3.width+width div 18;
  //button4.font.Size:=button3.font.size;
  //button4.font.Name:=button3.font.Name;
  //button4.height:=button7.height;

  {testing}
  button5.Left := button3.Left + button3.Width + round(_width / 15);
  button5.top := button3.top;
  button5.Width := button3.Width - _width div 14;
  button5.font.Size := button3.font.size;
  button5.font.Name := button3.font.Name;
  button5.Height := button7.Height;

  {memo-components}
  memo1.Clear;
  memo1.Top := button3.top + button3.Height + (_height div 125);
  memo1.Left := round(_width / 45);
  memo1.Height := button1.Top - memo1.Top - _height div 250;
  memo1.Width := richedit1.Width;
  memo1.ScrollBars := ssboth;
  memo1.Font.size := memo5.Font.Size;
  if memo1.Font.size < 10 then
    memo1.Font.Size := 10;
  memo1.Font.Name := _fontname;
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
  button10.Top := memo1.Top;
  button10.Width := _width div 35;
  button10.Height := button10.Width;
  button10.left := richedit1.Left + richedit1.Width - button8.Width;
  button10.Caption := '+';
  button10.font.Size := button7.Font.size;
  button10.Font.Style := [fsbold];
  button10.font.Name := button7.font.Name;
  button10.Visible := True;
  button10.Enabled := False;
  button10.Visible := False;
  //Note: if the property visible is false, the property enabled is ignored.
  button11.Top := memo1.Top + button10.Height + _height div 55;
  button11.Width := _width div 35;
  button11.Height := button11.Width;
  button11.left := richedit1.Left + richedit1.Width - button9.Width;
  button11.Caption := '-';
  button11.font.Size := button7.Font.size;
  button11.Font.Style := [fsbold];
  button11.font.Name := button7.font.Name;
  button11.Visible := True;
  button11.Enabled := False;
  button11.Visible := False;
  task_size := False;
  text_size := False;
  //test_size:=false;
  chosen_task := '';
  filename := '';
  current_dir := getcurrentdir;
  //task_chapters_fill;
  //en_rus:=false;
  chapter_claims_amount := 0;
  task_claims_amount := 0;
  button3.Enabled := False;
  //button4.Enabled:=false;
  button5.Enabled := False;
  button6.Enabled := True;
  button7.Enabled := False;
  button8.Enabled := False;
  button9.Enabled := False;
  button10.Enabled := False;
  button11.Enabled := False;

  edit1.ReadOnly := True;
  memo1.ReadOnly := True;
  //memo2.ReadOnly:=true;
  //memo3.ReadOnly:=true;
  memo5.ReadOnly := True;
  richedit1.Clear;
  richedit1.ReadOnly := True;
  timer1.Enabled := False;
  ioresult;
  chosen_task := '';
  filename := '';
  chosen_chapter := 0;
  task_amount := 0;
  button1.click;
  initial := True;
  //current_dir:=getcurrentdir;
  createdir('tmp');
  ioresult;
  //creation of files temp01, temp02,...  in the directory tmp
  for i := 1 to max_test_number do
  begin
    assignfile(f, current_dir + '/tmp/temp0' + IntToStr(i) + '.sh');
    rewrite(f);
    ioresult;
    writeln(f, 'temp' + IntToStr(2 + (i - 1) mod 4) + ' <iii' +
      IntToStr(i) + ' >rrr' + IntToStr(i));
    closefile(f);
    assignfile(f, current_dir + '/tmp/temp00' + IntToStr(i) + '.sh');
    rewrite(f);
    ioresult;
    writeln(f, 'temp' + IntToStr(2 + (i - 1) mod 4) + '0 <iiii' +
      IntToStr(i) + ' >rrrr' + IntToStr(i));
    closefile(f);
    deletefile(current_dir + '/tmp/iii' + IntToStr(i));
    deletefile(current_dir + '/tmp/ooo' + IntToStr(i));
    deletefile(current_dir + '/tmp/rrr' + IntToStr(i));
    deletefile(current_dir + '/tmp/iiii' + IntToStr(i));
    deletefile(current_dir + '/tmp/oooo' + IntToStr(i));
    deletefile(current_dir + '/tmp/rrrr' + IntToStr(i));
  end;
  //forming of the file temp0.sh - let us remove it for quite a while
  {assignfile(f,current_dir+'/temp0.sh'); rewrite(f);
writeln(f, current_dir+'/Pascal_compiler/2.0.4/bin/i386-win32/fpc.exe '+current_dir+'/tmp/temp2.pas '+current_dir+'/tmp/result.txt');
writeln(f, current_dir+'/Pascal_compiler/2.0.4/bin/i386-win32/fpc.exe '+current_dir+'/tmp/temp3.pas '+current_dir+'/tmp/result.txt');
closefile(f);}
  //showmessage(inttostr(ioresult)+' '+current_dir);
  assignfile(ff, current_dir + '/tmp/p.txt');
  reset(ff);
  ii := ioresult;
  closefile(ff);
  ioresult;
  form1.label6.Visible := ii = 0;
  form1.label7.Visible := ii = 0;
  sorts := 0;
  errorr := False;
  binit := False;//false if the form2 was never activated yet; true, otherwise
  //It is an auxuliary component
  memo2.Visible := False;

end;

procedure TForm2.FormActivate(Sender: TObject);
var
  p: integer;
begin
  if not binit then
  begin
    task_chapters_fill;
    binit := True;
  end;
  p := pos(' ', current_dir);
  if p > 0 then
    if en_rus then
    begin
      ShowMessage(
        'The path to the current directory contains blank characters. It is not allowed. Rename the directories.');
      form1.Close;
    end
    else
    begin
      ShowMessage(
        'Путь к текущему каталогу содержит пробелы, что недопустимо. Переименуйте каталоги.');
      Form1.Close;
    end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action1: TCloseAction);
var
  f: textfile;
label
  1;
begin
  deletefile('./tmp/temp0.sh');
  assignfile(f, current_dir + '/tmp/tests.ini');
  rewrite(f);
  if form2.checkbox1.Checked then
    writeln(f, '1')
  else
    writeln(f, '0');
  if form2.checkbox2.Checked then
    writeln(f, '1')
  else
    writeln(f, '0');
  //showmessage(inttostr(ioresult));
  if combo1index >= 0 then
    writeln(f, 1 + combo1index)
  else
  begin
    closefile(f);
    ioresult;
    goto 1;
  end;
  if chosen_task <> '' then
    writeln(f, chosen_task);
  if filename <> '' then
    writeln(f, filename);
  1:
    closefile(f);
  ioresult;
  form1.Close;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  en_rus := False;
  if task_amount > 0 then
    richedit_fill;
  form2.Button8.Hint :=
    'Увеличение / уменьшение размеров окна с программой ';
  form2.Button9.Hint :=
    'Увеличение / уменьшение размеров окна с тeкcтoм задачи ';
  form2.Button8.ShowHint := True;
  form2.Button9.ShowHint := True;
  form2.Button10.Hint :=
    'Увеличение размеров окна с тестами ';
  form2.Button11.Hint :=
    'Уменьшение размеров окна с тестами ';
  form2.Button10.ShowHint := True;
  form2.Button11.ShowHint := True;
  form2.CheckBox2.Caption := 'Выводить только ошибки';
  form2.CheckBox1.Caption := 'Aвтотестирование';


  form2.Button6.Caption := 'Обзор';
  form2.Button7.Caption := 'Зaгрузить';
  form2.OpenDialog1.title := 'Открытие файла ';
  form2.OpenDialog2.title := 'Выбор компилятора';
  form2.Caption :=
    'Cистема автоматического тестирования программ';
  label1.Caption := 'Выберите раздел: ';
  label2.Caption := 'Выберите зaдaчу: ';
  label3.Caption := 'Введите имя файла ';
  label4.Caption :=
    'F1 - помощь       Свои замечания присылайте по электронному адресу: Novikov_57@mail.ru';
  button3.Caption := 'Предварительный анализ и кoмпиляция';
  //button4.Caption:='Компиляция';
  button5.Caption := 'Тестирование';
  chapter_names_correct;
  if task_amount > 0 then
    task_names_correct;
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

  en_rus := True;
  if task_amount > 0 then
    richedit_fill;
  form2.Button8.Hint := 'Increasing / decreasing the size of the window with the program';
  form2.Button9.Hint :=
    'Increasing / decreasing the size of the window with the text of the task';
  form2.Button8.ShowHint := True;
  form2.Button9.ShowHint := True;
  form2.Button10.Hint := 'Increasing the size of the window with the tests';
  form2.Button11.Hint := 'Decreasing the size of the window with the tests';
  form2.Button10.ShowHint := True;
  form2.Button11.ShowHint := True;
  form2.CheckBox2.Caption := 'Wrong results only';
  form2.CheckBox1.Caption := 'Autotesting';


  form2.Button6.Caption := 'Browse';
  form2.Button7.Caption := 'Load';
  form2.OpenDialog1.title := 'Opening a file ';
  form2.OpenDialog2.title := 'Choosing of a compiler';
  form2.Caption := 'Automated program testing system';
  label1.Caption := 'Choose a group: ';
  label2.Caption := 'Choose a task: ';
  label3.Caption := 'Enter your file name ';
  label4.Caption :=
    'F1 - Help      Send your reports to the email address: Novikov_57@mail.ru';
  button3.Caption := 'Preliminary analysis and compilation';
  //button4.Caption:='Compilation';
  button5.Caption := 'Testing';

  chapter_names_correct;

  if task_amount > 0 then
    task_names_correct;
end;

//Choosing a chapter
procedure TForm2.ComboBox1Click(Sender: TObject);
var
  q, p: integer;
  s: string;
begin
  combo2text := '';
  combo2index := -1;
  if text_size then
    button8.click;
  if task_size then
    button9.click;

  //button9.Click;
  //button11.Click;
  //property 'text' is the text of the chosen item
  setcurrentdir(current_dir);
  if initial then
    if (chosen_chapter = 0) then
      exit;
  if initial then
    combobox1.ItemIndex := chosen_chapter - 1;
  s := form2.ComboBox1.Text;
  combo1text := s;
  combo1index := combobox1.ItemIndex;
  if length(s) < 2 then
  begin
    chosen_chapter := 0;
    exit;
  end;
  //q:=pos('.',s);
  //if q<2 then begin
  //showmessage ('Fatal error. Wrong name of the chapter'); halt end;
  //val(copy(form2.ComboBox1.Text,1,q-1),chosen_chapter,p);
  //if p<>0 then begin
  //showmessage ('Fatal error. Wrong name of the chapter'); halt end;
  //showmessage('We are here');
  //task_names_fill(copy(form2.ComboBox1.Text,1,q-1));
  chosen_chapter := form2.ComboBox1.ItemIndex + 1;
  task_names_fill;//(form2.ComboBox1.Text);
  task_claims_amount := 0;
  chapter_claims_amount := 0;
  claims_fill(chapter_claims, chapter_claims_amount);
  edit1.ReadOnly := True;
  edit1.Clear;
  memo1.Clear;
  //memo3.clear;memo2.clear;
  memo5.Clear;
  richedit1.Clear;
  label3.Enabled := False;
  button3.Enabled := False;
  //button4.Enabled:=false;
  button5.Enabled := False;
  button6.Enabled := True;
  button7.Enabled := False;
  button8.Enabled := False;
  button9.Enabled := False;
  button10.Enabled := False;
  button11.Enabled := False;

  chosen_task := '';
  pr_an := False;
  compi := False;
  filename := '';
end;

//Choosing a task
procedure TForm2.ComboBox2Click(Sender: TObject);
var
  b: boolean;
  i1, p, i, k, j: integer;
begin
  //showmessage('ClickEvent');
  if text_size then
    button8.click;
  if task_size then
    button9.click;

  //button9.Click;
  //button11.Click;
  setcurrentdir(current_dir);
  edit1.ReadOnly := True;
  sorts := 0;
  errorr := False;
  arrayin := 0;
  arrayout := 0;
  matrixin := 0;
  matrixout := 0;
  func_proc0 := 0;
  program_sub := False;
  incorrect_boolean := False;
  task_claims_amount := 0;
  warnings_amount := 0;
  text_after := '';
  text_before := '';
  check_new := False;
  check_dispose := False;
  edit1.Clear;
  memo1.Clear;
  //memo3.clear;memo2.clear;
  richedit1.Clear;
  memo5.Clear;
  label3.Enabled := False;
  button3.Enabled := False;
  //button4.Enabled:=false;
  button5.Enabled := False;
  button6.Enabled := True;
  button7.Enabled := False;
  button8.Enabled := False;
  button9.Enabled := True;
  button10.Enabled := False;
  button11.Enabled := False;
  //showmessage(chosen_task);
  if initial then
  begin
    combobox2.ItemIndex := -1;

    //showmessage('###'+inttostr(task_amount));
    //showmessage('!! '+chosen_task+' @@  '+task_names[3]);

    for i1 := 1 to task_amount do
      if chosen_task = task_names[i1] then
      begin
        //showmessage('ssacscdasc');

        combobox2.ItemIndex := i1 - 1;
        combo2text := combobox2.Text;
        combo2index := i1 - 1;
      end;
    if combobox2.ItemIndex = -1 then
    begin
      chosen_task := '';
      exit;
    end;
  end
  else
  begin
    chosen_task := combobox2.Text;
    combo2text := combobox2.Text;
    combo2index := combobox2.ItemIndex;
    //Back correction
    p := pos(' ', chosen_task);
    if p > 0 then
      chosen_task := copy(chosen_task, 1, p - 1) + '-' + copy(chosen_task, p + 1, 200);
    p := pos('.', chosen_task);
    if p > 0 then
      chosen_task := copy(chosen_task, 1, p - 1) + '_' + copy(chosen_task, p + 1, 200);
  end;
  //end of the back correction
  j := pos('-', chosen_task);
  if (j > 1) and (j < length(chosen_task)) then
  begin
    k := pos(chosen_task[j + 1], engrus);
    if k > 26 then
      k := k - 26;
    for i := 1 to task_amount do
      if (copy(task_names[i], 1, j) = copy(chosen_task, 1, j)) and
        (StrToInt(copy(task_names[i], j + 1, 3)) = k) then
      begin
        chosen_task := task_names[i];
        break;
      end;
  end;
  while (chosen_task <> '') and (chosen_task[length(chosen_task)] = ' ') do
    chosen_task := copy(chosen_task, 1, length(chosen_task) - 1);
  //showmessage(chosen_task+' before the extract');
  b := extract_data;
  //showmessage('!!!!');
  if not b and initial then
    initial := False;
  //error in extract_data while initializing; the further initialization must be stopped in this case
  //showmessage('1939 after the extract data');
  if not b then
  begin
    button6.Enabled := False;
    button7.Enabled := False;
    button3.Enabled := False;
    button5.Enabled := False;
    exit;
  end;
  pr_an := False;
  compi := False;
  filename := '';
  edit1.Clear;
  edit1.ReadOnly := False;
  label3.Enabled := True;
  button3.Enabled := False;
  //button4.Enabled:=false;
  button5.Enabled := False;
  button6.Enabled := True;
  button7.Enabled := True;
  button8.Enabled := False;
  button9.Enabled := True;
  button10.Enabled := False;
  button11.Enabled := False;

  memo1.Clear;//memo3.clear;memo2.clear;
  richedit_fill;
end;

{Preliminary analysis and compilation}
procedure TForm2.Button3Click(Sender: TObject);
var
  i: integer;
begin
  if task_size then
    button9.Click;
  //button11.Click;
  setcurrentdir(current_dir);
  form2.Memo1.Font.Name := _fontname;
  for i := 1 to max_test_number do
    deletefile(current_dir + '/tmp/rrr' + IntToStr(i));
  button5.Enabled := False;
  memo1.Clear; //memo2.Clear; memo3.clear;
  button10.Enabled := False;
  button11.Enabled := False;
  timer1.Enabled := False;
  //form3.Timer1.Enabled := False;
  if chosen_task = '' then
  begin
    if en_rus then
      messagedlg('You have not chosen a task.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не выбрали задачу.', mtInformation, [mbOK], 0);
    exit;
  end;
  if filename = '' then
    if en_rus then
      messagedlg('You have not entered a file name.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не ввели имя файла.', mtInformation, [mbOK], 0);
  preliminary_analysis0;
  preliminary_analysis1;
  preliminary_analysis2;
  pr_an := preliminary_analysis3;
  //if pr_an then if en_rus then memo1.Lines.Add('No errors have been found.')else
  //memo1.Lines.Add('Ошибoк не обнаружeнo.');
  //button4.Enabled:=pr_an;
  if pr_an then
    fill_file_text(current_dir + '/tmp/temp1.pas');
  //showmessage('Before precompile!');
  //if pr_an then showmessage('!!!!!!!!!!!!!!');
  if pr_an then
    precompile
  else
    exit;
  //showmessage('After precompile!');
  //It is compilation
  compi := compilation(handle);
  button5.Enabled := compi;
  if (checkbox1.Checked) and (button5.Enabled) then
    button5.Click;
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
  if task_size then
    button9.Click;
  button5.Enabled := False;
  button1.Enabled := False;
  button2.Enabled := False;
  button3.Enabled := False;
  button6.Enabled := False;
  button7.Enabled := False;
  button8.Enabled := False;
  button9.Enabled := False;

  if chosen_task = '' then
  begin
    if en_rus then
      messagedlg('You have not chosen a task.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не выбрали задачу.', mtInformation, [mbOK], 0);
    exit;
  end;

  if filename = '' then
  begin
    if en_rus then
      messagedlg('You have not entered a file name.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не ввели имя файла.', mtInformation, [mbOK], 0);
    exit;
  end;

  if not (pr_an) then
  begin
    if en_rus then
      messagedlg('You have not made a preliminary analisis.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не cделали предварительный анализ.',
        mtInformation, [mbOK], 0);
    exit;
  end;

  if not (compi) then
    if en_rus then
      messagedlg('You have not compiled your program.', mtInformation, [mbOK], 0)
    else
      messagedlg('Вы не cкомпилировали программу.',
        mtInformation, [mbOK], 0);
  was_loop := False;
  testing(handle);
  button1.Enabled := True;
  button2.Enabled := True;
  button3.Enabled := True;
  button6.Enabled := True;
  button7.Enabled := True;
  button8.Enabled := True;
  button9.Enabled := True;

  if (not was_loop) and ((chosen_task[1] <> '1') or (chosen_task[2] <> '5')) then
    button5.Enabled := True;
  memo1.SetFocus;

end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
end;

//Button "Browse"
procedure TForm2.Button6Click(Sender: TObject);
var
  b: boolean;
  i: integer;
  s3, nt, s: string;
  nc: integer;
begin
  setcurrentdir(current_dir);
  b := form2.opendialog1.Execute;
  if b then
  begin
    s := form2.opendialog1.filename;
    if pos(' ', s) > 0 then
    begin
      if en_rus then
      begin
        ShowMessage(
          'Warning: the path to the tested file contains blank characters. The file may not be compiled correctly.');
      end
      else
      begin
        ShowMessage(
          'Путь к тестируемому файлу содержит пробелы. Возможны ошибки при компиляции.');
      end;
    end;
  end;
  if b then
  begin
    if text_size then
      button8.click;
    if task_size then
      button9.click;
    s3 := form2.opendialog1.filename;

    if not initial then
    begin
      b := decrypt(s3, nc, nt);
      if b then
      begin
        initial := True;
        chosen_chapter := nc + 1;
        //showmessage(inttostr(chosen_chapter));
        form2.ComboBox1click(Sender);
        chosen_task := nt;
        form2.ComboBox2click(Sender);
        initial := False;
        if not form2.Button6.Enabled then
          exit;
      end;

    end;

    //showmessage('!!!');

    if (form2.ComboBox1.ItemIndex = -1) or (form2.ComboBox2.ItemIndex = -1) then
    begin
      if en_rus then
        ShowMessage('You have not chosen a task.')
      else
        ShowMessage('Bы не выбрaли зaдaчу. ');
      exit;
    end;

    //showmessage(current_dir);
    for i := 1 to max_test_number do
      deletefile(current_dir + '/tmp/rrr' + IntToStr(i));
    //button4.Enabled:=false;
    button5.Enabled := False;

    //;showmessage('!!;');
    setcurrentdir(current_dir);
    if s3 <> '' then
    begin
      b := fileexistsf(s3);
      if not b then
        exit;
    end;
    filename := s3;
    deletefile('./tmp/temp1.pas');
    deletefile('./tmp/temp2.pas');
    deletefile('./tmp/temp3.pas');
    deletefile('./tmp/temp4.pas');
    deletefile('./tmp/temp5.pas');
    deletefile('./tmp/temp10.pas');
    deletefile('./tmp/temp20.pas');
    deletefile('./tmp/temp30.pas');
    deletefile('./tmp/temp40.pas');
    deletefile('./tmp/temp50.pas');
    if filename <> '' then
    begin
      memo1.Clear;
      memo5.Clear;
      func_proc := func_proc0;
      fill_file_text(filename);
      edit1.Text := filename;
      if form2.checkbox1.Checked then
        form2.Button3.click;

    end;
  end;
end;

//Button Load when we are choosing a file
procedure TForm2.Button7Click(Sender: TObject);
var
  b: boolean;
  s, s1: string;
begin
  setcurrentdir(current_dir);
  if task_size then
    button9.click;
  if text_size then
    button8.Click;
  s := edit1.Text;
  s1 := s;
  delete_blanks(s1);
  if (s1 = '') or (s1[1] = ' ') then
  begin
    button6.click;
    exit;
  end;
  if pos(' ', s) > 0 then
  begin
    if en_rus then
    begin
      ShowMessage(
        'Warning: the path to the tested file contains blank characters. The file may not be compiled correctly.');
    end
    else
    begin
      ShowMessage(
        'Путь к тестируемому файлу содержит пробелы. Возможны ошибки при компиляции.');
    end;
  end;
  if s <> '' then
  begin
    b := fileexistsf(s);
    if b then
    begin //button4.Enabled:=false;
      button5.Enabled := False;
      button8.Enabled := True;
      button3.Enabled := True;
      button9.Enabled := True;
      button10.Enabled := False;
      button11.Enabled := False;
      memo5.Clear;
      memo1.Clear;
      deletefile(current_dir + '/tmp/temp1.pas');
      deletefile(current_dir + '/tmp/temp2.pas');
      deletefile(current_dir + '/tmp/temp3.pas');
      deletefile(current_dir + '/tmp/temp4.pas');
      deletefile(current_dir + '/tmp/temp5.pas');
      deletefile(current_dir + '/tmp/temp10.pas');
      deletefile(current_dir + '/tmp/temp20.pas');
      deletefile(current_dir + '/tmp/temp30.pas');
      deletefile(current_dir + '/tmp/temp40.pas');
      deletefile(current_dir + '/tmp/temp50.pas');
      deletefile(current_dir + '/tmp/temp1');
      deletefile(current_dir + '/tmp/temp10');
      deletefile(current_dir + '/tmp/temp2');
      deletefile(current_dir + '/tmp/temp3');
      deletefile(current_dir + '/tmp/temp4');
      deletefile(current_dir + '/tmp/temp5');
      deletefile(current_dir + '/tmp/temp20');
      deletefile(current_dir + '/tmp/temp30');
      deletefile(current_dir + '/tmp/temp40');
      deletefile(current_dir + '/tmp/temp50');
      deletefile(current_dir + '/tmp/temp1.o');
      deletefile(current_dir + '/tmp/temp10.o');
      deletefile(current_dir + '/tmp/temp2.o');
      deletefile(current_dir + '/tmp/temp3.o');
      deletefile(current_dir + '/tmp/temp4.o');
      deletefile(current_dir + '/tmp/temp5.o');
      deletefile(current_dir + '/tmp/temp20.o');
      deletefile(current_dir + '/tmp/temp30.o');
      deletefile(current_dir + '/tmp/temp40.o');
      deletefile(current_dir + '/tmp/temp50.o');
      filename := s;
      func_proc := func_proc0;
      fill_file_text(filename);

      if form2.checkbox1.Checked then
        form2.Button3.click;

    end;
  end;
  //setcurrentdir(dir_1);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  //showmessage('!!!###'+inttostr(number_of_intervals));
  //application.ProcessMessages;
  Number_of_intervals := number_of_intervals + 1;

end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  if not text_size and task_size then
    exit;
  if not text_size then
  begin //memo5.Height:=memo5.Height*3;
    memo5.Height := round(form2.Height * low_pos) - memo5.Top;
    text_size := True;
    button8.Caption := '-';
    button3.Visible := False;
    button5.Visible := False;
    memo1.Visible := False;
    if en_rus then
      form2.Button8.Hint := 'Decreasing the size of the window with the program'
    else
      form2.Button8.Hint :=
        'Уменьшение размеров окна с программой ';
  end
  else
  begin
    //memo5.Height:=memo5.Height div 3;
    text_size := False;
    button8.Caption := '+';
    memo5.Height := _height div memo5height;//see file00 for the definition
    button3.Visible := True;
    button5.Visible := True;
    memo1.Visible := True;
    //if en_rus then form2.Button8.Hint:='Increasing / cecreasthe size of the window with the program'
    //else form2.Button8.Hint:='Увеличение размеров окна с программой ';
  end;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  if not task_size and text_size then
    exit;
  if not task_size then
  begin //memo5.Height:=memo5.Height*3;
    richedit1.Height := memo5.Top + memo5.Height - richedit1.top;
    task_size := True;
    button9.Caption := '-';
    //button3.Visible:=false;button5.Visible:=false; memo1.Visible:=false;
    //if en_rus then form2.Button9.Hint:='Decreasing the size of the window with the program'
    //else form2.Button9.Hint:='Уменьшение размеров окна с программой ';
  end
  else
  begin
    //memo5.Height:=memo5.Height div 3;
    task_size := False;
    button9.Caption := '+';
    richedit1.Height := round(_height / 5.8);
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
var
  k1, k2, k3: integer;
const
  _interval = 1;
begin
  //exit;
  k1 := form2.Width;
  k2 := form2.Height;

  //showmessage('Resize!! '+inttostr(k1)+' '+inttostr(k2)+' '+inttostr(_width)+'  '+inttostr(_height)+' '+inttostr(current_width)+' '+inttostr(current_height));

  if k1 < _width * 0.8 then
  begin
    form2.Width := round(_width * 0.8);
    exit;
  end;
  if k2 < _height * 0.8 then
  begin
    form2.Height := round(_height * 0.8);
    exit;
  end;
  if k1 > current_width + _interval then
  begin
    k3 := _interval;
    while form2.Width - current_width > k3 do
      k3 := k3 + _interval;
    k3 := k3 - _interval;
    memo5.Width := memo5.Width + k3;
    button8.Left := button8.left + k3;
    button9.Left := button9.left + k3;
    richedit1.Width := richedit1.Width + k3;
    memo1.Width := memo1.Width + k3;
    current_width := current_width + k3;
  end
  else
    if (k1 < current_width - _interval){and(k1>_width)} then
    begin


      //showmessage('!!!');

      k3 := _interval;
      while current_width - form2.Width > k3 do
        k3 := k3 + _interval;
      k3 := k3 - _interval;
      memo5.Width := memo5.Width - k3;
      button8.Left := button8.left - k3;
      button9.Left := button9.left - k3;
      richedit1.Width := richedit1.Width - k3;
      memo1.Width := memo1.Width - k3;
      current_width := current_width - k3;
    end;
  if k2 > current_height + _interval then
  begin
    k3 := _interval;
    while form2.Height - current_height > k3 do
      k3 := k3 + _interval;
    k3 := k3 - _interval;
    memo1.Height := memo1.Height + k3;
    if text_size then
      memo5.Height := memo5.Height + k3;
    button1.Top := button1.Top + k3;
    button2.Top := button2.Top + k3;
    label4.top := label4.top + k3;
    current_height := current_height + k3;
  end
  else
    if (k2 < current_height - _interval){and(k2>_height)} then
    begin
      k3 := _interval;
      while current_height - form2.Height > k3 do
        k3 := k3 + _interval;
      k3 := k3 - _interval;
      memo1.Height := memo1.Height - k3;
      current_height := current_height - k3;
      button1.Top := button1.Top - k3;
      button2.Top := button2.Top - k3;
      label4.top := label4.top - k3;
      if text_size then
        memo5.Height := memo5.Height - k3;
    end;
  application.ProcessMessages;


  //width:=_width; height:=_height;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if key = chr(13) then
    form2.Button7.click;
end;

procedure TForm2.ComboBox1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.ComboBox2KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Memo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Memo5KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.RichEdit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button10KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button3KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button5KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button6KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button7KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button8KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button9KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button11KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Button2KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.Edit1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 112 then
    showhelp;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  //showMessage(Sender.UnitName); //
  form2.combobox1.Text := combo1text;
  form2.combobox1.ItemIndex := combo1index;
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
  combobox2.Text := combo2text;
  combobox2.ItemIndex := combo2index;
end;

end.
