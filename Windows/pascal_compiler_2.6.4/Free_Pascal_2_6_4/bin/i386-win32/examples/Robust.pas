uses  Crt,Windows;
  {$I-} {Блокируем ошибку ввода}
  const MaxInput=3;
  var   x,y,OldColors,ReturnCode,InpNum,ButtonCode: integer;
        Temp: int64; {Самый большой диапазон целых}
        Sym: char;
        BadNumber: Pchar='Плохое число, повторить ввод ?';
        BigNumber: Pchar='Большое число, повторить ввод ?';
        OnceMore:  Pchar='Повторить программу ?';
        MsgCapture:Pchar='';
begin
// Заголовок окна
   SetConsoleTitle ('       Ввод целого Х,  вывод значения Y=Х+1');
// Перекодировка текстов окон сообщений для Windows 
   OemToChar(BadNumber,BadNumber);
   OemToChar(BigNumber,BigNumber);
   OemToChar(OnceMore,OnceMore); 

repeat {Главный цикл}
  ClrScr; {Очистка экрана}
  InpNum:=0; {Число попыток ввода числа}
  GotoXY(8,2);
  repeat {Цикл ввода числа}
    GotoXY(8,5); Write('Введите X = '); ReadLn(Temp);
    ReturnCode:=IOResult; {Получения кода возврата}
    InpNum:=InpNum+1;
    if ReturnCode<>0 then begin {Плохое число}
      ButtonCode:=MessageBox(0,BadNumber,MsgCapture,
                  MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1);
      ClrEol
    end else {Синтаксически правильное целое число}
    if (Temp<-MaxInt-1) or (Temp>=MaxInt) then begin
      ReturnCode:=1; {Большое число, повторить}       
      ButtonCode:=MessageBox(0,BigNumber,MsgCapture,
                  MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON1);
      ClrEol
    end
  until (ReturnCode=0) or (InpNum=MaxInput) or
        (ButtonCode=IDNO);
  if ReturnCode=0 then begin {Всё хорошо !}
    x:=Temp; y:=x+1;
    GotoXY(8,10); Write('Ответ Y = ',y);
//  Стандартный вид введённого числа
    GotoXY(8,5); Write('Введите X = ',x); ClrEol
  end;
  if (ReturnCode<>0) and (InpNum=MaxInput) then begin
//  Много попыток ввода
    OldColors:=TextAttr; TextAttr:=16*Blue+White;
    GotoXY(8,25); WriteLn('Превышено число попыток ввода!');
    TextAttr:=OldColors
  end;
{ Всё было хорошо или ButtonCode=IDNO } 
  ButtonCode:=MessageBox(0,OnceMore,MsgCapture,
              MB_YESNO+MB_ICONASTERISK+MB_DEFBUTTON2)
until ButtonCode=IDNO;
GotoXY(8,25); OldColors:=TextAttr; TextAttr:=16*Blue+White;
WriteLn('КОНЕЦ ПРОГРАММЫ. Нажмите ENTER...');
TextAttr:=OldColors; ReadLn

end.

