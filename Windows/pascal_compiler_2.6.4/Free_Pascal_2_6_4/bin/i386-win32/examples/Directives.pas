program Directives;
   uses Crt,Windows,SysUtils;

   {$Assertions ON}             // ������� �ଠ��� �⢥ত����
   {$AsmMode Intel}             // ��ᥬ���� MASM
   {$GOTO+}                     // {$GOTO-} - label L; Goto L; ����� !!!
   {$R+}
   {$I+} //    {=$IOChecks+}
   {$Calling stdcall}
// �� 㬮�砭�� {$B+} (᮪�饭��� ���᫥��� boolean) Shot-cut Evaluated
   {$B+}
   {$COperators ON}             // ������� C� ������� �������
// �������� ��� packed ��६�����, ���� ������ ��।����� �� var
   {$BitPacking ON}
   {$InLine ON}
   {$PackEnum 1}                // 1 ���� ��� ⨯� Week, ���� 4
   {$TypedAddress ON}
   {$S+}                        // Stack checking, default OFF
// {$X+}={$EXTENDEDSYNTAX ON}
// + �� 㬮�砭��; �맮� ���������������� �㭪権 ��� ��楤��
   {$EXTENDEDSYNTAX OFF}        // �� ࠡ�⠥� !
// {$J-} ����� ������������ ��� ⨯���஢����� ����⠭�
   {$J-} {=$WriteableConst OFF - ����� Const N:integer=100;}
   {$Macro ON}                  // �� 㬮�砭�� OFF
   {V+} {=$VarStringChecks ON}  // ��ண�� �஢�ઠ ⨯�� ��ப �� ��뫪�
   {$H-} {=$LongString OFF �� 㬮�砭��, ⮣�� String=ShortString,
           �᫨ $H+ ⮣�� String=AnsiString }
   {$T+} {=$TypedAddress ON}    // var x:Tip; @x �����. ^Tip, ���� Pointer
   {MaxStackSize 4096}          // <= $7FFFFFFFF
// {$M 4096,4996}               // StackSize,HeapSize

   Label L;

   var   Arr:array[1..100] of byte;
   Const N=10; M=10; &const=100; // �ᯮ�짮����� �㦥����� ����� !
         NBit=%10110011;         // ����筮� �᫮
         R:real=0;               // {$J-} - ����� R:=1

// ����⠭�� �६��� �������樨
         N1=2*N+1; N2=sqr(N1)+abs(trunc(sin(N1)));
         N3=low(Arr); N4=high(Arr);
         S1='A'; S2=S1+#10+^A;
// ����⠭�� �६��� �믮������
//       N5=pos('B','ABCD'); �訡�� !

   type Week=(Monday=1, { ⥯��� ����� succ,pred,array[Week] ! }
           Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday=0);
           { for w:=Monday to Sunday do; ���⮩ 横� ! }

   var
{ AnsiString ���.��ப� � ���,-4=�����,-8=�᫮ ��뫮� }
     AnsiStr: AnsiString='��ப� ⨯� AnsiString';
     sCap: pChar='���������'; { ��ப� � ��� ��� � C }
     pTxt: Pchar;
     wTxt: WideString='��ப� Unicode';
     fmt: string='dd.mm.yyyy hh:mm:ss';
     Color:(cRed,cGreen,cBlue);

// �ࠢ����� �� ࠢ���⢮ ��६����� ��� ⨯�
   function Equal(var x,y; Len:Longword):boolean;
     type Bytes=array [0..MaxLongint-1] of byte;
     var i:Longword;
   begin i:=1;
     while (i<Len) and (Bytes(x)[i]=Bytes(y)[i]) do inc(i);
     Equal:=i=Len;
//   i:=LocalVar - ��� LocalVar ����� �� ����� !
   end;


// ������� ����� begin ... end. �� �� ����� ���� �� ⥪��� !
   var LocalVar: Longint;
       LocalChar: char;


begin
   ClrScr;

// {$EXTENDEDSYNTAX OFF} �� ࠡ�⠥� !
   { bool3:= } Equal(LocalVar,LocalVar,4);

   SetConsoleTitle ('��४⨢� ���������');
   GotoXY(WindMaxX div 2,WindMaxY div 2);
   Writeln('WindMaxX=',WindMaxX,' WindMaxY=',WindMaxY);
   GotoXY(1,3);
   Writeln('high(Arr)=',N4);

   readln;

end.