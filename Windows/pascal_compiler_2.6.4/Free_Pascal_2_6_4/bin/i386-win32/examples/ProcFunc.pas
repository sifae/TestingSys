program p1;
   uses Crt,Windows;

   {$AsmMode Intel}             // Ассемблер MASM
   {$GOTO+}                     // {$GOTO-} - label L; Goto L; Нельзя !!!
   {$Calling stdcall}
   {$InLine ON}                 // Можно INLINE процедуры, нет рекурсии !
// {$X+}={$EXTENDEDSYNTAX ON}
// + по умолчанию; вызов ПОЛЬЗОВАТЕЛЬСКИХ функций как процедур
   {$X-}                        // не работает !

   {V+} {=$VarStringChecks ON}  // Строгая проверка типов строк по ссылке

   Const N=10; M=10;

   Type
     Week=(Monday=1, { теперь нельзя succ,pred,array[Week] ! }
           Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday=0);
           { for w:=Monday to Sunday do; Пустой цикл ! }
     Mas=array[1..N] of Longint;
     Arr=array of Longint;  // ОТКРЫТЫЙ массив, начиная с нуля!!
     proc=procedure (x:Longint; y:char); // Процедурный тип
     Mat=array of array of Longint;
     pMas=^Mas;
     Comp=record re:double; im:double end;

   {$L a2asm.obj} // Модуль a2asm.asm на Ассемблере

   var
     xasm2: Longint{;} external name '_xasm2';
//   xasm2 из a2.asm имеет два ВНЕШНИХ имени: xasm2 и _xasm2

     xp1: Longint=$123ABC; public {=export} name '_xp1';
//   xp1 имеет два ВНЕШНИХ имени: _XP1 и _xp1

     x: Longword; y: Longint;
     xMas: Mas=(1,2,3,4,5,6,7,8,9,10); yMas: Mas;
     zMas: array[1..N] of Longint;    // структурно-совместивый тип с xMas и yMas
     zMas1: array[1..M] of Longint;   // структурно-совместивый тип с xMas и yMas
     zMas2: array[0..N-1] of Longint; // структурно-НЕсовместивый тип !!!
     xArr: Arr; // ДИНАМИЧЕСКИЙ открытый массив
     Matrix: Mat;

   Function UpCaseRus(s: String): String; Forward;

// Перегрузка операции + для массивов типа Mas
// constref ОБЕСПЕЧИТ передачу по ссылке в ДРУГИЕ процедуры
// При stdcall const=constref для БОЛЬШИХ параметров
   Operator + (const x,y: Mas) z: Mas;
      var i: Longint;
   begin
      for i:=Low(x) to High(x) do z[i]:=x[i]+y[i]
   end;

// Перегрузка <> для массивов типа Mas
   Operator <> (const x,y: Mas) z: Boolean;
      var i: Longint;
   begin {z:=false;}
      for i:=Low(x) to High(x) do
          if x[i]<>y[i] then {z:=true} exit(true);
      exit(false)
   end;

// Перегрузка унарного - (минус) для массивов типа Mas
   Operator - (const x: Mas) z: Mas;
      var i: Longint;
   begin
      for i:=Low(x) to High(x) do z[i]:=-x[i]
   end;

   Procedure P(const x); InLine;
   begin
      WriteLn('Передано значение x=',integer(x))
   end;

{  Только в Delpfi! : Значения параметра по умолчанию, параметр out
   Function Sum(out x: Longint; y: Longint=1): Longint;
   begin
      Sum:=x+y;
   end;
}

   {$L a2asm.obj} // Модуль a2asm.asm на Ассемблере
   Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External name '_Q@0';
(* Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External 'Name';
   тогда Q ищется в БИБЛИОТЕКЕ Name.dll
*)
(* Procedure Q(var x:Longint; y:Longint){;} stdcall{;} External;
   тогда надо явно задать Q d библиотеке MyLib.dll {$LinkLib MyLib}
*)
   Procedure QReg(var x,y: Longint; p,g: Longint){;} pascal{;} Register{;} External;
(* Передача eax:=@x; edx:=@y; ecx:=p; push g;
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
      end ['ebx','eax']; // Эти регистры использует блок ASM,
// При входе будет push ebx; push eax; при выходе pop ebx; pop eax
      temp:=1
   end;

   Function F(x: Longint):Mas;
{  LocalName_GlobalValue - Глобальная ПЕРЕМЕННАЯ (если {$J+})
   с ЛОКАЛЬНЫМ именем! Т.е. будет существовать при повторном входе
}
      const LocalName_GlobalValue: Longint=-1;

      var i: Longint;
   begin
      for i:=low(Mas) to high(Mas) do F[i]:=-i
   end;

// Перегрузка функции F
   Function F(x: Char): Longint; { Overload; - искать имя F ТАКЖЕ в Units }
      var i: Longint;
   begin
      F:=1; i:=F;
      if F<4 then F:=1;
      exit (0) // Это F:=0; exit
   end;

   Function abs(const x: Mas):Mas; // Перегрузка СТАНДАРТНОЙ функции abs
      var i: Longword;
   begin
      for i:=low(x) to high(x) do abs[i]:=system.abs(x[i])
   end;

// Procedure pArr(var x: array of Mas);     // параметр - абстрактный массив
   Procedure pArr(var x: array of Longint); // параметр - абстрактный массив
      var i: Longint;
   begin
// Для ПУСТОГО массива low(x)=0, high(x)=-1 !
      for i:=low(x) to high(x) do x[i]:=i;
      WriteLn('x[high(x)]=',x[high(x)],' low(x)=',low(x),
              ' high(x)=',high(x))           // начиная с x[0] !!
   end;

   Function SumMas(var x: array of Longint): Longint;
      var i: Longint;
   begin
      SumMas:=0; // В отличие от СТАНДАРТА SumMas локальная ПЕРЕМЕННАЯ
      Write('low(yMas)=',low(x),' high(yMas)=',high(x),
            ' @Массива=',Longword(@x[low(x)]));
      for i:=low(x) to high(x) do SumMas:=SumMas+x[i];
   end;

   Procedure pMat(var x: Mat);
   begin
      Write('high(x)=',high(x),' high(x[1])=',high(x[1]));
      Writeln(' Length(x)=',Length(x),' Length(x[1])=',Length(x[1]))
   end;

   Procedure OutHex(x: Longword); [public, alias: '_OutHex'];
   // OutHex имеет два ВНЕШНИХ имени: OutHex и _OutHex
   begin
      Writeln(HexStr{IntToHex}(x,2*Sizeof(x)),'h')
   end;

   Function UpCaseRus(s: String):String;
      const r1='абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdehghijklmnopqrstuvwxyz';
            r2='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var i,j:byte;
   begin
      UpCaseRus:=s;
      for i:=1 to Length(s) do begin j:=Pos(s[i],r1);
          if j>0 then UpCaseRus[i]:=r2[j]
      end;
   end;

// Сравнение на равенство переменных любого типа
   function Equal(const x,y; Len: Longword):boolean;
     type Bytes=array [0..MaxLongint-1] of byte;
     var i: Longword;
// Можно a: array[0..0] of byte absolute x;
//       b: array[0..0] of byte absolute y;
     begin i:=1;
        while (i<Len) and (Bytes(x)[i]=Bytes(y)[i]) do inc(i);
//{$R-} while (i<Len) and (a[i]=b[i]) do inc(i); {$R+}
        Equal := i=Len;
//      i:=LocalVar - имя LocalVar здесь не видно !
   end;

   {$COperators ON}  // Разрешить некоторые Cи подобные операторы

// Перегрузка операции x**y КАК ЗНАЧЕНИЯ оператора x+=y для integer
   Operator ** (var x: integer; y: integer) z:integer;
   begin
      x+=y; z:=x
   end;

// Функция без параметров
   function GetChar:char; // Вызов var c: char; c:=Getchar
   begin
     Read(Getchar);       // Getchar - локальная переменная
     if Getchar=#0 then   // Getchar - локальная переменная
       GetChar:=Getchar() // Рекурсивный вызов Getchar
   end;

// Описанных ниже имён не видно ВЫШЕ по тексту !
   label Lif, Lwhile, LBegin, LFor;
   var LocalVar: Longint;
       i: Longint; j: integer; b: boolean; cc: char;
begin
   ClrScr; GotoXY(1,2);
   SetConsoleTitle ('Процедуры и функции');

// Пример плохих GOTO в сложных операторах
   goto Lif;           // К сожалению !
   if i=0 then Lif: i:=1;
   i:=0; goto Lwhile;  // К сожалению !
   while i<>0 do begin
      Lwhile: i:=0
   end;
   goto LBegin;         // К сожалению !
   begin
      i:=0; LBegin: i:=1; i:=2
   end;
   goto LFor;           // К сожалению !
   for i:=1 to 10 do LFor: j:=1;

   { b:= } Equal(x,x,4); // {$EXTENDEDSYNTAX OFF} не работает !

   j:=0; while j**2 {j+=2} <= 8 do Write(j:4); Writeln;

   Writeln('UpCaseRus("dddd дддд")=',UpCaseRus('dddd ДДДД'),#13#10);
   Write('Процедура ассемблера Q(x,y) вызывает OutHex(y=43),OutHex(xp1) = ');
   Q(y,43); Writeln('y из Q=',y);
   R(y); Writeln('ebp=',x,' y из R=',y);
   OutHex(x); OutHex(y);

   Writeln('F(''1'')[F:=1; exit(0)] =',F('1'):3,#13,#10);
   yMas:=xMas; Writeln('yMas<>xMas = ',yMas<>xMas);
   x:=SumMas(yMas); WriteLn(' SumMas(yMas)=',x);

// Явное задание границ ОТКРЫТОГО массива !
   x:=SumMas(yMas[1..5]);  WriteLn(' SumMas(yMas[1..5])=',x);
   x:=SumMas(yMas[6..10]); WriteLn(' SumMas(yMas[6..10])=',x);
// x:=SumMas(yMas[1,5,10]); НЕЛЬЗЯ конструктор мн-ва эл-тов

   yMas:=F(1); Write('yMas='); for y in yMas do Write(y:4); Writeln;
   yMas:=abs(yMas+yMas); WriteLn('yMas:=abs(yMas+yMas): yMas[5]=',yMas[5]);
   zMas:=xMas; Write('zMas='); for y in zMas do Write(y:4); Writeln;
   zMas1:=zMas;
   pArr(zMas); Write('zMas='); for y in zMas do Write(y:4); Writeln;
   SetLength(xArr,N);   // Порождение xArr[0..N-1] of Longint;
   pArr(xArr);
   Write('xArr='); for y in xArr do Write(y:4); Writeln;
   x:=SumMas(xArr[0..4]);  WriteLn(' SumMas(xArr[0..4])=',x);

   Writeln;
   pArr(xArr[1..5]); pArr(xArr[6..10]);
   xArr:=nil; // Уничтожение массива
   SetLength(Matrix,5,10); //Mat[0..9,0..4] of Longint;
   pMat(Matrix); SetLength(Matrix,3,7); pMat(Matrix);
   WriteLn('Внешняя пересенная из a2asm.asm xasm2=',xasm2);

   readln;

end.
