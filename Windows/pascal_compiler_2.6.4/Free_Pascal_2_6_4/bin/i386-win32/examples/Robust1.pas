uses  Crt,Windows;
  {$I-} {Блокируем ошибку ввода}
const
  Enter=#13; BS=#8; Beep=#7; Esc=#27; MaxSymbols=6;
  Title='   Ввод целого Х,  вывод значения Y=Х+1;   Esc - выход';
var
  x,y,OldColors,ReturnCode,NumSym,PosX: integer;
  Temp: Longint; Sym,Sign: char; BigNumber: boolean;
  ButtonCode: integer;
  OnceMore:  Pchar='Повторить программу ?';
  MsgCapture:Pchar='';

procedure EraseError;
  begin PosX:=WhereX; GotoXY(1,24); Clreol; GotoXY(PosX,5) end;

begin
// Заголовок окна
   SetConsoleTitle(Title);
// Перекодировка текстов окон сообщений для Windows 
   OemToChar(OnceMore,OnceMore); 
   OldColors:=TextAttr;  {Запоминаем текущие цвета}

repeat {Главный цикл программы}
  ClrScr; {Очистка экрана}
  Sign:='+'; Temp:=0; BigNumber:=false;
  GotoXY(8,5); Write('Введите X = ');
  Temp:=0; NumSym:=0; {Число введённых символов}
  repeat {Цикл ввода символов числа}
    Sym:=ReadKey; ReturnCode:=IOResult; {Код возврата}
    if ReturnCode<>0 then begin {Фатальная ошибка ввода}
      TextAttr:=16*Blue+Yellow; {Цвета диагностики}
      GotoXY(20,24); 
      Write('Фатальная ошибка ввода, конец программы');
      TextAttr:=OldColors; {Восстановим текущие цвета}
      ClrEol
    end else {Введён символ без эха и контроля}
    if (Sym in ['-','+']) and (NumSym=0) then begin {Знак числа}
      NumSym:=NumSym+1; Sign:=Sym; Write(Sym); {Эхо знака}
      EraseError  {Стирание диагностики}
    end else
    if (Sym in ['0'..'9']) and (NumSym<MaxSymbols) then begin
// Цифра
      NumSym:=NumSym+1; Write(Sym);    {Эхо цифры}
      Temp:=10*Temp+ord(Sym)-ord('0'); {Схема Горнера}
      EraseError  {Стирание диагностики}
    end else
    if (Sym=BS) and (NumSym>0) then begin {Удалить символ}
      if NumSym=1 then Sign:='+'; {Возможно, удалён знак числа}
      Temp:=Temp div 10; {Удаление цифры или знака числа}
      Write(BS,' ',BS); {Эхо удаления символа}
      NumSym:=NumSym-1; EraseError  {Стирание диагностики}
    end else
    if Sym=Esc then begin {Выход из программы}
      ReturnCode:=1; TextAttr:=16*Red+White; 
      GotoXY(10,24); Write('Нажата клавиша ESC !');
      TextAttr:=OldColors; ClrEol
    end else
    if (Sym<>Enter) or (NumSym=0) then begin {Плохой символ}
      if Sym=#0 then Sym:=ReadKey; {Дополнительный алфавит}
      PosX:=WhereX; {Позиция курсора}
      TextAttr:=16*Black+LightRed;
      GotoXY(10,24); Write('ПЛОХОЙ СИМВОЛ !');
      Write(Beep); {Звуковой сигнал}
      TextAttr:=OldColors; ClrEol; GotoXY(PosX,5)
      end
  until (Sym=Enter) and (NumSym>0) or (ReturnCode<>0);
  if ReturnCode=0 then begin {Проверка введённого числа}
    if (Temp<-MaxInt-1) or (Temp>=MaxInt) then begin
      TextAttr:=16*Black+LightRed; GotoXY(8,24);
      Write('Введено большое число !');
      TextAttr:=OldColors; ClrEol; BigNumber:=True
    end else begin {Всё хорошо !}
      x:=Temp; if Sign='-' then x:=-x;
      y:=x+1; GotoXY(8,10); Write('Ответ Y = ',y);
//  Стандартный вид введённого числа
      GotoXY(8,5); Write('Введите X = ',x); ClrEol
    end;
  end;
  ButtonCode:=MessageBox(0,OnceMore,MsgCapture,
              MB_YESNO+MB_ICONASTERISK+MB_DEFBUTTON2);
until ButtonCode=IDNO;

GotoXY(8,24); TextAttr:=16*Blue+White;
WriteLn('КОНЕЦ ПРОГРАММЫ. Нажмите ENTER...');
TextAttr:=OldColors; ReadLn

end.

