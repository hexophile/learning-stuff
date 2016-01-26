type
	uint = cardinal; { unsigned integer - 4 bajtowa liczba bez znaku
	typ ten jest zdolny do pomieszczenia adresu w pamieci
	ktory jest z reguly wielkosci 4 bajtow }
	pointerPtr = ^pointer; // wskaznik na wskaznik

var
	zmienna:uint;                  // zmienna typu unsigned int
	wskaznik:pointer;              // zmienna typu pointer (zmienna wskaznikowa)
	wskazniknawskaznik:pointerPtr; // zmienna typu ^pointer (wskaznik na wskaznik)

begin
	zmienna := 4; // Podajemy wartosc zmiennej.
	writeln( 'zmienna := 4' );
	writeln( 'zmienna = ', zmienna );
	writeln;
	writeln;

	wskaznik := @zmienna; // Podajemy adres zmiennej.
	writeln( 'wskaznik := @zmienna' );
	writeln;

	// Rzutowanie typu. Przedstawiamy zmienna typu 'pointer' jako zmienna typu 'uint'.
	writeln( 'wskaznik = ', uint(wskaznik) );
	writeln( 'wskaznik^ = ', uint(wskaznik^) );
	writeln( '@wskaznik = ', uint(@wskaznik) );
	writeln;
	writeln;

	wskazniknawskaznik := @wskaznik; // Podajemy adres wskaznika.
	writeln( 'wskazniknawskaznik := @wskaznik' );
	writeln;

	writeln( 'wskazniknawskaznik = ', uint(wskazniknawskaznik) );
	writeln( 'wskazniknawskaznik^ = ', uint(wskazniknawskaznik^) );
	writeln( '@wskazniknawskaznik = ', uint(@wskazniknawskaznik) );
	writeln;
	writeln;

	wskazniknawskaznik := wskaznik; // Podajemy adres wskazywany przez wskaznik.
	writeln( 'wskazniknawskaznik := wskaznik' );
	writeln;

	writeln( 'wskazniknawskaznik = ', uint(wskazniknawskaznik) );
	writeln( 'wskazniknawskaznik^ = ', uint(wskazniknawskaznik^) );
	writeln( '@wskazniknawskaznik = ', uint(@wskazniknawskaznik) );

	readln;
end.        
