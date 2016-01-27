uses sysutils;

const
	ADDRESS_DIGITS = 8; { Amount of didgits in hexadecimal representation of address. }
	NL = #10; { New Line char. }
	TAB = #9; { Tab char. }

type
	int = integer;
	uint = cardinal;

	analysis = record
		data:int;
		address:pointer; { This one will contain address of function inside. }
	end;

	templateFunction = function( x:int ):analysis;
	tempFuncPtr = ^templateFunction;

var
	newFunction:tempFuncPtr;
	x:int;


procedure PrintAddress( const rem:string; address:pointer; digits:int );
begin
	write( rem+'0x', IntToHex( uint( address ), digits ) )
end; { End of hexadecimal PrintAddress procedure }

procedure PrintAddress( const rem:string; address:pointer );
begin
	write( rem, uint( address ) )
end; { End of decimal PrintAddress procedure }

function test( i:int ):analysis;
begin
	test.data := i + 1;
	test.address := @test;
end; { End of test function }

procedure ShowResults( func:tempFuncPtr; x:int ); { Passing function address by 'reference' }
begin
	PrintAddress( NL+'Current function addr = ', @ShowResults, ADDRESS_DIGITS );
	PrintAddress( TAB, @ShowResults );

	PrintAddress( NL+'arg function addr = '+TAB, @func, ADDRESS_DIGITS );
	PrintAddress( TAB, @func );

	PrintAddress( NL+'arg func. call addr = '+TAB, func^(x).address, ADDRESS_DIGITS );
	PrintAddress( TAB, func^(x).address );

	writeln( NL+'x = ',x,'; Returned data: ', func^(x).data, NL );
end; { End of ShowResults function }

procedure ShowResults_2( func:templateFunction; x:int ); { Passing function address by value (here: address) }
begin
	PrintAddress( NL+'Current function addr = ', @ShowResults_2, ADDRESS_DIGITS );
	PrintAddress( TAB, @ShowResults_2 ); { FUNNY PROBLEM: you can't get addres of overloaded function; TODO }

	PrintAddress( NL+'arg function addr = '+TAB, @func, ADDRESS_DIGITS );
	PrintAddress( TAB, @func );

	PrintAddress( NL+'arg func. call addr = '+TAB, func(x).address, ADDRESS_DIGITS );
	PrintAddress( TAB, func(x).address );

	writeln( NL+'x = ',x,'; Returned data: ', func(x).data, NL );
end; { End of ShowResults_2 function }

procedure ShowResults_3( var func:templateFunction; x:int ); { Passing function address by reference }
begin
	PrintAddress( NL+'Current function addr = ', @ShowResults_3, ADDRESS_DIGITS );
	PrintAddress( TAB, @ShowResults_3 );

	PrintAddress( NL+'arg function addr = '+TAB, @func, ADDRESS_DIGITS );
	PrintAddress( TAB, @func );

	PrintAddress( NL+'arg func. call addr = '+TAB, func(x).address, ADDRESS_DIGITS );
	PrintAddress( TAB, func(x).address );

	writeln( NL+'x = ',x,'; Returned data: ', func(x).data, NL );
end; { End of ShowResults_3 function }

begin
	x := 4;

	new( newFunction );
	newFunction^ := @test;

	PrintAddress( 'pCall ShowRes() addr = '+TAB, @ShowResults, ADDRESS_DIGITS );
	PrintAddress( TAB, @ShowResults );

	PrintAddress( NL+'pCall test() addr = '+TAB, @test, ADDRESS_DIGITS );
	PrintAddress( TAB, @test );

	PrintAddress( NL+'newFunction addr = '+TAB, newFunction, ADDRESS_DIGITS );
	PrintAddress( TAB, newFunction );

	writeln( NL+'### END OF INIT PRINTS ###'+NL );


	write( 'ShowResults( newFunction, x ) where: arg1:tempFuncPtr; arg2:int ');
	ShowResults( newFunction, x );

	write( 'ShowResults_2( @test, x ) where: arg1:templateFunction; arg2:int ');
	ShowResults_2( @test, x );

	write( 'ShowResults_3( newFunction^, x ) where: var arg1:templateFunction; arg2:int ');
	ShowResults_3( newFunction^, x );

	readln;
end.
