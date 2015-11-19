// Sortowanie przez wybieranie
uses sysutils;

const
     N = 4;

var
   i:integer;
   tab:array[0..N-1] of integer;

// Function and procedure definitions
procedure SortArr( var tab:array of integer );
var
   i,j,swap:integer;
Begin
     for i := 0 to N-1 do
     begin
          for j := i to N-1 do
          begin
               if( tab[i] > tab[j] ) then
               begin
                    swap := tab[i];
                    tab[i] := tab[j];
                    tab[j] := swap;

               end; { End of swap if statement }
          end; { End of 'j' loop }
     end; { End of 'i' loop}
End; { End of SortArr procedure }


procedure ShowArr( tab:array of integer );
var
   i:integer;
Begin
     for i := 0 to N-1 do
     begin
          write(tab[i],' ':2);
//          if( i+1 = N div 2 ) then writeln;
     end; { End of 'i' loop }
End; { End of ShowArr procedure }

Begin
     if( Paramcount <> N ) then
     begin
          writeln('Nieprawidlowa ilosc parametrow. Poprawna ilosc: ',N);
          readln;
          exit;
     end;

     for i := 0 to N-1 do
     begin
          tab[i] := StrToInt(ParamStr(i+1));

          write(tab[i],' ':2);

//          if( i+1 = N div 2 ) then writeln;
     end;

     sortArr( tab );

     writeln;

     showArr( tab );
End.
