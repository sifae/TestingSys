uses  Crt,Windows;
  {$I-} {������㥬 �訡�� �����}
  const MaxInput=3;
  var   x,y,OldColors,ReturnCode,InpNum,ButtonCode: integer;
        Temp: int64; {���� ����让 �������� 楫��}
        Sym: char;
        BadNumber: Pchar='���宥 �᫮, ������� ���� ?';
        BigNumber: Pchar='����讥 �᫮, ������� ���� ?';
        OnceMore:  Pchar='������� �ணࠬ�� ?';
        MsgCapture:Pchar='';
begin
// ��������� ����
   SetConsoleTitle ('       ���� 楫��� �,  �뢮� ���祭�� Y=�+1');
// ��४���஢�� ⥪�⮢ ���� ᮮ�饭�� ��� Windows 
   OemToChar(BadNumber,BadNumber);
   OemToChar(BigNumber,BigNumber);
   OemToChar(OnceMore,OnceMore); 

repeat {������ 横�}
  ClrScr; {���⪠ �࠭�}
  InpNum:=0; {��᫮ ����⮪ ����� �᫠}
  GotoXY(8,2);
  repeat {���� ����� �᫠}
    GotoXY(8,5); Write('������ X = '); ReadLn(Temp);
    ReturnCode:=IOResult; {����祭�� ���� ������}
    InpNum:=InpNum+1;
    if ReturnCode<>0 then begin {���宥 �᫮}
      ButtonCode:=MessageBox(0,BadNumber,MsgCapture,
                  MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1);
      ClrEol
    end else {���⠪��᪨ �ࠢ��쭮� 楫�� �᫮}
    if (Temp<-MaxInt-1) or (Temp>=MaxInt) then begin
      ReturnCode:=1; {����讥 �᫮, �������}       
      ButtonCode:=MessageBox(0,BigNumber,MsgCapture,
                  MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON1);
      ClrEol
    end
  until (ReturnCode=0) or (InpNum=MaxInput) or
        (ButtonCode=IDNO);
  if ReturnCode=0 then begin {��� ��� !}
    x:=Temp; y:=x+1;
    GotoXY(8,10); Write('�⢥� Y = ',y);
//  �⠭����� ��� ����񭭮�� �᫠
    GotoXY(8,5); Write('������ X = ',x); ClrEol
  end;
  if (ReturnCode<>0) and (InpNum=MaxInput) then begin
//  ����� ����⮪ �����
    OldColors:=TextAttr; TextAttr:=16*Blue+White;
    GotoXY(8,25); WriteLn('�ॢ�襭� �᫮ ����⮪ �����!');
    TextAttr:=OldColors
  end;
{ ��� �뫮 ��� ��� ButtonCode=IDNO } 
  ButtonCode:=MessageBox(0,OnceMore,MsgCapture,
              MB_YESNO+MB_ICONASTERISK+MB_DEFBUTTON2)
until ButtonCode=IDNO;
GotoXY(8,25); OldColors:=TextAttr; TextAttr:=16*Blue+White;
WriteLn('����� ���������. ������ ENTER...');
TextAttr:=OldColors; ReadLn

end.

