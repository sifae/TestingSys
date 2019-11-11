unit testing_main;

{$mode objfpc}{$H+}

interface

procedure testing(handle: THandle);

implementation

uses testing_utils, file02, file00, SysUtils, Dialogs, file09, Forms,
file_executeScript, file_killprocess;

{$I-,R+}

{Testing}
procedure testing(handle: THandle);

begin

  //showmessage(result_type[1,1]+result_type[1,2]+result_type[1,2]+'   '+result_type[2,1]+result_type[2,2]+result_type[2,3]+result_type[2,4]);

  form2.memo1.Clear;
  bb := False;

  n_err := 0;
  n_err1 := 0;
  //It is amount of errors in tests for the main program and for the subroutine respectively

  time_tests := 0;

  if (matrixin > 0) or (matrixout > 0) or (matrixins > 0) or (matrixouts > 0) or
    (chosen_task = '6_24') or (chosen_task = '15_25') or (copy(chosen_task, 1, 5) = '15_49') then
    form2.Memo1.Font.Name := 'Courier new'
  else
    form2.Memo1.Font.Name := _fontname;
  for ii5 := 1 to 1 + byte(program_sub) do
  begin
    if ii5 = 1 then
      ii6 := number_of_tests
    else
      ii6 := number_of_subtests;
    Amount_of_loops := 0;

    for i := 1 to ii6 do
    begin

      bloop := False;
      if ii5 = 1 then
        assignfile(h, current_dir + '/tmp/iii' + IntToStr(i))
      else
        assignfile(h, current_dir + '/tmp/iiii' + IntToStr(i));
      closefile(h);
      ioresult;

      reset(h);
      si := '';
      if (ioresult <> 0) then
      begin
        ShowMessage('Fatal!' + IntToStr(i));
        halt;
      end;


      //Replacing all blanks by '_', all tabs by '~' for the tasks 6_24, 15_25.
      if (chosen_task = '15_25') or (chosen_task = '6_24') then
      begin
        if not EOF(h) then
          readln(h, si);
        correct6_24_15_25(si);
      end
      else
        if (textsin > 0) or (chosen_task = '15_38') then
        begin
          if not (EOF(h)) then
            readln(h, si);
        end
        else
        begin
          if EOF(h) then
            si := ' '
          else
            repeat
              readln(h, si2);
              si := si + si2;
              if (matrixin > 0) or (arrayin > 0) then
                si := si + ' ';
              if (not EOF(h)) and (matrixin = 0) and (arrayin = 0) then
                si := si + chr(10);
            until EOF(h);
        end;



      closefile(h);

      if (textsin = 0) and (chosen_task <> '15_38') then
        delete_blanks(si);

      //A special correction for the tasks 16_18 and others - removal of the end 1E20
      if (chosen_task = '16_20-005') or (copy(chosen_task, 1, 5) = '16_18') or
        (copy(chosen_task, 1, 5) = '16_23') or (copy(chosen_task, 1, 5) = '16_29') then
        correct_16_1E20(si);

      //A special correction for the tasks 16_19 - removal of the @
      if copy(chosen_task, 1, 5) = '16_19' then
      begin
        correct_16_19(si);
        form2.memo1.Font.Name := 'Courier New';
      end;

      if ii5 = 1 then
      begin
        assignfile(f, current_dir + '/tmp/ooo' + IntToStr(i));
        assignfile(g, current_dir + '/tmp/rrr' + IntToStr(i));
      end
      else
      begin
        assignfile(f, current_dir + '/tmp/oooo' + IntToStr(i));
        assignfile(g, current_dir + '/tmp/rrrr' + IntToStr(i));
      end;

      closefile(f);
      ioresult;
      closefile(g);
      ioresult;
      setcurrentdir(current_dir + '/tmp/');
      time_test := now;
      cc1 := timetostr(time_test);
      if cc1[2] = ':' then
        cc1 := '0' + cc1;
      application.ProcessMessages;

      if ii5 = 1 then
        //k:=ShellExecute(Handle, 'open',pchar('temp0'+inttostr(i)+'.sh'), nil, nil,sw_hide)
        k := executeScript(handle, PChar('temp0' + IntToStr(i) + '.sh'))
      else
        //k:=ShellExecute(Handle, 'open',pchar('temp00'+inttostr(i)+'.sh'), nil, nil,sw_hide);
        k := executeScript(handle, PChar('temp00' + IntToStr(i) + '.sh'));

      application.ProcessMessages;
      setcurrentdir(current_dir);
      time_test := now;
      cc2 := timetostr(time_test);
      if cc2[2] = ':' then
        cc2 := '0' + cc2;
      //if (length(cc1)<>8) or(length(cc2)<>8)then begin showmessage('Fatal! Wrong time'); halt end;
      xx1 := 0; //xx1:=strtoint(copy(cc1,1,2))*3600+strtoint(copy(cc1,4,2))*60+strtoint(copy(cc1,7,2));
      xx2 := 0; //xx2:=strtoint(copy(cc2,1,2))*3600+strtoint(copy(cc2,4,2))*60+strtoint(copy(cc2,7,2));
      time_tests := time_tests + xx2 - xx1;
      application.ProcessMessages;
      setcurrentdir(current_dir);
      closefile(f);
      ioresult;
      closefile(g);
      ioresult;
      application.ProcessMessages;
      if k < 33 then
        exit;
      form2.Timer1.Interval := 300 - 120 * byte(i > 4) - 130 * byte(amount_of_loops > 4);
      form2.Timer1.Enabled := True;
      number_of_intervals := 0;
      bloop := True;
      repeat
        application.ProcessMessages;
        reset(g);
        if ioresult = 0 then
        begin
          bloop := False;
          closefile(g);
          break;
        end;
      until number_of_intervals >= 75;
      form2.Timer1.Enabled := False;
      number_of_intervals := 0;
      application.ProcessMessages;
      //if bloop then  begin j:=FindWindow(nil, 'c:/windows/system32/cmd.exe');
      //  SendMessage(j, WM_CLOSE, 0, 0);end;
      if bloop then
      begin
        Inc(amount_of_loops);
        if ii5 = 1 then
          case i mod 4 of
            1: killproc('temp2');
            2: killproc('temp3');
            3: killproc('temp4');
            0: killproc('temp5')
          end
        else
          case i mod 4 of
            1: killproc('temp20');
            2: killproc('temp30');
            3: killproc('temp40');
            0: killproc('temp50')
          end;

        form2.Timer1.Enabled := False;
        application.ProcessMessages;
        number_of_intervals := 0;
        //showmessage('Possibly infinite loop for the test  ');
        //bloop:=false
      end;

      //if bloop then begin if en_rus then showmessage('Time is out. Possible infinite loop. Please, close the dos window and restart the program.') else
      //showmessage ('Время истекло. Возможно зацикливание. Закройте DOS-окно и запустите программу вновь.'); delete_temp; form2.Close;end;

      //showmessage(inttostr(i));
      if not program_sub then
        if en_rus then
          s := 'Test number ' + IntToStr(i) + '. '
        else
          s := 'Тест номер ' + IntToStr(i) + '. '
      else
        if ii5 = 1 then
          if en_rus then
            s := 'Test number ' + IntToStr(i) + ' for the main program. '
          else
            s := 'Тест номер ' + IntToStr(i) + ' для основной программы. '
        else
          if en_rus then
            s := 'Test number ' + IntToStr(i) + ' for the subprogram. '
          else
            s := 'Тест номер ' + IntToStr(i) + ' для подпрограммы. ';
      form2.Memo1.Lines.add(s);
      if not program_sub or (ii5 = 1) then
      begin
        linetest[i] := form2.Memo1.Lines.Count;
        linetest[i + 1] := 0;
      end
      else
      begin
        linetest[i + number_of_tests] := form2.Memo1.Lines.Count;
        linetest[i + number_of_tests + 1] := 0;
      end;

      //showmessage(inttostr(i)+'  '+inttostr(linetest[i]));

      if not bloop then
      begin

        if (chosen_task = '6_24') or (chosen_task = '15_25') or (textsout <> 0) then
        begin
          reset(f);
          so := '';
          if not EOF(f) then
            readln(f, so);
          closefile(f);
          reset(g);
          sr := '';
          if not EOF(g) then
            readln(g, sr);
          closefile(g);


          //showmessage(sr);

          //Replacing of all blanks by '_' for the tasks 6_24, 15_25.
          if (copy(chosen_task, 1, 4) = '6_24') or (copy(chosen_task, 1, 5) = '15_25') then
            correct6_24_15_25(so);
          if (copy(chosen_task, 1, 4) = '6_24') or (copy(chosen_task, 1, 5) = '15_25') or
            (copy(chosen_task, 1, 5) = '15_49') then
            correct6_24_15_25(sr);
        end

        else
        begin
          so := '';
          reset(f);
          if (ioresult <> 0) then
            halt;
          if EOF(f) then
            so := ' '
          else
            repeat
              readln(f, so1);
              so := so + ' ' + so1;
            until EOF(f);
          closefile(f);
          sr := '';
          reset(g);
          if (ioresult <> 0) then
            halt;
          if EOF(g) then
            sr := ' '
          else
            repeat
              readln(g, sr1);
              sr := sr + ' ' + sr1;
            until EOF(g);
          closefile(g);
        end;

        //showmessage(inttostr(length(so)));

        //if i in [1,7,13] then showmessage(inttostr(i)+'Enter diff'+'!'+so+'!'+sr+'!');

      end
      else
      begin
        so := '   ';
        sr := so;
      end;
      ; //of not bloop

      //Removal of the last two zeroes and insertion of square brackets in the input data for the task 15.8 and 15.23
      if (chosen_task = '15_8') or (chosen_task = '15_23') then
        correct15_8_23(si);

      //Removal of the last integer in the input data for the task 15.11 and other task using a file of integer or real
      if (chosen_task = '15_11') or (copy(chosen_task, 1, 5) = '15_13') or
        (chosen_task = '15_16') or (chosen_task = '15_15') or (copy(chosen_task, 1, 5) = '15_28') then
        correct15_1int(si);

      //Removal of the final point in the input data for the task 15.12 and other tasks using a file of char
      if (copy(chosen_task, 1, 5) = '15_12') or (chosen_task = '15_14') or
        (chosen_task = '15_25') or (chosen_task = '15_29') or (chosen_task = '15_30') or
        (chosen_task = '15_31') or (copy(chosen_task, 1, 5) = '15_32') or (chosen_task = '15_34') or
        (chosen_task = '15_35') or (copy(chosen_task, 1, 5) = '15_50') then
        correct15_1char(si);
      //The same for the task 16_31-002
      if chosen_task = '16_31-002' then
      begin
        correct16_31(si);
        form2.Memo1.Font.Name := 'Courier New';
      end;


      if notblank(si) and (copy(chosen_task, 1, 4) = '8_44') or (chosen_task = '8_46') then
        si := copy(si, 1, length(si) div 2) + '  ' + copy(si, length(si) div 2 + 1, 100);

      if notblank(si) and (chosen_task = '8_47_а') then
        si := copy(si, 1, length(si) - 4) + '  ' + copy(si, length(si) - 3, 10);

      if notblank(si) and (length(si) > 1) and (chosen_task = '8_54') then
      begin
        kk := 0;
        for ii := 1 to length(si) do
          if si[ii] = ' ' then
          begin
            Inc(kk);
            if (kk = 9) and (i mod 2 = 1) or (kk = 8) and (i mod 2 = 0) then
            begin
              si := copy(si, 1, ii) + '  ' + copy(si, ii + 1, 100);
              break;
            end;
          end;
      end;

      if (chosen_task[1] = '9') and (chosen_task <> '9_32') then
      begin
        form2.Memo1.Font.Name := 'Courier New';
        forminout(si, True);
        if notblank(si) then
          if en_rus then
            form2.memo1.Lines.add('Initial data: ')
          else
            form2.memo1.Lines.add('Исходные данные: ');
        if (chosen_task = '9_20') or (chosen_task = '9_26') then
        begin
          if en_rus then
            form2.memo1.Lines.add('The matrix : ')
          else
            form2.memo1.Lines.add('Maтрица: ');
          //showmessage(outmatr[matrows]);
          if chosen_task = '9_20' then
          begin
            ccc := outmatr[matrows, length(outmatr[matrows])];
            outmatr[matrows] := copy(outmatr[matrows], 1, length(outmatr[matrows]) - 2);
          end;
          if chosen_task = '9_26' then
          begin
            matrows := matrows - 1;
            ccc := outmatr[matrows + 1];
          end;
        end;//of 9-20 or 9-26

        for ii := 1 to matrows do
          form2.Memo1.Lines.add(outmatr[ii]);

        if chosen_task = '9_20' then
          if en_rus then
            form2.memo1.Lines.add('The checked character: ' + ccc)
          else
            form2.memo1.Lines.add('Проверяемый символ: ' + ccc);

        if chosen_task = '9_26' then
          if en_rus then
            form2.memo1.Lines.add('The power: ' + ccc)
          else
            form2.memo1.Lines.add('Cтепень: ' + ccc);

      end //of chapter 9
      else
      begin
        //form2.Memo1.Font.Name:=_fontname;
        if (consts[1, 1] <> 0) and (consts[1, 2] = 0) then
          if en_rus then
            form2.memo1.Lines.add('N=' + IntToStr(consts[(i - 1) mod 4 + 1, 1]))
          else
            form2.memo1.Lines.add('n=' + IntToStr(consts[(i - 1) mod 4 + 1, 1]));
        if (consts[1, 1] <> 0) and (consts[1, 2] <> 0) then
          if en_rus then
            form2.memo1.Lines.add('N=' + IntToStr(consts[(i - 1) mod 4 + 1, 1]) + ' M=' +
              IntToStr(consts[(i - 1) mod 4 + 1, 2]))
          else
            form2.memo1.Lines.add('n=' + IntToStr(consts[(i - 1) mod 4 + 1, 1]) + ' m=' +
              IntToStr(consts[(i - 1) mod 4 + 1, 2]));

        //It is arrayin>0
        if (arrayin > 0) and (ii5 = 1) or (arrayins > 0) and (ii5 = 2) then
        begin
          if ii5 = 1 then
            arrayin0 := arrayin
          else
            arrayin0 := arrayins;
          correct_multi_arrays(si, arrayin0, 0, i);
          for iii := 1 to 1 + arrayin0 do
            form2.Memo1.Lines.Add(string_out[iii]);
        end {of arrayin>0}
        else
        //It is matrixin>0
          if (matrixin > 0) and (ii5 = 1) or (matrixins > 0) and (ii5 = 2) then
          begin
            form2.Memo1.Font.Name := 'Courier New';
            if ii5 = 1 then
              matrixin0 := matrixin
            else
              matrixin0 := matrixins;
            correct_matrices(si, matrixin0, 0, i, ii5, number_of_lines);
            //A special correction of the input data for the task 11_61
            if (chosen_task = '11_61') and (ii5 = 1) then
            begin
              if en_rus then
                string_out[number_of_lines] := 'The power P=' + string_out[number_of_lines] + '.'
              else
                string_out[number_of_lines] := 'Степень P=' + string_out[number_of_lines] + '.';
            end;
            //A special correction of the input data for the task 14_16
            if chosen_task = '14_16' then
            begin
              se := string_out[number_of_lines];
              delete_blanks(se);
              pq := pos('0', se);
              if pq = 0 then
                pq := 1;
              se := copy(se, pq + 1, length(se));
              delete_blanks(se);
              Delete(string_out[number_of_lines], pq, length(string_out[number_of_lines]));
              if string_out[number_of_lines] = '' then
                string_out[number_of_lines] := ' - ';
              Inc(number_of_lines);
              pq := pos('0', se);
              if pq = 0 then
                pq := 1;
              string_out[number_of_lines] := copy(se, 1, pq - 1);
              if string_out[number_of_lines] = '' then
                string_out[number_of_lines] := ' - ';
              if en_rus then
              begin
                string_out[number_of_lines - 1] := 'The set of rows: ' + string_out[number_of_lines - 1];
                string_out[number_of_lines] := 'The set of columns: ' + string_out[number_of_lines];
              end
              else
              begin
                string_out[number_of_lines - 1] :=
                  'Множество стpoк: ' + string_out[number_of_lines - 1];
                string_out[number_of_lines] := 'Мнoжествo cтoлбцoв: ' +
                  string_out[number_of_lines];
              end;
            end;

            for iii := 1 to number_of_lines do
              form2.Memo1.Lines.Add(string_out[iii]);
          end
          {of matrixin>0}

          else
            if (chosen_task = '11_24') and (ii5 = 2) then //ii5=1/2 - the main program/subroutine is tested
            begin
              correct11_24(si, i);
              form2.Memo1.Lines.Add(string_out[1]);
              form2.Memo1.Lines.Add(string_out[2]);
              form2.Memo1.Lines.Add(string_out[3]);
            end
            else
              if chosen_task = '11_22-001' then
              begin
                correct11_22a(si, ii5);
                form2.Memo1.Lines.Add(string_out[1]);
                form2.Memo1.Lines.Add(string_out[2]);
                form2.Memo1.Lines.Add(string_out[3]);
                if ii5 = 2 then
                  form2.Memo1.Lines.Add(string_out[4]);
              end {of 11_22-001}
              else
                if chosen_task = '11_57' then
                begin
                  arrayin1 := arrayin;
                  arrayin := 3 - byte(ii5 = 2);
                  Inc(consts[(i - 1) mod 4 + 1, 1]);

                  //showmessage(inttostr(arrayin));

                  correct_multi_arrays(si, arrayin, 0, i);
                  for pp1 := 2 to 3 - byte(ii5 = 2) do
                  begin
                    if ii5 = 1 then
                    begin
                      pp := pos('array', string_out[pp1]);
                      if pp > 0 then
                      begin
                        Delete(string_out[pp1], pp, 5);
                        insert('polinomial', string_out[pp1], pp);
                      end;
                      pp := pos('массив', string_out[pp1]);
                      if pp > 0 then
                      begin
                        Delete(string_out[pp1], pp, 6);
                        insert('полином', string_out[pp1], pp);
                      end;
                    end;
                    if ii5 = 2 then
                    begin
                      pp := pos('first array', string_out[pp1]);
                      if pp > 0 then
                      begin
                        Delete(string_out[pp1], pp, 11);
                        insert('polinomial', string_out[pp1], pp);
                      end;
                      pp := pos('первый массив', string_out[pp1]);
                      if pp > 0 then
                      begin
                        Delete(string_out[pp1], pp, 13);
                        insert('полином', string_out[pp1], pp);
                      end;
                    end;
                  end;
                  pp := pos(':', string_out[4 - byte(ii5 = 2)]);
                  if pp > 0 then
                    if en_rus then
                      string_out[4 - byte(2 = ii5)] := 'the point' + copy(string_out[4 - byte(2 = ii5)], pp, 1000)
                    else
                      string_out[4 - byte(ii5 = 2)] := 'тoчка' + copy(string_out[4 - byte(ii5 = 2)], pp, 1000);
                  for iii := 1 to 1 + arrayin do
                    form2.Memo1.Lines.Add(string_out[iii]);
                  arrayin := arrayin1;
                  Dec(consts[(i - 1) mod 4 + 1, 1]);
                end //of 11_57
                //A special correction of the input data for the task 11.29-004
                else if chosen_task = '11_29-004' then
                  begin
                    ppa := length(si);
                    ppa2 := 0;
                    for ppa1 := ppa downto 1 do
                      if si[ppa1] = ' ' then
                      begin
                        ppa2 := ppa1;
                        break;
                      end;
                    if ppa2 > 0 then
                    begin
                      if en_rus then
                        form2.memo1.Lines.add('Initial array: ' + copy(si, 1, ppa2 - 1))
                      else
                        form2.memo1.Lines.add('Исходный массив: ' + copy(si, 1, ppa2 - 1));
                      if en_rus then
                        form2.memo1.Lines.add('Amount of positions of the shift: ' + copy(si, ppa2 + 1, 100))
                      else
                        form2.memo1.Lines.add('Koличествo пoзиций cдвигa: ' +
                          copy(si, ppa2 + 1, 100));
                    end;
                  end //of 11_29-004
                  //A special correction of the input data for the tasks where more than one input file is needed
                  else
                    if filein > 0 then
                      output_multifiles(si, 1)
                    //of Chapter 15 - multifiles

                    else
                      if textsin > 0 then
                        outputtextfile(si, 1)
                      //if (copy(chosen_task,1,5)='15_42')or(copy(chosen_task,1,5)='15_44') or(copy(chosen_task,1,5)='15_45')or(copy(chosen_task,1,5)='15_47')or(copy(chosen_task,1,5)='15_48')then outputtextfile(si,1)

                      else
                        if copy(chosen_task, 1, 5) = '16_16' then
                        begin
                          output16_16input(si);
                        end



                        ////////INSERT A SPECIAL INPUT HERE!!!!!!!!!!!!!!!!!


                        else
                          if notblank(si) then
                          begin
                            if pos(chr(10), si) = 0 then
                              if en_rus then
                                form2.memo1.Lines.add('Initial data: ' + si)
                              else
                                form2.memo1.Lines.add('Исходные данные: ' + si)
                            else
                            begin
                              if en_rus then
                                form2.memo1.Lines.add('Initial data: ')
                              else
                                form2.memo1.Lines.add('Исходные данные: ');
                              repeat
                                if si = '' then
                                  pa := 0
                                else
                                  pa := pos(chr(10), si);
                                if pa > 0 then
                                begin
                                  sp := copy(si, 1, pa - 1);
                                  delete_blanks(sp);
                                  //if i<10 then showmessage(sp);
                                  if sp = '' then
                                    if en_rus then
                                      sp := '<Empty line>'
                                    else
                                      sp := '<Пустая строка>';
                                end;
                                if pa <> 0 then
                                begin
                                  form2.Memo1.Lines.add(sp);
                                  Delete(si, 1, pa);
                                end
                                else
                                begin
                                  delete_blanks(si);
                                  if si = '' then
                                    if en_rus then
                                      si := '<Empty line>'
                                    else
                                      si := '<Пустая строка>';
                                  form2.Memo1.Lines.add(si);
                                end;
                                //if i=51 then showmessage('!'+si+'!'+inttostr(pa));
                              until (pa = 0);
                            end; //of pos(chr(10),si)<>0
                          end //of not blank si
                          else //of not blank si
                            if en_rus then
                              if (chosen_task <> '6_24') and (chosen_task <> '15_25') and (chosen_task <> '15_32-006') then
                                form2.memo1.Lines.add('Initial data: -')
                              else
                                form2.memo1.Lines.add('Initial data: <Empty line>')
                            else if (chosen_task <> '6_24') and (chosen_task <> '15_25') then
                                form2.memo1.Lines.add('Исходные данные: -')
                              else
                                form2.memo1.Lines.add('Исходные данные: <Пуcтая стpoка>');
      end;

      //{of else from chapter 9
      //i42:=0; if (length(sr)>=21)and(copy(sr,length(sr)-20,21)='!unclosed!files!left!')and (chosen_task[1]='1')and(chosen_task[2] in ['5'..'7']) then
      //begin i42:=1; sr:=copy(sr,1,length(sr)-21) end;
      //The case of existing temporary files
      i43 := 0;
      if (length(sr) >= 1) and (copy(sr, length(sr), 1) = chr(5)) and (chosen_task[1] = '1') and
        (chosen_task[2] in ['5'..'7']) then
      begin
        i43 := 1;
        Delete(sr, length(sr), 1);
      end;
      //The case of unclosed files
      i42 := 0;
      if (length(sr) >= 1) and (copy(sr, length(sr), 1) = chr(4)) and (chosen_task[1] = '1') and
        (chosen_task[2] in ['5'..'7']) then
      begin
        i42 := 1;
        Delete(sr, length(sr), 1);
      end;


      if notblank(sr) and (chosen_task = '8_47_б') then
        sr := copy(sr, 1, length(sr) - 4) + '  ' + copy(sr, length(sr) - 3, 10);
      if notblank(so) and (chosen_task = '8_47_б') then
        so := copy(so, 1, length(so) - 4) + '  ' + copy(so, length(so) - 3, 10);
      if notblank(sr) and (chosen_task = '9_32') then
        for k2 := 1 to length(sr) - 1 do
          if (sr[k2] <> ' ') and (sr[k2 + 1] <> ' ') then
          begin
            sr := copy(sr, 1, k2) + ' ' + copy(sr, k2 + 1, 1000);
            break;
          end;


      st := so;
      while True do
      begin
        k2 := pos('||', st);
        if (chosen_task = '7_24')
        //numbers of other tasks will probably be added here; it is a case when the first answer is in English but the second one is in Russian the choice depends on the current language
        then
        begin
          if en_rus then
          begin
            so := copy(st, 1, k2 - 1);
            st := '';
          end
          else
          begin
            so := copy(st, k2 + 2, 2222);
            st := '';
          end;
          k2 := 0;
          sw := so;
          sv := sr;
        end
        else
        begin

          if k2 = 0 then
          begin
            so := st;
            st := '';
          end
          else
          begin
            so := copy(st, 1, k2 - 1);
            st := copy(st, k2 + 2, 10000);
          end;
          sw := so;
          sv := sr;

        end;

        //if length(sr)<100 then begin
        //showmessage(sr+'!'+inttostr(length(sr)));
        //showmessage(so+'!'+inttostr(length(so))); end;



        if not bloop then
          m := diff(i)
        else
          m := 25; {infinite loop}
        if i42 * i43 > 0 then
        begin
          i42 := 0;
          i43 := 0;
          m := 8;
        end;
        if i42 = 1 then
        begin
          i42 := 0;
          m := 6;
        end;
        if i43 = 1 then
        begin
          i43 := 0;
          m := 7;
        end;

        //A special words error, no roots...that must be converted to the current language

        //if (sr<>'')and(sr[1]>':') then showmessage(sr+'!'+so);

        if ((sr = 'Ошибка') and (so = 'Error') or (sr = 'Нет корней') and (so = 'No roots')) and
          not en_rus and (m = 0) and errorr then
          so := sr
        else
        begin

          sr := sv;
          so := sw;

        end;

        if (m = 0) or (k2 = 0) then
          break;
      end;//of while true


      //showmessage('here');

      if not bloop then
      begin
        //It is arrayout>0
        if (arrayout > 0) and (ii5 = 1) or (arrayouts > 0) and (ii5 = 2) then
        begin
          if ii5 = 1 then
            arrayout0 := arrayout
          else
            arrayout0 := arrayouts;
          correct_multi_arrays(sr, arrayout0, 1, i);

          //showmessage(inttostr(ii5));
          //showmessage(inttostr(arrayout0));

          for iii := 1 to 1 + arrayout0 do
            form2.Memo1.Lines.Add(string_out[iii]);
        end {of arrayout>0}
        else
          if (matrixout > 0) and (ii5 = 1) or (matrixouts > 0) and (ii5 = 2) then
          begin
            //A special correction of the output data for the task 11_60
            if chosen_task = '11_60' then
            begin
              ii2 := consts[(i - 1) mod 4 + 1, 1] * consts[(i - 1) mod 4 + 1, 2];
              sro := so;
              delete_blanks(sro);
              ii4 := 0;
              for ii3 := 1 to length(sro) do
                if sro[ii3] = ' ' then
                  Inc(ii4);
              Inc(ii4);
              ii4 := ii4 div ii2;
              //showmessage(inttostr(ii2)+' '+inttostr(ii4)+'    '+sro);
              if ii4 = 0 then
                Inc(ii4);
              matrixout := ii4;
            end;
            if ii5 = 2 then
              matrixout0 := matrixouts
            else
              matrixout0 := matrixout;
            correct_matrices(sr, matrixout0, 1, i, ii5, number_of_lines);
            for iii := 1 to number_of_lines do
              form2.Memo1.Lines.Add(string_out[iii]);
          end {of matrixout>0}
          else
            if (chosen_task = '9_5-005') or (chosen_task = '9_11') or (copy(chosen_task, 1, 4) = '9_13') or
              (copy(chosen_task, 1, 4) = '9_25') or (copy(chosen_task, 1, 4) = '9_26')

            // we shall add other tasks here
            then
            begin
              forminout(sr, False);
              if notblank(sr) then
              begin
                if en_rus then
                  form2.memo1.Lines.add('Obtained result: ')
                else
                  form2.memo1.Lines.add('Полученный результат: ');
                for ii := 1 to matrows do
                  form2.Memo1.Lines.add(outmatr[ii]);
              end
              else
                if en_rus then
                  form2.memo1.Lines.add('Obtained result: -')
                else
                  form2.memo1.Lines.add('Полученный результат: -');
            end
            else
              if chosen_task = '15_23' then
                output15_23(sr, 1)
              else
              //A special correction of the output data for the tasks where more than one output file is needed
                if fileout > 0 then
                  output_multifiles(sr, 2)
                else
                //if (chosen_task='15_38')or (chosen_task='15_47')or (chosen_task='15_48')then outputtextfile(sr,2)
                  if textsout > 0 then
                    outputtextfile(sr, 2)
                  else
                    if (chosen_task = '16_16-003') or (chosen_task = '16_16-004') or
                      (chosen_task = '16_16-005') or (chosen_task = '16_16-006') then
                    begin
                      correct_16_16(sr);
                      form2.memo1.Font.Name := 'Courier New';
                      output16_16output(sr, 2);
                    end
                    else
                      if ((chosen_task = '10_21') or (chosen_task = '10_22')) and (pos('rror', so) = 0) then
                        output10_21_22(sr, 1)

                      ////////INSERT A SPECIAL OUTPUT HERE!!!!!!!!!!!!!!!!!
                      //END OF SPECIAL OUTPUT!!!!!!!!!!!!!!!

                      else
                      begin
                        if copy(chosen_task, 1, 5) = '16_19' then
                          correct_16_19(sr);
                        if copy(chosen_task, 1, 5) = '16_16' then
                        begin
                          correct_16_16(sr);
                          form2.memo1.Font.Name := 'Courier New';
                        end;
                        if copy(chosen_task, 1, 5) = '16_18' then
                          correct_16_1E20(sr);
                        if check_new or check_dispose then
                          checknewdispose(sr);

                        if (chosen_task = '15_8') and (notblank(sr)) then
                        begin
                          delete_blanks(sr);
                          sr := '[' + sr + ']';
                        end;
                        if notblank(sr) then
                          if en_rus then
                            form2.memo1.Lines.add('Obtained result: ' + sr)
                          else
                            form2.memo1.Lines.add('Полученный результат: ' + sr)
                        else if en_rus then
                            if (chosen_task <> '6_24') and (chosen_task <> '15_25') and (chosen_task <> '15_32-006') then
                              form2.memo1.Lines.add('Obtained result: -')
                            else
                              form2.memo1.Lines.add('Obtained result: <Empty line>')
                          else if (chosen_task <> '6_24') and (chosen_task <> '15_25') then
                              form2.memo1.Lines.add('Полученный результат: -')
                            else
                              form2.memo1.Lines.add('Полученный результат: <Пустая строка>');
                      end;

        if (arrayout > 0) and (ii5 = 1) or (arrayouts > 0) and (ii5 = 2) then
        begin
          if ii5 = 1 then
            arrayout0 := arrayout
          else
            arrayout0 := arrayouts;
          correct_multi_arrays(so, arrayout0, 2, i);
          for iii := 1 to 1 + arrayout0 do
            form2.Memo1.Lines.Add(string_out[iii]);
        end {of arrayout>0}
        else
          if (matrixout > 0) and (ii5 = 1) or (matrixouts > 0) and (ii5 = 2) then
          begin
            if ii5 = 1 then
              matrixout0 := matrixout
            else
              matrixout0 := matrixouts;
            correct_matrices(so, matrixout0, 2, i, ii5, number_of_lines);
            for iii := 1 to number_of_lines do
              form2.Memo1.Lines.Add(string_out[iii]);
          end {of matrixout>0}
          else

            if (chosen_task = '9_5-005') or (chosen_task = '9_11') or (copy(chosen_task, 1, 4) = '9_13') or
              (copy(chosen_task, 1, 4) = '9_25') or (copy(chosen_task, 1, 4) = '9_26')

            // we shall add other tasks here
            then
            begin
              forminout(so, False);
              if notblank(so) then
              begin
                if en_rus then
                  form2.memo1.Lines.add('Correct result: ')
                else
                  form2.memo1.Lines.add('Правильный результат: ');
                for ii := 1 to matrows do
                  form2.Memo1.Lines.add(outmatr[ii]);
              end
              else
                if en_rus then
                  form2.memo1.Lines.add('Correct result: -')
                else
                  form2.memo1.Lines.add('Правильный результат: -');
            end
            else
              if chosen_task = '15_23' then
                output15_23(so, 2)
              else
              //A special correction of the output data for the tasks where more than one output file is needed
                if fileout > 0 then
                  output_multifiles(so, 3)
                else
                //if (chosen_task='15_38')or (chosen_task='15_47')or (chosen_task='15_48')then outputtextfile(so,3)
                  if textsout > 0 then
                    outputtextfile(so, 3)
                  else
                    if (chosen_task = '16_16-003') or (chosen_task = '16_16-004') or (chosen_task = '16_16-005') or
                      (chosen_task = '16_16-006') then
                      output16_16output(so, 3)
                    else
                    ////////INSERT A SPECIAL OUTPUT HERE!!!!!!!!!!!!!!!!!
                      if ((chosen_task = '10_21') or (chosen_task = '10_22')) and (pos('rror', so) = 0) then
                        output10_21_22(so, 2)
                      else
                      begin
                        if (chosen_task = '15_8') and (notblank(so)) then
                        begin
                          delete_blanks(so);
                          so := '[' + so + ']';
                        end;
                        if notblank(so) then
                          if en_rus then
                            form2.memo1.Lines.add('Correct result: ' + so)
                          else
                            form2.memo1.Lines.add('Правильный результат: ' + so)
                        else if en_rus then
                            if (chosen_task <> '6_24') and (chosen_task <> '15_25') and (chosen_task <> '15_32-006') then
                              form2.memo1.Lines.add('Correct result: -')
                            else
                              form2.memo1.Lines.add('Correct result: <Empty line>')
                          else if (chosen_task <> '6_24') and (chosen_task <> '15_25') then
                              form2.memo1.Lines.add('Правильный результат: -')
                            else
                              form2.memo1.Lines.add('Правильный результат: <Пустая строка>');
                      end;
        //l:=1;m:=0;//l - the number of received/correct value; m - the final result of the current testing

        //if chosen_task='11_63' then m:=1;


        case m of
          8:
          begin
            if en_rus then
              s := 'A temporary file has not been deleted and some files have not been closed.'
            else
              s := 'Вpeменный файл не был удалeн и некоторые файлы не были закрыты.';
          end;
          7:
          begin
            if en_rus then
              s := 'A temporary file has not been deleted.'
            else
              s := 'Вpeменный файл не был удалeн.';
          end;
          6:
          begin
            if en_rus then
              s := 'Some of the files have not been closed.'
            else
              s := 'Некоторые файлы не были закрыты.';
          end;
          5:
          begin
            if en_rus then
              s := 'An admissible permutation.'
            else
              s := 'Допустимая перестановка.';
            bb := True;
            m := 0;
          end;
          3: if en_rus then
              s := 'Excessive output.'
            else
              s := 'Избыточный вывод.';
          4: if en_rus then
              s := 'Not enough output data.'
            else
              s := 'Мало результирующих данных.';
          2: if en_rus then
              s := 'Accuracy is not reached.'
            else
              s := 'Точность не достигнута.';
          1: if en_rus then
              s := 'ERROR.'
            else
              s := 'ОШИБKA.';
          0: s := 'Ok';
        end;//of case
        if ii5 = 1 then
          n_err := n_err + byte(m <> 0)
        else
          n_err1 := n_err1 + byte(m <> 0);

        //if m>0 then  form2.Memo1.Font.Color:=clred else form2.Memo1.Font.Color:=clblack;
        closefile(f);
        closefile(g);
        form2.memo1.Lines.add(s);

        //if m>0 then form2.memo1.Lines.Add(chr(33));

      end

      else
      begin
        if en_rus then
          s := 'Time is out. Possible infinite loop.'
        else
          s := 'Истекло время. Возможно зацикливание.';
        closefile(f);
        closefile(g);//form2.memo1.lines.add('   ');
        form2.Memo1.Lines.Add(s);
        if ii5 = 1 then
          n_err := n_err + 1
        else
          n_err1 := n_err1 + 1;
        //assignfile(f1,current_dir+'/tmp/temp2'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
        //assignfile(f1,current_dir+'/tmp/temp3'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
        //assignfile(f1,current_dir+'/tmp/temp4'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
        //assignfile(f1,current_dir+'/tmp/temp5'); closefile(f1); ioresult; reset(f1); ioresult;closefile(f1); ioresult;
        was_loop := True;
      end;

      closefile(h);
      ioresult;
      closefile(f);
      ioresult;
      closefile(g);
      ioresult;
      //killproc('temp2');
      application.ProcessMessages;
      //killproc('temp3');
      application.ProcessMessages;
      //killproc('temp4');
      application.ProcessMessages;
      //killproc('temp5');
      application.ProcessMessages;

    end;//of for from 1 to number of tests
  end;//of for external from 1 to 1+byte(program_sub)
  //It is blocked now
  //if en_rus then form2.memo1.Lines.Add('The total tests execution time is '+inttostr(time_tests)+' sec.')
  //else
  //form2.memo1.Lines.Add('Общее время выполнения тестов -  '+inttostr(time_tests)+' сек.');

  form2.Memo1.Lines.Add('  ');
  for i := 1 to warnings_amount do
    form2.memo1.Lines.add(warnings[i]);
  if incorrect_boolean then
    if en_rus then
      form2.Memo1.Lines.Add(
        'Hint: an expression <variable>=true or <variable>=false was found in the program.')
    else
      form2.Memo1.Lines.Add(
        'Замечание: в программе найдено выражение <переменная>=true or <переменнaя>=false.');
  form2.Memo1.Lines.Add('  ');


  for ii5 := 1 to 1 + byte(program_sub) do
  begin
    if ii5 = 1 then
      n_err2 := n_err
    else
      n_err2 := n_err1;
    if ii5 = 1 then
      nummm := number_of_tests
    else
      nummm := number_of_subtests;
    if ii5 = 1 then
      s8 := ''
    else
      s8 := s8 + chr(10);
    if not program_sub then
      s7 := ''
    else if ii5 = 1 then
        if en_rus then
          s7 := ' for the main program'
        else
          s7 := ' для основной программы'
      else
        if en_rus then
          s7 := ' for the subprogram'
        else
          s7 := ' для пoдпрограммы';
    if (n_err2 > 0) then
    begin
      if en_rus then
        if n_err2 = 1 then
          s8 := s8 + IntToStr(n_err2) + ' wrong result out of ' + IntToStr(nummm) + s7 + '.'
        else
          s8 := s8 + IntToStr(n_err2) + ' wrong results out of ' + IntToStr(nummm) + s7 + '.'
      else if (n_err2 = 1) or (n_err2 > 20) and (n_err2 mod 10 = 1) then
          s8 := s8 + IntToStr(n_err2) + ' ошибочный ответ из ' + IntToStr(nummm) + s7 + '.'
        else if (n_err2 < 5) or (n_err2 > 20) and (n_err2 mod 10 in [2..4]) then
            s8 := s8 + IntToStr(n_err2) + ' ошибочных ответa из ' + IntToStr(nummm) + s7 + '.'
          else
            s8 := s8 + IntToStr(n_err2) + ' ошибочных ответoв из ' + IntToStr(nummm) + s7 + '.';
    end
    else if en_rus then
        s8 := s8 + 'All the results are correct' + s7 + '.'
      else
        s8 := s8 + 'Bce ответы ' + s7 + ' правильные.';
    //showmessage('We are here'+inttostr(ii5));
  end;
  if bb and (n_err = 0) and (n_err1 = 0) then
    if en_rus then
      s8 := s8 + ' Admissible permutations of elements in the resulting array were found.'
    else
      s8 := s8 + ' Были найдены допустимые перестановки элементов в результирующем массиве.';
  ShowMessage(s8);
  closefile(f);
  ioresult;
  closefile(g);
  ioresult;
  closefile(h);
  ioresult;
  if (form2.checkbox2.Checked) then
    delete_correct_results;

  //showmessage('after the testing');

  //form2.memo1.lines.add('  ');
end;

end.
