//An excessive file now. //This program unit contains all procedures and fuctions connected with claims to programs - both common and individual
unit file101;

interface

{$I-}

implementation
uses file09,file00,dialogs,sysutils;
//procedure of initializing the encoded claim-file
{$I-}
{procedure initializef2(var f:t_f);
var k:byte;
begin closefile(f); ioresult;
reset(f);if (ioresult<>0)or(filesize(f)<12) then begin showmessage('Fatal error in initializef 2'); halt;end;
read(f,k);read(f,k); read(f,k); i_n_2:=k mod 10;
//i_n:=0;
read(f,k); read(f,k); read(f,k); s_n_2:=[k mod 10, k div 10 mod 10];
//showmessage(inttostr(i_n)+' '+inttostr(k mod 10)+'  '+inttostr(k div 10 mod 10));
//s_n:=[];
read(f,k); read(f,k);read(f,k); read(f,k);
i_c_2:=10;
  end;
}

end.
