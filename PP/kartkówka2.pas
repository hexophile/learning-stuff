uses sysutils;
begin
  writeln( ( (StrToInt(Paramstr(1))+StrToInt(Paramstr(2)) ) * ( StrToInt(Paramstr(2)) - StrToInt(Paramstr(1)) + 1 ) ) div 2 );
  readln;  // Program ma wyświetlić sumę kolejnych liczb całkowitych na podanym przedziale (przedział ma być rosnący)
end.
