unit zadanie5_unit;

interface { INTERFACE }

uses keyboard, crt, zadanie5_error_mgmt;

type
	int = integer;
	uint = cardinal;
	bool = boolean;
	
	intPtr = ^integer;
	uintPtr = ^cardinal;
	boolPtr = ^boolean;

	TElementPtr = ^TElement;
	TElemPtrPtr = ^TElementPtr;
	
	TElement = record
		prev:TElementPtr;
		data:int;
		next:TElementPtr;
	end;

{ End of typedef }

var
	key:TKeyEvent;
	keyChar:char;

	watcher:TElement;

	_lastError:TError;

{ End of variable declarations }


{ Database management functions declarations }
procedure InitializeDatabase(); { Initializes database }
function AddNew( data:intPtr ):TError; { Adds new item to database }
function AddNew( data:intPtr; element:TElementPtr; direction:boolPtr ):TError; { Adds new element after or before element }
function Remove( element:TElementPtr ):TError; { Remove element specified with prt }
function ShowElement( element:TElementPtr ):TError; { Show pointed element }


{ UI functions declarations }
procedure MainMenu(); { Main menu loop }


{ End of interface }
implementation { IMPLEMENTATION }

function SwapElements( left:TElementPtr; right:TElementPtr ):TError;
var
	temp:TElementPtr;
Begin
	if ( watcher.data = 0 ) then
	begin
		SwapElements := 1;

		exit;
	end;

	if ( ( left = nil ) or ( right = nil ) ) then
	begin
		SwapElements := 4;
		exit;
	end;

	left^.prev^.next := right;
	left^.next^.prev := right;

	right^.prev^.next := left;
	right^.next^.prev := left;

	temp := right^.next;
	right^.next := left^.next;
	left^.next := temp;

	temp := right^.prev;
	right^.prev := left^.prev;
	left^.prev := temp;

	temp := nil;

	SwapElements := 0;
End;


{ Database management functions definitions }
procedure InitializeDatabase();
Begin
	writeln( 'Initialization...' );

	watcher.prev := @watcher;
	watcher.data := 0; { I decided that watcher data field will contain amount of elements in database. }
	watcher.next := @watcher;
End;

function ShowDatabase():TError;
var
	temp:TElementPtr;
Begin
	if ( watcher.data = 0 ) then
	begin
		ShowDatabase := 1;

		exit;
	end;

	temp := watcher.next;
	repeat
		ShowElement( temp );
		temp := temp^.next;
	until ( temp = @watcher );
End;

function AddNew( data:intPtr ):TError;
var
	temp:TElementPtr;
Begin
	temp := new( TElementPtr );

	if ( temp = nil ) then { something that would warn about memory }
	begin
		AddNew := 4;
		
		exit;
	end;

	temp^.data := data^;
	
	temp^.next := @watcher;
	temp^.prev := watcher.prev;

	watcher.prev^.next := temp;
	watcher.prev := temp;

	watcher.data := watcher.data + 1;
End;

function AddNew( data:intPtr; element:TElementPtr; direction:boolPtr ):TError;
var
	temp:TElementPtr;
Begin

	temp := new( TElement );

	if ( temp <> nil ) then
	begin
		AddNew := 4;

		temp := nil;
		
		exit;
	end;

	temp^.data := data;

	if direction^ then
	begin
		temp^.next := element^.next;
		temp^.prev := element;

		element^.next^.prev := temp;
		element^.next := temp;
	end
	else
	begin
		temp^.next := element;
		temp^.prev := element^.prev;

		element^.prev^.next := temp;
		element^.prev := temp;
	end;
	
	watcher.data := watcher.data + 1;
End;

function Remove( element:TElementPtr ):TError;
Begin
	element^.prev^.next := element^.next;
	element^.next^.prev := element^.prev;
	element := nil;
	
	watcher.data := watcher.data - 1;
End;

function ShowElement( element:TElementPtr ):TError;
Begin
	writeln( element^.data );
End;

function FindElement( data:intPtr ):TElementPtr;
var
	temp:TElementPtr;
Begin
	if ( watcher.data = 0 ) then
	begin
		_lastError := 1;

		exit;
	end;

	temp := watcher.next;
	repeat
		if ( temp^.data = data^ ) then
		begin
			_lastError := 0;
			
			FindElement := temp;

			exit;
		end;

		temp := temp^.next;
	until ( temp = @watcher );

	_lastError := 5;

	FindElement := nil;
End;


{ UI functions definitions }
procedure MainMenu();
Begin
	InitKeyBoard;

	repeat
		clrScr;

		writeln;
		writeln( '[1] Add new element' );
		writeln( '[2] Remove element' );
		writeln( '[0] E(x)it' );

		key := GetKeyEvent;
		key := TranslateKeyEvent( key );

		keyChar := GetKeyEventChar( key );

		case keyChar of
			'1':
		end; 
		
	{	writeln( KeyEventToString( key ) ); }
	until ( ( keyChar = 'x' ) or ( keyChar = '0' ) );
End;
{ End of implementation }
Begin
End. { End of unit }
