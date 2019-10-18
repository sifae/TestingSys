program Heap;
   uses (* HeapTrc {����஫� ���, �ᥣ�� ��ࢠ� !} ,*)
        Crt,Windows;

   {$Calling stdcall}
   {$S+}                        // Stack checking, default OFF
   {MaxStackSize 4096}          // <= $7FFFFFFFF
// {$M 4096,4996}               // StackSize,HeapSize

   Const N=10; M=4000;

   Type
     Mas=array[1..N] of Longint;
     Arr=array of Longint;  // �������� ���ᨢ, ��稭�� � ���!!
     Mat=array of array of Longint;
     pMas=^Mas;

   var
     x: Longword; GetHeap: Longword; i: word;
     xMas: Mas=(1,2,3,4,5,6,7,8,9,10);
     xArr,yArr: Arr; // ������������ ������ ���ᨢ
     ptr: Pointer; LPtr:^Longint;
     Matrix: Mat;
     z: pMas; pLong: ^Longint;
     Ansi: AnsiString;

   Procedure pArr(var x:array of Longint); // ��ࠬ��� - ����ࠪ�� ���ᨢ
      var i:Longint;
   begin
      for i:=0 to high(x) do x[i]:=-3*i;
//    WriteLn('x[5]=',x[5],' high(x)=',high(x)) // ��稭�� � x[0] !!
   end;

   Procedure pMat(var x:Mat);
   begin
      Write('high(x)=',high(x),' high(x[1])=',high(x[1]));
      Writeln(' Length(x)=',Length(x),' Length(x[1])=',Length(x[1]))
   end;

   Procedure PrintHeap(x: String);
   begin
     Writeln(x);
     with getHeapStatus do
       WriteLn({'TotalAddrSpace=',TotalAddrSpace:6,}
               '     TotalAllocated=',TotalAllocated:6
               {,' TotalFree=',TotalFree:6})
   end;

begin {$R+}
   ClrScr; gotoXY(1,3);
   SetConsoleTitle ('����� � ��祩');
   ReturnNilIfGrowHeapFails:=true;
{  New,GetMem,ReallocMem �������� nil �� �訡��,
   ���� RunTimeError
}

// WriteLn('��砫� ���=',Heaporg,' ����� ���=',heapend); �� ࠡ�⠥�
// Mark(ptr); �� ࠡ�⠥�
   GetHeap:=getHeapStatus.TotalAllocated;
   with getHeapStatus do
     WriteLn('TotalAddrSpace=',TotalAddrSpace:6,
             ' TotalAllocated=',TotalAllocated:6,' TotalFree=',TotalFree:6);
   WriteLn;

   PrintHeap('��砫� ࠡ��� � ��祩');
   SetLength(xArr,M);     // ��஦����� xArr[0..M-1] of Longint;
   PrintHeap('��஦����� xArr[0..3999] of Longint = 16000 ����');
   pArr(xArr); yArr:=xArr; xArr:=nil; // ����⮦���� ���ᨢ� xArr
   PrintHeap('����⮦���� xArr[0..3999] of Longint, ������ �� �᢮���������!');
// pArr(yArr);  // ������, yArr=xArr ���������
   x:=Longword(yArr); yArr:=nil; // � ᮦ������, xArr ������������ !
   PrintHeap('����⮦���� yArr=xArr of Longint, ������ �᢮���������!');
// xArr:=Arr(x); ������! xArr 㪠�뢠�� �� 㦥 �� ������������ ���ᨢ 
// WriteLn('xArr[5]=',xArr[5]); Run Time Error 204, xArr 㦥 �� ���������
// xArr:=nil; ������! Run Time Error 204, xArr 㦥 �� ��������� 
   new(LPtr); PrintHeap('��஦����� Longint, 16 (�����.����) ���� !');
   dispose(LPtr); PrintHeap('����⮦���� Longint');
   SetLength(Matrix,10,20); //Matrix[0..9,0..19] of Longint;
   PrintHeap('��஦����� Matrix[0..9,0..19] of Longint = 800 ����');
   pMat(Matrix); SetLength(Matrix,5,10); pMat(Matrix);
   PrintHeap('��������� ࠧ��� Matrix[0..4,0..9] of Longint = 200 ����');
   Matrix:=nil; // ����⮦���� ������
   PrintHeap('����⮦���� Matrix[0..4,0..9] of Longint = 200 ����');
   new(z); z^:=xMas;
   PrintHeap('��஦����� z^=[1..10] of Longint = 40 ����');
   Writeln(z^[1]:3,z^[2]:3,' sizeof(z^)=',sizeof(z^));
// ����� � 㪠��⥫ﬨ
   z:=pMas(Longword(z)+4);  // �� z:=z+1 !
   Writeln('z=@xMas[2]; z^[1]=',z^[1]:3,' z^[2]=',z^[2]:3);
   pLong:=@z^[1];           // pLong = @xMas[2]
   pLong:=pLong+1;          // pLong:=pLong+1 = @xMas[3]; ����� inc(pLong);
   Writeln('pLong=@z^[2]=xMas[3]=',pLong^:3);
// dispose(z); - �訡��, z 㦥 �� 㪠�뢠�� �� ��砫� ���ᨢ� !!!
   z:=pMas(Longword(z)-4);  // �� z:=z-1, ᭮�� 㪠�뢠�� �� ��砫� ���ᨢ�
   dispose(z);
   PrintHeap('����⮦���� z^=[1..10] of Longint = 40 ����');

   SetLength(Ansi,20000);
   PrintHeap('��஦����� ��ப� Ansi = 20000 ����');
   Writeln('����� ��ப� Ansi = ',Length(Ansi));
   SetLength(Ansi,0); // ����� 㭨�⮦��� � ⠪: Ansi:='';
   PrintHeap('����⮦���� Ansi = 20000 ����');


   WriteLn;
   with getHeapStatus do
     WriteLn('TotalAddrSpace=',TotalAddrSpace:6,
             ' TotalAllocated=',TotalAllocated:6,' TotalFree=',TotalFree:6);

   GetHeap:=GetHeap-getHeapStatus.TotalAllocated;
   Writeln(#13#10,'    ��窠 ����� = ',GetHeap:6);

   readln;
end.
