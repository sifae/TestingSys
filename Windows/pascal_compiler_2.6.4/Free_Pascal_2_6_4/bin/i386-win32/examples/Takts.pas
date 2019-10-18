program Takts;
   {$AsmMode Intel}             // Ассемблер MASM
   uses Crt,Windows;

   Const N=10000; K=20000;

   Var
     i,j,x,z: Longword; AT,T: Longword;

      function Tak:Longword;
{        var x: Longword; }
      begin
      asm
           rdtsc
           mov  Tak,eax
      end ['eax','edx'];
 //        Tak:=x
      end;

begin
   ClrScr; GotoXY(1,5); SetConsoleTitle ('Замер скорости работы цикла');


   AT:=10000000;
   for j:=1 to K do begin
       T:=Tak;
       for i:=1 to N do x:=x+1;
       T:=Tak-T;
       if T<AT then AT:=T // Минимум
   end;
   Writeln('N=10000. Число тактов=',AT);

   AT:=10000000;
   for j:=1 to K do begin
       T:=Tak;
       for i:=1 to N div 2 do begin x:=x+1; x:=x+1 end;
       T:=Tak-T;
       if T<AT then AT:=T // Минимум
   end;
   Writeln('N=2*5000. Число тактов=',AT);

   readln
end.
