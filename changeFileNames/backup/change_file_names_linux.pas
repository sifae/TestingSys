unit change_file_names_linux;

interface

uses
  LCLIntf, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{$I-}
procedure TForm1.FormCreate(Sender: TObject);
begin
  caption:='Change file names ';
  button1.width:=300;
  button2.width:=300;
  button2.left:=button1.Left+400;
  button1.caption:='From Cyrillic letters to Numbers ';
  button2.caption:='From Numbers to Cyrillic letters  ';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
s:string;searchrec:Tsearchrec;j,i,m,k,l:integer;
var
s2,s1:string;b:boolean;g,f:textfile;
begin
  showmessage ('The program is blocked');exit;
  s1:='�������������������������';
  k:=findfirst ('texts\*.*',faanyfile,searchrec);//k=0 - success, k<>0 - failure
  //showmessage(inttostr(k));
  if k=0 then repeat
  s:=searchrec.name;m:=0;i:=1;
  repeat l:=pos('_'+s1[i]+'_', s);
    //showmessage(s+'!'+'_'+s1[i]+'_'+inttostr(l));
    if l>0 then begin
      m:=i; break
    end;
    inc(i); until i>length(s1);
if m<>0 then begin if m<10 then s2:=copy(s,1,l-1)+'-00'+inttostr(m)+'_'+copy(s,l+3,100)else
s2:=copy(s,1,l-1)+'-0'+inttostr(m)+'_'+copy(s,l+3,100);
b:=renamefile ('texts\'+s,'texts\'+s2);
if not b then showmessage('Failure');
end;
k:=findnext(searchrec);
until k<>0;
findclose(searchrec);
for i:=1 to 20 do begin
assignfile(f, 'tests_chapter_'+inttostr(i)+'.txt');
reset(f); if ioresult<>0 then continue;
assignfile(g,'temp00');rewrite(g);
repeat readln(f,s2); if (s2='')then continue;
if (s2[1]<>'_')then begin writeln(g,s2); continue end;
l:=0;for j:=1 to length(s1) do begin l:=pos(s1[j],s2);
if l<>0 then break;end;
if l=0 then begin writeln(g,s2); continue end;
if j<10 then s2:=copy(s2,1,l-2)+'-00'+inttostr(j)+copy(s2,l+1,100)
else s2:=copy(s2,1,l-2)+'-0'+inttostr(j)+copy(s2,l+1,100);
writeln(g,s2)until eof(f);
closefile(f); erase(f); closefile(g); rename(g,'tests_chapter_'+inttostr(i)+'.txt');

end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s:string;searchrec:Tsearchrec;m,j,i,k,l:integer;
var s4,s3,s2,s1:string;b:boolean;f,g:textfile;
begin
showmessage ('The program is blocked');exit;

s1:='�������������������������';
k:=findfirst ('texts\*.*',faanyfile,searchrec);//k=0 - success, k<>0 - failure
if k=0 then repeat
s:=searchrec.name;m:=0; i:=1;
repeat
if i<10 then s3:='-00'+inttostr(i)+'_e';
if i<10 then s4:='-00'+inttostr(i)+'_r';
if i>=10 then s3:='-0'+inttostr(i)+'_e';
if i>=10 then s4:='-0'+inttostr(i)+'_r';

l:=pos(s3, s);if l=0 then l:=pos(s4,s);
//showmessage(s+'!'+'_'+s1[i]+'_'+inttostr(l));
if l>0 then begin
m:=i; break end;
inc(i); until i>length(s1);
if m<>0 then begin
s2:=copy(s,1,l-1)+'_'+s1[m]+'_'; if pos(s3,s)>0 then s2:=s2+'e.rtf' else s2:=s2+'r.rtf';
b:=renamefile ('texts\'+s,'texts\'+s2);
if not b then showmessage('Failure');
end;

k:=findnext(searchrec);
until k<>0;
findclose(searchrec);
for i:=1 to 20 do begin
assignfile(f, 'tests_chapter_'+inttostr(i)+'.txt');
reset(f); if ioresult<>0 then continue;
assignfile(g,'temp00');rewrite(g);
repeat readln(f,s2); if (s2='')then continue;
if (s2[1]<>'_')then begin writeln(g,s2); continue end;
l:=0;for j:=1 to length(s1) do begin
if j<10 then s3:='-00'+inttostr(j);
if j>=10 then s3:='-0'+inttostr(j);
l:=pos(s3,s2);
if l<>0 then break;end;
if l=0 then begin writeln(g,s2); continue end;
s2:=copy(s2,1,l-1)+'_'+s1[j]+copy(s2,l+4,100);
writeln(g,s2)until eof(f);
closefile(f); erase(f); closefile(g); rename(g,'tests_chapter_'+inttostr(i)+'.txt');
end;
end;
end.
