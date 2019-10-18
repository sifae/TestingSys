{$I+,R+}
var n,s:integer;
begin n:=0;read(s);
repeat n:=n+1;s:=s div 10;until s=0;writeln(n);end.
