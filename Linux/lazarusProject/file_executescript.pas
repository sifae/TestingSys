unit File_ExecuteScript;

interface

function executeScript() : Integer;

implementation

uses
   Classes, SysUtils, Process;

function executeScript();
 // Опишем переменную "AProcess"
 // типа "TProcess"
  var
    AProcess: TProcess;

 // Здесь наша программа начинается
begin
   // Создаем объект  TProcess и
   // присваиваем его переменной AProcess.
   AProcess := TProcess.Create(nil);

   // Сообщаем новому AProcess, что это за команда для выполнения.
   // Давайте использовать компилятор Free Pascal (версия i386)
   AProcess.Executable:= 'fpc';

   // Передаеv -vu -Sg w вместе с fpc, чтобы фактически выполнить 'fpc -vu -Sg w':
   AProcess.Parameters.Add(' -vu -Sg w');

   // Мы определим опцию, когда программа
   // будет запущена. Эта опция гарантирует, что наша программа
   // не продолжит работу, пока программа, которую мы запустили,
   // не перестанет работать. vvvvvvvvvvvvvv
   AProcess.Options := AProcess.Options + [poWaitOnExit];

   // Теперь пусть Process запустит программу
   AProcess.Execute;

   // Пока ppc386 не прекратит работу, мы досюда не дойдем
   AProcess.Free;
 end.
