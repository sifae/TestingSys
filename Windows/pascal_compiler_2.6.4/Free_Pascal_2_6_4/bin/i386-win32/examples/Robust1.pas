uses  Crt,Windows;
  {$I-} {������㥬 �訡�� �����}
const
  Enter=#13; BS=#8; Beep=#7; Esc=#27; MaxSymbols=6;
  Title='   ���� 楫��� �,  �뢮� ���祭�� Y=�+1;   Esc - ��室';
var
  x,y,OldColors,ReturnCode,NumSym,PosX: integer;
  Temp: Longint; Sym,Sign: char; BigNumber: boolean;
  ButtonCode: integer;
  OnceMore:  Pchar='������� �ணࠬ�� ?';
  MsgCapture:Pchar='';

procedure EraseError;
  begin PosX:=WhereX; GotoXY(1,24); Clreol; GotoXY(PosX,5) end;

begin
// ��������� ����
   SetConsoleTitle(Title);
// ��४���஢�� ⥪�⮢ ���� ᮮ�饭�� ��� Windows 
   OemToChar(OnceMore,OnceMore); 
   OldColors:=TextAttr;  {���������� ⥪�騥 梥�}

repeat {������ 横� �ணࠬ��}
  ClrScr; {���⪠ �࠭�}
  Sign:='+'; Temp:=0; BigNumber:=false;
  GotoXY(8,5); Write('������ X = ');
  Temp:=0; NumSym:=0; {��᫮ ������� ᨬ�����}
  repeat {���� ����� ᨬ����� �᫠}
    Sym:=ReadKey; ReturnCode:=IOResult; {��� ������}
    if ReturnCode<>0 then begin {��⠫쭠� �訡�� �����}
      TextAttr:=16*Blue+Yellow; {���� �������⨪�}
      GotoXY(20,24); 
      Write('��⠫쭠� �訡�� �����, ����� �ணࠬ��');
      TextAttr:=OldColors; {����⠭���� ⥪�騥 梥�}
      ClrEol
    end else {����� ᨬ��� ��� �� � ����஫�}
    if (Sym in ['-','+']) and (NumSym=0) then begin {���� �᫠}
      NumSym:=NumSym+1; Sign:=Sym; Write(Sym); {�� �����}
      EraseError  {��࠭�� �������⨪�}
    end else
    if (Sym in ['0'..'9']) and (NumSym<MaxSymbols) then begin
// ����
      NumSym:=NumSym+1; Write(Sym);    {�� ����}
      Temp:=10*Temp+ord(Sym)-ord('0'); {�奬� ��୥�}
      EraseError  {��࠭�� �������⨪�}
    end else
    if (Sym=BS) and (NumSym>0) then begin {������� ᨬ���}
      if NumSym=1 then Sign:='+'; {��������, 㤠�� ���� �᫠}
      Temp:=Temp div 10; {�������� ���� ��� ����� �᫠}
      Write(BS,' ',BS); {�� 㤠����� ᨬ����}
      NumSym:=NumSym-1; EraseError  {��࠭�� �������⨪�}
    end else
    if Sym=Esc then begin {��室 �� �ணࠬ��}
      ReturnCode:=1; TextAttr:=16*Red+White; 
      GotoXY(10,24); Write('����� ������ ESC !');
      TextAttr:=OldColors; ClrEol
    end else
    if (Sym<>Enter) or (NumSym=0) then begin {���宩 ᨬ���}
      if Sym=#0 then Sym:=ReadKey; {�������⥫�� ��䠢��}
      PosX:=WhereX; {������ �����}
      TextAttr:=16*Black+LightRed;
      GotoXY(10,24); Write('������ ������ !');
      Write(Beep); {��㪮��� ᨣ���}
      TextAttr:=OldColors; ClrEol; GotoXY(PosX,5)
      end
  until (Sym=Enter) and (NumSym>0) or (ReturnCode<>0);
  if ReturnCode=0 then begin {�஢�ઠ ����񭭮�� �᫠}
    if (Temp<-MaxInt-1) or (Temp>=MaxInt) then begin
      TextAttr:=16*Black+LightRed; GotoXY(8,24);
      Write('������� ����讥 �᫮ !');
      TextAttr:=OldColors; ClrEol; BigNumber:=True
    end else begin {��� ��� !}
      x:=Temp; if Sign='-' then x:=-x;
      y:=x+1; GotoXY(8,10); Write('�⢥� Y = ',y);
//  �⠭����� ��� ����񭭮�� �᫠
      GotoXY(8,5); Write('������ X = ',x); ClrEol
    end;
  end;
  ButtonCode:=MessageBox(0,OnceMore,MsgCapture,
              MB_YESNO+MB_ICONASTERISK+MB_DEFBUTTON2);
until ButtonCode=IDNO;

GotoXY(8,24); TextAttr:=16*Blue+White;
WriteLn('����� ���������. ������ ENTER...');
TextAttr:=OldColors; ReadLn

end.

