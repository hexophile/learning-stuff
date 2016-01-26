type
	int = integer;
var
	n:int;

function PostIncr( var x:integer ):int;
begin
	PostIncr := x;
	x := x + 1;
end;

function PreIncr( var x:integer ):int;
begin              
	x := x + 1;
	PreIncr := x;
end;

begin
	n := 1;
	n := PostIncr( n ) + PreIncr( n ); { 1 + 3 }
	writeln( n );

	n := 1;
	n := PostIncr( n ) + PostIncr( n ); { 1 + 2 }
	writeln( n );

	n := 1;
	n := PreIncr( n ) + PreIncr( n ); { 2 + 3 }
	writeln( n );            

	n := 1;
	n := PreIncr( n ) + PostIncr( n ); { 2 + 2 - haczyk, PostIncr nigdy nie inkrementuje n }
	writeln( n );

	readln;
end.
