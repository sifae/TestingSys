var m1,m2,m3,m4,m5,m6,n1,n2,n3:integer;
begin 
//m3 - max,  m2 - the second, m1 - the third; n3, n2 and n1 - the number of their occurences in the sequence
n3:=0; n2:=0; n1:=0; m3:=-maxint; m2:=-maxint; m1:=-maxint; 
readln(m3); n3:=1; if m3=0 then begin write(0);halt end; 
readln(m2); if m2=0 then begin write(0);halt end; 
if m2<m3 then n2:=1 else if m2=m3 then begin m2:=-maxint; n3:=2; end else begin n2:=1; m4:=m2; m2:=m3; m3:=m4 end;
if n3=2 then begin readln(m2); if m2=0 then begin write(0);halt end; 
if m2<m3 then n2:=1 else if m2=m3 then begin m2:=-maxint; n3:=3; end else begin n2:=2; n3:=1; m4:=m2; m2:=m3; m3:=m4 end end;
readln(m1); if m1=0 then begin write(0);halt end; 
if n3=1 then begin readln(m1); 
if m1>m3 then begin m1:=m2; m2:=m3; m3:=m1; n1:=1 end else
if m1=m3 then begin n3:=n3+1; m1:=0 end else
if m1<m2 then n1:=1 else if m1=m1 then begin n1:=0; m1:=0; n2:=2 end 
else {between} begin n1:=1; m4:=m2; m2:=m1; m1:=m4 end; END;
repeat readln(m4); 
if m4=0 then break; 
if m4>m3 then begin m1:=m2; m2:=m3; m3:=m4; n1:=n2; n2:=n3; n3:=1 end else
if m4=m3 then n3:=n3+1 else
if m4>m2 then begin m1:=m2; n1:=n2; n2:=1; m2:=m4 end else  
if m4=m2 then n2:=n2+1 else
if m4>m1 then begin n1:=1; m1:=m4 end else
if m4=m1 then n1:=n1+1;
until false; 
m5:=0; 
for m6:=1 to n3 do begin m5:=m5+1; IF M5<=3 THEN writeln(m3); end;
if m5=3 then halt; 
for m6:=1 to n2 do begin m5:=m5+1; if m5<=3 then writeln(m2); end;
if m5=3 then halt; 
for m6:=1 to n1 do begin m5:=m5+1; if m5<=3 then writeln(m1); end;
end.