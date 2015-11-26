Program zadanie1;

var
plik:text;
tab:array[0..9] of integer;
tab2:array[0..9] of char;
i:integer;

begin
    for i := 0 to 9 do
    begin
        tab[i] := i;
    end;
    
    Assign( plik, 'plik.txt' );
    rewrite( plik );
    
    repeat
        writeln( plik, tab[i] );
        i := i - 1;
    until(i = 0);
    
    close( plik );
    
    assign( plik, 'plik.txt' );
    reset( plik );
    
    while( not eof(plik) ) do
    begin
        readln( plik, tab2[i] );
        writeln( tab2[i] );
        i := i + 1;
    end;
    
    close( plik );
    readln;
end.
