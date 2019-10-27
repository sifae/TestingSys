unit testing_utils;

{$mode objfpc}{$H+}

interface
    //Break and output the input or output files; the exclamation mark is the separator;
    //i=1,2,3 - input, received, correct respectively.
    procedure output_multifiles(si:string;k:integer);

    //An output of the text file in order of its rows
    //s - the text; k=1,2,3 - input, output, correct
    //!!Attention! Points or semicolons are not allowed!! They are special characters!
    procedure outputtextfile(s:string;k:integer);

    procedure addblanks(var s:string);

    //A special correction of the output for the task 14_15-002 and 14_27-002-003.
    //All blanks are deleted.
    procedure correct14_15_27(var sr:string);

    //A special correction of the result for the task 8.47-002.
    //It is possible to obtain XY(Z-1)99999 instead of XYZ00000 that is correct too.
    procedure correct847(var sr,so:string);

    //A special correction of the result such as Error, No roots and some others.
    //The first letter is converted to uppercase; the other letters are converted to lowercase;
    procedure correctcapitalsmall(var sr:string);

    //A special correction of the result for the task 8.46.
    //All capital letters are replaced by the corresponding small letters;
    //A blank is inserted between the last letter and the following digit.
    procedure correct846(var sr:string);

    //Analyzing of the result of the task 8.29- 008
    function analysis_8_29_8(si,sr,so:string):integer;

    //A special correction of the output data for the tasks 14.38.
    //All blanks between letters are deleted.
    procedure correct14_38(var s:string);

    //A special correction of the result for the task 8.56 and 8.59.
    //A blank character is inserted between each pair of Latin letters.
    procedure correct856_59(var sr:string);

    //A special correction of the input data for the task 11.22a.
    //Two initial strings are output at different lines if it is a test for the main block;
    //ii5=1/2 - then main block/the function is tested.
    procedure correct11_22a(s:string; ii5:integer);

    //A special correction of the output for the task 11_24 when the subprogram is tested.
    //si - the input string; it - the number of the current test
    procedure correct11_24(si:string;it:integer);

    //A special correction of input and output data for the tasks 6_24, 15_25 and 15_49
    //all blanks are replaced by '_' and all tab characters are replaced by '~'.
    procedure correct6_24_15_25(var s:string);

    //A special correction of the result for the task 13_12-002
    procedure correct13_12_2(var sr,so:string);

    //A special correction of the result for the tasks 10_21 and 10_22
    procedure correct10_21_22(var sr:string);

    //A special analysis if the pointers were changed in the tasks 16_16
    procedure correct_16_16(var s:string);

    //A special correction for the tasks 16_18 and others removal of the
    //last number equal to 1E20 and analysis if the pointer was changed.
    procedure correct_16_1E20(var s:string);

    //A special correction for the tasks 16_19 - removal of the last @
    //and analysis if the pointer was changed.
    procedure correct_16_19(var s:string);

    //A special procedure that checks if the amount of calls of New or Dispose procedure was incorrect.
    procedure checknewdispose(var s:string);

    //A special correction for the task 15_58
    function correct_15_58(var s:string):integer;

    //A procedure that replaces the numbers of months by their names.
    procedure month_num_name(p1:integer; var s3:string);

    //A special correction of the input data
    //(removing two last zeroes and inserting pairs of square brackets, replacing numbers by month names)
    //for the task 15.8 and 15.23
    procedure correct15_8_23(var s:string);

    //A special output for the task 15_23 - numbers of months are converted into its names.
    procedure output15_23(var s:string; k:integer);

    //A special output for the tasks 10_21 and 10_22 - a chessboard is output as a 8*8 matrix
    procedure output10_21_22(sa:string;p:integer);

    //A special correction of the input data (removing the last integer)
    //for the task 15.11, 15.13, 15.15, 15.16 and others that use a file of real or integer
    procedure correct15_1int(var s:string);

    //A special correction of the outout string for the task 15_63-005 -
    //all digits after the decimal point are deleted except for the left one
    procedure correct15_63_005(var sr:string);

    //A special correction of the input data (removing the final point)
    //for the task 15.12, 15.14 and others that use a file of char
    procedure correct15_1char(var s:string);

    //A special correction of the input data
    //(removing the final point and inserting blanks) for the task 16.31-002
    procedure correct16_31(var s:string);

    //A special correction of the data containing two or more one-dimensional arrays.
    procedure correct_multi_arrays(s:string;n,t,ntest:integer);

    procedure correct_matrices(s:string;n,t,ntest,ii5:integer;var number_of_lines:integer);
    //s - data, n - amount of martices, t=0,1,2 - input, output, correct (respectively),
    //ntest - number of the current test, ii5=1(2) if the main program (the subpregram) is beign tested;
    // output number_of_lines - how many lines were formed

    function diff(n_test:integer):integer;
    //evaluation the accuracy of the result; n_test - number of the current test
    //k=0 - Ok, k=1 - error, k=2 - inaccurate result; k=3 - excessive output; k=4 - not enough output

    //procedure that outputs the initial texts for the tasks 16_16
    //This procedure uses a global variable I that is the number of the current test.
    procedure output16_16input(s:string);

    //procedure that outputs the result and correct texts for the tasks 16_16
    //This procedure uses a global variable I that is the number of the current test.
    procedure output16_16output(s:string;kkk:integer);

    //procedure of forming the array outmatr for output of a matrix in ascending order of its rows
    //sf - initial string; b=true (false) - it is input (output).
    //This procedure uses a global variable I that is the number of the current test.
    procedure forminout(sf:string;b:boolean);

    //The procedure sorting the numerical data
    procedure sorting (var sr:string);

    //This procedure deletes all correct results from Memo1, remaining the wrong ones only
    procedure delete_correct_results;


var string_out : array [1..100] of string;
    number_of_lines : integer;

var bloop,b : boolean;
    ii5,iii,k1,k2,ii,kk,m,l,n,j,k,i,i11 : integer;
    ff,h,f,g:textfile;
    mr,mo : real;
    sv,sw,st,so1,sr1,si,so,sr,s : ansistring;
    n_err,n_err1 : integer;

var outmatr : array[1..100] of string;
    matcols, matrows : integer; //rows of the matrix and their amount

var bb : boolean;
    i43,i42,ppb,pq,nummm,n_err2,ii6,
    ppa,pa,ii3,ii4,ii2,pp1,pp,ppa1, ppa2,arrayin1,xx1,xx2 : integer;
    sp,si2 : string;
    cc2,cc1,ccc : string[20];
    time_tests : integer;
    time_test : tdatetime;
    f1,f2 : text;
    sro,s7,S8,se : string;

var arrayin0,matrixin0,arrayout0,matrixout0,amount_of_loops:integer;

implementation

uses file02, file09, file00, Dialogs, SysUtils, Forms;

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

var q1,q2,q,p:integer;bc:boolean;s1,s2:string;
begin
if (copy(chosen_task,1,5)='15_63')and(k=3)and(s='Too many records.') then begin
  if not en_rus then s:='Количество записей больше максимально допустимого.';
  end;
//if (s<>'')and(s[1]=' ')then delete(s,1,1);

//if (length(s)<40)and(length(s)>10)  then begin q:=pos('.',s); showmessage(copy(s,1,q)+'
//'+inttostr(length(copy(s,1,q)))+' '+copy(s,q+1,1000)+' '+inttostr(length(copy(s,q+1,10000))));end;

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

procedure addblanks(var s:string);
  var i,q:integer;s2,s1:string;
  begin
    s1:=''; s2:=s1;
    q:=pos(' ',s); if q=0 then exit;
    s1:=copy(s,1,q); delete(s,1,q); for i:=q to 13 do s1:=s1+' ';
    q:=pos(' ',s); if (s='')or(q=0)or(not(s[1] in ['A'..'Z']))then begin s:=s1+s; exit;end;
    s2:=copy(s,1,q); delete(s,1,q); for i:=q to 11 do s2:=s2+' ';
    if (s<>'')and(s[1]='f')then s[1]:='F';
    if (s<>'')and(s[1]='m')then s[1]:='M';
    s:=s1+s2+s;
  end;

//A special correction of the output for the task 14_15-002 and 14_27-002-003. All blanks are deleted.
procedure correct14_15_27(var sr:string);
  var p:integer;
  begin repeat p:=pos(' ',sr); if p>0 then delete(sr,p,1) until p=0 end;

//A special correction of the result for the task 8.47-002. It is possible to obtain XY(Z-1)99999 instead of XYZ00000 that is correct too.
procedure correct847(var sr,so:string);
  var i:integer;k:boolean;
  var srr,soo:string;
  begin
    k:=false;srr:=sr; soo:=so;
    if length(sr)<>length(so)then exit;
    for i:=1 to length(srr)-4 do begin
      if (srr[i]=' ') and (soo[i]=' ') then continue;
      if (ord(srr[i])=ord(soo[i])-1) and not k then begin k:=true;srr[i]:=chr(ord(srr[i])+1);continue end;
      if not k and (srr[i]<>soo[i]) then exit;
      if k then if not (srr[i]='9') and(soo[i]='0')then exit else srr[i]:='0';
    end;
    sr:=srr; so:=soo;
  end;

//A special correction of the result such as Error, No roots and some others. The first letter is converted to uppercase; the other letters are converted to lowercase;
procedure correctcapitalsmall(var sr:string);
  var p,i:integer;b:boolean; label 1;
  begin
    b:=false;
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

procedure correct11_22a(s:string; ii5:integer);
  var p:integer;
  begin
    if en_rus then string_out[1]:='Initial data:' else string_out[1]:='Исходные данные:';
    if ii5=1 then begin
      if en_rus then string_out[2]:='the first string: ' else string_out[2]:='первaя строка: ';
      string_out[2]:=string_out[2]+copy(s,1,length(s) div 2);
      if en_rus then string_out[3]:='the second string: ' else string_out[3]:='вторая строка: ';
      string_out[3]:=string_out[3]+copy(s,length(s) div 2+1,length(s));
    end
    else begin
      p:=pos(chr(10),s);
      if p=0 then begin showmessage('Error! No ''\n'' in tests for the subroutine.'); p:=1 end;
      if en_rus then string_out[2]:='the string: '+copy(s,1,p-1)else string_out[2]:='строка: '+copy(s,1,p-1);s:=copy(s,p+1,length(s));
      p:=pos(chr(10),s);
      if p=0 then begin showmessage('Error! No ''\n'' in tests for the subroutine.'); p:=1 end;
      if length(s)<p+2 then s:=s+'!!!!!!!!';
      if en_rus then string_out[3]:='substring bounds: '+copy(s,1,p-1)else string_out[3]:='грaницы пoдстpoки: '+copy(s,1,p-1);
      if en_rus then string_out[4]:='character range: '+s[p+1]+' '+s[p+2]else string_out[4]:='диапазон символов: '+s[p+1]+' '+s[p+2];
      //string_out[3]:=copy(s,p+1,length(s));
    end;
  end;

//A special correction of the output for the task 11_24 when the subprogram is tested.
procedure correct11_24(si:string;it:integer);//si - the input string; it - the number of the current test
  var p,i:integer;s:string;
  begin
    s:='';
    for i:=1 to consts[it,1] do begin p:=pos(' ',si);
      if p=0 then begin s:=s+si; si:='';break end else begin s:=s+' '+copy(si,1,p-1); delete(si,1,p);
      if si=''then break end;
    end;

    if en_rus then string_out[1]:='The first array: '+s else string_out[1]:='Первый массив: '+s;
    s:='';
    for i:=1 to consts[it,1] do begin p:=pos(' ',si);
      if p=0 then begin s:=s+si; si:='';break end
      else begin s:=s+' '+copy(si,1,p-1); delete(si,1,p);
      if si=''then break end;
    end;
    if en_rus then string_out[2]:='The second array: '+s else string_out[2]:='Втоpoй массив: '+s;
    if en_rus then string_out[3]:='The range of indices: '+si else string_out[3]:='Диапазон индексов : '+si;
  end;

//A special correction of input and output data for the tasks 6_24, 15_25 and 15_49 -
//all blanks are replaced by '_' and all tab characters are replaced by '~'.
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
    sr:=inttostr(i2)+' '+inttostr(j2);
    end;
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
    if (s<>'') and (i>0) and ((chosen_task='16_16-001')or(chosen_task='16_16-004')or(chosen_task='16_16-007')) then begin
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
  begin
    i:=pos('1E',s);
    if i>0 then begin delete(s,i,4);exit end;
    i:=pos('!',s);
    if i>0 then if en_rus then s:=copy(s,1,i-2)+'.'+
    ' The pointer to the first node of the list was changed. It is not allowed.' else
    s:=copy(s,1,i-2)+'.'+' Была изменена ссылка на первое звено списка, что недопустимо.'
  end;

//A special correction for the tasks 16_19 - removal of the last @ and analysis if the pointer was changed.
procedure correct_16_19(var s:string);
  var i:integer;
  begin
    i:=pos('@',s);
    if i>0 then begin delete(s,i,1);exit end;
    i:=pos(' !',s);
    if i>0 then if en_rus then s:=copy(s,1,i-1)+'.'+
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
      s:=s+' Было зафиксировано неверное количество обращений к процедуре New.';
    end;
    if check_dispose and not check_new and (p1>0) then begin
      s:=copy(s,1,p1-1);s1:=s; delete_blanks(s1);
      if s1<>'' then s:=s+'.';
      if en_rus then s:=s+' The Dispose procedure was called a wrong number of times.' else
      s:=s+' Было зафиксировано неверное количество обращений к процедуре Dispose.';
    end;
    if check_dispose and check_new and (p1>0) then begin
      s:=copy(s,1,p1-1);s1:=s;delete_blanks(s1);
      if s1<>'' then s:=s+'.';
      if en_rus then s:=s+' The New and Dispose procedures were called a wrong number of times.' else
      s:=s+' Было зафиксировано неверное количество обращений к процедурaм New и Dispose.';
    end;
  end;

//A special correction for the task 15_58
function correct_15_58(var s:string):integer;
  var s1:string;k:integer;
  begin
  delete_blanks(s);
  s1:='';
  while s<>'' do begin
    if s[1]<>chr(2) then s1:=s1+s[1]else
    begin
      inc(k);
      s1:=s1+' 0 ';
    end;
    delete(s,1,1)
  end;
  delete_blanks(s1); s:=s1;
  //showmessage(inttostr(k));
  correct_15_58:=k end;

//A procedure that replaces the numbers of months by their names.
procedure month_num_name(p1:integer; var s3:string);
  begin
    if en_rus then
    case p1 of
      1: s3:='January';
      2:s3:='February';
      3: s3:='March';
      4:s3:='April';
      5:s3:='May';
      6:s3:='June';
      7:s3:='July';
      8:s3:='August';
      9:s3:='September';
      10:s3:='October';
      11:s3:='November';
      12:s3:='December';
    end
    else
    case p1 of
      1: s3:='января';
      2:s3:='фeвраля';
      3: s3:='мартa';
      4:s3:='aпреля';
      5:s3:='мaя';
      6:s3:='июня';
      7:s3:='июля';
      8:s3:='aвгуcтa';
      9:s3:='ceнтября';
      10:s3:='oктябpя';
      11:s3:='нoябpя';
      12:s3:='дeкабpя';
      end;
end;

//A special correction of the input data
//(removing two last zeroes and inserting pairs of square brackets, replacing numbers by month names)
//for the task 15.8 and 15.23
procedure correct15_8_23(var s:string);
  var p2,p1,p:integer;s2,s1,s3:ansistring;
  begin
    delete_blanks(s); s2:=''; s3:='';
    if (length(s)>=3) and (s[length(s)]='0') then delete(s,length(s)-2,3);

    if chosen_task='15_8' then begin
      s1:='';
      while s<>'' do begin
        s1:=s1+'[';p:=pos(' ',s);
        s1:=s1+copy(s,1,p);
        delete(s,1,p);
        p:=pos(' ',s);
        s1:=s1+copy(s,1,p-1)+']  ';
        delete(s,1,p);
      end;
      s:=s1;
    end;

    if chosen_task='15_23' then begin
      s1:='';
      while s<>'' do begin
        p:=pos(' ',s);
        s2:=copy(s,1,p-1);
        delete(s,1,p);
        p:=pos(' ',s);
        s3:=copy(s,1,p-1);
        delete(s,1,p);
        val(s3,p1,p2);
        month_num_name(p1,s3);
        if en_rus then s1:=s1+' '+s3+' '+s2+',' else s1:=s1+' '+s2+' '+s3+',';
      end;
      delete_blanks(s1);
      if (s1<>'') then delete(s1,length(s1),1);
      if s1<>''then s1:=s1+'.'; s:=s1
    end;

    //showmessage(s);
  end;

//A special output for the task 15_23 - numbers of months are converted into its names.
procedure output15_23(var s:string; k:integer);
  var b3:boolean;s4,s5, s2,s3,s1:string;p2,p1,p:integer;      b1,b2:boolean;
  begin
    b1:=false; b2:=false;
    b3:=false; s1:='';delete_blanks(s);

    if k=1 then
      if en_rus then form2.Memo1.Lines.Add('Obtained result:') else form2.Memo1.Lines.Add('Полученный результат:')
    else
      if en_rus then form2.Memo1.Lines.Add('Correct result:') else form2.Memo1.Lines.Add('Правильный результат:');

    if en_rus then s1:='summer dates: 'else s1:='лeтниe дaты: ';
    if en_rus then s4:='winter dates: 'else s4:='зимние дaты: ';

    while s<>'' do begin
      p:=pos(' ',s);
      s2:=copy(s,1,p-1);
      delete(s,1,p);
      p:=pos(' ',s);
      if p>0 then begin
        s3:=copy(s,1,p-1); delete(s,1,p)
      end
      else begin
        s3:=s; s:=''
      end;
      delete_blanks(s);
      val(s3,p1,p2);         //if p2<>0 then showmessage('Error!');
      if p1<1 then begin b3:=true;continue end;
      month_num_name(p1,s3);
      if p1 in [1,2,12] then b2:=true;
      if p1 in [6,7,8] then b1:=true;

      if b3 then if en_rus then s4:=s4+' '+s3+' '+s2+',' else s4:=s4+' '+s2+' '+s3+','
      else if en_rus then s1:=s1+' '+s3+' '+s2+',' else s1:=s1+' '+s2+' '+s3+',';
    end;//of while s<>''

    delete_blanks(s4);
    delete_blanks(s1);

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
      if en_rus then form2.Memo1.Lines.Add('Obtained result:') else form2.Memo1.Lines.Add('Полученный результат:')
    else
      if en_rus then form2.Memo1.Lines.Add('Correct result:')else form2.Memo1.Lines.Add('Правильный результат:');

    for i:=1 to 8 do begin
      s:='';
      for j:=1 to 8 do begin
        s:=s+' '+sa[(i-1)*8+j];
        form2.Memo1.Lines.Add(s);
      end;
    end;

    if length(sa)>64 then form2.Memo1.Lines.Add(copy(sa,65,length(sa)))
    //showmessage('@@');
  end;

//A special correction of the input data (removing the last integer) for the task 15.11, 15.13, 15.15, 15.16 and others that use a file of real or integer
procedure correct15_1int(var s:string);
  var p:integer;
  begin
    delete_blanks(s);
    while (s<>'') and (s[length(s)]<>' ') do
      delete(s,length(s),1);
  end;

//A special correction of the outout string for the task 15_63-005 - all digits after the decimal point are deleted except for the left one
procedure correct15_63_005(var sr:string);
  var p,i,k:integer;
  begin
    i:=1; k:=0;
    if length(sr)<2 then exit;

    repeat
      inc(k);
      if (sr[i]in['2'..'5']) and (length(sr)>i) and not (sr[i+1]='.') and(i>1) and not(sr[i-1]='.') then begin
        insert ('.0',sr, i+1);
      end;
      if (sr[i]in['0'..'9']) and(length(sr)>i) and(sr[i+1]='0') then begin
        delete(sr,i+1,1);
        dec(i)
      end;
      inc(i)
    until (i>length(sr)) or (k=9000);
  end;

//A special correction of the input data (removing the final point) for the task 15.12, 15.14 and others that use a file of char
procedure correct15_1char(var s:string);
  var p:integer;
  begin
    delete_blanks(s);
    if (s<>'') and (s[length(s)]='.') then delete(s,length(s),1);
    if (chosen_task='15_50-002') and (s<>'') then delete(s, length(s)-1,2);
  end;

//A special correction of the input data (removing the final point and inserting blanks) for the task 16.31-002
procedure correct16_31(var s:string);
  var s1:string;
  begin
    delete_blanks(s);
    if(s<>'')and(s[length(s)]='.') then delete(s,length(s),1);
    s1:=' ';
    while s<>'' do begin s1:=s1+s[1]+' '; delete(s,1,1) end;
    s:=s1
end;

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
    while (s<>'') do begin
      p:=pos(' ',s);
      if p=0 then begin
        s1:=s1+s+' ';s:='';
      end
      else begin
        s1:=s1+copy(s,1,p-1)+' ';
        delete(s,1,p)
      end;
      inc(k);
      if (k=m div n) or (s='') then begin k:=0;inc(q);
      case q of
        1: if en_rus then s1:='the first array: '+s1 else s1:='первый массив: '+s1;
        2: if en_rus then s1:='the second array: '+s1 else s1:='второй массив: '+s1;
        3: if en_rus then s1:='the third array: '+s1 else s1:='третий массив: '+s1;
        4: if en_rus then s1:='the fourth array: '+s1 else s1:='четвертый массив: '+s1;
      end;
      if q=n then begin string_out[1+q]:=s1+s;s:='' end else string_out[1+q]:=s1;s1:='' end;
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

end.

