program p1;
   uses Crt,Windows;

   {$AsmMode Intel}             // ��ᥬ���� MASM
   {$GOTO+}                     // {$GOTO-} - label L; Goto L; ����� !!!
   {$Calling stdcall}
   {$InLine ON}                 // ����� INLINE ��楤���, ��� ४��ᨨ !
// {$X+}={$EXTENDEDSYNTAX ON}
// + �� 㬮�砭��; �맮� ���������������� �㭪権 ��� ��楤��
   {$X-}                        // �� ࠡ�⠥� !

   {V+} {=$VarStringChecks ON}  // ��ண�� �஢�ઠ ⨯�� ��ப �� ��뫪�

   Const N=10; M=10;

   Type
     Week=(Monday=1, { ⥯��� ����� succ,pred,array[Week] ! }
           Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday=0);
           { for w:=Monday to Sunday do; ���⮩ 横� ! }
     Mas=array[1..N] of Longint;
     Arr=array of Longint;  // �������� ���ᨢ, ��稭�� � ���!!
     proc=procedure (x:Longint; y:char); // ��楤��� ⨯
     Mat=array of array of Longint;
     pMas=^Mas;
     Comp=record re:double; im:double end;

   {$L a2asm.obj} // ����� a2asm.asm �� ��ᥬ����

   var
     xasm2: Longint{;} external name '_xasm2';
//   xasm2 �� a2.asm ����� ��� ������� �����: xasm2 � _xasm2

     xp1: Longint=$123ABC; public {=export} name '_xp1';
//   xp1 ����� ��� ������� �����: _XP1 � _xp1

     x: Longword; y: Longint;
     xMas: Mas=(1,2,3,4,5,6,7,8,9,10); yMas: Mas;
     zMas: array[1..N] of Longint;    // ������୮-ᮢ���⨢� ⨯ � xMas � yMas
     zMas1: array[1..M] of Longint;   // ������୮-ᮢ���⨢� ⨯ � xMas � yMas
     zMas2: array[0..N-1] of Longint; // ������୮-��ᮢ���⨢� ⨯ !!!
     xArr: Arr; // ������������ ������ ���ᨢ
     Matrix: Mat;

   Function UpCaseRus(s: String): String; Forward;

// ��ॣ�㧪� ����樨 + ��� ���ᨢ�� ⨯� Mas
// constref ��������� ��।��� �� ��뫪� � ������ ��楤���
// �� stdcall const=constref ��� ������� ��ࠬ��஢
   Operator + (const x,y: Mas) z: Mas;
      var i: Longint;
   begin
      for i:=Low(x) to High(x) do z[i]:=x[i]+y[i]
   end;

// ��ॣ�㧪� <> ��� ���ᨢ�� ⨯� Mas
   Operator <> (const x,y: Mas) z: Boolean;
      var i: Longint;
   begin {z:=false;}
      for i:=Low(x) to High(x) do
          if x[i]<>y[i] then {z:=true} exit(true);
      exit(false)
   end;

// ��ॣ�㧪� 㭠୮�� - (�����) ��� ���ᨢ�� ⨯� Mas
   Operator - (const x: Mas) z: Mas;
      var i: Longint;
   begin
      for i:=Low(x) to High(x) do z[i]:=-x[i]
   end;

   Procedure P(const x); InLine;
   begin
      WriteLn('��।��� ���祭�� x=',integer(x))
   end;

{  ���쪮 � Delpfi! : ���祭�� ��ࠬ��� �� 㬮�砭��, ��ࠬ��� out
   Function Sum(out x: Longint; y: Longint=1): Longint;
   begin
      Sum:=x+y;
   end;
}

   {$L a2asm.obj} // ����� a2asm.asm �� ��ᥬ����
   Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External name '_Q@0';
(* Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External 'Name';
   ⮣�� Q ����� � ���������� Name.dll
*)
(* Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External;
   ⮣�� ���� � ������ Q d ������⥪� MyLib.dll {$LinkLib MyLib}
*)
   Procedure QReg(var x,y: Longint; p,g: Longint){;} pascal{;} Register{;} External;
(* ��।�� eax:=@x; edx:=@y; ecx:=p; push g;
*)

   Procedure R(var t:Longint); cdecl;
      var temp: byte;
   begin
      asm
         mov ebx,t
         mov eax,[ebx]
         add [ebx],eax
         mov x,esp
         push eax
         mov [ebx],esp
         pop eax
      end ['ebx','eax']; // �� ॣ����� �ᯮ���� ���� ASM,
// �� �室� �㤥� push ebx; push eax; �� ��室� pop ebx; pop eax
      temp:=1
   end;

   Function F(x: Longint):Mas;
{  LocalName_GlobalValue - ������쭠� ���������� (�᫨ {$J+})
   � ��������� ������! �.�. �㤥� ����⢮���� �� ����୮� �室�
}
      const LocalName_GlobalValue: Longint=-1;

      var i: Longint;
   begin
      for i:=low(Mas) to high(Mas) do F[i]:=-i
   end;

// ��ॣ�㧪� �㭪樨 F
   Function F(x: Char): Longint; { Overload; - �᪠�� ��� F ����� � Units }
      var i: Longint;
   begin
      F:=1; i:=F;
      if F<4 then F:=1;
      exit (0) // �� F:=0; exit
   end;

   Function abs(const x: Mas):Mas; // ��ॣ�㧪� ����������� �㭪樨 abs
      var i: Longword;
   begin
      for i:=low(x) to high(x) do abs[i]:=system.abs(x[i])
   end;

// Procedure pArr(var x: array of Mas);     // ��ࠬ��� - ����ࠪ�� ���ᨢ
   Procedure pArr(var x: array of Longint); // ��ࠬ��� - ����ࠪ�� ���ᨢ
      var i: Longint;
   begin
// ��� ������� ���ᨢ� low(x)=0, high(x)=-1 !
      for i:=low(x) to high(x) do x[i]:=i;
      WriteLn('x[high(x)]=',x[high(x)],' low(x)=',low(x),
              ' high(x)=',high(x))           // ��稭�� � x[0] !!
   end;

   Function SumMas(var x: array of Longint): Longint;
      var i: Longint;
   begin
      SumMas:=0; // � �⫨稥 �� ��������� SumMas �����쭠� ����������
      Write('low(yMas)=',low(x),' high(yMas)=',high(x),
            ' @���ᨢ�=',Longword(@x[low(x)]));
      for i:=low(x) to high(x) do SumMas:=SumMas+x[i];
   end;

   Procedure pMat(var x: Mat);
   begin
      Write('high(x)=',high(x),' high(x[1])=',high(x[1]));
      Writeln(' Length(x)=',Length(x),' Length(x[1])=',Length(x[1]))
   end;

   Procedure OutHex(x: Longword); [public, alias: '_OutHex'];
   // OutHex ����� ��� ������� �����: OutHex � _OutHex
   begin
      Writeln(HexStr{IntToHex}(x,2*Sizeof(x)),'h')
   end;

   Function UpCaseRus(s: String):String;
      const r1='������񦧨�����������������������abcdehghijklmnopqrstuvwxyz';
            r2='���������������������������������ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var i,j:byte;
   begin
      UpCaseRus:=s;
      for i:=1 to Length(s) do begin j:=Pos(s[i],r1);
          if j>0 then UpCaseRus[i]:=r2[j]
      end;
   end;

// �ࠢ����� �� ࠢ���⢮ ��६����� ��� ⨯�
   function Equal(const x,y; Len: Longword):boolean;
     type Bytes=array [0..MaxLongint-1] of byte;
     var i: Longword;
// ����� a: array[0..0] of byte absolute x;
//       b: array[0..0] of byte absolute y;
     begin i:=1;
        while (i<Len) and (Bytes(x)[i]=Bytes(y)[i]) do inc(i);
//{$R-} while (i<Len) and (a[i]=b[i]) do inc(i); {$R+}
        Equal := i=Len;
//      i:=LocalVar - ��� LocalVar ����� �� ����� !
   end;

   {$COperators ON}  // ������� ������� C� ������� �������

// ��ॣ�㧪� ����樨 x**y ��� �������� ������ x+=y ��� integer
   Operator ** (var x: integer; y: integer) z:integer;
   begin
      x+=y; z:=x
   end;

// �㭪�� ��� ��ࠬ��஢
   function GetChar:char; // �맮� var c: char; c:=Getchar
   begin
     Read(Getchar);       // Getchar - �����쭠� ��६�����
     if Getchar=#0 then   // Getchar - �����쭠� ��६�����
       GetChar:=Getchar() // �����ᨢ�� �맮� Getchar
   end;

// ���ᠭ��� ���� ��� �� ����� ���� �� ⥪��� !
   label Lif, Lwhile, LBegin, LFor;
   var LocalVar: Longint;
       i: Longint; j: integer; b: boolean; cc: char;
begin
   ClrScr; GotoXY(1,2);
   SetConsoleTitle ('��楤��� � �㭪樨');

// �ਬ�� ����� GOTO � ᫮���� �������
   goto Lif;           // � ᮦ������ !
   if i=0 then Lif: i:=1;
   i:=0; goto Lwhile;  // � ᮦ������ !
   while i<>0 do begin
      Lwhile: i:=0
   end;
   goto LBegin;         // � ᮦ������ !
   begin
      i:=0; LBegin: i:=1; i:=2
   end;
   goto LFor;           // � ᮦ������ !
   for i:=1 to 10 do LFor: j:=1;

   { b:= } Equal(x,x,4); // {$EXTENDEDSYNTAX OFF} �� ࠡ�⠥� !

   j:=0; while j**2 {j+=2} <= 8 do Write(j:4); Writeln;

   Writeln('UpCaseRus("dddd ����")=',UpCaseRus('dddd ����'),#13#10);
   Write('��楤�� ��ᥬ���� Q(x,y) ��뢠�� OutHex(y=43),OutHex(xp1) = ');
   Q(y,43); Writeln('y �� Q=',y);
   R(y); Writeln('ebp=',x,' y �� R=',y);
   OutHex(x); OutHex(y);

   Writeln('F(''1'')[F:=1; exit(0)] =',F('1'):3,#13,#10);
   yMas:=xMas; Writeln('yMas<>xMas = ',yMas<>xMas);
   x:=SumMas(yMas); WriteLn(' SumMas(yMas)=',x);

// ����� ������� �࠭�� ��������� ���ᨢ� !
   x:=SumMas(yMas[1..5]);  WriteLn(' SumMas(yMas[1..5])=',x);
   x:=SumMas(yMas[6..10]); WriteLn(' SumMas(yMas[6..10])=',x);
// x:=SumMas(yMas[1,5,10]); ������ ��������� ��-�� ��-⮢

   yMas:=F(1); Write('yMas='); for y in yMas do Write(y:4); Writeln;
   yMas:=abs(yMas+yMas); WriteLn('yMas:=abs(yMas+yMas): yMas[5]=',yMas[5]);
   zMas:=xMas; Write('zMas='); for y in zMas do Write(y:4); Writeln;
   zMas1:=zMas;
   pArr(zMas); Write('zMas='); for y in zMas do Write(y:4); Writeln;
   SetLength(xArr,N);   // ��஦����� xArr[0..N-1] of Longint;
   pArr(xArr);
   Write('xArr='); for y in xArr do Write(y:4); Writeln;
   x:=SumMas(xArr[0..4]);  WriteLn(' SumMas(xArr[0..4])=',x);

   Writeln;
   pArr(xArr[1..5]); pArr(xArr[6..10]);
   xArr:=nil; // ����⮦���� ���ᨢ�
   SetLength(Matrix,5,10); //Mat[0..9,0..4] of Longint;
   pMat(Matrix); SetLength(Matrix,3,7); pMat(Matrix);
   WriteLn('������ ���ᥭ��� �� a2asm.asm xasm2=',xasm2);

   readln;

end.