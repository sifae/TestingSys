program MsgBox;
   uses Crt,Windows;

   var
     sCap: pChar='���������'; { ��ப� � ��� ��� � C }
     sText: pChar='Hi! �ਢ��!'+#13+#10+'���� ��ப�';
     sTxt: String='Hi! �ਢ��!'#13#10'���� ��ப� � String';
     handle: integer; ButtonCode: word;

begin
   ClrScr;
   SetConsoleTitle ('���� ᮮ�饭��');
// ��४���஢�� � Windows
   OemToChar(sText,sText); OemToChar(sCap,sCap);

   ButtonCode:=MessageBox(handle,sText,sCap,
                          MB_YESNOCANCEL+MB_ICONQUESTION+MB_HELP);

   ButtonCode:=MessageBox(handle,'Hello!'+#13+#10+'Second Line',
                         '���������1',MB_ABORTRETRYIGNORE+MB_ICONASTERISK);

// ������:
//   MB_OK (0h),MB_OKCANCEL (1h),MB_ABORTRETRYIGNORE (2h)
//   MB_YESNOCANCEL (3h),MB_YESNO (4h),MB_RETRYCANCEL (5h)
//   MB_CANCELTRYCONTINUE (6h)
// ���箪:
//   MB_ICONSTOP (10h - ����-�⮯),MB_ICONQUESTION (20h - ? (�����))
//   MB_ICONEXCLAMATION (30h - !), MB_ICONASTERISK (40h - i � ��㣥)
//   MB_HELP (4000h ������ �ࠢ�� ��� ���� ������)
// ����� ������ �� 㬮�砭��:
//   MB_DEFBUTTON1,2,3,4 (0h,100h,200h,300h)
// ��� ������:
//   IDOK(1),IDCANCEL(2) [��� ESC ��� ���⨪ ������� ����]
//   IDABORT(3),IDRETRY(4),IDIGNORE(5),IDYES(6),IDNO(7)
//   IDTRYAGAIN(10),IDCONTINUE(11)

   GotoXY(10,5); Writeln('Button Code=',ButtonCode);

   readln;

end.
