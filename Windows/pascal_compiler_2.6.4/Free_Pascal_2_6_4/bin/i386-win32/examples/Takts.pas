program Takts;
   {$AsmMode Intel}             // ��ᥬ���� MASM
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
   ClrScr; GotoXY(1,5); SetConsoleTitle ('����� ᪮��� ࠡ��� 横��');


   AT:=10000000;
   for j:=1 to K do begin
       T:=Tak;
       for i:=1 to N do x:=x+1;
       T:=Tak-T;
       if T<AT then AT:=T // ������
   end;
   Writeln('N=10000. ��᫮ ⠪⮢=',AT);

   AT:=10000000;
   for j:=1 to K do begin
       T:=Tak;
       for i:=1 to N div 2 do begin x:=x+1; x:=x+1 end;
       T:=Tak-T;
       if T<AT then AT:=T // ������
   end;
   Writeln('N=2*5000. ��᫮ ⠪⮢=',AT);

   readln
end.
