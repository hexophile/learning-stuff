{ TL;DR move image with h,j,k,l,u,i,n,m }
program zadanie4;

uses keyboard, crt;

const
	UP = %0001;
	DOWN = %0010;
	LEFT = %0100;
	RIGHT = %1000;

type
	int = integer;
	uint = cardinal;

var
	key:TKeyEvent;
	keyChar:char;

	ptrTable:^char;

	ptrTableWidth:uint;
	ptrTableHeight:uint;

procedure ClearTable();
var
	i:uint;
Begin
	for i := 1 to ptrTableWidth * ptrTableHeight do
	begin
		( ptrTable + i-1 )^ := '.';
	end;
End; { End of InitializeTable }

procedure ShowTable();
var
	i:uint;
Begin
	for i := 1 to ptrTableWidth * ptrTableHeight do
	begin
		write( ( ptrTable + i-1 )^ );
		if ( ( i mod ptrTableWidth = 0 ) and ( i <> 0 ) ) then writeln;
	end;  
End; { End of ShowTable }

procedure MoveTable( direction:byte );
var
	buffer:^char;
	i, j:uint;
Begin
	GetMem( buffer, ptrTableWidth + ptrTableHeight );

	case direction of
	UP:
		begin
			for i := 0 to ptrTableWidth-1 do
			begin
				( buffer + i )^ := ( ptrTable + i )^;
			end;

			for i := 0 to ptrTableHeight-2 do
			begin
				for j := 0 to ptrTableWidth-1 do
				begin
					( ptrTable + j + ( i * ptrTableWidth ) )^ := ( ptrTable + j + (  ( i + 1 ) * ptrTableWidth ) )^;
				end;
			end;
			
			for i := 0 to ptrTableWidth-1 do
			begin
				( ptrTable + i + ( ptrTableHeight*ptrTableWidth - ptrTableWidth ) )^ := ( buffer + i )^;
			end;
		end;
	DOWN:
		begin
			for i := 0 to ptrTableWidth-1 do
			begin
				( buffer + i )^ := ( ptrTable + i + ( ptrTableHeight*ptrTableWidth - ptrTableWidth ) )^;
			end;

			for i := ptrTableHeight-1 downto 1 do
			begin
				for j := ptrTableWidth-1 downto 0 do
				begin
					( ptrTable + j + ( i * ptrTableWidth ) )^ := ( ptrTable + j + (  ( i - 1 ) * ptrTableWidth ) )^;
				end;
			end;
			
			for i := 0 to ptrTableWidth-1 do
			begin
				( ptrTable + i )^ := ( buffer + i )^;
			end;
		end;
	LEFT:
		begin
			for i := 0 to ptrTableHeight-1 do
			begin
				( buffer + i )^ := ( ptrTable + ( i * ptrTableWidth ) )^;
			end;

			for i := 0 to ptrTableHeight-1 do
			begin
				for j := 0 to ptrTableWidth-2 do
				begin
					( ptrTable + ( i * ptrTableWidth ) + j )^ := ( ptrTable + ( i * ptrTableWidth ) + j + 1 )^;
				end;
			end;
			
			for i := 0 to ptrTableHeight-1 do
			begin
				( ptrTable + ( i * ptrTableWidth ) + ptrTableWidth - 1 )^ := ( buffer + i )^;
			end;
		end;
	RIGHT:
		begin
			for i := 0 to ptrTableHeight-1 do
			begin
				( buffer + i )^ := ( ptrTable + ( i * ptrTableWidth ) + ptrTableWidth - 1  )^;
			end;

			for i := ptrTableHeight-1 downto 0 do
			begin
				for j := ptrTableWidth-1 downto 1 do
				begin
					( ptrTable + ( i * ptrTableWidth ) + j )^ := ( ptrTable + ( i * ptrTableWidth ) + j - 1 )^;
				end;
			end;
			
			for i := 0 to ptrTableHeight-1 do
			begin
				( ptrTable + ( i * ptrTableWidth ) )^ := ( buffer + i )^;
			end;
		end;
	UP+LEFT:
		begin
		end;
	UP+RIGHT:
		begin
		end;
	DOWN+LEFT:
		begin
		end;
	DOWN+RIGHT:
		begin
		end;
	end; { TODO combinations }

	FreeMem( buffer );
	
	buffer := nil;
End; { End of MoveImage }

procedure MakeZ();
var
	i, j:uint;
begin
	for i := 1 to ptrTableWidth do
	begin
		for j := 1 to ptrTableHeight do
		begin
			if ( ( i + j-1 = ptrTableWidth ) or ( i = 1 ) or ( i = ptrTableHeight ) ) then
				( ptrTable + j-1 + ( (i-1) * ptrTableWidth ) )^ := 'Z';
		end; 
	end;
end; { End of MakeZ }

begin { Start of main body }

	ptrTableWidth := 0;

	repeat
		clrScr;

		write( 'Size of image (between 3 and 20): ' );
		readln( ptrTableWidth );

	until ( ( ptrTableWidth > 2 ) and ( ptrTableWidth < 21 ) );


	ptrTableHeight := ptrTableWidth; { it'll be a square for now }

	GetMem( ptrTable, ( ptrTableWidth * ptrTableHeight ) );
	
	ClearTable();

	MakeZ();

	InitKeyBoard;

	repeat
		clrScr;
		ShowTable();

		writeln;
		writeln( 'Press r to clear' );
		writeln( 'Press Z to make Z letter' );
		writeln( 'Press x to exit' );

		key := GetKeyEvent;
		key := TranslateKeyEvent( key );

		keyChar := GetKeyEventChar( key );

		case keyChar of
			'k': MoveTable(UP);
			'j': MoveTable(DOWN);
			'h': MoveTable(LEFT);
			'l': MoveTable(RIGHT);
			'u':
			begin
				MoveTable(UP);
				MoveTable(LEFT);
			end;
			'i':
			begin
				MoveTable(UP);
				MoveTable(RIGHT);
			end;
			'n':
			begin
				MoveTable(DOWN);
				MoveTable(LEFT);
			end;
			'm':
			begin
				MoveTable(DOWN);
				MoveTable(RIGHT);
			end;

			'r': ClearTable();
			'Z': MakeZ();
		end; 
		
	{	writeln( KeyEventToString( key ) ); }
	until ( keyChar = 'x' );

	FreeMem( ptrTable );

	ptrTable := nil;

	DoneKeyBoard;
end. { End of main body }

