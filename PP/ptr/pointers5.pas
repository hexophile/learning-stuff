program MMPPIB; { MMPPIB Magically Prints Parameters In Binary }

uses
	sysutils; { The book of magics. }

const
	DEFAULT_BUFFER_SIZE = 8; { Magicial number of buffer size for magical binary numbers. }
	NL = #10; { Magicial teleporter to new line. Magichar. }

type
	int = integer; { Transformation magical spell. }
	bool = boolean; { Another one magicial spell of transformations. }

var
	x,y:int; { High-leveled magic of creation. }

function ParseInt( arg:string; var variable:int ):bool; { Use the magic to change string to integer! }
begin
	ParseInt := true;
	try
		variable := StrToInt( arg ); { Something happens, little glitter starts to drip... }
	except
		write( NL+'Error converting string("' + arg + '") to integer. ' );
		ParseInt := false; { ur a fail. in running a program with a to-be-integer-designed params. }
	end;
end;

procedure BitWrite( x:int; size:int ); { Print variable in binary, in size of size. Magics. }
begin
	write( '0b' );
	for size := size downto 0 do { Really... That's magic of you, pascal... }
	begin
		if ( bool( x and ( 1 shl size ) ) ) then { Start spelling. (dat pun...) }
			write( 1 )
		else
			write( 0 );
	end;
end;

begin
	if ( ParamCount >= 1 ) then { Distracted by whether it shall be '> 0' or '>= 1', but then: "rational number of parameters... what?" }
	begin
		for y := 1 to ParamCount do
		begin
			if ( ParseInt( ParamStr(y), x ) ) then
			begin
				write( NL+'arg', y,' = ', x, ' = ' );
				BitWrite( x, DEFAULT_BUFFER_SIZE );
			end
			else
				write( 'ParamCount = ', y );
		end;
	end
	else
		writeln( 'Wrong amount of arguments.' ); { No dumas, ur magicing ron! }
end. { I'm a magician! }
