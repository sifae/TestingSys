program Files;
   uses Crt,Windows;

   Const N=10; M=10;

   Type
     Mas=array[1..N] of Longint;

   Var
     x: Longword; y: Longint;
     x1,x2,x3,x4: integer;
     fi:File of integer; f1:Text; f2:TextFile; f: file;

begin
   ClrScr; GotoXY(1,5); SetConsoleTitle ('����� � 䠩����');
   Writeln(output); Readln(input);

   Assign(fi,'programs\f.int'); ReWrite(fi);
   x1:=1; x2:=2; x3:=3; x4:=-2;
   Write(fi,x1,x2,x3);
   Writeln('FilePos=',FilePos(fi),' FileSize=',FileSize(fi),#13);

   Reset(fi); Writeln('FilePos=',FilePos(fi),' FileSize=',FileSize(fi));
   Seek(fi,1); // �� ������ ������
// x1:=fi^;    �� ࠡ�⠥�
   Read(fi,x1); Writeln('������ �᫮ � 䠩��=',x1); close(fi);
// FileMode=2, Reset ���뢠�� 䠩� �� ������ � ������
// FileMode=0, Reset ���뢠�� 䠩� ⮫쪮 �� ������
   Writeln('FileMode=',FileMode);
   Reset(fi); Seek(fi,1); // �� ������ ������
   Read(fi,x1); Writeln('������ �᫮ � 䠩��=',x1);
   Seek(fi,1); Write(fi,x4); Seek(fi,1);
   Read(fi,x1); Writeln('������ �᫮ � 䠩��=',x1);

   FileMode:=0; Reset(fi); Seek(fi,1); // �� ������ ������
{$I-}
   Write(fi,x4); x:=IOResult;
   Writeln('FileMode=',FileMode,' IOResult=',x);
   Writeln('FileMode=0, �� Reset, ������ ����� � �������������� 䠩�');

   readln
end.
