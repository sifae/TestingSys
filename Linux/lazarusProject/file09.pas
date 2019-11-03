//This file contains some functions and procedures for the preliminary analysis and testing
unit file09;
{$I-,R+}

interface
uses  file00;
//This function decrypts the filename given as '_', the chapter's number, '_', the task's number,'-', the subtask's number, if exists, as a three-digit integer with leading zeros, when less then 100.
//the result is true (false) if the decryption is (un)successful
//If successful then nc - the chapter number, nt - the task name (as in the file of initialization)
function decrypt(nameoffile:string;var nc:integer; var nt:string):boolean;
//This function checks if the program contains nested for-loops.
function nested_loops:boolean;
//This function checks correctness of the output for the task 6.30
function char_output:boolean;
//This procedure deletes the first three characters with order numbers 239,187 and 191 from a pascal program
procedure delete_extra(var s:string);
//This function checks correctness of the output for the task 5.6-010.
function check56010:boolean;
//This function checks the balance begin - end, repeat - until, absence/presence of end.
function check_beginend:boolean;
//This function adds a main program block to a procedure or a function.
//The result is 0 if no errors in the procedure or the function were found and <>0, otherwise
function add_main_block:integer;
{function of reading a line from the encoded file}
{the result - if the eof was reached}
{s - the output string}
function readlnf(var f:t_f; var s:string):boolean;
{function of reading a line from the encoded claim-file}
{the result - if the eof was reached}
{s - the output string}
function readlnf2(var f:t_f; var s:string):boolean;
//Determining the sizes of the forms depending on the sizes of the screen
//the parameters are the current width and height of the screen.
// the procedure assign the size to variables _width and _height
procedure determine_size(screenwidth, screenheight:integer);
//Insertion of blanks into the line of a pascal program before output it onto the component Memo5
procedure insert_blanks(var s:string);
//true if the string contains at least one nonblank symbol; false, otherwise
function notblank(s:ansistring):boolean;
//removal of all temporary files
procedure delete_temp;
//How many times each of the words ss[1],..., ss[n] occurs in the pascal program}
procedure occurrences(ss:tss; var ns:tns; n:integer);
//ss - words for check, ns - the output number of occurences, n: number of words
//These procedures check a pascal program whether everything is correct in it;
//As to the word 'const', not only its existence is checking but its two first positions are fixed too.
//Each task is analyzed separately}
function analysis:t_an_res;
//How many calls of a function or a procedure are there in the pascal-program
function callsp:integer;
//The procedure deleting all superfluous blanks
procedure delete_blanks(var s:string);
//The procedure that replaces call F with F() if the function F has no formal parameters.
procedure add_parentheses(var s:string; s13:string);

//This procedure joins all lines of the file temp1.pas; the result is the variable s}
procedure join(var s:string);

//This function returned a list of names of functions that have no formal parameters
function func_names(s:string):string;

//This procedure breaks the string that contains the tested program into several lines. ';' or blanks are possible separators.
//It writes the result into the file temp1.pas too
//s - the tested program
procedure breaks(s:string; b1:boolean);

//This function checks if there are variables declared before procedure definitions in the program.
function findglobal:boolean;

//This function forms a Pascal program for testing the subroutine
//If the result is 0 , it is a success. Otherwise, errors were found.
function formsubroutine:integer;

//This procedure removes all characters from strings
procedure delete_strings(var s:string);

//this procedure add key words if they are absent, for instance change const n=3; m=5 to const n=3; const m=5;
procedure insertwords(var s:string);

//This function checks if there are strings '=true' or '=false' without the character ':' before them.
function checkboolean: boolean;

//In the tasks 15_32- from 2 to 8 and some other tasks - only a file with the name 'temp15_2' can be assigned; a temporary file can be renamed to 'temp15_1' only; the corresponding replacements are made in the pascal program
procedure replace15_32_and_others;

//Function that analyzes programs that process external files - these are tasks 15.58 and the next.
function external_files:boolean;



implementation
uses file02,dialogs,sysutils;


//Function that analyzes programs that process external files - these are tasks 15.58 and the next.
function external_files:boolean;
var s7,st,sfr,sf,ss,s1,s,s2,s3:string;b,b1:boolean;j3,j2,j1,j,i:integer;k:integer;
begin join(s); external_files:=false;sf:=''; st:=''; sfr:=''; ss:='';j3:=0;b1:=false;

k:=0; if chosen_task='15_58' then k:=4;if chosen_task='15_59' then k:=3; if chosen_task='15_60' then k:=2; if chosen_task='15_61' then k:=1; if chosen_task='15_62' then k:=1;
if copy(chosen_task,1,5)='15_63' then k:=2;
if (pos('begin ',s)=0) or (pos('end.',s)=0) or(pos('assign',s)=0) then begin
if en_rus then showmessage('Error in the structure of the program: at least one of the words ''begin'', ''end.'' or ''assign'' were not found.')else
showmessage('Ошибка в структуре программы: пo крайней мере одно из слов ''begin'', ''end.'' или ''assign'' нe было найдено.');exit end;
i:=0; repeat s2:='readfile'+inttostr(i);  if pos(s2,s)=0 then break; inc(i) ; until i>10000;//for a safe reason; it cannot really happen
i:=0; repeat s3:='writefile'+inttostr(i); if pos(s3,s)=0 then break; inc(i) ; until i>10000;//for a safe reason; it cannot really happen
if chosen_task='15_59' then
s1:='procedure '+s2+'(var f1,f2:text);var c:char; begin rewrite(f1); repeat read(c); if c=''.'' then break; if c=chr(2) then writeln(f1) else write(f1,c) until c=''.''; close(f1); '+
'rewrite(f2); repeat read(c); if c=''.'' then break; if c=chr(2) then writeln(f2) else write(f2,c) until c=''.''; close(f2) end;'
else if chosen_task='15_58' then
s1:='procedure '+s2+'(var f1:text);var c:char; begin rewrite(f1); repeat read(c); if c=''.'' then break; if c=chr(2) then writeln(f1) else write(f1,c) until c=''.''; close(f1); end;'
else if chosen_task='15_60' then
s1:='procedure '+s2+'(var f1:text);var c:char; begin rewrite(f1); repeat read(c); if c=''#'' then break; if c=''~'' then c:='';''; if c=chr(2) then writeln(f1) else write(f1,c) until c=''#''; close(f1); end;'
else if copy(chosen_task,1,5)<>'15_63'then

s1:='procedure '+s2+'(var f1:text);var c:char; begin rewrite(f1); repeat read(c); if c=''#'' then break; if c=chr(2) then writeln(f1) else write(f1,c) until c=''#''; close(f1); end;'
else begin
s1:='procedure '+s2+'(var f1:TFile); var s1,s:ansistring; i,p:integer; stud:Tstud; begin rewrite(f1); readln(s); if length(s)>1 then repeat p:=pos('' '',s); stud.name.s_name:=copy(s,1,p-1); delete(s,1,p);';
s1:=s1+'p:=pos('' '',s); stud.name.f_name:=copy(s,1,p-1); delete(s,1,p); p:=pos('' '',s); s1:=copy(s,1,p-1); delete(s,1,p); if (s1=''f'')or(s1=''F'')then stud.sex:=f else stud.sex:=m; ';
s1:=s1+'for i:=1 to 5 do begin stud.marks[i]:=ord(s[1])-48; delete(s,1,2);end; write(f1,stud); if length(s)<5 then break until length(s)<5; close(f1) end;';
end;


//s1:=s1+'procedure '+s3+'(var f2:text);var c:char; begin reset(f2); while not eof(f2) do begin while not eoln(f2) do begin read(f2,c); write(c); end; readln(f2); write(chr(2)); end; close(f2); end;';
if chosen_task='15_58'then
s1:=s1+'procedure '+s3+'(var f1,f2,f3,f4:text); var i,k:integer; c:char; begin {$I-}; close(f1); i:=ioresult; close(f2); k:=ioresult;'+
'reset(f2); while not eof(f2) do begin while not eoln(f2) do begin read(f2,c); write(c); end; readln(f2); write(chr(2)); end; close(f2);'+
'if i*k=0 then write(chr(4)); erase(f1); ioresult; erase(f2); ioresult; close(f3); ioresult; close(f4); '+
'ioresult; reset(f3); i:=ioresult; reset(f4); k:=ioresult; close(f3); ioresult; close(f4); ioresult; if i*k=0 then write(chr(5)) {$I+}; end; ';

if chosen_task='15_59'then
s1:=s1+'procedure '+s3+'(var f1,f2,f3:text); var i,k:integer; c:char; begin {$I-}; close(f1); i:=ioresult; close(f2); k:=ioresult;'+
'reset(f1); while not eof(f1) do begin while not eoln(f1) do begin read(f1,c); write(c); end; readln(f1); write(chr(2)); end; close(f1); write(''.'');'+
'reset(f2); while not eof(f2) do begin while not eoln(f2) do begin read(f2,c); write(c); end; readln(f2); write(chr(2)); end; close(f2);write(''.''); '+
'if i*k=0 then write(chr(4)); '+'erase(f1); ioresult; erase(f2); ioresult; close(f3); ioresult; reset(f3); i:=ioresult;  close(f3); ioresult;  if i=0 then write(chr(5)) {$I+}; end; ';
if chosen_task='15_60'then
s1:=s1+'procedure '+s3+'(var f1,f2:text); var i,k:integer; c:char; begin {$I-}; close(f1); i:=ioresult; close(f2); k:=ioresult; '+
'reset(f2); while not eof(f2) do begin while not eoln(f2) do begin read(f2,c); if c='';'' then c:=''~''; write(c); end; readln(f2); write(chr(2)); end; close(f2);'+
'if i*k=0 then write(chr(4));erase(f1); ioresult; erase(f2); ioresult; {$I+}; end; ';
if (copy(chosen_task,1,4)='15_6')and(chosen_task[5]<>'0')and (chosen_task[5]<>'3') then
s1:=s1+'procedure '+s3+'(var f1:text); var k:integer; begin {$I-}; close(f1); k:=ioresult; if k=0 then write(chr(4));erase(f1); ioresult; {$I+}; end; ';
if copy(chosen_task,1,5)='15_63' then begin s1:=s1+'procedure '+s3+'(var f1:tfile; var f2:text); var i,k:integer; s:string;';
s1:=s1+'begin {$I-}; close(f1); k:=ioresult; close(f2); i:=ioresult; {$I+}; reset(f2);while not eof(f2) do ';
s1:=s1+'begin readln(f2,s); while (s<>'''')and(s[1]='' '')do delete(s,1,1); while(s<>'''')and(s[length(s)]='' '')do delete(s,length(s),1); write(s); write(chr(2)); end; close(f2); erase(f1); erase(f2); if i*k=0 then write(chr(4)); end;';
end;
b:=true;s7:='';
repeat if s[1]='''' then b:=not b;
if b and (copy(s,1,6)='begin ') then break; if copy(chosen_task,1,5)<>'15_63' then s1:=s1+s[1]else s7:=s7+s[1]; delete(s,1,1);until false or(s='');
if copy(chosen_task,1,5)<>'15_63' then s1:=s1+'begin ' else s1:=s7+s1+'begin ';delete(s,1,6);


//showmessage(inttostr(k));


for j:=1 to k do begin

//showmessage(inttostr(j)+'s  !! '+s);

if copy(s,1,7)<>'assign('then begin if en_rus then showmessage('Not enough Assign procedures at the beginning of the program.')
else showmessage('Недостаточно процедур assign в начале прогpaммы.'); exit end;
s1:=s1+'assign('; delete(s,1,7);
j2:=pos(',''',s);
if j2<2 then begin if en_rus then showmessage('Wrong syntax of an Assign procedure.') else showmessage('Невеpный синтаксис процедуры assign.');exit end;
j1:=pos(''')',s);
if (j1=0)or(j1<j2)then begin if en_rus then showmessage('Wrong syntax of an Assign procedure.') else showmessage('Невеpный синтаксис процедуры assign.');exit end;
if (copy(s,j2+2,j1-j2-2)='1.txt')and(copy(chosen_task,1,5)<>'15_63') or (copy(s,j2+2,j1-j2-2)='1.std')and(copy(chosen_task,1,5)='15_63')then
begin if sf='' then sf:=copy(s,1,j2-1)else b1:=true; s1:=s1+copy(s,1,j2)+'''temp15_1'');' end else
if copy(s,j2+2,j1-j2-2)='2.txt'then begin if ss='' then ss:=copy(s,1,j2-1)else b1:=true; s1:=s1+copy(s,1,j2)+'''temp15_2'');' end else
if j3=0 then begin inc(j3); s1:=s1+copy(s,1,j2)+'''temp15_3'');' ; if st='' then st:=copy(s,1,j2-1)else b1:=true; end else
begin s1:=s1+copy(s,1,j2)+'''temp15_4'');';if sfr='' then sfr:=copy(s,1,j2-1)else b1:=true;end;
if j=k then delete(s,1,j1+1)else delete(s,1,j1+2);

//showmessage(inttostr(j)+'s1  !! '+s1);

end;


//showmessage(sf);

if ((sf='')or(ss=''))and((chosen_task='15_58')or(chosen_task='15_59')or(chosen_task='15_60')or(copy(chosen_task,1,5)='15_63'))then begin
if en_rus then
if copy(chosen_task,1,5)<>'15_63'then
showmessage('Assign procedure for the external files ''1.txt'' or ''2.txt'' was not found.')
else showmessage('Assign procedure for the external files ''1.std'' or ''2.txt'' was not found.')
else
if copy(chosen_task,1,5)<>'15_63'then
showmessage('Не найдена процедура assign для внешних файлов 1.txt или 2.txt.') else
showmessage('Не найдена процедура assign для внешних файлов 1.std или 2.txt.') ;exit end;

if (sf='')and((chosen_task='15_62')or(chosen_task='15_61'))then begin
if en_rus then showmessage('Assign procedure for the external file ''1.txt'' was not found.')
else
showmessage('Не найдена процедура assign для внешнeгo файлa 1.txt.');
exit end;
if b1 then begin
if en_rus then showmessage('A wrong filename in one of the Assign procedures.') else showmessage('Невернорное имя файла для процедуры assign.') ;exit end;

if chosen_task<>'15_59' then
s1:=s1+';'+s2+'('+sf+')'
else s1:=s1+';'+s2+'('+sf+','+ss+')';

//showmessage('s  !! '+s);
//showmessage('s1 before  !! '+s1);

repeat if copy(s,1,4)='end.' then break; s1:=s1+s[1]; delete(s,1,1) until s='';

//if (chosen_task='15_58') or (chosen_task='15_59') or(chosen_task='15_60')then  s1:=s1+';'+s3+'('+ss+')';
if (chosen_task='15_58')then s1:=s1+';'+s3+'( '+sf+','+ss+','+st+','+sfr+')';
if (chosen_task='15_59')then s1:=s1+';'+s3+'( '+sf+','+ss+','+st+')';
if (chosen_task='15_60')then s1:=s1+';'+s3+'( '+sf+','+ss+')';
if (chosen_task='15_61')or(chosen_task='15_62')then s1:=s1+';'+s3+'('+sf+')';
if (copy(chosen_task,1,5)='15_63')then s1:=s1+';'+s3+'( '+sf+','+ss+')';
s1:=s1+' end.';

//showmessage(s1);
breaks(s1,false);

external_files:=true;
end;

//In the tasks 15_32- from 2 to 8 - only a file with the name 'temp15_2' can be assigned; a temporary file can be renamed to 'temp15_1' only; the corresponding replacements are made in the pascal program
procedure replace15_32_and_others;
var s,s1,s2,s3:string;  b2,b:boolean;p:integer;//i:integer;
begin join(s);s:=' '+s; s1:=''; b:=false;//i:=0;
while s<>'' do begin

//inc(i); if (i mod 10 =0)or(i>160) then showmessage(s1);

if s[1]='''' then b:=not b; if not b and ((copy(s,1,8)=' assign(')or(copy(s,1,8)=';assign(')or(copy(s,1,8)=' rename(')or(copy(s,1,8)=';rename(')) then begin
b2:=copy(s,2,6)='assign';
s1:=s1+copy(s,1,8); delete(s,1,8); if s='' then exit;p:=pos(',',s); if p=0 then exit; s1:=s1+copy(s,1,p); delete(s,1,p); if (s='')or(s[1]<>'''')then exit; s1:=s1+''''; delete(s,1,1);
if b2 then s1:=s1+'temp15_2''' else s1:=s1+'temp15_1'''; p:=pos('''',s); if p=0 then exit; delete(s,1,p); if s='' then exit else continue end else begin s1:=s1+s[1]; delete(s,1,1) end;
end;
//showmessage('!!!!');
breaks(s1,false);
end;


//This function checks if there are strings '=true' or '=false' without the character ':' before them.
function checkboolean: boolean;
var s1,s:string;p:integer;
begin checkboolean:=false; join(s); delete_strings(s); delete_blanks(s);s1:=s;
repeat p:=pos('=true',s); if p<2 then break; if (s[p-1]<>':')and(length(s)>p+5) and(s[p+5] in [' ',')',':'])then begin checkboolean:=true; exit end;delete(s,1,p); until length(s)<3;s:=s1;
repeat p:=pos('=false',s);if p<2 then break; if (s[p-1]<>':')and(length(s)>p+5) and(s[p+6] in [' ',')',':'])then begin checkboolean:=true; exit end;delete(s,1,p); until length(s)<3;s:=s1;
repeat p:=pos('true=',s); if p<2 then break; if not(s[p-1]in alphadigit) then begin checkboolean:=true; exit end;delete(s,1,p); until length(s)<3;s:=s1;
repeat p:=pos('false=',s);if p<2 then break; if not(s[p-1]in alphadigit) then begin checkboolean:=true; exit end;delete(s,1,p); until length(s)<3;
end;

//This function decrypts the filename given as '_', the chapter's number, '_', the task's number,'-', the subtask's number, if exists, as a three-digit integer with leading zeros, when less then 100.
//the result is true (false) if the decryption is (un)successful
//If successful, nc - the chapter number, nt - the task name.
function decrypt(nameoffile:string;var nc:integer; var nt:string):boolean;
var f:t_f; s,s3,s1,s2,s4:string; m,i,n,p,q:integer;b:boolean;s5:array[1..200] of string;
begin decrypt:=false;
s1:=extractfilename(nameoffile);
if (length(s1)<5)or(s1[1]<>'_') then exit;
s2:=s1[2]; delete(s1,1,2); if s1[1]in ['0'..'9'] then begin s2:=s2+s1[1]; delete(s1,1,1)end;
//n - the number of a chapter in the textbook by Pilshchikov
val(s2,n,p);if (p<>0)or(s1[1]<>'_')then exit;delete(s1,1,1);
p:=1;

//showmessage(s1);
repeat if not(s1[p] in ['0'..'9','-']) then break else inc(p) until p>=length(s1);
if (p<2) or (p>=length(s1)) then exit;
s2:=copy(s1,1,p-1);

//showmessage(s2);

p:=form2.ComboBox1.Items.Count; if p=0 then exit;
b:=false;
for i:=0 to p-1 do
begin
s3:=form2.combobox1.Items[i];
q:=0;repeat inc(q); if not(s3[q]in ['0'..'9'])or(length(s3)=q) then continue;
if s3[q+1] in ['0'..'9'] then s4:=s3[q]+s3[q+1] else s4:=s3[q];break;
until q>=length(s3);
if n=strtoint(s4)then begin b:=true; break end;
end;
if not b then exit; //the given chapter was not found
n:=i; //now n is the chapter number in combobox1, beginning with 0.
//showmessage(inttostr(n));
//showmessage(directory_names[1]);
assignfile(f,current_dir+'/tests/'+directory_names[1+n]+'/tests.cde'); //..'Tests_chapter_'+chosen+'.cde');
initializef(f, i_n, i_c, s_n,true);
//reset(f);
m:=0;b:=false;
while not eof(f) and not b do begin b:=readlnf(f,s);
if (s='')or(s[1]<>'_')then continue;
//showmessage('!!!!!'+s);
i:=pos(';',s); if i>0 then s:=copy(s,1, i-1);//removal of a possible comment
inc(m);s5[m]:=copy(s,2,200);
while (s5[m]<>'')and(s5[m,length(s5[m])]=' ')do
delete (s5[m], length(s5[m]), 1);

end;closefile(f); ioresult;

//showmessage('@@@@@@@@@@@@@  '+s4+'_'+s2);
//showmessage(s5[3]);
for i:=1 to m do if s5[i]=s4+'_'+s2 then begin decrypt:=true;nc:=n; nt:=s4+'_'+s2;
//showmessage('!!!!!!!!!!!!!!!!!!  '+s5[i]);

exit end;

end;

//This function checks if the program contains nested for-loops.
function nested_loops:boolean;
var s2,s1,s:string;k,q1,q,p:integer;label 2,1; //p1,p2,p3,p4:integer; q1,q2:integer;
begin nested_loops:=false;
join(s);delete_strings(s);s2:=s;
//showmessage(s);
for k:=1 to 3 do begin s:=s2;
repeat
//showmessage(s);
repeat if k=1 then p:=pos('for ',s) else if k=2 then p:=pos('else ',s)else p:=pos('then ',s); if p<2 then goto 2;

if (p>1)and (s[p-1]in alphadigit) then delete(s,1,p+2+ord(k>=2)) else break;
until false;
delete(s,1,p+2+ord(k>=2));
if k=1 then begin repeat q:=pos('do ',s);if q=0 then
begin q:=pos(' do;',s); if q=0 then goto 2 else begin delete(s,1,q+2);goto 1; end end;

if (q>1)and (s[q-1]in alphadigit) then delete(s,1,q+1) else break;
until false;
delete(s,1,q+1) end;
if copy(s,1,5)=' for ' then begin nested_loops:=true; exit end;
//if copy(s,1,4)=' if ' then begin
//q1:=pos(' then ',s); if q1=0 then begin delete(s,1,1); continue end;
//delete(s,1,q1+4); if copy(s,1,5)=' for ' then begin nested_loops:=true; exit end;
//if copy(s,1,7)<>' begin 'then begin delete(s,1,1); continue;end;end;
if copy(s,1,7)<>' begin ' then begin delete(s,1,1); continue;end;
q:=0; p:=0; s1:=s;
repeat
if (copy(s1,2,3)='end') and not(s1[1]in alphadigit)  and not(s1[5]in alphadigit)then dec(p);
if (copy(s1,2,5)='begin') and not(s1[1]in alphadigit)  and not(s1[7]in alphadigit)then inc(p);
if (copy(s1,2,3)='for') and not(s1[1]in alphadigit)  and not(s1[5]in alphadigit)then q:=1;
delete(s1,1,1); until (s1='')or(p=0);
if q=1 then begin nested_loops:=true; exit end;
s:=s1;
1:until(s='');
2: end; //of for k:=1 to 2
end;

//This procedure deletes the first three characters with order numbers 239,187 and 191 from a pascal program
procedure delete_extra(var s:string);
begin if (length(s)>2)and(copy(s,1,3)=chr(239)+chr(187)+chr(191))then delete(s,1,3) end;

//The procedure that replaces call F with F() if the function F has no formal parameters.
procedure add_parentheses(var s:string;s13:string);
var p2,p:integer; b:boolean;s14:string;
begin b:=false; p:=1;
repeat if s[p]='''' then b:=not b;
if (not b)and(s[p]in alphadigit)and((p=1)or(not(s[p-1]in alphadigit)))then begin s14:=''; p2:=p; while (p2<length(s))and(s[p2]in alphadigit) do begin s14:=s14+s[p2];inc(p2); end;end else s14:='!';
if (s14<>'!')and not b and(pos(' '+s14+' ',s13)>0)and(copy(s,p,length(s14)+1)<>s14+':')and(copy(s,p,length(s14)+1)<>s14+'(')
then s:=copy(s,1,p+length(s14)-1)+'()'+copy(s,p+length(s14),10000);
inc(p);
until p>=length(s);
end;

//This procedure joins all lines of the file temp1.pas; the result is the variable s}
procedure join(var s:string);
var f:textfile;var sL:string;
begin
assignfile(f, current_dir+'/tmp/temp1.pas'); closefile(f); ioresult; reset(f); if (ioresult<>0)or eof(f) then
begin showmessage ('Fatal error. File ''temp1.pas'' not found'); close(f); ioresult; delete_temp; halt end;
s:=''; while not eof(f) do begin
readln(f,sL);
delete_blanks(sL);if sL='' then continue;if s='' then s:=sL else if (s[length(s)]in alphadigit)and(sL[1] in alphadigit)then s:=s+' '+sL else s:=s+sL;
end;
{of not eof}
closefile(f); ioresult;
end;

//This procedure removes all characters from strings
procedure delete_strings(var s:string);
var s1:string;i:integer;b:boolean;
begin s1:=''; b:=false;
for i:=1 to length(s) do begin if not b then s1:=s1+s[i]; if s[i]=chr(39)then begin b:=not b;if not b then s1:=s1+'''' end;end;
s:=s1;
end;

//This function checks correctness of the output for the tasl 5.6-010.
function check56010:boolean;
var s:string;p2,p3,p:integer;bb3:boolean;
begin check56010:=true;
join(s); delete_strings(s);
ss[1]:='write'; ss[2]:='writeln'; occurrences(ss,ns,2);
if ns[1]+ns[2]>1 then begin check56010:=false; exit end;
if ns[1]+ns[2]=0 then exit;
repeat
p:=pos('write(',s);bb3:=false; if p=0 then begin bb3:=true; p:=pos('writeln(',s); end;if p=0 then break;
if (p>1)and(not(s[p-1] in alphadigit))then begin delete(s,1,p+5);if bb3 then delete(s,1,2);
p2:=0; p3:=0;
if s<>'' then repeat inc(p2); if s[p2]='(' then inc(p3); if s[p2]=')' then dec(p3);
if p3=-1 then break; if (p3=0) and (s[p2]=',')then begin check56010:=false; exit end;
until p2>=length(s)
end else delete(s,1,p+1) until false end;

//This procedure checks if the character with the order number p is within a string
function withinstring(s:string; p:integer):boolean;
var i:integer;b:boolean;
begin b:=false;
for i:=1 to p do if s[i]='''' then b:=not b;
withinstring:=b end;

//This function returned a list of names of functions that have no formal parameters
function func_names(s:string):string;
var i2,i:integer;ss:string;c:char;
begin delete_strings(s);ss:='';c:=' ';
while s<>'' do begin if (copy(s,1,9)='function ')and(not (c in alphadigit))then begin
delete(s,1,9); i:=pos(':',s); i2:=pos('(',s);
if (i2=0)or(i2>i) then begin ss:=ss+' '+copy(s,1,i-1); delete(s,1,i) end end
else begin c:=s[1]; delete(s,1,1) end end;
func_names:=ss+' ';
if ss='' then func_names:=ss;

//showmessage(ss);

end;

//This function returns the name of the first (and probably the second) function or the first procedure in the program text
//s - the text of the program, b=false(true) if one (two) functions are needed.
function first_name(s:string;b:boolean):string;
var se,ss:string;c:char;
begin delete_strings(s);ss:='';c:=' ';
se:='';
//showmessage(s);
while s<>'' do begin if ((func_proc=1)or program_sub)and(copy(s,1,9)='function ')and(not (c in alphadigit))or ((func_proc=2)or program_sub)and(copy(s,1,10)='procedure ')and(not (c in alphadigit))then begin
delete(s,1,9+byte(copy(s,1,10)='procedure '));
ss:=''; while (s<>'')and(s[1]in alphadigit) do begin ss:=ss+s[1]; delete(s,1,1)end;

//showmessage('!! '+ss);

if ss='' then begin first_name:='!';exit end else if not b then begin first_name:=ss; exit end else begin
if se='' then se:=ss else begin first_name:=se+' '+ss; exit end;
 end end
else begin c:=s[1]; delete(s,1,1) end end;

first_name:='!';
end;

//This procedure breaks the string that contains the tested program into several lines. ';' or blanks are possible separators.
//It writes the result into the file temp1.pas too
//s - the tested program
procedure breaks(s:string;b1:boolean);
var f:textfile;q,p:integer;b:boolean;
begin

//showmessage(s);

if b1 then assignfile(f, current_dir+'/tmp/temp10.pas') else assignfile(f, current_dir+'/tmp/temp1.pas'); rewrite(f); if (ioresult<>0)then
begin showmessage ('Fatal error. File ''temp1<0>.pas'' cannot be created.'); close(f); ioresult; halt end;
b:=false;//true if we are within a string
//p:=pos('}',s); if (p>0)and(p<100) then begin writeln(f,copy(s,1,p));delete(s,1,p) end;
p:=1;
repeat delete_blanks(s); if s='' then break;
//if pos(s,'{$I+,')in [1..10] then showmessage(inttostr(p)+'       '+s);
if not b and (s<>'')and(s[p]='{')then begin q:=pos('}',s);
//showmessage(inttostr(p)+'    '+inttostr(q)+'   '+s);
if q>0 then begin if p>1 then writeln(f,copy(s,1,p-1)); writeln(f,copy(s,p,q+1-p));delete(s,1,q); p:=1; ;
continue end;end;
if s[p]='''' then b:=not(b);
if not b and((s[p]=';')or(p>50)and(s[p]=' ')or((s[p]='.')and(p>1)and(s[p-1]='d')))then begin
//showmessage(inttostr(p)+'   '+copy(s,1,p)+'   !!!');
writeln(f, copy(s,1,p)); delete(s,1,p); p:=0 end;
p:=p+1;
//if p=1 then showmessage(s);
until (p>length(s))or(s='');
if s<>'' then writeln(f,s);
closefile(f); ioresult; end;

//This function tries to find a procedure or a function in the program text if both subroutines are possible;
//it returned 1 if a function was found; 2 if a procedure was found; 0 if nothing was found; if subroutines of both types were found, the first is taken.
function find_subroutine(s:string):integer;
var i:integer;
begin find_subroutine:=0;
s:=' '+s; for i:=1 to length(s) do begin
if (copy(s,i,9)='function ')and (not(s[i-1]in alphadigit)) then begin find_subroutine:=1; exit end;
if (copy(s,i,10)='procedure ')and (not(s[i-1]in alphadigit)) then begin find_subroutine:=2; exit end;
end;
end;

//This function checks the balance of begin - end and repeat - until; absence/presence of the final end.
function check_beginend:boolean;
var s:string;
begin check_beginend:=false;
ss[1]:='begin'; ss[2]:='case'; ss[3]:='record'; ss[4]:='end'; ss[5]:='repeat'; ss[6]:='until';
occurrences(ss,ns,6);
if ns[1]+ns[2]+ns[3]<>ns[4] then begin
//showmessage('!!!'+inttostr(ns[1])+' '+inttostr(ns[2])+'@'+inttostr(ns[3])+'!'+inttostr(ns[4]));

if en_rus then showmessage('Error. Amount of the words ''begin'' is not equal to amount of the words ''end''.')else showmessage('Oшибка. Нет баланса операторных скобок begin end.');exit end;
if ns[5]<>ns[6] then begin
if en_rus then showmessage('Error. Amount of the words ''repeat'' is not equal to amount of the words ''until''.')else showmessage('Ошибка. Нет баланса операторных скобок repeat-until.');exit end;
join(s);
if s='' then exit;
if (copy(s,length(s)-3,4)='end.')and(func_proc>0)then begin
if en_rus then showmessage('Error: ''end.'' was found in the subroutine definition.') else showmessage('Ошибка: в описании подпрограммы обнаружено ''end.''');exit end;
if (copy(s,length(s)-3,4)<>'end.')and(func_proc=0)then begin
if en_rus then showmessage('Error: ''end.'' was not found in the program.') else showmessage('Ошибка: в программе не найдено заключительное''end.''');exit end;
check_beginend:=true;
end;


//This procedure inserts a count into the program. It is used to count how many calls of New or Dispose procedure was made
procedure countnewdispose(var s:string);
var p4,p3,j,i,p1,p2:integer;s1,s2:string;
begin
check_new:=false; check_dispose:=false;
//showmessage(s);
for j:=1 to 2 do begin

if j=1 then p1:=pos('/new/',text_before)else p1:=pos('/dis/',text_before); if p1=0 then continue; 
text_before:=copy(text_before,1,p1-1)+copy(text_before,p1+5, length(text_before));
if j=1 then check_new:=true else check_dispose:=true;
for i:=1+j*100 to 99+j*100 do if (i=99+j*100)or(pos('s'+inttostr(i),s)=0) then break;
s2:='s'+inttostr(i); text_before:='var '+s2+':integer;'+text_before;

s1:=''; repeat if j=1 then p1:=pos('new(',s)else p1:=pos('dispose(',s);
if p1=0 then begin s1:=s1+s; break end;
if (p1>1)and(s[p1-1]in alphadigit) then begin s1:=s1+copy(s,1,p1+1); delete(s,1,p1+1); continue end;
s1:=s1+copy(s,1,p1-1);s1:=s1+'begin inc('+s2+');'; if j=1 then s1:=s1+'new' else s1:=s1+'dispose';delete(s,1,p1-1);
p4:=pos('(',s); if p4=0 then p4:=1; delete(s,1,p4-1); p3:=pos(')',s); if p3=0 then p3:=1; s1:=s1+copy(s,1,p3)+'end ';
s:=copy(s,p3+1,length(s)) until false;
s:=s1;

repeat if j=1 then p1:=pos('s100',text_after) else p1:=pos('s200',text_after);
if p1=0 then break; text_after:=copy(text_after,1,p1-1)+s2+copy(text_after,p1+4, length(text_after));until false;

end;//of for from 1 to 2
end;


//This function checks if parameters that must be value paramaters only, satisfy this condition.
//If the condition is fulfilled, the function returns an empty string; otherwise, the function returns the list of parameters that do not satisfy the condition.
//The parameter s is the text of the program.
function checkvalueparam(s:string):string;
var s6,s5, s4,s2,s7:string;k7,k6,k,j,i:integer;b1:boolean;
begin s4:=s; checkvalueparam:='';
s2:=text_before; i:=pos('//',s2); if i=0 then exit; s2:=copy(s2, i,100);
i:=pos('procedure',s4); j:=pos('function',s4);  if i+j=0 then exit;
if i=0 then k:=j;if j=0 then k:=i;
if i*j>0 then if i>j then k:=j else k:=i;
s4:=copy(s4,k,10000);
i:=pos('(',s4); if i=0 then exit; s4:=copy(s4,i+1, 10000);
i:=pos(')',s4); if i=0 then exit; s4:=copy(s4,1,i-1);k6:=0;

//showmessage(s4);
//showmessage(s2);

repeat j:=pos(';',s4); if j=0 then begin s5:=s4; s4:='' end else begin s5:=copy(s4,1,j-1); s4:=copy(s4,j+1,1000) end;
if (length(s5)<2)then exit; k7:=pos(':',s5); //I added these statements for a safe reason
if k7>1 then s5:=copy(s5,1,k7-1); b1:=copy(s5,1,4)='var ';if b1 then s5:=copy(s5,5,1000); if s5='' then exit;
repeat k7:=pos(',',s5); if k7=0 then s6:=s5 else begin s6:=copy(s5,1,k7-1);s5:=copy(s5,k7+1,1000) end; if s5='' then exit;
inc(k6);str(k6:1,s7); if b1 and (pos(s7,s2)>0)then begin checkvalueparam:=s6; exit end; until k7=0;until (s4='');
end;



//This function checks if all actual parameters that must be passed by reference only, satisfy this condition;
//the function returns an empty string if the condition is fulfilled; otherwise it returns the type of the first wrong actual paramater.
//s is the text of the program.
function checkvarparam(s:string):string;
var p6,p5,p4,p3,q,i,p,p2:integer;s2,s1:string;
begin checkvarparam:='';delete_strings(s);


i:=0;s1:=s;while varparam[i+1]<>'' do begin inc(i);
s:=s1;

//showmessage('We are here   '+s);

repeat

p4:=pos('procedure ',s); if (p4=1)or(p4>1)and(not(s[p4-1]in[';','}']))then p4:=0;
p5:=pos('function ',s); if (p5=1)or(p5>1)and(not(s[p5-1]in[';','}']))then p5:=0;
if (p4=0)and(p5=0)then break;
if (p4>0)and(p5>0)and(p4>p5) then p4:=p5; if p4=0 then p4:=p5; delete(s,1,p4);
p6:=pos(';',s);
p2:=pos('(',s);

if (p6=0)and(p2=0)then break;
if (p6>0)and(p2>0)and(p6<p2) then begin delete(s,1,p6-1); continue end;
if p2=0 then break; s2:=copy(s,p2,length(s));
p3:=pos(')',s2); if p3=0 then break; s2:=copy(s2,1,p3);

//showmessage(inttostr(p4)+'  '+inttostr(p5));
//showmessage('SSSS  '+s);
//showmessage('SSSS1122222   '+s2);

repeat p:=pos(':'+varparam[i],s2); if p=0 then break;
if (pos(':'+varparam[i]+';',s2)<>p)and(pos(':'+varparam[i]+')',s2)<>p)then begin s2:=copy(s2,p+1,length(s2)); continue end;
q:=p;repeat dec(q); until (s2[q]='(')or(s2[q]=';')or(q<=1);

//showmessage(inttostr(p));
//showmessage(s);

if copy(s2,q+1,4)<>'var ' then begin checkvarparam:=varparam[i];exit end;
s2:=copy(s2,p+1, length(s2)); until (s2='');
until false;
end;

end;

//This function checks correctness of the output for the task 6.30
function char_output:boolean;
var s15:string;p2,p3,p:integer;bb3:boolean;
begin
char_output:=true;
join(s15);
delete_strings(s15);
repeat p:=pos('write(',s15);bb3:=false; if p=0 then begin bb3:=true; p:=pos('writeln(',s15); end;if p=0 then break;
if (p>1)and(not(s15[p-1] in alphadigit))then begin delete(s15,1,p+5);if bb3 then delete(s15,1,2);
p2:=0; p3:=0;
if s15<>'' then repeat inc(p2); if s15[p2]='(' then inc(p3); if s15[p2]=')' then dec(p3);
if p3=-1 then break; if (p3=0) and (s15[p2]=',')then begin char_output:=false; exit end;
until p2>=length(s15);
end else begin delete(s15,1,p+1); continue end;
if (copy(s15, 1, 4)<>'chr(') and (copy(s15,1,5)<>'char(')and(s15[1]<>'''')then begin char_output:=false; exit end;
until false;
end;


//It is a function adding the main block to a program that is presented as a procedure or a function.
//The result is false if there are errors in the procedure or in the function
function add_main_block:integer;
var s34,s17,s14,s13,s11,name,s22,s15,s12,s10,s9,s6,s7,s5,s4,s3,s8,s2,s:string;p5,p4,p6, p3,p2,pp,p1,p:integer;realb:boolean;bb3,b,bb:boolean;
begin add_main_block:=-1;
text_after:=text_after0;
text_before:=text_before0;

//the variable 's' contains a function or a procedure in pascal
join(s);
//showmessage('We are here  '+s);

s34:=checkvalueparam(s);
if s34<>'' then begin if en_rus then showmessage(' Error. The parameter '+s34+' must be a value parameter.') else
showmessage(' Oшибкa. Пapaметр '+s34+' должен быть параметром-значением.'); exit end;
p5:=pos('//',text_before);if p5>0 then begin p6:=pos(' ',copy(text_before,p5,100)); if p6=0 then text_before:=copy(text_before,1,p5-1)
else text_before:=copy(text_before,1,p5-1)+copy(text_before,p6+p5,length(text_before)); end;

countnewdispose(s); 

p4:=pos('}',s);if p4>0 then s22:=copy(s,p4+1,length(s)) else s22:=s;
if (copy(s22,1,10)<>'procedure ')and(copy(s22,1,9)<>'function ') then begin
if en_rus then showmessage('Error. The program must begin with the word ''procedure'' or ''function''.') else
showmessage('Oшибкa. Текст программы должен начинаться со слова ''процедура'' или ''функция''.');
exit;
end;
if (varparam[1]<>'')then begin p:=pos(';type ',s);
if (p>0)or(copy(s,1,5)='type ')then begin
if en_rus then showmessage('Error. A type declaration is not allowed for this task.') else
showmessage('Oшибкa. Oписание типов в этой задаче не допускается.');
exit;
end end;

if func_proc=3 then begin s12:=s;delete_strings(s12); func_proc:=find_subroutine(s12); if func_proc=0 then exit; end;
if (text_after<>'')then begin s14:=first_name(s,false); p3:=pos('<name>', text_after);

if (text_before<>'')and(s14<>'!')then begin


s17:=checkvarparam(s);

if s17<>'' then begin
if en_rus then showmessage('Error. Parameters of the type '''+s17+''' must be var parameters.') else
showmessage('Oшибкa. Параметры типа '+s17+' должны быть var параметрами.');
exit; end end;

//showmessage('!Q!!  '+s14);
//showmessage(text_after);


if s14='!' then begin if en_rus then showmessage('Error in the subroutine definition.  Probably, a procedure was found instead of a function or vice versa.') else
showmessage('Ошибка в подпрограмме. Возможно, найдена процедура вместо функции или наоборот. '); exit end;
s:=copy(s,1,pos('}',s))+' '+text_before+' '+copy(s,pos('}',s)+1,length(s));
while p3>0 do begin
text_after:=copy(text_after,1, p3-1)+' '+s14+' '+copy(text_after, p3+6, length(text_after));p3:=pos('<name>', text_after);
end;
s:=s+text_after;delete_blanks(s);

//showmessage(text_after);

s13:=func_names(s);if length(s13)>1 then
add_parentheses(s,s13);
//showmessage('assds');

breaks(s,false);add_main_block:=0;exit end;

if func_proc=1 then s4:='function'else s4:='procedure';
if func_proc=1 then s5:='функция' else s5:='процедура';
b:=false;//true if we are within a string
s2:='';
repeat if s='' then break;
if s[1]='''' then b:=not b;

if not b and((copy(s,1,9)='function ')and(func_proc=2)and((s2='')or(not (s2[length(s2)]in alphadigit)))or(copy(s,1,10)='procedure ')and(func_proc=1)and((s2='')or(not (s2[length(s2)]in alphadigit))))then begin
add_main_block:=2; exit end;// A subrountine of a wrong type was found

if b or not(((copy(s,1,9)='function ')and(func_proc=1)and((s2='')or(not (s2[length(s2)]in alphadigit)))or(copy(s,1,10)='procedure ')and(func_proc=2)and((s2='')or(not (s2[length(s2)]in alphadigit)))))
then begin s2:=s2+s[1]; delete(s,1,1); continue end;
if not b and((copy(s,1,9)='function ')and(func_proc=1)and((s2='')or(not (s2[length(s2)]in alphadigit)))or(copy(s,1,10)='procedure ')and(func_proc=2)and((s2='')or(not (s2[length(s2)]in alphadigit))))then begin

if length(s2)>3 then begin s15:=s2; delete_strings(s15); s15:=' '+s15; p3:=pos('var ',s15);if (p3>0)and(not(s15[p3-1] in alphadigit))then begin add_main_block:=3; exit; end end;

s2:=s2+copy(s,1,9+byte(func_proc=2)); delete(s,1,9+byte(func_proc=2));
p:=pos('(',s); if func_proc=2 then p1:=pos(';',s) else p1:=pos(':',s);
if p=0 then p:=p1; if p>p1 then p:=p1;
if p=0 then begin if en_rus then showmessage('Error in the '+s4+' definition.'+chr(10)+s) else showmessage('Ошибка в описании '+s5+chr(10)+s);exit end;
name:=copy(s,1,p-1); delete(s,1,p-1); delete_blanks(s);
bb:=true; for pp:=1 to length(name) do
if not(name[pp]in alphadigit) then bb:=false;
if not bb or not((s[1]='(')or(s[1]=';')and(func_proc=2)or(s[1]=':')and(func_proc=1))then begin
if en_rus then showmessage('Error in the '+s4+' definition. A wrong symbol in its name or after it.'+chr(10)+name+' '+s) else showmessage('Ошибка в описании '+s5+'. Неверный символ в имени или после него. '+chr(10)+name+' '+s); exit end;
if s[1]='(' then
begin p:=pos(')',s);
if p=0 then begin if en_rus then showmessage('Error in the '+s4+' definition. '')'' is absent.'+chr(10)+name+' '+s) else showmessage('Ошибка в описании '+s5+'. Нет закрывающей скобки.'+chr(10)+name+' '+s); exit end;
realb:=(func_proc=1)and (copy(s,p+1,6)=':real;');
s6:=copy(s,1,p); delete(s,1,p);
s3:='';s7:=copy(s6,2,length(s6)-2);
repeat
delete_blanks(s7); p:=pos(';',s7); if p>0 then begin s8:=copy(s7,1,p); delete(s7,1,p); end else begin s8:=s7; s7:='' end;
delete_blanks(s7); if copy(s8,1,3)<>'var' then s8:='var '+s8; s3:=s3+s8;
until s7='';
s3:=s3+';';
s9:='';s7:=copy(s6,2,length(s6)-2);
repeat
p:=pos(';',s7); if p>0 then begin s8:=copy(s7,1,p); delete(s7,1,p); end else begin s8:=s7; s7:='' end;
delete_blanks(s7); if copy(s8,1,3)='var' then delete(s8,1,4);
p:=pos(':',s8);
if p=0 then begin if en_rus then showmessage('Error in the '+s4+' definition. A colon is absent. '+chr(10)+s8) else showmessage('Ошибка в описании '+s5+'. Нет двоеточия.'+chr(10)+s8);exit end;
delete(s8,p,1000);
s9:=s9+s8;if s7<>'' then s9:=s9+',';
until s7='' ;s9:='('+s9+')'
end
else
//it is the case if the function/procedure has no formal parameters
begin s3:=''; s9:='' end;
//All calls F where F is a function without formal parameters must be replaced by F().
if (length(s)>1) then begin
s13:=func_names(s2+name+s6+s);
//showmessage(s2+name+s6+s);
//showmessage(s13);
p:=1; b:=false;

add_parentheses(s,s13);
//repeat if s[p]='''' then b:=not b;
//if (not b)and(s[p]in alphadigit)and((p=1)or(not(s[p-1]in alphadigit)))then begin s14:=''; p2:=p; while (p2<length(s))and(s[p2]in alphadigit) do begin s14:=s14+s[p2];inc(p2); end;end else s14:='!';
//if (s14<>'!')and not b and(pos(' '+s14+' ',s13)>0)and(copy(s,p,length(s14)+1)<>s14+':')and(copy(s,p,length(s14)+1)<>s14+'(')
//then s:=copy(s,1,p+length(s14)-1)+'()'+copy(s,p+length(s14),10000);
//inc(p);
//if (p>36)and(p mod 20=0) then showmessage(inttostr(p)+' '+s+' '+s14);
//until p>=length(s);
end;
break;
end;
until s='';
if name=''then begin
add_main_block:=1;exit;
end;
if realb then s10:=':1:9'else s10:='';
if s9<>'' then s11:='readln'+s9+';' else s11:='';
if (func_proc=1)and(s9='')then s9:='()';
if func_proc=1 then s9:='begin '+s11+'writeln('+name+s9+s10+')end.'
else s9:='begin '+s11+' '+name+' '+s9+'end.';

//Only character output is allowed in the task 12-12-7.
if chosen_task='12_12-007' then begin
s15:=s2+name+s6+s+s3+s9;delete_strings(s15);
repeat
p:=pos('write(',s15);bb3:=false; if p=0 then begin bb3:=true; p:=pos('writeln(',s15); end;if p=0 then break;
if (p>1)and(not(s15[p-1] in alphadigit))then begin delete(s15,1,p+5);if bb3 then delete(s15,1,2);
p2:=0; p3:=0;
if s15<>'' then repeat inc(p2); if s15[p2]='(' then inc(p3); if s15[p2]=')' then dec(p3);
if p3=-1 then break; if (p3=0) and (s15[p2]=',')then begin add_main_block:=4; exit end;
until p2>=length(s15);
end else begin delete(s15,1,p+1); continue end;
if (copy(s15, 1, 4)<>'chr(') and (copy(s15,1,5)<>'char(')and(s15[1]<>'''')then begin add_main_block:=4; exit end;
until false;
end;
breaks(s2+name+s6+s+s3+s9,false);
add_main_block:=0;
end;


function readlnf(var f:t_f; var s:string):boolean;
var k:byte;
begin
s:=''; readlnf:=eof(f);
while not eof(f) do begin
if (i_c+2)mod 10 in s_n then begin read(f,k); if eof(f) then readlnf:=true; inc(i_c); continue end;
read(f,k);if eof(f) then readlnf:=true; i_c:=i_c+1; if (k<=30)and(k>=20)then exit else begin
{$R-}
k:=k-i_n-(i_c-2)mod 10; s:=s+chr(k);
{$R+}
end end;
//showmessage('!!!!!!!!!!!!!!!!!'+inttostr(i_n)+' '+inttostr(k mod 10)+'  '+inttostr(k div 10 mod 10));
end;

{function of reading a line from the encoded claim-file}
{the result - if the eof was reached}
{s - the output string}
function readlnf2(var f:t_f; var s:string):boolean;
var k:byte;
begin
s:=''; readlnf2:=eof(f);
while not eof(f) do begin
if (i_c_2+2)mod 10 in s_n_2 then begin read(f,k); if eof(f) then readlnf2:=true; inc(i_c_2); continue end;
read(f,k);if eof(f) then readlnf2:=true; i_c_2:=i_c_2+1; if (k<=30)and(k>=20)then exit else begin
{$R-}
k:=k-i_n_2-(i_c_2-2)mod 10; s:=s+chr(k);
{$R+}
end end;
//showmessage('!!!!!!!!!!!!!!!!!'+inttostr(i_n)+' '+inttostr(k mod 10)+'  '+inttostr(k div 10 mod 10));
end;

procedure determine_size(screenwidth, screenheight:integer);
var r:real;
begin r:=0.85;
_width:=1300; _height:=round(_width*0.652);
if _width>screenwidth*r then _width:=round(screenwidth*r);
if _height>screenheight*(r+r/30)then _height:=round(screenheight*r);
if _width>1.56*_height then _width:=round(_height*1.53);
if _height>0.7*_width then _height:=round(_width*0.67);
//showmessage(floattostr(_height*1.0));
//showmessage(floattostr(_width*1.0));
end;

function findglobal:boolean;
var s:string;//program
s2:string; i:integer;b:boolean;
p1,p2:integer;//level of procedures and begin-ends, respectively
begin p1:=0; p2:=0;findglobal:=false;b:=false;
join(s);delete_strings(s); s:=' '+s;
if length(s)<4 then exit;
i:=1;
repeat i:=i+1;
if (copy(s,i,4)='end.') and not(s[i-1] in alphadigit) then exit;
if (copy(s,i,4)='var ')and not(s[i-1] in alphadigit) and(p1=0)and(p2=0) then b:=true; //variable declaration at the level 0 was found
if (copy(s,i,10)='procedure ')and not(s[i-1] in alphadigit) then begin if b then begin findglobal:=true; exit end; inc(p1); end;
if (copy(s,i,9)='function ') and not(s[i-1] in alphadigit) then begin if b then begin findglobal:=true; exit end; inc(p1); end;
if (copy(s,i,6)='begin ') and not(s[i-1] in alphadigit) then inc(p2);
if (copy(s,i,5)='case ') and not(s[i-1] in alphadigit) then inc(p2);
if (copy(s,i,7)='record ') and not(s[i-1] in alphadigit) then inc(p2);
if ((copy(s,i,4)='end ')or (copy(s,i,4)='end;'))and not(s[i-1] in alphadigit) then begin dec(p2);if p2=0 then dec(p1); end;
until i>=length(s);
end;

//this procedure add key words if they are absent, for instance change const n=3; m=5 to const n=3; const m=5;
procedure insertwords(var s:string);
var s1:string;p:integer;
begin delete_blanks(s);
s1:=' ';
repeat
if ((copy(s,1,9)='function ')or (copy(s,1,10)='procedure '))and(not(s1[length(s1)]in alphadigit))then break;
if (copy(s,1,6)='const ')and(not(s1[length(s1)]in alphadigit))then begin p:=pos(';',s); if p=0 then exit;
s1:=s1+copy(s,1,p); delete(s,1,p); if (copy(s,1,6)<>'const ') and (copy(s,1,10)<>'procedure ') and (copy(s,1,9)<>'function ')and (copy(s,1,5)<>'type ')and(copy(s,1,4)<>'var ')then
s:='const '+s end else
if (copy(s,1,5)='type ')and(not(s1[length(s1)]in alphadigit))then begin p:=pos(';',s); if p=0 then exit;
s1:=s1+copy(s,1,p); delete(s,1,p); if (copy(s,1,6)<>'const ') and (copy(s,1,10)<>'procedure ') and (copy(s,1,9)<>'function ')and (copy(s,1,5)<>'type ')and(copy(s,1,4)<>'var ')then
s:='type '+s end else
if (copy(s,1,4)='var ')and(not(s1[length(s1)]in alphadigit))then begin p:=pos(';',s); if p=0 then exit;
s1:=s1+copy(s,1,p); delete(s,1,p); if (copy(s,1,6)<>'const ') and (copy(s,1,10)<>'procedure ') and (copy(s,1,9)<>'function ')and (copy(s,1,5)<>'type ')and(copy(s,1,4)<>'var ')then
s:='var '+s end else
begin s1:=s1+s[1]; delete(s,1,1) end; until s='';
s:=s1+s; delete_blanks(s);
end;

//Funciton returns 0 , if the forming was successful
function formsubroutine:integer;
var s8,s5,s6,s4,s44,s3:string; i4,i5,i3,i2,pp,j,i:integer;b3,b7,b2:boolean;
p7,p1,p2:integer;//level of procedures and begin-ends, respectively
var s:string;p6,p5,pp1:integer;
p3,p4:integer; //the current amount of types and constants
//These are names of types and constants, respectively
const maxtypes=35;
var strings,typ,con:array[1..maxtypes]of string;
begin p1:=0; p2:=0; p3:=0; p4:=0;b2:=false;b3:=false; formsubroutine:=1;

//showmessage('we are here');

join(s);//delete_strings(s);

//showmessage(s);

for p7:=1 to maxtypes do strings[p7]:='';
b7:=false;p7:=0; s8:=''; while s<>'' do begin if s[1]=chr(39) then begin b7:=not b7; if b7 and(p7<maxtypes) then inc(p7);
s8:=s8+s[1];if b7 then s8:=s8+chr(1) end else if b7 then begin if p7<maxtypes then strings[p7]:=strings[p7]+s[1] end else s8:=s8+s[1];
delete(s,1,1) end;
s:=s8;

if length(s)<4 then s:='Error';
//adding the words 'type' and 'const' and 'var' to the text of the program if they are not repeated before the second and next declarations
insertwords(s);
//showmessage(s);
s4:=first_name(s,pos('<name2>',text_after)>0); s:=s+' ';
if s4='!' then begin formsubroutine:=-1;
if en_rus then showmessage('Error. Wrong name of a function or function not found.') else
showmessage('Oшибкa. Неверное имя функции или функция не найдена.');exit end;

//showmessage(s4);

delete_blanks(s4); pp1:=pos(' ',s4); s44:=''; if pp1>0 then begin s44:=copy(s4,pp1+1,100);delete(s4,pp1,100); end;
i:=1;repeat inc(i);
if (copy(s,i,6)='const ')and not(s[i-1] in alphadigit) then begin p5:=pos('=',copy(s,i,length(s))); if p5=0 then exit; inc(p3); if p3<=maxtypes then con[p3]:=copy(s,i+6,p5-7)end;
if (copy(s,i,5)='type ')and not(s[i-1] in alphadigit) then begin p5:=pos('=',copy(s,i,length(s)));
if p5=0 then exit; inc(p4);if p4<=maxtypes then typ[p4]:=copy(s,i+5,p5-6)end;
if (copy(s,i,4)='var ')and not(s[i-1] in alphadigit) and(p1=0)and(p2=0) then begin
p5:=pos(';',copy(s,i,length(s))); if p5=0 then exit; delete(s,i,p5);dec(i); end; //all global variable declaration are removed
if (copy(s,i,10)='procedure ')and not(s[i-1] in alphadigit) then begin inc(p1);if not b2 then b2:=true else b3:=true; end;
if (copy(s,i,9)='function ') and not(s[i-1] in alphadigit) then begin inc(p1);if not b2 then b2:=true else b3:=true; end;
// the first subroutine was found (b2); the second subroutine was found if needed (b3)
if (copy(s,i,6)='begin ') and not(s[i-1] in alphadigit) then inc(p2);
if (copy(s,i,5)='case ') and not(s[i-1] in alphadigit) then inc(p2);
if (copy(s,i,7)='record ') and not(s[i-1] in alphadigit) then inc(p2);
if ((copy(s,i,4)='end ')or (copy(s,i,4)='end;'))and not(s[i-1] in alphadigit) then begin dec(p2);if p2=0 then dec(p1); end;
until (i>=length(s))or(p1=0)and(p2=0)and ((b2 and (s44=''))or (b3 and (s44<>'')));

//showmessage(s);

i2:=0; while varparam[1+i2]<>'' do begin i2:=i2+1; if length(varparam[i2])=2 then val(varparam[i2,2],i4,i5)else val(copy(varparam[i2],2,2),i4,i5);
if (i4>0)and(i4<maxtypes)then varparam[i2]:=typ[i4];end;


s5:=checkvarparam(s);
//showmessage(s5);
if s5<>'' then begin
if en_rus then showmessage('Error. Parameters of type '''+s5+''' must be var parameters.') else
showmessage('Oшибкa. Параметры типа '+s5+' должны быть var параметрами.');
formsubroutine:=-1; exit; end;

j:=i;

i:=0; while i<=maxtypes do begin inc(i); p6:=pos(chr(1),s); if p6>0 then begin delete(s,p6,1); insert(strings[i],s,p6); if p6<j then j:=j+length(strings[i])-1; end;end;

s3:=text_after;

//showmessage(s3);
repeat p6:=pos('<name>', s3);if p6>0 then s3:=copy(s3,1,p6-1)+s4+copy(s3,p6+6,length(s3)); until p6=0;
repeat p6:=pos('<name2>', s3);if p6>0 then s3:=copy(s3,1,p6-1)+s44+copy(s3,p6+7,length(s3)); until p6=0;

for i:=1 to p3 do
repeat p6:=pos('<c'+inttostr(i)+'>',s3);if p6>0 then s3:=copy(s3,1,p6-1)+con[i]+copy(s3,p6+4,length(s3)); until p6=0;
for i:=1 to p4 do
repeat p6:=pos('<t'+inttostr(i)+'>',s3);if p6>0 then s3:=copy(s3,1,p6-1)+typ[i]+copy(s3,p6+4,length(s3)); until p6=0;


breaks(copy(s,1,j+3)+s3,true);
formsubroutine:=0;
end;

procedure insert_blanks(var s:string);
const let=['a'..'z','[',']'];
var i:integer;
begin if length(s)<3 then exit;
i:=1; repeat
if (i>1)and(s[i] in ['+','-','*','/','='])and (s[i-1] in let)then
begin s:=copy(s,1,i-1)+' '+copy(s,i,1000) end;
if (i<length(s))and(s[i] in [':','+','-','*','/','='])and(s[i+1]in let)then
begin s:=copy(s,1,i)+' '+copy(s,i+1,1000);i:=i+1 end;
if (i<length(s))and(s[i] in [']',',',';'])and(s[i+1]in let)then
begin s:=copy(s,1,i)+' '+copy(s,i+1,1000);i:=i+1 end;
if (i>1)and(i<length(s)-1)and(copy(s,i,2)=':=')and (s[i-1] in let)and(s[i+2]in let)then
begin s:=copy(s,1,i-1)+' '+s[i]+s[i+1]+' '+copy(s,i+2,1000);i:=i+1 end;
i:=i+1 until i=length(s);
end;


function notblank(s:ansistring):boolean;
var i:integer;
begin notblank:=true;
for i:=1 to length(s) do if s[i]<>' ' then exit;
notblank:=false;
end;

//true if the string s1 occurs in the string s and false, otherwise. s1 may contain characters '*'; every '*' means any group of characters
//i - the position where we seek the occurrence.
function occur(s1,s:string; i:integer): boolean;
var p,k:integer;s2:string;asterisk1,asterisk2:boolean;
begin s:=' '+s+' '; inc(i); occur:=false;asterisk1:=false;asterisk2:=false;
k:=length(s1);if k=0 then exit;

//if (s1='=char')then
//showmessage(s1+'!!!'+s+'!!!'+inttostr(i));


repeat p:=pos('*',s1); if p<2 then begin s2:=s1; s1:=''; asterisk2:=false  end
else begin s2:=copy(s1,1, p-1); asterisk2:=true; s1:=copy(s1,p+1, 1000); end;
k:=length(s2);

//if (copy(s,i,k)=s2) then begin showmessage(s2+'!!!!!'+s1+'@@@'+s); showmessage(inttostr(i));;end;
//if asterisk1 then showmessage('CDSCDCDC');
//if asterisk2 then showmessage('CDSCDCDsssssC');end;


if asterisk1 then repeat
if not
((copy(s,i,k)=s2)and(not(s[i-1]in alphadigit)or asterisk1)
and (not(s[i+k]in alphadigit) or asterisk2)) then inc(i) else break;
if i>=length(s) then exit;
until false
else
if not
((copy(s,i,k)=s2)and(not(s[i-1]in alphadigit)or asterisk1)
and (not(s[i+k]in alphadigit) or asterisk2)) then exit;


asterisk1:=asterisk2
until s1='';

//showmessage('WE are here!');

//if s1='=char' then showmessage('!!!'+s1);
occur:=true;
end;


//ss - the checked strings, ns - how many occurences were found, n - the current amount of analyzed strings
procedure occurrences(ss:tss; var ns:tns; n:integer);
var f:textfile;k,l,i,j:integer;s,sL:string;b:boolean;
begin

//showmessage(ss[1]+'!'+ss[2]+'! '+ss[3]+'!'+ss[4]+'!'+ss[5]);

//showmessage(ss[4]);
for l:=1 to css do ns[l]:=0;
join(s);
i:=1;b:=false; //'b' shows whether we are within a string or outside it
//if ss[1]='const' then showmessage(inttostr(k1)+'!'+s+'!');
//showmessage(s);
while i<=length(s)do begin
if s[i]=chr(39)then b:=not b;
for j:=1 to n do begin
if not b and occur(ss[j],s,i)then ns[j]:=ns[j]+1;
//if not b and(copy(s,i,k)=ss[j])and((i=1)or not(s[i-1]in alphadigit))
//and((i+k-1=length(s))or not(s[i+k]in alphadigit)) then begin ns[j]:=ns[j]+1;
//end;
end;{of j}
i:=i+1
end;{of i}
end;{of procedure}

//The procedure deleting all superfluous blanks
procedure delete_blanks(var s:string);
var i:integer;b:boolean;
begin while (s<>'')and(s[1]=' ')do delete(s,1,1);
while (s<>'')and(s[length(s)]=' ')do delete(s,length(s),1);
i:=1;b:=false; repeat if (i<=length(s))and(s[i]='''') then begin b:=not b; inc(i); continue end; if (i<length(s))and (s[i]=' ') and(s[i+1]=' ')and not b then delete(s,i,1) else i:=i+1;until i>=length(s);
end;


function callsp:integer;
//We analyze only the case when a function or a procedure has at least one parameter - NOT! We analyze functions without parameters too
label 1; var f:textfile; s4,s2,s1,s:string; b2, b:boolean;p3,p2,p1,k,i2,j,i:integer;
//ss - words 'function' and 'procedure'
var ss1:array[1..2]of string;
begin ss1[1]:='function'; ss1[2]:='procedure';
assignfile(f, current_dir+'/tmp/temp1.pas'); reset(f); if (ioresult<>0)or eof(f) then
begin showmessage ('Fatal error. File ''temp1.pas'' not found'); close(f); ioresult; halt end;
i2:=0; s:=''; while not eof(f) do begin
readln(f,s2);s:=s+' '+s2 end; closefile(f);
delete_blanks(s);s4:=s;
i:=1;b2:=false; b:=false; //'b' shows whether we are within a string or outside it
while i<=length(s) do begin
if s[i]=chr(39)then b:=not b;
for j:=1 to 2 do begin
k:=length(ss1[j]);
if not b and(copy(s,i,k)=ss1[j])and((i=1)or not(s[i-1]in alphadigit))
and((i+k-1=length(s))or not(s[i+k]in alphadigit)) then begin
s:=copy(s,i+k,1000); delete_blanks(s);
if s='' then begin close(f); ioresult; callsp:=0; exit end;
p1:=pos('(',s);p2:=pos(':',s);p3:=pos(';',s);
if(p3>0)and(p2>0)and(p2>p3)then p2:=p3;if (p2=0)and(p3>0)then p2:=p3;


if (p1=0)and(p2=0)then begin callsp:=0; exit end;
//b2=false(true) - the function has parameters (does  not have any)
if(p1=0)and(p2<>0)then p1:=p2; if (p1>0)and(p2>0)and(p1>p2)then p1:=p2;
s1:=copy(s,1,p1-1);delete(s,1,p1);//Function or procedure name
delete_blanks(s1); goto 1;
end;//of when found a procedure or a function
end;//of j
i:=i+1
end;//of i
callsp:=-1; exit;
1:closefile(f);ioresult;
delete_blanks(s);p1:=0; //if not b2 then dec(p1);
repeat
p2:=pos(' :',s);
if p2>0 then delete(s,p2,1);
until p2=0;
repeat
p2:=pos(' (',s);
if p2>0 then delete(s,p2,1);
until p2=0;
repeat
p2:=pos(' ;',s);
if p2>0 then delete(s,p2,1);
until p2=0;
i:=1; b:=false;
delete_blanks(s1);p2:=length(s1);
while(i<length(s)) do begin
if s[i]='''' then b:=not b;
if b then begin inc(i); continue end;
if (copy(s,i,p2)=s1)and(length(s)>=i+p2)and(not(s[i+p2]in alphadigit))then inc(p1);
//if copy(s,i,p2)=s1 then showmessage(s+'  '+inttostr(i)+s[i]);
if copy(s,i,p2+1)=s1+':'then dec(p1);
inc(i);end;
//showmessage('!'+s+'!');
//showmessage('!'+s1+'!');
//showmessage(inttostr(p1));

closefile(f); ioresult; callsp:=p1;
end;

//procedure analyzing all claims to the program
procedure analysis_chapter_task(var aclaims:Tclaims;amount:integer; bbb:boolean);
var p1,m,j,p,i,k:integer;s2:string;
begin

//showmessage(inttostr(amount));
//showmessage(aclaims[1].s1);
for i:=1 to amount do
begin
aclaims[i].b:=false;s2:=aclaims[i].s1;j:=0;
if noclaims and bbb then exit;

//showmessage(inttostr(i)+' '+s2);

repeat while (s2<>'')and (s2[1]=' ') do delete(s2,1,1);while (s2<>'')and (s2[length(s2)]=' ') do delete(s2,length(s2),1);
if s2[1]='<' then begin p1:=pos('>', s2); if p1=0 then
p:=pos(' ',s2)
//begin showmessage('Fatal error in the file ''Claims.txt'': no closing angle bracket for an opening one.'); halt end
else p:=p1+1 end
else p:=pos(' ',s2);
//showmessage(s+'!!'+inttostr(p));
if (p=0)and((s2='')or(not(s2[1]in ['0'..'9'])))then begin showmessage('Fatal error in the file ''Claims.txt'' or ''Test.txt'' : no blank characters.'); halt end;
if not(s2[1] in ['0'..'9']) then begin inc(j); if s2[1]<>'<' then ss[j]:=copy(s2,1,p-1)else ss[j]:=copy(s2,2,p-3); delete(s2,1,p) end
else begin
if (length(s2)>1)and(not(s2[2] in ['+','-']))then begin
showmessage('Fatal error in the file ''Claims.txt'' or ''Test.txt'' : a wrong symbol '+s2[2]+' after the admitted amount of occurences of the words in the program.'); halt end;
break;
end;
until false;
//showmessage(inttostr(j)+ss[1]+'!'+ss[2]+'!'+ss[3]+'!'+ss[4]);
occurrences(ss, ns, j);
m:=0; for k:=1 to j do m:=m+ns[k];
val(s2[1],k,p);
//showmessage(s2+' '+inttostr(m)+' '+inttostr(k)+' '+inttostr(j)+' '+inttostr(ns[1])+' '+ss[1]+'!'+ss[2]+'!'+ss[3]+'!'+ss[4]);
if (length(s2)=1)and(k<>m) or (length(s2)>1)and(s2[2]='+')and(k>m)
 or (length(s2)>1)and(s2[2]='-')and(k<m)then aclaims[i].b:=true;{wrong amount of analyzing words in the program}
end;
end;


//procedure analyzing programs
//results:
//an_res[1]=1 - array were found.
//an_res[2]=1 - no constants for tasks connected with sequences of numbers or characters were found
//an_res[3]=1 - more than one loop or nested loops were found
//an_res[4]=1 - standard functions were found
//an_res[5]=1 - procedures or functions defined by user were found
//an_res[6]=1 - only one constant was found for a rectangular matrix
//an_res[7]=1 - strings were found
//an_res[8]=1 - no loops were found
//an_res[9]=1 - no constants for tasks connected with arrays were found
//an_res[10]=1 - no constants for tasks connected with square matrix were found

function analysis:t_an_res;

var k:integer;an_res:t_an_res;
begin for k:=1 to nres do an_res[k]:=0;

analysis_chapter_task(chapter_claims, chapter_claims_amount,true);
// it is analyzing of the claims to all progrmas of the chosen chapter
analysis_chapter_task(task_claims, task_claims_amount,false);

// it is analyzing of the claims to the chosen progrma

{case chosen_chapter of //it must be changed!!!!
1,2: begin ss[1]:='array'; ss[2]:='string'; ss[3]:='ansistring'; ss[4]:='shortstring'; occurences (ss,ns,4);
if ns[1]>0 then an_res[1]:=1;
if ns[2]+ns[3]+ns[4]>0 then an_res[7]:=1;
 end;
end;{of case}

{case chosen_chapter of
5,6,8,9,10: begin ss[1]:='repeat'; ss[2]:='while'; ss[3]:='for'; occurences (ss,ns,3);
if ns[1]+ns[2]+ns[3]=0 then an_res[8]:=1;
 end;
end;{of case}

//showmessage(chosen_task);

if (chosen_task='5_7-001')or (chosen_task='5_7-004')
or(chosen_task='5_14')or(chosen_task='5_13')
or (chosen_task='5_20-002')or (chosen_task='5_20-003')
or(chosen_task='5_20-004')or (chosen_task='5_2-005')
or(chosen_task='5_27')or (chosen_task='5_28')
or(chosen_task='5_29')or (chosen_task='5_30-002')
or(chosen_task='5_30-003')or (chosen_task='5_30-004')
or(chosen_task='5_40')or (chosen_task='5_44')
or(chosen_task='5_46')or (chosen_task='5_48')
or(chosen_task='5_53')
then begin ss[1]:='const'; occurrences(ss,ns,1);
if ns[1]=0 then an_res[2]:=1;end;

if (copy(chosen_task,1,4)='8_20')
or (chosen_task='8_27')
or (chosen_task='8_28')
or (copy(chosen_task,1,4)='8_29')
or (copy(chosen_task,1,4)='8_30')
or (copy(chosen_task,1,4)='8_31')
or (chosen_task='8_32')
or (chosen_task='8_35')
or (copy(chosen_task,1,4)='8_44')
or (chosen_task='8_46')
or (chosen_task='8_51')
or (chosen_task='8_52')
or (chosen_task='8_53')
or (chosen_task='8_54')
or (chosen_task='8_55')
//or (chosen_task='8_57')

then begin ss[1]:='const'; occurrences(ss,ns,1);
if ns[1]=0 then an_res[9]:=1;end;

if (copy(chosen_task,1,4)='5_20') or(chosen_task='5_27') then
begin ss[1]:='for';ss[2]:='while'; ss[3]:='repeat'; ss[4]:='goto'; ss[5]:='function'; ss[6]:='procedure';
ss[7]:='sin'; ss[8]:='cos'; ss[9]:='arctan'; ss[10]:='ln'; ss[11]:='exp'; ss[12]:='sqrt';occurrences(ss,ns,12);
if ns[1]+ns[2]+ns[3]+ns[4]>1 then an_res[3]:=1;
if ns[5]+ns[6]>0 then an_res[5]:=1;
if (ns[7]+ns[8]+ns[9]+ns[10]+ns[11]+ns[12]>0)and(chosen_task<>'5_27')then an_res[4]:=1;
end;

if (copy(chosen_task,1,4)='9_11')
or (copy(chosen_task,1,4)='9_13')
or (copy(chosen_task,1,4)='9_18')
or (copy(chosen_task,1,4)='9_19')
or (copy(chosen_task,1,4)='9_20')
or (copy(chosen_task,1,4)='9_21')
or (copy(chosen_task,1,4)='9_28')


//names of other tasks that require two constants for sizes of a rectangular matrices
//will be added here
then
begin ss[1]:='const';occurrences(ss,ns,1);
if ns[1]<2 then an_res[6]:=1
;//showmessage(chosen_task+inttostr(ns[1])+' '+inttostr(consts[1])+' '+inttostr(consts[2])+' '+inttostr(consts[3])+' '+inttostr(consts[4])+' ');
//showmessage(inttostr(consts_positions[1,1])+' '+inttostr(consts_positions[1,2])+inttostr(consts_positions[2,1])+inttostr(consts_positions[2,2]));
end;

if (copy(chosen_task,1,3)='9_5')
or (copy(chosen_task,1,4)='9_17')
or (copy(chosen_task,1,4)='9_25')
or (copy(chosen_task,1,4)='9_26')
or (copy(chosen_task,1,4)='9_27')
or (copy(chosen_task,1,4)='9_29')
or (copy(chosen_task,1,4)='9_30')
or (copy(chosen_task,1,4)='9_31')
or (copy(chosen_task,1,4)='9_33')

then
//names of other tasks that require one constant for size of a square matrices
//will be added here
begin ss[1]:='const';occurrences(ss,ns,1);
if ns[1]<1 then an_res[10]:=1
;//showmessage(chosen_task+inttostr(ns[1])+' '+inttostr(consts[1])+' '+inttostr(consts[2])+' '+inttostr(consts[3])+' '+inttostr(consts[4])+' ');
//showmessage(inttostr(consts_positions[1,1])+' '+inttostr(consts_positions[1,2])+inttostr(consts_positions[2,1])+inttostr(consts_positions[2,2]));
end;

if (copy(chosen_task,1,4)='9_18')or(chosen_task='9_19-002')or (chosen_task='9_20')
or (chosen_task='9_27') or (chosen_task='9_30')or (chosen_task='9_31')
then
begin ss[1]:='break'; ss[2]:='goto' ; ss[3]:='repeat'; ss[4]:='while'; occurrences (ss,ns, 4);
if ns[1]+ns[2]+ns[3]+ns[4]=0 then an_res[11]:=1; end;

{if chosen_chapter in [8,9] then
begin ss[1]:='array'; occurences (ss,ns,1);
if ns[1]=0 then an_res[12]:=1 end;
}
analysis:=an_res;

//if chosen_task='9_21' then
//begin ss[1]:='for';ss[2]:='while'; ss[3]:='repeat'; ss[4]:='goto';occurences(ss,ns,4);
//if ns[1]+ns[2]+ns[3]+ns[4]>2 then an_res[7]:=1;end;
analysis:=an_res;
end;{of the function}
//}}

//end;

procedure delete_temp;
var i:integer;
begin
deletefile(current_dir+'/tmp/temp1');
deletefile(current_dir+'/tmp/temp1.pas');
deletefile(current_dir+'/tmp/temp1.o');
deletefile(current_dir+'/tmp/temp2');
deletefile(current_dir+'/tmp/temp2.pas');
deletefile(current_dir+'/tmp/temp2.o');
deletefile(current_dir+'/tmp/temp3');
deletefile(current_dir+'/tmp/temp3.pas');
deletefile(current_dir+'/tmp/temp3.o');
deletefile(current_dir+'/tmp/temp4');
deletefile(current_dir+'/tmp/temp4.pas');
deletefile(current_dir+'/tmp/temp4.o');
deletefile(current_dir+'/tmp/temp5');
deletefile(current_dir+'/tmp/temp5.pas');
deletefile(current_dir+'/tmp/temp5.o');
deletefile(current_dir+'/tmp/temp0.sh');
deletefile(current_dir+'/tmp/temp10');
deletefile(current_dir+'/tmp/temp10.pas');
deletefile(current_dir+'/tmp/temp10.o');
deletefile(current_dir+'/tmp/temp20');
deletefile(current_dir+'/tmp/temp20.pas');
deletefile(current_dir+'/tmp/temp20.o');
deletefile(current_dir+'/tmp/temp30');
deletefile(current_dir+'/tmp/temp30.pas');
deletefile(current_dir+'/tmp/temp30.o');
deletefile(current_dir+'/tmp/temp40');
deletefile(current_dir+'/tmp/temp40.pas');
deletefile(current_dir+'/tmp/temp40.o');
deletefile(current_dir+'/tmp/temp50');
deletefile(current_dir+'/tmp/temp50.pas');
deletefile(current_dir+'/tmp/temp50.o');
deletefile(current_dir+'/tmp/temp00.sh');
deletefile(current_dir+'/tmp/result.txt');
for i:=1 to max_test_number do begin
deletefile(current_dir+'/tmp/iii'+inttostr(i));
deletefile(current_dir+'/tmp/ooo'+inttostr(i));
deletefile(current_dir+'/tmp/rrr'+inttostr(i));
deletefile(current_dir+'/tmp/temp0'+inttostr(i)+'.sh');
deletefile(current_dir+'/tmp/iiii'+inttostr(i));
deletefile(current_dir+'/tmp/oooo'+inttostr(i));
deletefile(current_dir+'/tmp/rrrr'+inttostr(i));
deletefile(current_dir+'/tmp/temp00'+inttostr(i)+'.sh');
end;end;
end.
