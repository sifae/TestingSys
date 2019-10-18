program ConstVarTypes;

// Здесь Crt самый ВНЕШНИЙ блок, Math предпоследний,
// заданный по умолчанию System - самый ВНУТРЕННИЙ блок
   uses Crt,SysUtils,DateUtils,Windows,
   Variants, // надо для VaRArrayCreate
// MyUnit in 'C:\MyDir\MyUnit.ppu', - поиск в заданном каталоге
        Math {в Math операция **};

   {$Calling stdcall}
// Разрешить C подобные операторы, можно x+=3; НЕЛЬЗЯ x++; --x;
   {$COperators ON}
   {$BitPacking ON}             // Упаковка для packed переменных
   {$PackEnum 1}                // 1 байт для типа Week, иначе 4
// {$J-} Запрет ПРИСВАИВАНИЯ для типизированных констант
   {$J-} {=$WriteableConst OFF}
   {$H-} {=$LongString OFF По умолчанию, тогда String=ShortString,
           если $H+ тогда String=AnsiString }
   {$T+} {=$TypedAddress ON}    // var x:Tip; @x возвр. ^Tip, иначе Pointer

   Const N=10; M=10; &const=100; // Так можно для СЛУЖЕБНОГО имени
         NBit=%10110011;         // Двоичное число
         N4:real=0;              // {$J-} - Нельзя N4:=1
         P: Extended=Pi;
// Константы времени компиляции
         N1=2*N+1; N2=sqr(N1)+abs(trunc(sin(N1)));
         Const1='A'; Const2=Const1+#10+^A;
// Константы времени ВЫПОЛНЕНИЯ
//       N3=pos('B','ABCD'); Ошибка !

   Type
     Week=(Monday{:}=1, { теперь нельзя succ,pred,array[Week] ! }
           Tuesday,{ord(Tuesday)=2!} Wednesday=0,
           Thursday,{ord(Thursday)=1!}Friday,Saturday,Sunday);
           { for w:=Monday{1} to Wednesday{0} do; Пустой цикл ! }
     tWeek=(Sun,Mon,Tue,Wed,Thu,Fri,Sat);
     Index=1..N;
     Mas=array[1..N] of Longint;
     Arr=array of Longint;  // ОТКРЫТЫЙ массив, начиная с нуля!!
     proc=procedure (x:Longint; y:char); // Процедурный тип
     Mat=array of array of Longint;
     pMas=^Mas;
     Comp=record re:double; im:double end;
     Stud=record Name: String[40]; ex: record An,Al,Pr: 0..5 end end;

   Var   // Для всех скалярных переменных выравнивание 16 байт !
     a1: byte; a2: smallint; a3: shortint; a4: integer; a5: word;
     a6: Cardinal {=Longword}; x: Longint; y: Longword;
     a7: Single absolute y;   // Наложение a7: Single; на y: Longword;
     a8: Longint absolute a4; // Наложение a8: Longint; на a4: integer;
//   int64 НЕ СОВСЕМ дискретный тип, можно ord,succ,pred НЕЛЬЗЯ for
     g1: int64 {=qword}; g2: qword;
     b1: Single; b2: real {=double}; b3: double; b4: Extended {10 байт};
     b5: real48;              // Для совместимости с Turbo Pascal
     c: char {=AnsiChar};
     bool1: boolean; { =ByteBool 1 байт }
     bool2: WordBool; { 2 байта }
     bool4: LongBool; { 4 байта }

     procarr: array[1..N] of proc; // массив [ссылок] на процедуры
     dt: TDateTime;

// МОЖНО  String:=Ansistring, pChar, WideString, Packed Array, array
// МОЖНО  Ansistring:=String, pChar, WideString, array
// МОЖНО  pChar:=pChar(Ansistring), pChar(WideString)
// НЕЛЬЗЯ pChar:=String, pChar(String), Packed Array, Pchar(Packed Array)
     s1: String; { String=ShortString, =AnsiString при $H+ }
     s2: AnsiString='Динам.строка с нулём в конце,-4=длина,-8=число ссылок';
     s2a: AnsiString; // Всегда порождается = nil, независимо от класса !
// UniqueString(s2) - число ссылок s2:=1
// Вместо s2[0]:=#12; { Присвоить строке длину 12 } надо SetLength(s2,12)
     s3: Pchar; { строка с нулём в конце как в C }
     s4: packed array[1..N] of char; // из стандарта Паскаля
     s5: array[1..N] of char;

     sCap: pChar='Заголовок';
     sText: pChar='Hi! Привет!'+#13+#10+'Вторая строка';
     sTxt: String='Hi! Привет!'#13#10'Вторая строка в String';
     wTxt: WideString='Строка Unicode psi='+#$03A8+' omega='+#$03A9;
     fmt: string='dd.mm.yyyy hh:mm:ss';

     xMas: Mas=(2,4,6,8,10,12,14,16,18,20); yMas: Mas; // Совместимый тип
// zMas,zMas1 - структурно-совместивый тип с xMas и yMas
     zMas:  array[1..N] of Longint;
// zMas1 - структурно-совместивый тип с xMas и zMas (N=M)
     zMas1: array[1..M] of Longint;
// zMas2 - структурно-НЕсовместивый тип !!!
     zMas2: array[0..N-1] of Longint;
     xArr,yArr: Arr; // ДИНАМИЧЕСКИЙ открытый массив
     ptr: Pointer; LPtr: ^Longint;  Matrix: Mat;
     w: tWeek; Color: (cRed,cGreen,cBlue);
     wArr: array[1..7] of string[3]=
           ('ПН','ВТ','СР','ЧТ','ПТ','СБ','ВС');
     wArray: array[tWeek] of Longint;
     z: pMas; pLong: ^Longint;
     BigMas: array[1..200000000] of Longint; { 1.6 млрд.байт }
// Записи
     rec1: Comp=(re: 0.5; im: -0.5);
     rec2: record re: double; im: double end=(re: 0.5; im: 0.5);
     Grup: array[1..2] of Stud=
                       ((Name: 'Иванов'; Ex: (An:1; Al:1; Pr:1)),
                        (Name: 'Петров'; Ex: (An:2; Al:2; Pr:2)));
// Множества
     wSet: set of tWeek=[Mon..Fri];
// До 32-х эл-тов 4 байта, больше 32-х э-тов сразу 16 байт!
     SetDiget: Set of '0'..'9'; { длина 4 байта ! }
     Set1_40:  Set of 1..40;    { длина уже 256 байт ! }
//   bukva: Set of ('a','b','c');  // Так нельзя
     bukva: Set of 'a'..'c';       // Так можно
// Переменная ВАРИАТИВНОГО типа, тип определяется при присваивании !
     VariantVar: Variant;
// Выравнивание
     {$CodeAlign VarMax=2}  // Не работает
     Aligh1: byte; Aligh2: word; Aligh4: Longword;

   Function F(x:Longint):Mas;
      var i: Longint;
   begin
      for i:=low(Mas) to high(Mas) do F[i]:=-x
   end;

   Operator + (var x,y:Mas) z:Mas; // Перегрузка операции
      var i:Longint;
   begin
      for i:=Low(x) to High(x) do z[i]:=x[i]+y[i]
   end;

   Function abs(const x:Mas):Mas; // Перегрузка стандартной функции abs
      var i:Longword;
   begin
      for i:=low(x) to high(x) do Abs[i]:=system.abs(x[i])
   end;

   Procedure pArr(var x:array of Longint); // параметр - абстрактный массив
      var i:Longint;
   begin
      for i:=0 to high(x) do x[i]:=-3*i;
      WriteLn('x[5]=',x[5],' high(x)=',high(x)) // начиная с x[0] !!
   end;

   Procedure pMat(var x:Mat);
   begin
      Write('high(x)=',high(x),' high(x[1])=',high(x[1]));
      Writeln(' Length(x)=',Length(x),' Length(x[1])=',Length(x[1]))
   end;

// Локальные переменные для begin ... end
   Var i: Longint; j: integer; r: real; s: String; ch: char; str1: String[1];
   Const BigN=1000;

{  Старшинство операций:
   --------------------

     0. **       (если use Math;)
     1. not  @
     2. *    /   div  mod  and  shl  shr  <<  >>  as (Оператор класса)
     3. +    -   or   xor
     4. =    <>  >    <    >=   <=   in           is (Оператор класса)

   Операции одинакового старшинства НЕ ОБЯЗАТЕЛЬНО вычисляются слева-направо
}

begin
   ClrScr; GotoXY(1,3);
   SetConsoleTitle ('Константы, переменные, типы');
   TextAttr:=16*Blue+Yellow;
   dt:=now; WriteLn('Текушие дата и время=',FormatDateTime(fmt,dt),#13#10);
   TextAttr:=LightGray;

// readln; halt;

// Цикл for
   Writeln('for i:=low(xMas) to high(xMas) do write(i:4)');
   for i:=low(xMas) to high(xMas) do write(i:4); Writeln;
   Writeln('for i in xMas do write(i:4)');
   for i in xMas do write(i:4); Writeln;
   Writeln('for s in wArr do write(s:6);');
   for s in wArr do write(s:6); Writeln;
   Writeln('for w in tWeek do write(w:6);');
   for w in tWeek do write(w:6); Writeln;
   Writeln('for i in Index do write(w:6);');
   for i in [1..N{ N<=256 ! }] do write(i:6); Writeln;
   Writeln('for w in wSet do write(w:6);');
   for w in wSet do write(w:6); Writeln;
// В целых множествах [...] только значения типа byte !
// [-5..5] - ПУСТОЕ множество byte(-5)=251 > 5
   Writeln('for i in [-3,0..1,3,5,7,9..13] do write(i:4); = ');
   for j in [-3{-3=253!},0..1,3,7,9..13] do write(j:4);
   Writeln(#13#10);
// for i:=1 to 100 do i:=i+1; ОШИБКА компиляции ! Но можно обмануть:
{  Procedure H(var x:integer); begin x:=x+1 end;
   Procedure G(x:integer); begin H(x) end;
   for i:=1 to 100 do G(i);
}

// Наложение переменных в памяти
   y:=1; Writeln('a7:Single absolute y:Longword=1 = ',a7);
   a4:=-1 {65535 в Longword}; a5:=1;
// a4 МЛАДШАЯ часть a8; a5 ЗА a8 aligne 16 !
   Writeln('a8:Longword absolute a4:integer=-1; = ',a8);
   Writeln('@a8=',Longword(@a8),' @a4=',Longword(@a4),' @a5=',Longword(@a5));
// Выравнивание
   Writeln;
   Writeln('Выравнивание: @byte=',Longword(@Aligh1),
           ' @word=',Longword(@Aligh2),' @Longword=',Longword(@Aligh4));
// Тип Variant
   VariantVar:=111; Writeln('VariantVar:=integer = ',VariantVar);
   VariantVar:=22.22; Writeln('VariantVar:=real = ',VariantVar);
   VariantVar:='Строка'; Writeln('VariantVar:=String = ',VariantVar);
   VariantVar:=true; Writeln('VariantVar:=Boolean = ',VariantVar,#13#10);
// Неявное преобразование типов при присваивании, если возможно
   r:=VariantVar; Writeln('real:=VariantVar==Boolean = ',r);
   VariantVar:='1234'; i:=VariantVar;
   Writeln('integer:=VariantVar==String=1234 = ',i,#13#10);
// Порождение массива из 10 VarInteger
   VariantVar:=VarArrayCreate([1,10],varInteger);
// НЕЯВНОЕ преобразование к integer при присваивании
   for i:=1 to 10 do begin
       Write(VariantVar[i]:3); VariantVar[i]:=odd(i){-1.5*i}; Write(VariantVar[i]:4)
   end;
   Writeln; VariantVar:=VarArrayCreate([1,8],varVariant);
   for i:=1 to 8 do begin
       VariantVar[i]:=-i; Write(VariantVar[i]:3);
       VariantVar[i]:=odd(i); Write(VariantVar[i]:6)
   end;

   Writeln(#13#10);
   s1:=s2; Writeln('s1=',s1,#13#10,'s2=',s2);
   Writeln('sCap=',sCap); s1:=sCap;
   Writeln('s1=',s1,#13#10,'s2=',s2);
   s2:=s1; s2:=sCap; s2:=wTxt;
   SetLength(s2,3);    // Изменение длины строки, нельзя s2[0]:=#3
   s2:='ABC'; s2a:=s2; // s2 и s2a указывают на ОДНУ строку 'ABC' в куче
   s2a[2]:='*';        // s2 указывает на 'ABC', а s2a указывает на 'A*C'
                       // Копирование при записи (copy-on-write semantics)
   Writeln('wTxt=',wTxt,'     НЕТ руских букв');
   s2:=s1; Writeln('s1=',s1,#13#10,'s2=',s2);
   s1:=wTxt; wTxt:=s1;
   s1:=s4; s2:=s4; s1:=s5; s2:=s5;
   s4:='ABC'; // К сожалению можно, s4[1..3]:='ABC'
// s3:=s4; s3:=Pchar(s4);  s3:=s5; НЕЛЬЗЯ
{$I-}
   Write('Ввод Longint='); Readln(x); y:=IOResult; x+=3;
   if y<>0 then Writeln('Плохое число, код возврата=',y)
           else Writeln('Введено=',x-3);

// Массивы
   xMas:=F(1); WriteLn('xMas[5]=',xMas[5]);
   xMas:=abs(xMas+xMas); WriteLn('xMas:=abs(xMas+xMas): xMas[5]=',xMas[5]);
// Совместимость по присваиванию
   yMas:=xMas;            // Совместимые по типу
   zMas:=xMas;            // Структурно-совместивые массивы
   zMas1:=zMas;           // Структурно-совместивые массивы
   pArr(zMas);
// ДИНАМИЧЕСКИЙ открытый массив
   SetLength(xArr,N);     // Порождение xArr[0..N-1] of Longint;
   yArr:=xArr;            // xArr и yArr ссылаются на ОДИН и тот же массив
   pArr(xArr); xArr:=nil; // Уничтожение массива
   yArr:=nil;             // ОБЯЗАТЕЛЬНО
   SetLength(Matrix,5,10); //Mat[0..9,0..4] of Longint;
   pMat(Matrix); SetLength(Matrix,3,7); pMat(Matrix);
   Finalize(Matrix); // Matrix:=nil;
// Записи
{  With A,B do S // Выполняется как
   With A do
     With B do S
}
   for i:=low(Grup) to high(Grup) do
       with Grup[i],Ex do
            Writeln('Name=',Name,'; Ex.An=',An);
   writeln;

// b1:=3.; b2:=.3;  Нельзя !!!
// x:=y:=1;         Нельзя !!!
// ch:=str1;        Нельзя char:=String[1]

   r:=0.2E-10; Writeln('r=',r);
   Writeln('r*5E+10=',r*5E+10,' НЕ РАВНО 10.0 !!!');
   Writeln('sizeof(integer)=',sizeof(integer));
   for i:=1 to n do begin xMas[i]:=i; Write(xMas[i]:3) end; Writeln;
   writeln('2*4**3=',2*4**3,' 4.0**3=',4.0**3); // uses Math !
   Writeln('Extended Pi=',P);
   WriteLn('MaxInt=',MaxInt,' Maxword=',Maxword);
   WriteLn('MinInt=НЕТ ТАКОГО',' Minword=НЕТ ТАКОГО');
   WriteLn('MaxLongint=',MaxLongint,' MaxLongword=НЕТ ТАКОГО');
   g1:=999999999999999999; g2:=g1;
   writeln('g1=',g1,' succ(g1)=',succ(g1)); g1:=ord(g1);
   writeln('g2=',g2,' pred(g2)=',pred(g1)); g2:=ord(g2);

// Явные преобразования типов x: Longint; b3: double; bool1: boolean; c: char;
   x:=Longint('A'); x:=Longint(Single(1)); b3:=double(Longint(1));
   bool1:=boolean(Longint(1)); c:=char(Longint(1));
// Ошибки! Для вещ.чисел надо размер получателя НЕ МЕНЬШЕ
// x:=Longint(double(1)); bool1:=boolean(Single(1));

// Ссылка на переменную эквивалентна массиву [0..inf] таких переменных
// LPtr: ^Longint; xMas: Mas=(1,2,3,4,5,6,7,8,9,10);
   LPtr:=@xMas[1];
   Writeln('xMas[4(от 1)]=',xMas[4],' == LPtr[3(от 0)]=',LPtr[3]);

   readln;
   readln;
end.
