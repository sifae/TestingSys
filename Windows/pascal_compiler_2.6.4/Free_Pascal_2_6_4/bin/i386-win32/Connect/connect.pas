{ $OUTPUT_FORMAT MASM}
Program Connect;
   uses Crt,Windows;

{ $ OBJECTPATH c:\temp}
{ $ LIBRARYPATH 'c:\temp'}
{ $ LINKLIB 'user32.lib'}
{ $ LINKLIB masm32.lib}

 {;kernel32.lib;msvcrt.lib;io_proc.lib}

Function FU(a,b:Longint):Longint;
   stdcall; external name '_FU@0';
{$L connect_asm.obj}
   Var ss:Longint;
begin
   ClrScr;
   SetConsoleTitle ('�맮� �㭪樨 ��ᥬ����');
   Writeln('Proramm Connect');
   ss:=FU(11111,22222);
   Writeln('FU=',ss);
   Readln;
   Readln
end.
