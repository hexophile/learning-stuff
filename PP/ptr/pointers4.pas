uses sysutils;

type
	bool = boolean;
	int = integer;

function Equal( x:int; y:int ):bool;
begin
	if ( not bool( ( ( x or $FFFFFFFE ) xor $FFFFFFFF ) xor ( ( y or $FFFFFFFE ) xor $FFFFFFFF ) ) and ( bool(x) and bool(y) ) ) then
		Equal := Equal( x shr 1, y shr 1 )
	else if not( bool(x) or bool(y) ) then
		Equal := true
	else
		Equal := false;
end;

begin
	if ( Equal( StrToInt( ParamStr( 1 ) ), StrToInt( ParamStr( 2 ) ) ) ) then
		writeln( ParamStr( 1 ),' == ',ParamStr( 2 ) )
	else
		writeln( ParamStr( 1 ),' != ',ParamStr( 2 ) );
	readln;
end.
