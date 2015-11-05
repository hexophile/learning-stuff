Program zadanie1;               // Dziala nawet bez tego.

var
plik:text;                      // Deklaracja zmiennej plikowej
tab:array[0..9] of integer;     // Deklaracje tablic
tab2:array[0..9] of char;       // Uzywamy tylko cyfr, nie trzeba wiekszego typu danych
i:integer;                      // Deklaracja zmiennej pomocniczej

begin
    for i := 0 to 9 do          // Pierwsza petla, wypelnia tablice tab[]
    begin
        tab[i] := i;
    end;
    
    Assign( plik, 'plik.txt' ); // Przypisanie pliku do zmiennej
    rewrite( plik );            // Otworz nowy plik pod zmienna 'plik'
    
    repeat                      // Druga petla, zapisuje zawartosc tablicy tab[] do pliku
        writeln( plik, tab[i] );
        i := i - 1;
    until(i = 0);
    
    close( plik );              // Zamkniecie pliku
    
    assign( plik, 'plik.txt' ); // Drugie przypisanie
    reset( plik );              // Otworz plik i przesun wskaznik na poczatek
    
    while( not eof(plik) ) do   // Lub i < 10
    begin                       // Trzecia petla, odczytuje zawartosc pliku i wpisuje do tablicy tab2[]
        readln( plik, tab2[i] );
        writeln( tab2[i] );
        i := i + 1;
    end;
    
    close( plik );              // Zamkniecie pliku
    readln;
end.
