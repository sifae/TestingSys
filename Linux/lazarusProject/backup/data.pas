unit Data;

{$mode objfpc}{$H+}

interface

  {procedure extracting tests from the file 'tests_chapter_<chosen number>' and forming files with the
  initial data and correct results}
function extract_data: boolean;

{Procedure that fills the array varparam, that is, define types of actual parameters that can be passed by reference only}
procedure setvarparam(var s: string);

implementation

uses SysUtils, file00, Forms, file02, Dialogs, file09;

{procedure extracting tests from the file 'tests_chapter_<chosen number>' and forming files with the
initial data and correct results}
function extract_data: boolean;
  //Attention! Integer variables xx21, xx22 and next are used for random tests!
var
  xx29, xx21, xx22, xx23, xx24, xx25, xx26, xx27, xx28: integer;
  sd: set of char;
  sa: array[1..5] of string;
  se, sf: string;
  //Attention! Real variables xx31, xx32 and next are used for random tests!
var
  xx39, xx38, xx37, xx31, xx32, xx33, xx34, xx35, xx36: real;
  ss31, ss32: string;
  //q1,q2,q3:integer;s5:string;
var
  auto: boolean;
  jj3, jj5, jj6, jj7: boolean;
var
  ii4, dif, ii2i, p3, xx13: integer;
  xx16, xx17, xx18, xx19, xx14, xx15, xx9, xx10, xx11, xx12, xx3, xx4, xx5, xx6, xx7,
  xx8, xx1, yy1, xx2, yy2, yy, xx: real;
var
  g1, g, f: textfile;
  b1, b: boolean;
  pp, kk, j, q, l, p, k, i: integer;
  s1, s: string;
  h: t_f;
  s7: ansistring;
begin
  extract_data := False;
  auto := form2.checkbox1.Checked;
  form2.CheckBox1.Checked := False;
  jj3 := form2.button3.Enabled;
  jj5 := form2.button5.Enabled;
  jj6 := form2.button6.Enabled;
  jj7 := form2.button7.Enabled;
  form2.button3.Enabled := False;
  form2.button5.Enabled := False;
  form2.button6.Enabled := False;
  form2.button7.Enabled := False;
  //showmessage(inttostr(task_claims_amount));
  for i := 1 to max_test_number do
  begin
    assignfile(f, current_dir + '/tmp/iii' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    assignfile(f, current_dir + '/tmp/ooo' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    assignfile(f, current_dir + '/tmp/rrr' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    assignfile(f, current_dir + '/tmp/iiii' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    assignfile(f, current_dir + '/tmp/oooo' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
    assignfile(f, current_dir + '/tmp/rrrr' + IntToStr(i));
    closefile(f);
    ioresult;
    erase(f);
    ioresult;
  end; {of for}
  b := True;
  if chosen_task <> '' then
  begin
    Assign(h, current_dir + '/tests/' + directory_names[chosen_chapter] + '/tests.cde');
    initializef(h, i_n, i_c, s_n, True);// Is it necessary here?
  end
  else
    b := False;
  if not b then
  begin
    closefile(f);
    ioresult;
    ShowMessage('Fatal error 1!');
    exit;
  end;
  b := False;
  b1 := False;
  while not EOF(h) and (not b1) do
    {while not eof}
  begin
    b1 := readlnf(h, s);
    p := pos(';', s);
    if p > 0 then
      s := copy(s, 1, p - 1);
    while (s <> '') and (s[length(s)] = chr(32)) do
      s := copy(s, 1, length(s) - 1);
    if s <> '' then
      s := copy(s, 2, 200);
    if s = chosen_task then
      {of chosen task}
    begin

      //First lines contain information about claims to the task - each odd line contains what words the program must contain and each next even line contains information that is output
      //if the program does not satisfy the current claim

      program_sub := False;
      noclaims := False;
      func_proc := 0;
      func_proc0 := 0;
      task_claims_amount := 0;
      text_after := '';
      text_before := '';
      text_after0 := '';
      text_before0 := '';
      for xx21 := 1 to 20 do
        varparam[xx21] := '';
      while not EOF(h) do
      begin
        readlnf(h, s);
        while (s <> '') and (s[1] = ' ') do
          Delete(s, 1, 1);
        if (length(s) < 3) or (s[1] = ' ') then
        begin
          if en_rus then
            ShowMessage(
              'Fatal error with claims to the chosen task or with amount of the tests. A line is too short or its first character is blank.')
          else
            ShowMessage(
              'Фатальная ошибка в строке, содержащей требования к задаче или количество тестов. ');
          exit;
        end;

        if (s[1] in ['0'..'9']) or (EOF(h)) then
          break;
        task_claims[task_claims_amount + 1].b := False;
        if (s[1] in ['w', 'W']) and (s[2] = ' ') then
        begin
          task_claims[task_claims_amount + 1].b1 := True;
          Delete(s, 1, 2);
        end
        else
          task_claims[task_claims_amount + 1].b1 := False;
        task_claims[task_claims_amount + 1].s1 := s;
        readlnf(h, s);
        if (length(s) < 3) or (s[1] = ' ') then
        begin
          if en_rus then
            ShowMessage('Fatal error with claims to the chosen task.')
          else
            ShowMessage('Фатальная ошибка в строке, содержащей требования к задаче.');
          exit;
        end;

        pp := pos('!', s);
        if pp = 0 then
        begin
          task_claims[task_claims_amount + 1].s2 := s;
          task_claims[task_claims_amount + 1].s3 := s;
        end
        else
        begin
          task_claims[task_claims_amount + 1].s2 := copy(s, 1, pp - 1);
          task_claims[task_claims_amount + 1].s3 := copy(s, pp + 1, 200);
        end;
        Inc(task_claims_amount);
      end; //of While not eof(h)


      if EOF(h) then
      begin
        ShowMessage('Fatal error in claims to the task - unexpected end of file ');
        exit;
      end;
      //s - information about the chosen task - the first line after the claims to the task - contains number of tests and the results' types
      ioresult;
      if (s <> '') and (pos(';', s) > 0) then
        s := copy(s, 1, pos(';', s) - 1);

      //showmessage(s);
      //showmessage(inttostr(task_claims_amount));

      if (pos('program+sub', s) > 0) and ((pos('procedure', s) > 0) or (pos('Procedure', s) > 0) or
        (pos('function', s) > 0) or (pos('Function', s) > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. The algorithm cannot be both a program and a subprogram.')
        else
          ShowMessage(
            'Ошибка. Алгоритм не может быть программой и подпрограммой одновременно.');
        exit;
      end;
      p := pos('program+sub', s);
      program_sub := p > 0;
      number_of_tests := 0;
      number_of_subtests := 0;
      if program_sub then
        s := copy(s, 1, p - 1) + copy(s, p + 11, length(s));
      for xx29 := 1 to 1 + byte(program_sub) do
      begin
        delete_blanks(s);
        p := pos(' ', s);
        if p <= 1 then
        begin
          closefile(h);
          ioresult;
          if en_rus then
            ShowMessage('Error with amount of the tests - no number ' + IntToStr(xx29) + '.')
          else
            ShowMessage('Ошибка в задании количества тестов - нет числа №'
              +
              IntToStr(xx29) + '.');
          exit;
        end;
        //k - the current number of tests
        val(copy(s, 1, p - 1), k, q);
        if (q <> 0) or not (k in [1..max_test_number]) then
        begin
          closefile(h);
          ioresult;
          if en_rus then
            ShowMessage('Error with amount of the tests.')
          else
            ShowMessage('Ошибка в количестве тестов.');
          exit;
        end;
        if xx29 = 1 then
          Number_of_tests := k
        else
          Number_of_subtests := k;
        s := copy(s, p + 1, 200);
      end;


      //showmessage('We are here!'+inttostr(ord(noclaims)));

      //showmessage(inttostr(number_of_tests)+' '+inttostr(number_of_subtests));
      p := pos('noclaims', s);
      if p = 0 then
        p := pos('Noclaims', s);
      if p > 0 then
      begin
        noclaims := True;
        Delete(s, p, 8);
        delete_blanks(s);
      end;
      //Some peculiarities of the input and output

      //showmessage('We are here!'+inttostr(ord(noclaims)));


      delete_blanks(s);
      func_proc0 := 0;
      p := pos('functionprocedure', s);
      if p = 0 then
        p := pos('Functionprocedure', s);
      if p = 0 then
        p := pos('Procedurefunction', s);
      if p = 0 then
        p := pos('procedurefunction', s);
      if p > 0 then
      begin
        func_proc0 := 3;
        Delete(s, p, 17);
        delete_blanks(s);
      end;
      p := pos('function', s);
      if p = 0 then
        p := pos('Function', s);
      if p > 0 then
      begin
        func_proc0 := 1;
        Delete(s, p, 8);
        delete_blanks(s);
      end;
      p := pos('procedure', s);
      if p = 0 then
        p := pos('Procedure', s);
      if p > 0 then
      begin
        func_proc0 := 2;
        Delete(s, p, 9);
      end;
      delete_blanks(s);
      p := pos('matrixin', s);
      if p = 0 then
        p := pos('Matrixin', s);
      if p = 0 then
      begin
        matrixin := 0;
        matrixins := 0;
      end
      else
      begin
        if (length(s) < p + 8) or (not (s[p + 8] in ['0'..'9'])) then
        begin
          if en_rus then
            ShowMessage('Error in line ' + s +
              ' . An amount of matrices in the input data must be specified after the word ''Matrixin''')
          else
            ShowMessage('Oшибка в строке ' +
              s + ' . После слова ''Matrixin'' должно быть указано количество матриц во входном потоке.');
          exit;
        end;
        if program_sub and (length(s) > p + 8) and (s[p + 9] in ['0'..'9']) then
        begin
          dif := 1;
          matrixin := StrToInt(s[p + 8]);
          matrixins := StrToInt(s[p + 9]);
        end
        else
        begin
          dif := 0;
          matrixin := StrToInt(s[p + 8]);
          matrixins := StrToInt(s[p + 8]);
        end;
        Delete(s, p, 9 + dif);
      end;
      delete_blanks(s);
      p := pos('matrixout', s);
      if p = 0 then
        p := pos('Matrixout', s);
      if p = 0 then
      begin
        matrixout := 0;
        matrixouts := 0;
      end
      else
      begin
        if (length(s) < p + 9) or (not (s[p + 9] in ['0'..'9'])) then
        begin
          if en_rus then
            ShowMessage('Error in line ' + s +
              ' . An amount of matrices in the output data must be specified after the word ''Matrixout''')
          else
            ShowMessage('Oшибка в строке ' +
              s + ' . После слова ''Matrixout'' должно быть указано количество матриц в выходном потоке.');
          exit;
        end;
        if program_sub and (length(s) > p + 9) and (s[p + 10] in ['0'..'9']) then
        begin
          dif := 1;
          matrixout := StrToInt(s[p + 9]);
          matrixouts := StrToInt(s[p + 10]);
        end
        else
        begin
          dif := 0;
          matrixout := StrToInt(s[p + 9]);
          matrixouts := StrToInt(s[p + 9]);
        end;
        Delete(s, p, 10 + dif);
      end;
      delete_blanks(s);

      p := pos('Arrayin', s);
      if p = 0 then
        p := pos('arrayin', s);
      if p = 0 then
      begin
        arrayin := 0;
        arrayins := 0;
      end
      else
      begin
        if (length(s) < p + 7) or (not (s[p + 7] in ['0'..'9'])) then
        begin
          if en_rus then
            ShowMessage('Error in line ' + s +
              ' . An amount of arrays (1 - 9) in the input data must be specified after the word ''Arrayin''')
          else
            ShowMessage('Oшибка в строке ' +
              s + ' . После слова ''Arrayin'' должно быть указано количество массивов (1 - 9) во входном потоке.');
          exit;
        end;
        if program_sub and (length(s) > p + 7) and (s[p + 8] in ['0'..'9']) then
        begin
          dif := 1;
          arrayin := StrToInt(s[p + 7]);
          arrayins := StrToInt(s[p + 8]);
        end
        else
        begin
          dif := 0;
          arrayin := StrToInt(s[p + 7]);
          arrayins := StrToInt(s[p + 7]);
        end;
        Delete(s, p, 8 + dif);
      end;
      delete_blanks(s);

      p := pos('Arrayout', s);
      if p = 0 then
        p := pos('arrayout', s);
      if p = 0 then
      begin
        arrayout := 0;
        arrayouts := 0;
      end
      else
      begin
        if (length(s) < p + 8) or (not (s[p + 8] in ['0'..'9'])) then
        begin
          if en_rus then
            ShowMessage('Error in line ' + s +
              ' . An amount of arrays (1 - 9) in the output data must be specified after the word ''Arrayout''')
          else
            ShowMessage('Oшибка в строке ' +
              s + ' . После слова ''Arrayout'' должно быть указано количество массивов (1 - 9) в выходном потоке.');
          exit;
        end;
        if program_sub and (length(s) > p + 8) and (s[p + 9] in ['0'..'9']) then
        begin
          dif := 1;
          arrayout := StrToInt(s[p + 8]);
          arrayouts := StrToInt(s[p + 9]);
        end
        else
        begin
          dif := 0;
          arrayout := StrToInt(s[p + 8]);
          arrayouts := StrToInt(s[p + 8]);
        end;
        Delete(s, p, 9 + dif);
      end;
      delete_blanks(s);


      p := pos('Fileinc', s);
      if p = 0 then
        p := pos('fileinc', s);
      if (p > 0) and ((arrayin > 0) or (matrixin > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. Input data cannot be both a binary file and an array.')
        else
          ShowMessage(
            'Ошибка. Входные данные не могут быть одновременно типизированным фaйлом и массивом.');
        exit;
      end;
      filein := byte(p > 0);
      if p > 0 then
      begin
        Delete(s, p, 7);
        delete_blanks(s);
      end;

      if filein = 0 then
      begin
        p := pos('Fileini', s);
        if p = 0 then
          p := pos('fileini', s);
        if (p > 0) and ((arrayin > 0) or (matrixin > 0)) then
        begin
          if en_rus then
            ShowMessage('Error. Input data cannot be both a binary file and an array.')
          else
            ShowMessage(
              'Ошибка. Входные данные не могут быть одновременно типизированным фaйлом и массивом.');
          exit;
        end;
        filein := 2 * byte(p > 0);
        if p > 0 then
        begin
          Delete(s, p, 7);
          delete_blanks(s);
        end;
      end;

      p := pos('Fileout', s);
      if p = 0 then
        p := pos('fileout', s);
      if (p > 0) and ((arrayout > 0) or (matrixout > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. Output data cannot be both a binary file and an array.')
        else
          ShowMessage(
            'Ошибка. Выходные данные не могут быть одновременно типизированным фaйлом и массивом.');
        exit;
      end;
      fileout := byte(p > 0);
      if p > 0 then
      begin
        Delete(s, p, 7);
        delete_blanks(s);
      end;


      textsin := 0;
      p := pos('textin', s);
      if p = 0 then
        p := pos('Textin', s);
      if (p > 0) and ((arrayin > 0) or (matrixin > 0) or (filein > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. Input data cannot be both a text file and an array or a binary file.'
            )
        else
          ShowMessage(
            'Ошибка. Входные данные не могут быть одновременно текстовым фaйлом и массивом или типизированным файлом.');
        exit;
      end;
      textsin := byte(p > 0);
      if p > 0 then
      begin
        Delete(s, p, 6);
        delete_blanks(s);
      end;

      textsout := 0;
      p := pos('textout', s);
      if p = 0 then
        p := pos('Textout', s);
      if (p > 0) and ((arrayout > 0) or (matrixout > 0) or (fileout > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. Output data cannot be both a text file and an array or a binary file.'
            )
        else
          ShowMessage(
            'Ошибка. Выходные данные не могут быть одновременно текстовым фaйлом и массивом или типизированным файлом.');
        exit;
      end;
      textsout := byte(p > 0);
      if p > 0 then
      begin
        Delete(s, p, 7);
        delete_blanks(s);
      end;


      p := pos('run_time_err', s);
      if p = 0 then
        p := pos('Run_time_err', s);
      run_time_err := False;
      if p > 0 then
      begin
        Delete(s, p, 12);
        delete_blanks(s);
        run_time_err := True;
      end;
      p := pos('Error', s);
      if (arrayin > 0) and ((matrixin > 0) or (matrixout > 0)) or (arrayout > 0) and
        ((matrixin > 0) or (matrixout > 0)) then
      begin
        if en_rus then
          ShowMessage('Error. Input or output data cannot be both a one-dimensional array and a matrix.'
            )
        else
          ShowMessage(
            'Ошибка. Входные или выходные данные не могут быть одновременно одномерным массивом и матрицей.');
        exit;
      end;

      if p = 0 then
        p := pos('error', s);
      if p = 0 then
        errorr := False
      else
      begin
        errorr := True;
        Delete(s, p - 1, 5);
      end;
      p := pos('Any_order', s);
      if p = 0 then
        p := pos('any_order', s);
      if p = 0 then
        sorts := 0
      else
      begin
        Delete(s, p - 1, 1000);
        if (pos('b', s) > 0) or (pos('c', s) > 0) or (pos('s', s) > 0) or (pos('i', s) > 0) and (pos('r', s) > 0) then
        begin
          if en_rus then
            ShowMessage('Error in line ' + s +
              ' . Only numerical data of type either integer or real can be sorted.')
          else
            ShowMessage('Oшибка в строке ' +
              s + ' . Copтировать можно только данные либо вещественного, либо целого типа.');
          exit;
        end;
        if pos('i', s) > 0 then
          sorts := 2
        else
          sorts := 1;
      end;
      while (s <> '') and (s[length(s)] = ' ') do
        s := copy(s, 1, length(s) - 1);
      if s = '' then
      begin
        closefile(h);
        ioresult;
        ShowMessage('Fatal error 7!');
        exit;
      end;
      l := 1;
      while (s <> '') and (s[1] <> ' ') do
      begin
        result_type[1, l] := s[1];
        s := copy(s, 2, 200);
        l := l + 1;

        //showmessage(s+'  '+inttostr(l));
        //NO!!!! Read the next line! //The information to the right is outdated now. ATTENTION! TYPES OF RESULTS MAY BE DIFFERENT FOR ODD AND EVEN TESTS! I DO NOT USE IT NOW BUT IT IS POSSIBLE AND IT IS REALIZED HERE!!!
        //It is different now. Elements of the first row are the tyies of results for the main program and elements of the second row are the types of results for the subprogram.
        if l > max_results_number then
        begin
          closefile(h);
          ioresult;
          ShowMessage('Fatal error 10! Too many results.');
          exit;
        end;
      end;
      for ii4 := L to max_results_number do
        result_type[1, ii4] := result_type[1, L - 1];
      while (s <> '') and (s[1] = ' ') do
        Delete(s, 1, 1);

      if s = '' then
      begin
        number_of_results[1] := l - 1;
        number_of_results[2] := l - 1;
        for i := 1 to max_results_number do
          result_type[2, i] := result_type[1, i];
      end
      else
      begin
        number_of_results[1] := l - 1;
        l := 1;
        while (s <> '') do
        begin
          if s[1] <> ' ' then
          begin
            result_type[2, l] := s[1];
            l := l + 1;
            if l > max_results_number then
            begin
              closefile(h);
              ioresult;
              ShowMessage('Fatal error 11!');
              exit;
            end;
          end;
          s := copy(s, 2, 200);
        end;
        number_of_results[2] := l - 1;
        for ii4 := L to max_results_number do
          result_type[2, ii4] := result_type[2, L - 1];
      end;

      //showmessage(result_type[1,1]+result_type[1,2]+result_type[1,3]+result_type[1,4]+result_type[1,5]+result_type[1,6]);
      //showmessage(result_type[2,1]+result_type[2,2]+result_type[2,3]+result_type[2,4]+result_type[2,5]+result_type[2,6]);

      b := True;
      for i := 1 to number_of_results[1] do
        b := b and (result_type[1, i] in ['s', 'i', 'r', 'c', 'b']);
      for i := 1 to number_of_results[2] do
        b := b and (result_type[2, i] in ['s', 'i', 'r', 'c', 'b']);
      //showmessage(inttostr(number_of_results[1])+' '+inttostr(number_of_results[2])+' '+inttostr(byte(b)));
      if not b then
      begin
        closefile(h);
        ioresult;
        if en_rus then
          ShowMessage('Fatal error 4! Wrong type of data. Types s i r c b are allowed only.')
        else
          ShowMessage('Неверный тип данных. Допустимы только s i r c b.');
        exit;
      end;
      readlnf(h, s);
      //Information about the current task - the second line - eight constants or 'N' if no constants are needed; can be the main program text (two lines, the first one begins with the word 'Text'
      //if the algorithm must be presented as a procedure or a function
      if (s = '') or (s[1] = ' ') then
      begin
        closefile(h);
        ioresult;
        ShowMessage('Fatal error 6!');
        exit;
      end;
      for i := 1 to 4 do
      begin
        consts[i, 1] := 0;
        consts[i, 2] := 0;
      end;
      while (s[length(s)] = ' ') do
        s := copy(s, 1, length(s) - 1);

      if program_sub then
        if (copy(s, 1, 4) <> 'Text') and (copy(s, 1, 4) <> 'text') then
        begin
          if en_rus then
            ShowMessage('Error. No program text was found after the first line.')
          else
            ShowMessage('Ошибкa. Не найден текст программы после первой строки.');
          exit;
        end;
      if ((copy(s, 1, 4) = 'Text') or (copy(s, 1, 4) = 'text')) and ((func_proc0 > 0) or program_sub) then
      begin
        text_before := copy(s, 5, length(s));
        delete_blanks(text_before);
        setvarparam(text_before);
        readlnf(h, text_after);
        delete_blanks(text_after);
        text_before0 := text_before;
        text_after0 := text_after;
        if (text_after = '') or (copy(text_after, length(text_after) - 3, 4) <> 'end.') then
        begin
          if en_rus then
            ShowMessage('Error in line ''' + text_after + '''. It must end with ''end.''')
          else
            ShowMessage('Oшибка в строке ' + text_after +
              '; oна должна заканчиваться символами ''end.''');
          exit;
        end;

        p3 := pos('<name>', text_after);
        if (p3 = 0) then
        begin
          if en_rus then
            ShowMessage('Error in line ''' + text_after +
              '''. No strings ''<name>'' were found. The string ''<name>'' must be present in the text; it is replaced by the function/procedure name.')
          else
            ShowMessage('Ошибка в строке ' + text_after +
              '. Не найденa пoдстрока ''<name>''. Такая подстрока должна присутствовать в тексте; она заменяется на имя процедуры/функции.');
          exit;
        end;

        if text_after = '' then
        begin
          if en_rus then
            ShowMessage('Error. A part of the program to be inserted after the function/procedure is empty.')
          else
            ShowMessage(
              'Ошибкa. Часть программы, которая должна быть вставлена после процедуры/функции, является пустой.');
          exit;
        end;
        readlnf(h, s);
      end;

      //showmessage(s);
      delete_blanks(s);
      if s[1] <> 'N' then
        for i := 1 to 8 do
        begin
          p := pos(' ', s);
          if (i < 8) and (p = 0) or (i = 8) and (p > 0) then
          begin
            closefile(h);
            ioresult;
            ShowMessage('Fatal error 8! The line ''' + s +
              ''' must contain 8 constants or the capital letter N only if no constants are needed.');
            exit;
          end;
          if p = 0 then
            val(s, j, q)
          else
            val(copy(s, 1, p - 1), j, q);
          if p <> 0 then
            s := copy(s, p + 1, 200);
          if q <> 0 then
          begin
            closefile(h);
            ioresult;
            if en_rus then
              ShowMessage('Fatal error 9! The line ''' + s +
                ''' must contain 8 constants or the capital letter N only if no constants are needed.')
            else
              ShowMessage('Fatal error 9! Строка ''' + s +
                ''' должна содержать 8 констант или заглавную букву N, если константы не нужны.');
            exit;
          end;
          consts[(i + 1) div 2, 2 - i mod 2] := j;
          if p = 0 then
            break;
        end;
      //showmessage(inttostr(consts[1]));
      closefile(g);
      ioresult;
      closefile(f);
      ioresult;
      s1 := getcurrentdir;

      //showmessage(inttostr(k));
      for ii2i := 1 to 1 + byte(program_sub) do
      begin
        if ii2i = 1 then
          k := number_of_tests
        else
          k := number_of_subtests;
        for i := 1 to k do
        begin
          if ii2i = 1 then
            Assign(g, s1 + '/tmp/iii' + IntToStr(i))
          else
            Assign(g, s1 + '/tmp/iiii' + IntToStr(i));
          rewrite(g);
          readlnf(h, s7);
          ioresult;
          j := pos(';', s7);
          if j > 0 then
            s7 := copy(s7, 1, j - 1);
          //if (copy(chosen_task,1,4)='8_44') then begin
          //kk:=pos(' ',s7); if kk>0 then begin writeln(g, copy(s7,1, kk-1)); writeln(g,copy(s7, kk+1,100)) end
          //else writeln(g,s7);
          //end
          //else
          repeat
            j := pos(' /n', s7);
            if j = 0 then
            begin
              writeln(g, s7);
              break;
            end
            else
            begin
              writeln(g, copy(s7, 1, j - 1));
              Delete(s7, 1, j + 2);
            end;
          until j = 0;
          closefile(g);
          if ii2i = 1 then
            Assign(g, s1 + '/tmp/ooo' + IntToStr(i))
          else
            Assign(g, s1 + '/tmp/oooo' + IntToStr(i));
          rewrite(g);
          readlnf(h, s7);
          ioresult;
          j := pos(';', s7);
          if j > 0 then
            s7 := copy(s7, 1, j - 1);
          writeln(g, s7);
          closefile(g);
        end; //of for from 1 to number of tests or subtests}
      end; //of for from 1 to 1+byte(program+sub)
      //A special random test for the task 4.12a
      if chosen_task = '4_12-001' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx14 := random(30) / 10 + 3;
        xx15 := -abs(xx14 - 1) / 2 / xx14;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx14: 1: 10);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx15: 1: 10);
        closefile(g);
      end;
      k := number_of_tests;
      //A special random test for the task 4.12-003
      if chosen_task = '4_12-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx14 := random(30) / 10 + 3;
        xx15 := random(30) / 10 + 3;
        xx16 := random(30) / 10 + 3;
        xx17 := xx14 * 2 - 0.1;
        xx18 := xx15 * 2;
        xx19 := xx16 * 2 + 2 + random(10) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx14: 1: 5, '  ', xx15: 1: 5, '  ', xx16: 1: 5, '  ', xx17: 1: 5, '  ',
          xx18: 1: 5, '  ', xx19: 1: 5, ' ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, (xx16 * xx18 - xx19 * xx15) / (xx14 * xx18 - xx17 * xx15): 1: 10, '  ',
          (xx14 * xx19 - xx17 * xx16) / (xx14 * xx18 - xx17 * xx15): 1: 10);
        closefile(g);
      end;
      //A special random test for the task 4.12-006
      if chosen_task = '4_12-006' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx14 := random(30) / 10 + 3;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx14: 1: 5, '  ', xx14 - 0.01: 1: 5, '  ', xx14 + 0.04: 1: 5);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, 1);
        closefile(g);
      end;

      //A random test for the task 4.12-007
      if chosen_task = '4_12-007' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) + 3;
        xx22 := random(20) + 3;
        xx23 := random(20) + 3;
        xx24 := random(12) + 4;
        xx25 := random(12) + 4;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx21, '  ', xx22, '  ', xx23, ' ', xx24 * 60 + xx25);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx21, ' ', xx22 + xx24, ' ', xx23 + xx25);
      end;

      //4 random tests for the task 4.12-009
      if chosen_task = '4_12-009' then
      begin
        number_of_tests := number_of_tests + 4;
        k := k + 4;
        randomize;
        xx21 := (random(25) + 25) * 2 + 1;
        xx22 := (xx21 * xx21 + 7) div 8;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k - 3));
        rewrite(g);
        writeln(g, xx22);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k - 3));
        rewrite(g);
        writeln(g, 1);
        closefile(g);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k - 2));
        rewrite(g);
        writeln(g, 2 + xx22);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k - 2));
        rewrite(g);
        writeln(g, 0);
        closefile(g);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k - 1));
        rewrite(g);
        writeln(g, xx22 - 2);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k - 1));
        rewrite(g);
        writeln(g, 0);
        closefile(g);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, ((xx21 + 2) * (xx21 + 2) + 7) div 8);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, 1);
        closefile(g);
      end;

      {A special random test for tasks 5.20...}
      if copy(chosen_task, 1, 4) = '5_20' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx := (random(100) + 20) / 130;
        if (chosen_task[6] = 'б') or (copy(chosen_task, 6, 3) = '002') then
          yy := (exp(xx) - exp(-xx)) / 2;
        if (chosen_task[6] = 'в') or (copy(chosen_task, 6, 3) = '003') then
          yy := cos(xx);
        if (chosen_task[6] = 'г') or (copy(chosen_task, 6, 3) = '004') then
          yy := ln(1 + xx);
        if (chosen_task[6] = 'д') or (copy(chosen_task, 6, 3) = '005') then
          yy := arctan(xx);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx: 1: 10);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, yy: 1: 10);
        closefile(g);
      end;

      {A randon testr for the task 5.52}
      if chosen_task = '5_52' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(5) + 4;
        xx22 := xx21 + random(3) + 1;
        xx23 := -random(5) - 4;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, 1, ' ', xx21 + xx22 + xx23, ' ', xx21 * xx22 + (xx21 + xx22) * xx23, ' ', xx21 * xx22 * xx23);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, -xx22: 1, ' ', -xx21: 1, ' ', -xx23: 1);
        closefile(g);
      end;


      {A special random test for the task 8.29в}
      if chosen_task = '8_29_в' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := (random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' ', xx2: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx2: 1: 1, ' ', xx1: 1: 1);
        closefile(g);
      end;

      {A special random test for the task 8.29д}
      if chosen_task = '8_29_д' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := (random(100) + 20) / 10;
        yy1 := (random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' ', xx2: 1: 1, ' ', yy1: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, yy1: 1: 1, ' ', xx1: 1: 1, ' ', xx2: 1: 1);
        closefile(g);
      end;

      {A special random test for the task 8.29е}
      if chosen_task = '8_29_е' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := (random(100) + 20) / 10;
        yy1 := (random(100) + 20) / 10;
        xx := (random(100) + 20) / 10;
        yy := (random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' ', xx2: 1: 1, ' ', yy1: 1: 1, ' ', xx: 1: 1, ' ', yy: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, yy1: 1: 1, ' ', xx: 1: 1, ' ', yy: 1: 1, ' ', xx1: 1: 1, ' ', xx2: 1: 1);
        closefile(g);
      end;

      {A special random test for the task 8.29ж}
      if chosen_task = '8_29_ж' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := (random(100) + 20) / 10;
        yy1 := (random(100) + 20) / 10;
        xx := (random(100) + 20) / 10;
        yy := (random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, '0 ', xx1: 1: 1, ' 0 0 ', xx2: 1: 1, ' 0 ', yy1: 1: 1, ' ', xx: 1: 1, ' ', yy: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' ', xx2: 1: 1, ' ', yy1: 1: 1, ' ', xx: 1: 1, ' ', yy: 1: 1, ' 0 0 0 0');
        closefile(g);
      end;

      {A special random test for the task 8.30a}
      if chosen_task = '8_30_а' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := -(random(100) + 20) / 10;
        yy1 := (random(100) + 20) / 10;
        xx := (random(100) + 20) / 10;
        yy := -(random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' 0 ', xx2: 1: 1, ' 0 ', yy1: 1: 1, ' ', xx: 1: 1, ' ', yy: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx2: 1: 1, ' ', yy: 1: 1, ' ', xx1: 1: 1, ' 0 0 ', yy1: 1: 1, ' ', xx: 1: 1);
        closefile(g);
      end;

      {A special random test for the task 8.32}
      if chosen_task = '8_32' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20) / 10;
        xx2 := xx1 + (random(100) + 20) / 10;
        yy1 := xx2 + (random(100) + 20) / 10;
        yy2 := yy1 + (random(100) + 20) / 10;
        xx := yy2 + (random(100) + 20) / 10;
        yy := xx + (random(100) + 20) / 10;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1: 1: 1, ' ', xx2: 1: 1, ' ', yy1: 1: 1, ' ', yy2: 1: 1,
          ' ', xx: 1: 1, ' ', yy: 1: 1, ' ', -xx1 - xx2: 1: 1, ' ', xx + yy: 1: 1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, '6');
        closefile(g);
      end;

      {A special random test for the task 8.35}
      if chosen_task = '8_35' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := (random(100) + 20);
        xx2 := xx1 + (random(100) + 20);
        yy1 := xx2 + (random(100) + 20);
        yy2 := yy1 + (random(100) + 20);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        if random(100) < 50 then
        begin
          xx := 0;
          writeln(g, xx1: 1: 0, ' ', xx2: 1: 0, ' ', yy1: 1: 0, ' ', xx2: 1: 0, ' ', yy1: 1: 0, ' ', yy2: 1: 0);
        end
        else
        begin
          xx := -1;
          writeln(g, yy1: 1: 0, ' ', xx2: 1: 0, ' ', yy1: 1: 0, ' ', xx2 + 3: 1: 0, ' ', xx1: 1: 0, ' ', yy2: 1: 0);
        end;
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx = 0 then
          writeln(g, '4')
        else
          writeln(g, '5');
        closefile(g);
      end;

      {A special random test for the task 9.5-005}
      if chosen_task = '9_5-005' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := random(100) + 20;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        if random(100) < 50 then
        begin
          xx := 0;
          writeln(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 3: 1: 0,
            ' ', xx1 + 4: 1: 0, ' ', xx1 + 5: 1: 0, ' ',
            xx1 + 7: 1: 0, ' ', xx1 + 9: 1: 0, ' ', xx1 + 12: 1: 0, ' ', xx1 + 13: 1: 0,
            ' ', xx1 + 14: 1: 0, ' ', xx1 + 17: 1: 0, ' ',
            xx1 - 3: 1: 0, ' ', xx1 + 11: 1: 0, ' ', xx1 + 19: 1: 0, ' ', xx1 + 18: 1: 0);
        end
        else
        begin
          xx := -1;
          writeln(g, xx1: 1: 0, ' ', xx1 + 21: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 3: 1: 0,
            ' ', xx1 - 5: 1: 0, ' ', xx1 + 5: 1: 0, ' ',
            xx1 + 7: 1: 0, ' ', xx1 + 9: 1: 0, ' ', xx1 + 12: 1: 0, ' ', xx1 + 13: 1: 0,
            ' ', xx1 + 14: 1: 0, ' ', xx1 + 17: 1: 0, ' ',
            xx1 - 3: 1: 0, ' ', xx1 + 11: 1: 0, ' ', xx1 + 19: 1: 0, ' ', xx1 + 18: 1: 0);
        end;
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx = 0 then
          writeln(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 3: 1: 0,
            ' ', xx1 + 4: 1: 0, ' ', xx1 + 5: 1: 0, ' ',
            xx1 + 7: 1: 0, ' ', xx1 + 9: 1: 0, ' ', xx1 + 12: 1: 0, ' ', xx1 + 13: 1: 0,
            ' ', xx1 + 14: 1: 0, ' ', xx1 + 17: 1: 0, ' ',
            xx1 + 19: 1: 0, ' ', xx1 + 11: 1: 0, ' ', xx1 - 3: 1: 0, ' ', xx1 + 18: 1: 0)
        else
          writeln(g, xx1: 1: 0, ' ', xx1 - 5: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 3: 1: 0,
            ' ', xx1 + 21: 1: 0, ' ', xx1 + 5: 1: 0, ' ',
            xx1 + 7: 1: 0, ' ', xx1 + 9: 1: 0, ' ', xx1 + 12: 1: 0, ' ', xx1 + 13: 1: 0,
            ' ', xx1 + 14: 1: 0, ' ', xx1 + 17: 1: 0, ' ',
            xx1 - 3: 1: 0, ' ', xx1 + 11: 1: 0, ' ', xx1 + 19: 1: 0, ' ', xx1 + 18: 1: 0);
        closefile(g);
      end;

      {A special random test for the tasks 9.17}
      if copy(chosen_task, 1, 4) = '9_17' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := random(100) + 20;
        xx2 := random(100) + 35;
        xx3 := random(100) + 20;
        xx4 := random(100) + 35;
        xx5 := random(100) + 20;
        xx6 := random(100) + 35;
        xx7 := random(100) + 20;
        xx8 := random(100) + 35;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        writeln(g, xx1, ' ', xx2, ' ', xx3, ' ', xx4, ' ', xx5, ' ',
          xx6, ' ', xx7, ' ', xx8, ' ', xx3 - 0.1);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if chosen_task = '9_17-002' then
          Write(g, xx1 + xx3 + xx5 + xx7 + xx3 - 0.1: 1: 3);
        if chosen_task = '9_17-003' then
          Write(g, xx1 + xx2 + xx3 + xx5 + xx7 + xx8 + xx3 - 0.1: 1: 3);
        if chosen_task = '9_17-004' then
          Write(g, xx2 + xx4 + xx5 + xx6 + xx8: 1: 3);

        closefile(g);
      end;

      {A special random test for the tasks 9.18-003 and 004}
      if (chosen_task = '9_18-003') or (chosen_task = '9_18-004') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        if chosen_task = '9_18-003' then
        begin
          xx1 := random(400) + 20;
          xx3 := random(400) + 20;
          xx2 := random(400) + 20;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Write(g, xx1: 1: 0, ' ', xx1 + 10: 1: 0, ' ', xx1 + 34: 1: 0, ' ', xx1 + 10: 1: 0, ' ', xx1: 1: 0, ' ');
          Write(g, xx2: 1: 0, ' ', xx2: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2: 1: 0, ' ', xx2: 1: 0, ' ');
          Write(g, xx3: 1: 0, ' ', xx3 + 1: 1: 0, ' ', xx3: 1: 0, ' ', xx3 + 1: 1: 0, ' ', xx3: 1: 0, ' ');
          xx1 := random(400) + 20;
          xx3 := random(400) + 20;
          xx2 := random(400) + 20;
          Write(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1: 1: 0, ' ', xx1: 1: 0, ' ');
          Write(g, xx2: 1: 0, ' ', xx2: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2: 1: 0, ' ');
          writeln(g, xx3: 1: 0, ' ', -xx3: 1: 0, ' ', xx3: 1: 0, ' ', -xx3: 1: 0, ' ', -xx3: 1: 0);
          closefile(g);
        end;

        if chosen_task = '9_18-004' then
        begin
          xx1 := random(400) + 20;
          xx3 := random(400) + 20;
          xx2 := random(400) + 20;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Write(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ', -xx1: 1: 0, ' ', -xx1 * 2: 1: 0, ' ');
          Write(g, xx2: 1: 0, ' ', xx2 - 1: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2 - 1: 1: 0, ' ', -xx2: 1: 0, ' ');
          Write(g, xx3: 1: 0, ' ', xx3 + 1: 1: 0, ' ', xx3: 1: 0, ' ', xx3 + 1: 1: 0, ' ', xx3: 1: 0, ' ');
          xx1 := random(400) + 20;
          xx3 := random(400) + 20;
          xx2 := random(400) + 20;
          Write(g, xx1 * 2: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 - 1: 1: 0, ' ', xx1: 1: 0, ' ', xx1 * 2: 1: 0, ' ');
          Write(g, xx2 - 2: 1: 0, ' ', xx2 - 20: 1: 0, ' ', xx2 - 32: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2 + 1: 1: 0, ' ');
          writeln(g, xx3: 1: 0, ' ', xx3: 1: 0, ' ', xx3 - 1: 1: 0, ' ', xx3 - 22: 1: 0, ' ', xx3 - 24: 1: 0);
          closefile(g);
        end;
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if chosen_task = '9_18-003' then
          Write(g, 'true true true false false false');
        if chosen_task = '9_18-004' then
          Write(g, 'false true true true true true');
        closefile(g);
      end;

      {Special random tests for the tasks 9.19- 1 -3 }
      if chosen_task = '9_19-001' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := random(100) - 55;
        xx2 := random(100) - 54;
        xx3 := random(100) - 55;
        xx4 := random(100) - 54;
        xx5 := random(100) - 55;
        xx6 := random(100) - 44;
        xx7 := random(100) - 45;
        xx8 := random(100) - 44;
        xx9 := random(100) - 35;
        xx10 := random(100) - 44;
        xx11 := random(100) - 55;
        xx12 := random(100) - 44;
        xx13 := 0;
        if (xx1 > xx5 + xx9) then
          Inc(xx13);
        if (xx5 > xx1 + xx9) then
          Inc(xx13);
        if (xx9 > xx1 + xx5) then
          Inc(xx13);
        if (xx2 > xx6 + xx10) then
          Inc(xx13);
        if (xx6 > xx2 + xx10) then
          Inc(xx13);
        if (xx10 > xx2 + xx6) then
          Inc(xx13);
        if (xx3 > xx7 + xx11) then
          Inc(xx13);
        if (xx7 > xx3 + xx11) then
          Inc(xx13);
        if (xx11 > xx3 + xx7) then
          Inc(xx13);
        if (xx4 > xx8 + xx12) then
          Inc(xx13);
        if (xx8 > xx4 + xx12) then
          Inc(xx13);
        if (xx12 > xx4 + xx8) then
          Inc(xx13);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx1: 1: 0, ' ', xx2: 1: 0, ' ', xx3: 1: 0, ' ', xx4: 1: 0, ' ', xx5: 1: 0, ' ', xx6: 1: 0, '  ');
        writeln(g, xx7: 1: 0, ' ', xx8: 1: 0, ' ', xx9: 1: 0, ' ', xx10: 1: 0, ' ', xx11: 1: 0, ' ', xx12: 1: 0);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx13);
        closefile(g);
      end;

      if chosen_task = '9_19-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := random(100) + 25;
        xx2 := random(100) + 24;
        xx3 := random(100) + 25;
        xx4 := random(100) + 24;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx1: 1: 0, ' ', xx1 - 1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 12: 1: 0, ' ', xx1 + 15: 1: 0, ' ');
        Write(g, xx2 - 11: 1: 0, ' ', xx2 - 9: 1: 0, ' ', xx2 + 1: 1: 0, ' ', xx2: 1: 0, ' ', xx2 + 15: 1: 0, ' ');
        if xx3 > xx4 then
          writeln(g, xx3: 1: 0, ' ', xx4: 1: 0, ' ', xx3: 1: 0, ' ', xx4: 1: 0, ' ', xx3 + xx4: 1: 0)
        else
          writeln(g, -xx3 - 1: 1: 0, ' ', -xx3: 1: 0, ' ', xx3: 1: 0, ' ', xx4: 1: 0, ' ', xx3: 1: 0);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx3 > xx4 then
          writeln(g, '7')
        else
          writeln(g, '8');
        closefile(g);
      end;

      if chosen_task = '9_19-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx2 := random(100);
        xx1 := random(100) + 25;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        if xx2 < 50 then
        begin
          Write(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ');
          Write(g, xx1 + 1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 1: 1: 0, '  ');
          writeln(g, xx1: 1: 0, ' ', xx1 + 10: 1: 0, ' ', xx1: 1: 0, ' ', xx1 + 15: 1: 0);
        end
        else
        begin
          Write(g, xx1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 1: 1: 0, ' ', xx1 + 2: 1: 0, ' ');
          Write(g, xx1 + 1: 1: 0, ' ', xx1: 1: 0, ' ', xx1 + 2: 1: 0, ' ', xx1 + 1: 1: 0, ' ');
          writeln(g, xx1: 1: 0, ' ', xx1 + 10: 1: 0, ' ', xx1: 1: 0, ' ', xx1 + 15: 1: 0);
        end;
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx2 < 50 then
          writeln(g, '4')
        else
          writeln(g, '5');
        closefile(g);
      end;

      {A special random test for the task 9.25}
      if chosen_task = '9_25' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx1 := random(1000) - 250;
        xx2 := random(1000) - 250;
        xx3 := random(1000) - 250;
        xx4 := random(1000) - 250;
        xx5 := random(1000) - 250;
        xx6 := random(1000) - 250;
        xx7 := random(1000) - 250;
        xx8 := random(1000) - 250;
        xx9 := random(1000) - 250;
        xx10 := random(1000) - 250;
        xx11 := random(1000) - 250;
        xx12 := random(1000) - 250;
        xx13 := random(1000) - 250;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx1: 1: 0, ' ', xx2: 1: 0, ' ', xx3: 1: 0, ' ', xx4: 1: 0, ' ', xx5: 1: 0, ' ');
        Write(g, xx6 + 1: 1: 0, ' ', xx7: 1: 0, ' ', xx8: 1: 0, ' ', xx9: 1: 0, ' ', xx10: 1: 0, ' ');
        Write(g, xx11: 1: 0, ' ', xx12: 1: 0, ' ', -xx1: 1: 0, ' ', -xx2: 1: 0, ' ', -xx3: 1: 0, ' ');
        Write(g, -xx4: 1: 0, ' ', -xx5 - 1: 1: 0, ' ', -xx6 + 1: 1: 0, ' ', -xx7: 1: 0, ' ', -xx8: 1: 0, ' ');
        writeln(g, -xx9 - 1: 1: 0, ' ', -xx10: 1: 0, ' ', -xx11: 1: 0, ' ', -xx12: 1: 0, ' ', xx13: 1, ' ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx5: 1: 0, ' ', xx10: 1: 0, ' ', -xx3: 1: 0, ' ', -xx8: 1: 0, ' ', xx13: 1, ' ');
        Write(g, xx4: 1: 0, ' ', xx9: 1: 0, ' ', -xx2: 1: 0, ' ', -xx7: 1: 0, ' ', -xx12: 1: 0, ' ');
        Write(g, xx3: 1: 0, ' ', xx8: 1: 0, ' ', -xx1: 1: 0, ' ', -xx6 + 1: 1: 0, ' ', -xx11: 1: 0, ' ');
        Write(g, xx2: 1: 0, ' ', xx7: 1: 0, ' ', xx12: 1: 0, ' ', -xx5 - 1: 1: 0, ' ', -xx10: 1: 0, ' ');
        writeln(g, xx1: 1: 0, ' ', xx6 + 1: 1: 0, ' ', xx11: 1: 0, ' ', -xx4: 1: 0, ' ', -xx9 - 1: 1: 0, ' ');

        closefile(g);
      end;
      {A special random test for the task 11.22-003}
      if chosen_task = '11_22-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := random(10) / 10 + 5;
        xx32 := random(10) / 10 + 5;
        xx33 := random(10) / 10 + 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 8, ' ', xx32: 1: 8, ' ', xx33: 1: 8, ' ');
        closefile(g);
        xx34 := 0.5 * sqrt(2 * xx31 * xx31 + 2 * xx32 * xx32 - xx33 * xx33);
        xx35 := 0.5 * sqrt(2 * xx31 * xx31 + 2 * xx33 * xx33 - xx32 * xx32);
        xx36 := 0.5 * sqrt(2 * xx32 * xx32 + 2 * xx33 * xx33 - xx31 * xx31);
        xx31 := 0.5 * sqrt(2 * xx34 * xx34 + 2 * xx35 * xx35 - xx36 * xx36);
        xx32 := 0.5 * sqrt(2 * xx34 * xx34 + 2 * xx36 * xx36 - xx35 * xx35);
        xx33 := 0.5 * sqrt(2 * xx35 * xx35 + 2 * xx36 * xx36 - xx34 * xx34);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx31 > xx32 then
        begin
          xx34 := xx31;
          xx31 := xx32;
          xx32 := xx34;
        end;
        if xx32 > xx33 then
        begin
          xx34 := xx32;
          xx32 := xx33;
          xx33 := xx34;
        end;
        if xx31 > xx32 then
        begin
          xx34 := xx31;
          xx31 := xx32;
          xx32 := xx34;
        end;
        Write(g, xx31: 1: 8, ' ', xx32: 1: 8, ' ', xx33: 1: 8, ' ');
        closefile(g);
      end;
      {A special random test for the task 11.24}
      if chosen_task = '11_24' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) + 5;
        xx22 := random(10) + 5;
        xx23 := random(10) + 5;
        xx24 := random(10) + 5;
        xx25 := random(10) + 5;
        xx26 := random(10) + 5;
        xx27 := random(10) + 5;
        xx28 := random(10) + 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21: 1, ' ', xx22: 1, ' ', xx23: 1, ' ', xx24: 1, ' ', xx25: 1,
          ' ', xx26: 1, ' ', xx27: 1, ' ', xx28: 1,
          ' ', 12 + xx24 div 7, xx21 + xx22: 1, ' ', 25 - xx25 div 10, ' ', 45 + xx26 div
          3, ' ', xx23 div 5 + 122, ' ', 766 + xx21 div 2, ' ', -135 + xx21, ' ', -201 + xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * xx21 + xx22 * xx22 + xx23 * xx23 + xx24 * xx24 + xx25 * xx25 + xx26 * xx26 +
          xx27 * xx27 + xx28 * xx28);
        closefile(g);
      end;

      {A special random test for the task 11.29-003}
      if chosen_task = '11_29-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := random(10) / 4 + 5;
        xx32 := random(10) / 4 + 5;
        xx33 := random(10) / 4 + 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 4, ' ', xx31 + 1: 1: 4, ' ', xx31 - 3: 1: 4, ' ', xx31 - 4: 1: 4, ' ',
          xx32 + 4: 1: 4, ' ', xx32 + 1: 1: 4, ' ', xx32 - 3: 1: 4, ' ', xx32 - 52: 1: 4, ' ',
          xx33: 1: 4, ' ', xx33 + 1: 1: 4, ' ', xx33 + 3: 1: 4, ' ', xx33 * 2: 1: 4, ' ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, (xx31 + 1) * (xx33 * 4) + sqr(xx32 + 4): 1: 4);
        closefile(g);
      end;

      {A spacial random test for the task 11.29-004}
      if chosen_task = '11_29-004' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) + 5;
        xx22 := random(10) + 5;
        xx23 := random(10) + 5;
        xx24 := random(10) + 5;
        xx25 := random(10) + 5;
        xx26 := random(10) + 5;
        xx27 := random(10) + 5;
        xx28 := random(2) + 1;
        if (xx28 < 1) or (xx28 > 2) then
          xx28 := 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ', xx22, ' ', xx23, ' ', xx24, ' ', xx25, ' ', xx26,
          ' ', xx27, ' ', xx26 + xx25, ' ', xx21 + xx28, ' ', xx28, ' ', xx23 + xx28, ' ',
          xx24 + xx25, ' ', xx28);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx28 = 1 then
          Write(g, xx22, ' ', xx23, ' ', xx24, ' ', xx25, ' ', xx26, ' ', xx27,
            ' ', xx26 + xx25, ' ', xx21 + xx28, ' ', xx28, ' ', xx23 + xx28, ' ', xx24 + xx25, ' ', xx21)
        else
          Write(g, xx23, ' ', xx24, ' ', xx25, ' ', xx26, ' ', xx27, ' ', xx26 + xx25,
            ' ', xx21 + xx28, ' ', xx28, ' ', xx23 + xx28, ' ', xx24 + xx25, ' ', xx21, ' ', xx22);
        closefile(g);
      end;

      {A special random test for the task 11.29-005}
      if chosen_task = '11_29-005' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := (random(100) + 1) / 4;
        xx32 := (random(100) + 1) / 4;
        xx33 := -(random(100) + 1) / 4;
        xx34 := (random(100) + 1) / 4;
        xx35 := -(random(100) + 1) / 4;
        xx36 := (random(100) + 1) / 4;
        xx21 := random(10) + 50;
        if xx21 mod 2 = 1 then
          xx36 := -xx36;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 4, ' ', xx32: 1: 4, ' ', xx33: 1: 4, ' ', xx34: 1: 4,
          ' ', xx35: 1: 4, ' ', xx36: 1: 4);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx36 < 0 then
          Write(g, xx33: 1: 4, ' ', xx35: 1: 4, ' ', xx36: 1: 4, ' ', xx31: 1: 4, ' ', xx32: 1: 4,
            ' ', xx34: 1: 4, ' ')
        else
          Write(g, xx33: 1: 4, ' ', xx35: 1: 4, ' ', xx31: 1: 4, ' ', xx32: 1: 4, ' ',
            xx34: 1: 4, ' ', xx36: 1: 4);
        closefile(g);
      end;

      {A special random test for the task 11.61}
      if chosen_task = '11_61' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := (random(8) - 4) / 2;
        xx32 := (random(10) - 5) / 2;
        xx33 := (random(10) - 5) / 2;
        xx34 := (random(10) - 5) / 2;
        xx35 := (random(10) - 5) / 2;
        xx36 := (random(10) - 5) / 2;
        if xx31 = 0 then
          xx31 := 0.5;
        if xx32 = 0 then
          xx32 := -0.5;
        if xx33 = 0 then
          xx33 := -0.5;
        if xx34 = 0 then
          xx34 := -0.5;
        if xx35 = 0 then
          xx35 := 0.5;
        if xx36 = 0 then
          xx36 := -0.5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 1, ' 0 0 ', xx32: 1: 1, ' ', xx33: 1: 1, ' 0 0  ', xx34: 1: 1,
          ' ', xx35: 1: 1, ' 0 0 ', xx36: 1: 1, ' 3');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, sqr(xx31 * xx33 * xx35) * (xx31 * xx33 * xx35): 1: 9, ' 0 0 ',
          (xx32 * xx34 * xx36) * sqr(xx32 * xx34 * xx36): 1: 9);
        closefile(g);
      end;
      {A special random test for the task 11.62}
      if chosen_task = '11_62' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := -random(20) - 2;
        xx32 := random(20) + 2;
        xx34 := -random(20) - 2;
        xx33 := random(20) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, ' 0 ', xx31: 1: 1, ' 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 0 0 0 0 ',
          xx32: 1: 1, ' 0  ', ' 0 ', xx33: 1: 1, ' 0 0 0 0 ', xx34: 1: 1, ' 0 0 0 0 0 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        xx35 := xx32;
        if abs(xx32) > abs(xx34) then
          xx32 := abs(xx32)
        else
          xx32 := abs(xx34);
        Write(g, (abs(xx31) + abs(xx35) + abs(xx33) + abs(xx34)) / (abs(xx31 + xx33) + xx32): 1: 9);
        closefile(g);
      end;
      {A special random test for the task 12.5}
      if chosen_task = '12_5' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := random(20) / 10 + 0.3;
        xx21 := random(10);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 9, ' ', 2 + xx21 mod 2);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 mod 2 = 0 then
          xx31 := cos(cos(xx31))
        else
          xx31 := cos(cos(cos(xx31)));
        Write(g, xx31: 1: 9);
        closefile(g);
      end;
      {A special random test for the task 12.7}
      if chosen_task = '12_7' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := random(20) / 10 + 0.3;
        xx21 := random(4) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 9, ' ', xx21 mod 2 + 3);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 mod 2 = 1 then
          xx31 := xx31 * xx31 * xx31 * xx31 / 24
        else
          xx31 := xx31 * xx31 * xx31 / 6;
        Write(g, xx31: 1: 9);
        closefile(g);
      end;
      {A special random test for the task 12.12-1}
      if chosen_task = '12_12-001' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 80;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 < 100 then
          writeln(g, 2)
        else
          writeln(g, 3);
        closefile(g);
      end;
      {A special random test for the task 12.12-2}
      if chosen_task = '12_12-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 80;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 >= 100 then
          writeln(g, 1)
        else
          writeln(g, xx21 div 10);
        closefile(g);
      end;
      {A special random test for the task 12.12-3}
      if chosen_task = '12_12-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 50;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 mod 10 > xx21 div 10 then
          writeln(g, xx21 mod 10)
        else
          writeln(g, xx21 div 10);
        closefile(g);
      end;
      {A special random test for the task 12.12-4}
      if chosen_task = '12_12-004' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 50;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if (xx21 mod 10 = 5) or (xx21 div 10 = 5) then
          writeln(g, 'true')
        else
          writeln(g, 'false');
        closefile(g);
      end;
      {A special random test for the task 12.12-5}
      if chosen_task = '12_12-005' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 50;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if (xx21 mod 10 <> 8) and (xx21 div 10 <> 8) then
          writeln(g, 0)
        else if (xx21 mod 10 = 8) and (xx21 div 10 = 8) then
            writeln(g, 2)
          else
            writeln(g, 1);
        closefile(g);
      end;

      {A special random test for the task 12.12-7}
      if chosen_task = '12_12-007' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(200) - 100;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        writeln(g, xx21);
        closefile(g);
      end;

      {A special random test for the task 12.12-8}
      if chosen_task = '12_12-008' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(200) + 11;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 < 100 then
          writeln(g, xx21 div 10)
        else
          writeln(g, xx21 div 100 + xx21 mod 10);
        closefile(g);
      end;


      {A special random test for the task 12.14}
      if chosen_task = '12_14' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(40) + 5;
        xx22 := random(40) + 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ', -xx21, ' ', xx21 div 2, ' ', xx21 * 2, ' ', xx22, ' ',
          -xx22, ' ', xx22 * 3, ' ', xx22 * 2, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 * 2 > xx22 * 3 then
          writeln(g, 2 * xx21)
        else
          writeln(g, xx22 * 3);
        closefile(g);
      end;

      {A special random test for the task 12.17}
      if chosen_task = '12_17' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx25 := random(20) - 10;
        if xx25 = 0 then
          xx25 := 1;
        xx21 := random(40) + 5;
        xx22 := random(40) + 5;
        xx23 := random(40) + 5;
        xx24 := random(40) + 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx25, ' ', xx21, ' ', -xx22, ' ', xx23, ' ', -xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx25 > 0 then
          Write(g, -xx22, ' ', -xx24, ' ', xx23, ' ', xx21, ' ', xx25)
        else
          Write(g, xx25, ' ', -xx22, ' ', -xx24, ' ', xx23, ' ', xx21);
        closefile(g);
      end;

      {A special random test for the task 12.hometask1}
      if chosen_task = '12_hometask1' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(6) + 1;
        xx22 := random(6) + 1;
        xx23 := random(6) + 1;
        xx24 := random(6) + 1;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * 10 + xx22, ' ', xx23 * 10 + xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 + xx22 >= xx23 + xx24 then
          Write(g, xx21 * 10 + xx22)
        else
          Write(g, xx23 * 10 + xx24);
        closefile(g);
      end;

      {A special random test for the task 12.hometask3}
      if chosen_task = '12_hometask3' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(3) + 2;
        xx22 := random(3) + 2;
        xx23 := random(4) + 2;
        xx24 := random(4) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * 10 + xx22, ' ', xx23 * 10 + xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if (xx21 <> xx22) and (xx23 <> xx24) then
          Write(g, 2)
        else if (xx21 = xx22) and (xx23 = xx24) then
            Write(g, 0)
          else
            Write(g, 1);
        closefile(g);
      end;

      {A special random test for the task 12.hometask4}
      if chosen_task = '12_hometask4' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(3) + 2;
        xx22 := random(3) + 2;
        xx23 := random(4) + 2;
        xx24 := random(4) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * 10 + xx21 + xx22 * 100, ' ', xx23 * 10 + xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if (xx21 <> xx22) and (xx23 <> xx24) then
          Write(g, 0)
        else if (xx21 = xx22) and (xx23 = xx24) then
            Write(g, 2)
          else
            Write(g, 1);
        closefile(g);
      end;

      {A special random test for the task 12.hometask5}
      if chosen_task = '12_hometask5' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(4) + 2;
        xx22 := random(4) + 2;
        xx23 := random(4) + 2;
        xx24 := random(4) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * 10 + xx22, ' ', xx23 * 10 + xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 * xx22 >= xx23 * xx24 then
          Write(g, xx21 * 10 + xx22)
        else
          Write(g, xx23 * 10 + xx24);
        closefile(g);
      end;

      {A special random test for the task 12.hometask6}
      if chosen_task = '12_hometask6' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(7) + 2;
        xx22 := random(7) + 2;
        xx23 := random(7) + 2;
        xx24 := random(7) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * 10 + xx22, ' ', xx23 * 10 + xx24, ' 0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        xx25 := 0;
        if xx21 mod 2 <> xx22 mod 2 then
          Inc(xx25);
        if xx23 mod 2 <> xx24 mod 2 then
          Inc(xx25);
        Write(g, xx25);
        closefile(g);
      end;
      //A special random test for the task 13.12-2
      if chosen_task = '13_12-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(17) + 2;
        xx22 := random(17) + 2;
        xx23 := random(17) + 2;
        xx24 := random(17) + 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ', xx22, ' ', xx23, ' ', xx24);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx21 * xx24 + xx22 * xx23, ' ', xx22 * xx24);
        closefile(g);
      end;
      //A special random test for the task 13.12-3
      if chosen_task = '13_12-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(17) + 2;
        xx22 := random(17) + 2;
        xx23 := random(17) + 2;
        xx24 := random(17) + 2;
        if xx21 / xx22 = xx23 / xx24 then
          Inc(xx24);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ', xx22, ' ', xx23, ' ', xx24);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 / xx22 > xx23 / xx24 then
          Write(g, xx21, ' ', xx22)
        else
          Write(g, xx23, ' ', xx24);
        closefile(g);
      end;

      //A special random test for the task 14.15-2
      if chosen_task = '14_15-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(17) + 98;
        xx22 := random(17) + 98;//if xx21=xx22 then inc(xx22);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21), chr(xx22), '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 > xx22 then
          Write(g, chr(xx22), chr(xx21))
        else if xx21 = xx22 then
            Write(g, chr(xx22))
          else
            Write(g, chr(xx21), chr(xx22));
        closefile(g);
      end;

      //A special random test for the task 14.16
      if chosen_task = '14_16' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx31 := random(17) / 2;
        xx32 := random(17) / 2;
        xx33 := random(17) / 2;
        xx34 := random(17) / 2;
        xx35 := random(17) / 2;
        xx36 := random(17) / 2;
        xx37 := random(17) / 2;
        xx38 := random(17) / 2;
        xx35 := random(17) / 2;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx31: 1: 2, ' ', xx32: 1: 2, ' ', xx33: 1: 2, ' ', xx34: 1: 2, ' ', xx35: 1: 2,
          ' ', xx36: 1: 2, ' ', xx37: 1: 2, ' ', xx38: 1: 2, ' ', xx39: 1: 2, ' ');
        xx21 := random(3) + 1;
        if not xx21 in [1..3] then
          xx21 := 1;
        Write(g, '1 2 3 0 ', xx21, '  0');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 = 1 then
          Write(g, xx31 + xx34 + xx37: 1: 7);
        if xx21 = 2 then
          Write(g, xx32 + xx35 + xx38: 1: 7);
        if xx21 = 3 then
          Write(g, xx33 + xx36 + xx39: 1: 7);
        closefile(g);
      end;

      //A special random test for the task 14.26-002
      if chosen_task = '14_26-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(7) + 1;
        if not (xx21 in [1..7]) then
          xx21 := 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        for xx22 := 0 to 9 do
          if xx21 <> xx22 then
            Write(g, xx22, ' ');
        closefile(g);
      end;

      //A special random test for the task 14.27-002
      if chosen_task = '14_27-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(17) + 97;
        if not (xx21 in [97..122]) then
          xx21 := 100;
        xx22 := random(17) + 97;
        if not (xx22 in [97..122]) then
          xx22 := 100;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21), chr(xx21), chr(xx22), '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21));
        closefile(g);
      end;

      //A special random test for the task 14.27-003
      if chosen_task = '14_27-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(17) + 97;
        if not (xx21 in [97..122]) then
          xx21 := 100;
        xx22 := random(17) + 97;
        if not (xx22 in [97..122]) then
          xx22 := 100;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21), chr(xx22), chr(xx22), '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx22 <> xx21 then
          Write(g, chr(xx21));
        closefile(g);
      end;

      //A special random test for the task 15.8
      if chosen_task = '15_8' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(177) + 37;
        xx22 := random(17) + 37;
        xx23 := random(177) + 37;
        xx24 := random(17) + 37;
        if xx23 = xx21 then
          xx23 := xx21 + 1;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ', xx22, ' ', xx23, ' ', xx24, ' 0 0 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 > xx23 then
          Write(g, xx23, ' ', xx24, ' ')
        else
          Write(g, xx21, ' ', xx22, ' ');
        closefile(g);
      end;

      //A special random test for the task 15.9-002
      if chosen_task = '15_9-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) + 98;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21));
        xx23 := random(5) + 3;
        for xx24 := 1 to xx23 do
        begin
          xx22 := random(12) + 100;
          Write(g, chr(xx22));
        end;
        Write(g, '!');
        xx22 := random(10) + 98;
        if xx22 = xx21 then
          Inc(xx22);
        Write(g, chr(xx22));
        xx23 := random(5) + 3;
        for xx24 := 1 to xx23 do
        begin
          xx25 := random(12) + 100;
          Write(g, chr(xx25));
        end;
        Write(g, '!');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 > xx22 then
          Write(g, 'False')
        else
          Write(g, 'True');
        closefile(g);
      end;

      //A special random test for the task 15.10-002
      if chosen_task = '15_10-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) + 98;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, chr(xx21));
        Write(g, '!');
        xx22 := random(10) + 98;
        Write(g, chr(xx22));
        Write(g, '!');
        xx23 := random(10) + 98;
        Write(g, chr(xx23));
        Write(g, '!');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if (xx21 = xx22) or (xx21 = xx23) then
          Write(g, 'True')
        else
          Write(g, 'False');
        closefile(g);
      end;

      //A special random test for the task 15.11
      if chosen_task = '15_11' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(10) - 5;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Write(g, xx21, ' ');
        xx22 := random(10) + 5;
        xx25 := 0;
        for xx23 := 1 to xx22 do
        begin
          xx24 := random(10) - 5;
          if xx24 = xx21 then
            Inc(xx25);
          Write(g, xx24, ' ');
        end;
        Write(g, -32768);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx25);
        closefile(g);
      end;

      //A special random test for the tasks 6.17 and 15.12-001
      if (chosen_task = '15_12-001') or (chosen_task = '6_17') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        xx21 := random(5) + 3;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx24 := 0;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(3) + 40;
          if xx23 = 40 then
            Inc(xx24);
          if xx23 = 41 then
            Dec(xx24);
          if xx24 < 0 then
            xx24 := -1000;
          Write(g, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx24 = 0 then
          Write(g, 'true')
        else
          Write(g, 'false');
        closefile(g);
      end;

      //A special random test for the task 15.12-002
      if chosen_task = '15_12-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(15) + 3;
        for xx22 := 1 to xx21 do
          Write(g, '(');
        for xx22 := 1 to xx21 do
          Write(g, ')');
        xx23 := random(15) + 3;
        for xx22 := 1 to xx23 do
          Write(g, '(');
        for xx22 := 1 to xx23 do
          Write(g, ')');
        Write(g, '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx23 > xx21 then
          Write(g, xx23)
        else
          Write(g, xx21);
        closefile(g);
      end;

      //A special random test for the task 15.13-002
      if chosen_task = '15_13-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(15) + 3;
        xx23 := random(15) + 3;
        xx22 := random(2);
        if xx22 = 0 then
          Write(g, xx21, ' ', xx23, ' ', xx23 * 2 - xx21)
        else
          Write(g, xx21, ' ', xx23, ' ', xx23 * 2 - xx21 - 1);
        Write(g, ' -32768');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx22 = 0 then
          Write(g, 'true')
        else
          Write(g, 'false');
        closefile(g);
      end;

      //A special random test for the task 15.13-003
      if chosen_task = '15_13-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(15) + 3;
        xx22 := random(2);
        if xx22 = 0 then
          Write(g, xx21, ' ', xx21 * 3, ' ', xx21 * 9)
        else
          Write(g, xx21, ' ', xx21 + 1, ' ', xx21 + 2);
        Write(g, ' -32768');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx22 = 0 then
          Write(g, 'true')
        else
          Write(g, 'false');
        closefile(g);
      end;


      //A special random test for the task 15.14
      if chosen_task = '15_14' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 204;
        xx23 := 0;
        xx26 := 1;
        for xx25 := 1 to xx22 do
        begin
          xx21 := random(3) + 65;
          Write(g, chr(xx21));
          if (xx21 = 66) and (xx26 = 65) then
            Inc(xx23);
          xx26 := xx21;
        end;
        Write(g, '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx23);
        closefile(g);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 204;
        xx23 := 0;
        xx26 := 1;
        for xx25 := 1 to xx22 do
        begin
          xx21 := random(7) + 65;
          Write(g, chr(xx21));
          if (xx21 = 66) and (xx26 = 65) then
            Inc(xx23);
          xx26 := xx21;
        end;
        Write(g, '.');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx23);
        closefile(g);
      end;

      //A special random test for the task 15.15
      if chosen_task = '15_15' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(44) + 259;
        for xx25 := 1 to xx22 do
        begin
          xx21 := random(14) + 65;
          Write(g, xx21 / 2: 1: 1, ' ');
          if xx25 = xx22 - 1 then
            xx33 := xx21 / 2;
        end;
        Write(g, '-100000 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx33: 1: 1);
        closefile(g);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 87;
        for xx25 := 1 to xx22 do
        begin
          xx21 := random(24) + 65;
          Write(g, xx21 / 4: 1: 2, ' ');
          if xx25 = xx22 - 1 then
            xx33 := xx21 / 4;
        end;
        Write(g, '-100000 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx33: 1: 2);
        closefile(g);
      end;

      //A special random test for the task 15.16
      if chosen_task = '15_16' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 260;
        for xx25 := 1 to xx22 do
          Write(g, xx25 / 10: 1: 2, ' ');
        Write(g, ' -100000 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, xx22);
        closefile(g);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 260;
        xx23 := random(14) + 260;
        Write(g, xx22 / 2: 1: 2, ' ');
        Write(g, xx23 / 2: 1: 2);
        Write(g, ' -100000 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx22 < xx23 then
          Write(g, 2)
        else
          Write(g, 1);
        closefile(g);
      end;

      //A special random test for the task 15.22
      if chosen_task = '15_22' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(14) + 260;
        for xx25 := 1 to xx22 do
        begin
          xx23 := random(20) + 65;
          Write(g, char(xx23));
          Write(g1, char(xx23));
        end;
        Write(g, '!');
        xx22 := random(14) + 260;
        for xx25 := 1 to xx22 do
        begin
          xx23 := random(20) + 98;
          Write(g, char(xx23));
          Write(g1, char(xx23));
        end;
        Write(g, '!');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.23
      if chosen_task = '15_23' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(18) + 60;
        for xx25 := 1 to xx22 do
        begin
          xx23 := random(20) + 1;
          xx24 := random(12) + 1;
          Write(g, xx23, ' ', xx24, ' ');
        end;
        Write(g, ' 0 0 ');
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        reset(g);
        while not EOF(g) do
        begin
          Read(g, xx26);
          Read(g, xx27);
          if xx27 in [6..8] then
            Write(g1, xx26, ' ', xx27, ' ');
        end;
        closefile(g);
        Write(g1, ' -1 -1 ');
        reset(g);
        while not EOF(g) do
        begin
          Read(g, xx26);
          Read(g, xx27);
          if xx27 in [1, 2, 12] then
            Write(g1, xx26, ' ', xx27, ' ');
        end;
        closefile(g);
        closefile(g1);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(18) + 60;
        for xx25 := 1 to xx22 do
        begin
          xx23 := random(20) + 1;
          xx24 := random(12) + 1;
          Write(g, xx23, ' ', xx24, ' ');
        end;
        Write(g, '0 0');
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        reset(g);
        while not EOF(g) do
        begin
          Read(g, xx26);
          Read(g, xx27);
          if xx27 in [6..8] then
            Write(g1, xx26, ' ', xx27, ' ');
        end;
        closefile(g);
        Write(g1, ' -1 -1 ');
        reset(g);
        while not EOF(g) do
        begin
          Read(g, xx26);
          Read(g, xx27);
          if xx27 in [1, 2, 12] then
            Write(g1, xx26, ' ', xx27, ' ');
        end;
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.24
      if chosen_task = '15_24' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        for xx26 := 1 to 4 do
        begin
          xx22 := random(70) + 270;
          for xx25 := 1 to xx22 do
          begin
            xx23 := random(21) + 65;
            Write(g, char(xx23));
            Write(g1, char(xx23));
          end;
          Write(g, '!');
          Write(g1, '!');
        end;
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.27
      if chosen_task = '15_27' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(12) + 108;
        xx22 := random(3) + 1;
        xx24 := random(3) - 1;
        for xx23 := 1 to xx21 do
          Write(g, xx23 * xx22 * 3, ' ');
        Write(g, -10000, ' ');
        for xx23 := 1 to xx21 do
          Write(g, xx23 * xx22 * 3 + xx24, ' ');
        Write(g, -10000);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        for xx23 := 1 to xx21 do
          if xx24 = -1 then
            Write(g, xx23 * xx22 * 3 - 1, ' ', xx23 * xx22 * 3, ' ')
          else
            Write(g, xx23 * xx22 * 3, ' ', xx23 * xx22 * 3 + xx24, ' ');
        closefile(g);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(500) - 250;
        xx22 := random(500) - 250;
        Write(g, xx21, ' ', -10000, ' ', xx22, ' ', -10000);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        if xx21 <= xx22 then
          Write(g, xx21, ' ', xx22)
        else
          Write(g, xx22, ' ', xx21);
        closefile(g);
      end;

      //A special random test for the task 15.28-002
      if chosen_task = '15_28-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(5) - 2;
        xx23 := random(5) - 2;
        Write(g, xx23 / 2: 1: 1, ' ');
        Write(g, xx22 / 2: 1: 1, ' ');
        Write(g, '-10000 ');
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, 1 + byte(xx22 = xx23));
        closefile(g);
      end;

      //A special random test for the task 15.28-003
      if chosen_task = '15_28-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(25) + 57;
        for xx24 := 1 to xx22 * 2 do
        begin
          xx21 := random(1000) - 500;
          Write(g, xx21 / 5: 1: 1, ' ');
        end;
        Write(g, -10000);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, 'false');
        closefile(g);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx22 := random(25) + 57;
        for xx24 := 1 to xx22 * 2 - 1 do
        begin
          xx21 := random(1000) - 500;
          Write(g, xx21 / 5: 1: 1, ' ');
          if xx24 = xx22 then
            xx23 := xx21;
        end;
        Write(g, -10000);
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        Write(g, 'true', ' ', xx23 / 5: 1: 1);
        closefile(g);
      end;

      //A special random test for the task 15.29
      if chosen_task = '15_29' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        xx21 := random(3);
        case xx21 of
          0: Write(g, 'Ethan 21, Jake 23.');
          1: Write(g, 'Mason 24.')
          else
            Write(g, 'Harrison 35, Jacob 34, Oliver 36.')
        end;
        closefile(g);
        Assign(g, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g);
        case xx21 of
          0: Write(g, 'Ethan');
          1: Write(g, 'Mason')
          else
            Write(g, 'Jacob')
        end;
        closefile(g);
      end;

      //A special random test for the task 15.32-002
      if chosen_task = '15_32-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(20) + 67;
          Write(g, chr(xx23));
          Write(g1, chr(xx23));
        end;
        xx23 := random(20) + 98;
        Write(g, '.');
        Write(g, chr(xx23));
        Write(g1, chr(xx23));
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.32-003
      if chosen_task = '15_32-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(30) + 48;
          if xx23 = 59 then
            xx23 := 58;
          Write(g, chr(xx23));
          Write(g1, chr(xx23));
          if xx23 in [48..57] then
            Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g1);
        closefile(g);
      end;

      //A special random test for the task 15.32-004
      if chosen_task = '15_32-004' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(20) + 67;
          Write(g, chr(xx23));
          if xx22 <> xx21 then
            Write(g1, chr(xx23));
        end;
        xx23 := random(22) + 97;
        Write(g, '.');
        Write(g, chr(xx23));
        Write(g1, chr(xx23));
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.32-005
      if chosen_task = '15_32-005' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(30) + 47;
          if xx23 = 59 then
            xx23 := 58;
          Write(g, chr(xx23));
          if xx23 in [48..56] then
            Write(g1, chr(xx23 + 1))
          else if xx23 = 57 then
              Write(g1, '0')
            else
              Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.32-006
      if chosen_task = '15_32-006' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 150;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(17) + 40;
          if xx23 = 46 then
            xx23 := 45;
          Write(g, chr(xx23));
          if not (xx23 in [43, 45]) then
            Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.32-007
      if chosen_task = '15_32-007' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(23) + 65;
          Write(g, chr(xx23));
          if xx22 <> xx21 - 1 then
            Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(23) + 98;
          Write(g, chr(xx23));
          if xx22 <> xx21 - 1 then
            Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 50;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(10) + 48;
          Write(g, chr(xx23));
          if xx22 <> xx21 - 1 then
            Write(g1, chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.32-008
      if chosen_task = '15_32-008' then
      begin
        sd := [];
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(30) + 90;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(28) + 65;
          Write(g, chr(xx23));
          if not (chr(xx23) in sd) then
          begin
            Write(g1, chr(xx23));
            sd := sd + [chr(xx23)];
          end;
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.34
      if chosen_task = '15_34' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(9);
        xx22 := random(3);
        xx23 := random(9);
        Write(g, '(', xx21: 1);
        if xx22 = 0 then
          Write(g, '+');
        if xx22 = 1 then
          Write(g, '-');
        if xx22 = 2 then
          Write(g, '*');
        Write(g, xx23: 1, ').');
        closefile(g);
        if xx22 = 0 then
          xx24 := xx21 + xx23;
        if xx22 = 1 then
          xx24 := xx21 - xx23;
        if xx22 = 2 then
          xx24 := xx21 * xx23;
        Write(g1, xx24);
        closefile(g1);
      end;

      //A special random test for the task 15.35
      if chosen_task = '15_35' then
      begin
        sd := [];
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(3) + 5;
        xx24 := 0;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(23) + 65;
          Write(g, chr(xx23));
          if not (chr(xx23) in sd) then
            sd := sd + [chr(xx23)]
          else
            xx24 := 1;
        end;
        Write(g, '.');
        closefile(g);
        if xx24 = 0 then
          Write(g1, 'false')
        else
          Write(g1, 'true');
        closefile(g1);
      end;

      //A special random test for the task 15.42-003
      if chosen_task = '15_42-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(3);
        if xx21 = 1 then
          Write(g1, 'true')
        else
          Write(g1, 'false');
        closefile(g1);
        if xx21 = 1 then
        begin
          xx24 := random(20) + 65;
          Write(g, 'wervc' + chr(xx24) + chr(2) + '.' + 'wervc' + chr(xx24) + chr(2) + '.');
          closefile(g);
        end
        else
        begin
          xx23 := random(30) + 50;
          for xx22 := 1 to xx23 do
          begin
            xx24 := random(20) + 65;
            Write(g, chr(xx24));
          end;
          Write(g, chr(2) + '.');
          xx25 := random(30) + 50;
          if xx25 = xx23 then
            Inc(xx25);
          for xx22 := 1 to xx25 do
          begin
            xx24 := random(20) + 65;
            Write(g, chr(xx24));
          end;
          Write(g, chr(2) + '.');
          closefile(g);
        end;
      end;

      //A special random test for the task 15.44-002
      if chosen_task = '15_44-002' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 300;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30) + 300;
            for xx25 := 1 to xx24 do
            begin
              xx26 := -random(10) + 122;
              Write(g, chr(xx26));
            end;
            if xx26 = 122 then
              Inc(xx21);
            Write(g, chr(2));
          end;
          Write(g, '.');
          Write(g1, xx21);
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.44-003
      if chosen_task = '15_44-003' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 300;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30) + 300;
            for xx25 := 1 to xx24 do
            begin
              xx26 := -random(10) + 122;
              if xx25 = 1 then
                xx27 := xx26;
              Write(g, chr(xx26));
            end;
            if xx26 = xx27 then
              Inc(xx21);
            Write(g, chr(2));
          end;
          Write(g, '.');
          Write(g1, xx21);
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.44-004
      if chosen_task = '15_44-004' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 300;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30) + 300;
            xx27 := 0;
            xx29 := 0;
            for xx25 := 1 to xx24 do
            begin
              xx26 := random(100);
              if xx26 = 90 then
                Write(g, chr(xx24 mod 17 + 66))
              else
                Write(g, chr(xx24 mod 17 + 67));
              if xx26 = 90 then
                xx27 := 1
              else
                xx29 := 1;
            end;
            if xx27 * xx29 = 0 then
              Inc(xx21);
            Write(g, chr(2));
          end;
          Write(g, '.');
          Write(g1, xx21);
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.45
      if chosen_task = '15_45' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 300;
          xx27 := 0;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30);
            if xx24 = 3 then
            begin
              for xx29 := 1 to random(13) + 5 do
                Write(g, chr(random(23) + 65));
              xx27 := 1;
            end;
            Write(g, chr(2));
            if xx27 = 0 then
              Inc(xx21);
          end;
          Write(g, '.');
          Write(g1, xx21);
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.47
      if chosen_task = '15_47' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 30;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30) + 300;
            xx27 := random(10);
            if xx27 < 3 then
              Write(g, chr(2));
            for xx25 := 1 to xx24 do
            begin
              xx29 := random(20) + 65;
              Write(g, chr(xx29));
              Write(g1, chr(xx29));
            end;
            Write(g, chr(2));
            Write(g1, chr(2));
          end;
          Write(g, '.');
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.48
      if chosen_task = '15_48' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx21 := 0;
          xx22 := random(30) + 30;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(30) + 65;
            for xx25 := 1 to xx24 do
            begin
              xx29 := random(20) + 97;
              Write(g, chr(xx29));
              if xx25 <= 80 then
                Write(g1, chr(xx29));
            end;
            if xx24 < 80 then
              for xx25 := xx24 + 1 to 80 do
                Write(g1, '_');
            Write(g, chr(2));
            Write(g1, chr(2));
          end;
          Write(g, '.');
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.50-001
      if chosen_task = '15_50-001' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(10) + 10;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(12) + 65;
          xx24 := random(112) + 34;
          if odd(xx22) then
            xx23 := xx23 + 32;
          for xx25 := 1 to xx24 do
            Write(g, chr(xx23));
          Write(g1, ' ', xx24, ' ', chr(xx23));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.50-002
      if chosen_task = '15_50-002' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(10) + 10;
        for xx22 := 1 to xx21 do
        begin
          xx23 := random(12) + 65;
          xx24 := random(112) + 34;
          if odd(xx22) then
            xx23 := xx23 + 32;
          for xx25 := 1 to xx24 do
            Write(g1, chr(xx23));
          Write(g, ' ', xx24, ' ', chr(xx23));
        end;
        Write(g, ' 1 .');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.54
      if chosen_task = '15_54' then
      begin
        for xx28 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx26 := random(10) + 300;
          for xx27 := 1 to xx26 do
          begin
            xx21 := random(1000) - 500;
            xx22 := random(1000) - 500;
            Write(g, xx21, ' ', xx22, chr(2));
            if xx21 > 0 then
              Write(g1, xx21, ' ');
            if xx22 > 0 then
              Write(g1, xx22, ' ');
          end;
          Write(g, '.');
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.55
      if chosen_task = '15_55' then
      begin
        sa[1] := 'When was the museum opened?';
        sa[2] := 'What collections does the museum display?';
        sa[3] := 'What institute is there?';
        sa[4] := 'What is the central hall like?';
        sa[5] := 'When were several of the galleries destroyed?';
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx26 := random(25) + 1100;
        for xx27 := 1 to xx26 do
        begin
          xx21 := random(5) + 1;
          Write(g, sa[xx21]);
          Write(g, chr(2));
          if xx27 < 10 then
            Write(g1, '000')
          else if xx27 < 100 then
              Write(g1, '00')
            else if xx27 < 1000 then
                Write(g1, '0');
          Write(g1, xx27: 1);
          Write(g1, ' ');
          Write(g1, sa[xx21]);
          Write(g1, chr(2));
        end;
        Write(g, '.');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.58
      if chosen_task = '15_58' then
      begin
        for xx29 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx26 := random(25) + 25;
          for xx27 := 1 to xx26 do
          begin
            sf := '';
            se := '';
            xx25 := random(16);
            for xx24 := 1 to xx25 do
            begin
              xx28 := random(1000) - 500;
              Write(g, ' ', xx28);
              if xx28 > 0 then
                sf := sf + ' ' + IntToStr(xx28)
              else
                se := se + ' ' + IntToStr(xx28);
            end;
            Write(g, chr(2));
            Write(g1, sf + se + chr(2));
          end;
          Write(g, '.');
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.59
      if chosen_task = '15_59' then
      begin
        sa[1] := 'Why is it so cold now?';
        sa[2] := 'When will the weather improve?';
        sa[3] := 'Do you like rainy weather?';
        sa[4] := 'Do you like to live in the capital?';
        sa[5] := 'What time does this train leave?';
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx26 := random(25) + 260;
        ss31 := '';
        ss32 := '';
        for xx27 := 1 to xx26 do
        begin
          xx21 := random(6);
          if xx21 > 0 then
            ss31 := ss31 + sa[xx21];
          ss31 := ss31 + chr(2);
        end;
        ss31 := ss31 + '.';
        xx26 := random(25) + 260;
        for xx27 := 1 to xx26 do
        begin
          xx21 := random(6);
          if xx21 > 0 then
            ss32 := ss32 + sa[xx21];
          ss32 := ss32 + chr(2);
        end;
        ss32 := ss32 + '.';
        Write(g, ss31, ss32);
        Write(g1, ss32, ss31);
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.61
      if chosen_task = '15_61' then
      begin
        sa[1] := 'Bull';
        sa[2] := 'Cow';
        sa[3] := 'Goat';
        sa[4] := 'Whale';
        sa[5] := 'Walrus';
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx26 := random(25) + 260;
        for xx27 := 1 to xx26 do
        begin
          xx21 := random(100);
          if odd(xx21) then
            Write(g, 'It is an experimental text.' + chr(2))
          else
            Write(g, 'It contains lines of different lengths.' + chr(2));
        end;
        xx25 := random(5) + 1;
        Write(g, sa[xx25] + chr(2));
        xx21 := random(100);
        if odd(xx21) then
          Write(g, 'It is an experimental text.' + chr(2))
        else
          Write(g, 'It contains lines of different lengths.' + chr(2));
        xx21 := random(100);
        if odd(xx21) then
          Write(g, 'It is an experimental text.' + chr(2))
        else
          Write(g, 'It contains lines of different lengths.' + chr(2));
        xx21 := random(100);
        if odd(xx21) then
          Write(g, 'It is an experimental text.' + chr(2));
        xx21 := random(100);
        if odd(xx21) then
        else
          Write(g, 'It contains lines of different length.' + chr(2));
        Write(g1, sa[xx25]);
        Write(g, '#');
        closefile(g);
        closefile(g1);
      end;

      //A special random test for the task 15.62
      if chosen_task = '15_62' then
      begin
        for xx29 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx26 := random(257) + 25;
          for xx27 := 1 to xx26 do
          begin
            xx28 := random(1000) - 500;
            Write(g, ' ', xx28);
            xx28 := random(1000) - 500;
            Write(g, ' ', xx28);
            Write(g, chr(2));
          end;
          if xx29 = 2 then
          begin
            xx28 := random(1000) - 500;
            if odd(xx28) then
              Write(g, 'Bull  ')
            else
              Write(g, '  Cow  ');
            Write(g, chr(2));
          end;
          Write(g, '#');
          if xx29 = 1 then
            Write(g1, '0')
          else if odd(xx28) then
              Write(g1, 4)
            else
              Write(g1, 3);
          closefile(g);
          closefile(g1);
        end;
      end;

      //A special random test for the task 15.61
      if chosen_task = '15_62' then
      begin
        sa[1] := 'Bull';
        sa[2] := 'Cow';
        sa[3] := 'Goat';
        sa[4] := 'Whale';
        sa[5] := 'Walrus';
        number_of_tests := number_of_tests + 1;
        xx21 := 0;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx26 := random(280) + 26;
        for xx27 := 1 to xx26 do
        begin
          xx25 := random(5) + 1;
          Write(g, sa[xx25] + chr(2));
          xx21 := xx21 + length(sa[xx25]);
        end;
        Write(g1, xx21 / xx26: 1: 8);
        Write(g, '#');
        closefile(g);
        closefile(g1);
      end;

      //Special random tests for the tasks 16.15 and 16.18
      if (chosen_task = '16_15-001') or (chosen_task = '16_18-003') or (chosen_task = '16_18-004') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(1000) - 444;
        xx22 := random(1000) - 444;
        Write(g, xx21, ' ', xx22);
        if chosen_task = '16_18-003' then
          Write(g1, (xx21 + xx22) / 2: 1: 8)
        else
          if xx21 > xx22 then
            Write(g1, xx21)
          else
            Write(g1, xx22);
        if (copy(chosen_task, 1, 5) = '16_18') then
          Write(g, '  1E20');
        closefile(g);
        closefile(g1);
      end;

      if chosen_task = '16_15-003' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(4) + 14;
        xx22 := random(4) + 14;
        Write(g, xx21, ' ', xx22);
        if xx21 <> xx22 then
          Write(g1, 'False')
        else
          Write(g1, 'True');
        closefile(g);
        closefile(g1);
      end;

      if chosen_task = '16_16-001' then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx24 := random(10) + 5;
        for xx21 := 1 to 12 * xx24 do
        begin
          xx22 := random(20) + 98;
          Write(g, chr(xx22));
        end;
        Write(g, '.');
        Write(g1, xx24);
        closefile(g);
        closefile(g1);

      end;

      if (chosen_task = '16_18-006') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx24 := random(10) + 5;
        xx31 := random(1000) / 5 - 90;
        xx32 := random(1000) / 5 - 90;
        Write(g, xx31: 1: 3, ' ');
        Write(g1, xx32: 1: 3, ' ');
        for xx21 := 1 to xx24 do
        begin
          xx33 := random(1000) / 5 - 90;
          Write(g, xx33: 1: 3, ' ');
          Write(g1, xx33: 1: 3, ' ');
        end;
        Write(g1, xx31: 1: 3, ' ');
        Write(g, xx32: 1: 3, ' ');
        Write(g, '1E20');
        closefile(g);
        closefile(g1);
      end;

      if (chosen_task = '16_18-008') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx31 := random(1000) / 5 - 90;
        xx32 := random(1000) / 5 - 90;
        Write(g, xx31: 1: 3, ' ');
        Write(g, (xx31 + xx32) / 2: 1: 3, ' ');
        Write(g1, xx32: 1: 3, ' ');
        Write(g1, (xx31 + xx32) / 2: 1: 3, ' ');
        Write(g1, xx31: 1: 3, ' ');
        Write(g, xx32: 1: 3, ' ');
        Write(g, '1E20');
        closefile(g);
        closefile(g1);
      end;

      if (chosen_task = '16_18-010') then
      begin
        number_of_tests := number_of_tests + 1;
        k := k + 1;
        randomize;
        Assign(g, s1 + '/tmp/iii' + IntToStr(k));
        rewrite(g);
        Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
        rewrite(g1);
        xx21 := random(1000) - 90;
        xx22 := random(1000) - 90;
        if xx21 = xx22 then
          xx21 := xx21 + 1;
        Write(g, xx21, ' ');
        Write(g, (xx21 + xx22) div 2, ' ');
        Write(g, xx22, ' ');
        Write(g, '1E20');
        if (xx21 + xx22) mod 2 = 0 then
          Write(g1, 'True')
        else
          Write(g1, 'False');
        closefile(g);
        closefile(g1);
      end;

      if (chosen_task = '16_18-011') then
      begin
        for xx21 := 1 to 3 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx24 := random(15) + 12;
          for xx25 := 1 to xx24 do
          begin
            xx31 := random(1000) / 4 - 90;
            Write(g, xx31: 1: 3, ' ');
          end;
          xx31 := random(1000) / 5 - 90;
          Write(g, xx31: 1: 3, ' ');
          xx32 := random(1000) / 5 - 90;
          Write(g, xx32: 1: 3, ' ');
          Write(g1, xx31 + xx32: 1: 3, ' ');
          Write(g, '1E20');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_18-012') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx31 := random(4) - 2;
          Write(g, xx31: 1: 3, ' ');
          xx32 := random(4) - 2;
          Write(g, xx32: 1: 3, ' ');
          if xx31 = xx32 then
            Write(g1, 2)
          else
            Write(g1, 1);
          Write(g, '1E20');
          closefile(g);
          closefile(g1);
        end;
      end;

      //Special random tests for the tasks 16.20 and next

      if (chosen_task = '16_20-002') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := random(10000) + 24;
          Write(g, xx22);
          Write(g1, '1 1 ');
          xx23 := 1;
          xx24 := 1;
          repeat
            xx24 := xx24 + xx23;
            xx23 := xx24 - xx23;
            if xx24 <= xx22 then
              Write(g1, xx24, ' ')
            else
              break;
          until False;
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_20-004') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := 250 + random(2000);
          Write(g, xx22);
          xx23 := xx22 div 1000;
          xx24 := xx22 mod 1000 div 100;
          xx25 := xx22 mod 100 div 10;
          xx26 := xx22 mod 10;
          if xx23 > 0 then
            Write(g1, xx23, ' ');
          Write(g1, xx24, ' ');
          Write(g1, xx25, ' ');
          Write(g1, xx26, ' ');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_20-005') or (chosen_task = '16_29-009') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx31 := random(1000) / 10 - 50;
          xx32 := random(1000) / 10 - 50;
          xx33 := random(1000) / 10 - 50;
          xx34 := random(1000) / 10 - 50;
          xx35 := random(1000) / 10 - 50;
          Write(g, xx31: 1: 3, ' ', xx32: 1: 3, ' ', xx33: 1: 3, ' ', xx34: 1: 3, ' ', xx35: 1: 3, ' 1E20');
          Write(g1, xx35: 1: 3, ' ', xx34: 1: 3, ' ', xx33: 1: 3, ' ', xx32: 1: 3, ' ', xx31: 1: 3);
          closefile(g);
          closefile(g1);
        end;
      end;


      if (chosen_task = '16_23-007') then
      begin
        for xx21 := 1 to 3 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := random(20) + 5;
          for xx23 := 1 to xx22 do
          begin
            xx31 := (random(200) - 100) / 5;
            Write(g, xx31: 1: 3, ' ');
            if xx31 >= 0 then
              Write(g1, xx31: 1: 3, ' ');
          end;
          Write(g, ' 1E20 ');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_29-005') then
      begin
        for xx21 := 1 to 3 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := random(20) + 5;
          xx32 := (random(200) - 100) / 5;
          Write(g, xx32: 1: 3, ' ');
          for xx23 := 1 to xx22 do
          begin
            xx31 := (random(200) - 100) / 5;
            Write(g, xx31: 1: 3, ' ');
            Write(g1, xx31: 1: 3, ' ');
          end;
          Write(g, ' 1E20 ');
          Write(g1, xx32: 1: 3, ' ');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_29-006') then
      begin
        for xx21 := 1 to 3 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := random(20) + 5;
          xx32 := (random(200) - 100) / 5;
          Write(g1, xx32: 1: 3, ' ');
          for xx23 := 1 to xx22 do
          begin
            xx31 := (random(200) - 100) / 5;
            Write(g, xx31: 1: 3, ' ');
            Write(g1, xx31: 1: 3, ' ');
          end;
          Write(g, xx32: 1: 3, ' ');
          Write(g, ' 1E20 ');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_29-010') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx22 := random(20) + 15;
          for xx23 := 1 to xx22 do
          begin
            xx24 := random(3);
            Write(g, xx24, ' ');
            if (xx23 = 1) or (xx24 <> xx25) then
              Write(g1, xx24, ' ');
            xx25 := xx24;
          end;
          Write(g, ' 1E20 ');
          closefile(g);
          closefile(g1);
        end;
      end;

      if (chosen_task = '16_31-002') then
      begin
        for xx21 := 1 to 2 do
        begin
          number_of_tests := number_of_tests + 1;
          k := k + 1;
          randomize;
          Assign(g, s1 + '/tmp/iii' + IntToStr(k));
          rewrite(g);
          Assign(g1, s1 + '/tmp/ooo' + IntToStr(k));
          rewrite(g1);
          xx24 := random(3) + 98;
          Write(g, chr(xx24));
          xx25 := random(3) + 98;
          Write(g, chr(xx25));
          if xx24 = xx25 then
            Write(g1, 'True')
          else
            Write(g1, 'False');
          Write(g, '.');
          closefile(g);
          closefile(g1);
        end;
      end;

      //Insert random tests for next tasks here
    end;{of chosen task}

    if b then
      break;
  end;{of while}
  closefile(h);
  ioresult;
  closefile(g);
  ioresult;
  closefile(f);
  ioresult;
  if not b then
    ShowMessage('Fatal error 5!');
  extract_data := b;
  if b then
  begin
    form2.CheckBox1.Checked := auto;
    form2.button3.Enabled := jj3;
    form2.button5.Enabled := jj5;
    form2.button6.Enabled := jj6;
    form2.button7.Enabled := jj7;
  end;
end;

{Procedure that fills the array varparam, that is, define types of actual parameters that can be passed by reference only}
procedure setvarparam(var s: string);
var
  p, p2, i: integer;
  s1: string;
begin
  i := 0;
  //showmessage(s);
  repeat
    p := pos('var@', s);
    if p > 0 then
    begin
      s := copy(s, 1, p - 1) + copy(s, p + 4, length(s));
      s1 := copy(s, p, length(s));
      p := pos('=', s1);
      if (p < 2) and (not program_sub) then
      begin
        ShowMessage('Fatal in setvarparam');
        halt;
      end;
      if p < 2 then
        p := pos(' ', s1);
      if p < 2 then
        p := length(s) + 1;
      Inc(i);
      varparam[i] := copy(s1, 1, p - 1);
    end
  until (p = 0) or (length(s) < 2);

  varparam[i + 1] := '';
  for p := 1 to i do
    for p2 := 1 to length(varparam[i]) do
      if varparam[i, p2] in ['A'..'Z'] then
        varparam[i, p2] := chr(Ord(varparam[i, p2]) + 32);

end;

end.
