unit zadanie3_unit;

interface      

uses crt, sysutils, zadanie3_err_mgmt;
 
{ Constants }
const
	TRUE_LOW = 0;       // This is for table name record, it's true starting number
	LOW = TRUE_LOW+1;	// Starting number in database
	HIGH = 100000;		// Ending number
				// LOW and HIGH are numbers that define primary key of database
	TSTATE_FALSE = false;
	TSTATE_TRUE = true;
{ Structures }
type
    int = integer;

    TState = boolean;

	TPerson = record
		id:int;     // ID number
		name:string;    // Main information
		state:TState;  // Information whether record exists
	End; // Main database object structure   
	TPersonPtr = ^TPerson;

	TDatabase = array[TRUE_LOW..HIGH] of TPerson;
    TDatabasePtr = ^TDatabase;


{ Functions }
function ObjectState( var Database:array of TPerson; id:integer ):TState;
function FindObject( var Database:array of TPerson; name:string ):TPersonPtr;
function ModifyObject( obj:TPerson ):TPerson;

//function CreateDatabase():TDatabasePtr; // For extended
//function DeleteDatabase():int; // :TError; // For extended
//function MergeDatabases( var ParentDatabase:TDatabasePtr, var ChildDatabase:TDatabasePtr ):TDatabasePtr; // For extended

{ Procedures, most of them will turn into functions after adding error management }
procedure InitializeDatabase( var Database:array of TPerson );
procedure AddObject( var Database:array of TPerson );
procedure RemoveObject( var Database:array of TPerson; tabID:int );
procedure ShowDatabase( var Database:array of TPerson );                      
procedure ReIDDatabase( var Database:array of TPerson );
procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte );

//procedure LoadDatabase( var Database:TDatabasePtr ); // For extended
//procedure SaveDatabase( var Database:array of TPerson ); // For extended


implementation
{
    List of internal functions:            
    function FindNextExistent( var array of TPerson, int ):int;
    function FindRealHighValue( var array of TPerson ):int;

    procedure Swap( var TPerson, var TPerson );
    procedure ClearEmptyRecords( var array of TPerson );
}

{ Internal functions and procedures }
procedure Swap( var element:TPerson; var element2:TPerson ); // Swaps two elements in database
var
    swapVar:TPerson;
Begin
    swapVar := element;
    element := element2;
    element2 := swapVar;
End; { End of Swap }

function FindNextExistent( var Database:array of TPerson; id:int ):int; // Finds next element that isn't empty after certain ID
Begin
    while( not Database[id].state and ( id <= HIGH )) do
    begin
        id := id + 1;
    end;
    if( id > HIGH ) then
        FindNextExistent := LOW-1
    else
        FindNextExistent := id;
End; { End of FindNextExistent }

procedure ClearEmptyRecords( var Database:array of TPerson ); // It's supposed to remove 'empty' records in database.
var
   i,next:int;
Begin
	for i := LOW to HIGH do
	begin
		if not Database[i].state then
		begin
			next := FindNextExistent( Database, i );
			if( next = LOW-1 ) then
			begin
				writeln('End of data.');
		end
		else
			Swap( Database[i], Database[next] );
		end;
	end;
End; { End of ClearEmptyRecords }

function FindRealHighValue( var Database:array of TPerson ):int; // Finds max ID of data in database.
var
	i:int;
Begin
	ClearEmptyRecords( Database );

	for i := LOW to HIGH do
	begin
		if( not Database[i].state ) then FindRealHighValue := i - 1;
	end;

    if( i = HIGH ) then
        FindRealHighValue := -1;
{
    Need error management,
}
End; { End of FindRealHighValue }
{ End of internal functions and procedures }


{ Export functions }
function ObjectState( var Database:array of TPerson; id:int ):TState; // Function returns if object exists
Begin
	ObjectState := Database[id].state;
End; { End of ObjectExists }

function FindObject( var Database:array of TPerson; name:string ):TPersonPtr; // Function has to find record and return pointer to it
var
	i:int;
Begin
	i := LOW;

	while( not ( Database[i].name = name ) ) do // Pretty primitive, but working. TODO for extended
	begin
		if( HIGH = i ) then
		begin
			FindObject := nil;
			exit;
		end;

		i := i + 1;
	end;

	if( ObjectState( Database, i ) = TSTATE_FALSE ) then // Yeah, no comment, poor as hell
		FindObject := nil
	else
		FindObject := @Database[i];
{
    TODO in extended:
    binary tree of searching with DSW algorithm(?)
}
End; { End of FindObject }

function ModifyObject( obj:TPerson ):TPerson; // Function returns modified object
Begin
    writeln( 'Old id: ':1, obj.id );
    write( 'New id: ':1 );
    readln( obj.id );
    writeln( 'Old name: ':1, obj.name );
    write( 'New name: ':1 );
    readln( obj.name );

	ModifyObject := obj;
{
    TODO in extended:
    multiple modification, independence from definition of object,
    secure forms
}
End; { End of ModifyObject }

{ Export procedures }
procedure InitializeDatabase( var Database:array of TPerson ); // Before you start working on database, it has to be empty
var
	i,id:int;
Begin
	id := 1;
	for i := LOW to HIGH do
	begin
		Database[i].id := id;
		Database[i].state := false;
		id := id + 1;
	end;

	Database[TRUE_LOW].id := 0;
	Database[TRUE_LOW].name := #0'Table name';
	Database[TRUE_LOW].state := TSTATE_TRUE;
End; { End of InitializeDatabase }

procedure AddObject( var Database:array of TPerson ); // Procedure adds new record to database
var
    i:int;
Begin
    i := FindRealHighValue( Database );
    if( i > 0 ) then
    begin
        write( 'New id: ':1 );
        readln( Database[i+1].id );
        write( 'New name: ':1 );
        readln( Database[i+1].name );
    end
    else if( i = -1 ) then
    begin
        writeln('Database is full.');
        readln;
    end;
End; { End of AddObject }

procedure RemoveObject( var Database:array of TPerson; tabID:int ); // Procedure removes object from database
Begin
	Database[tabID].state := false;
End; { End of RemoveObject }

procedure ShowDatabase( var Database:array of TPerson ); // Procedure shows all existent records
var
	i:int;
Begin
	for i := LOW to FindRealHighValue( Database ) do
    begin              
		writeln( '':1, Database[i].id, ' ', Database[i].name );
    end;
{   while( i <= FindRealHighValue( Database ) ) do
	begin
		writeln( '':1, Database[i].id, ' ', Database[i].name );
		i := i - 1;
	end;   }
End; { End of ShowDatabase }

procedure ReIDDatabase( var Database:array of TPerson ); // Procedure has to re-ID whole database
var // It is recommended to re-ID database after sorting and removing empties
	i,id:int;
Begin
	id := 1;
	for i := LOW to HIGH do
	begin
		Database[i].id := id;
		id := id + 1;
	end;
End; { End of ReIDDatabase }

procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte ); // Procedure has to sort database
Begin // true = asc, false = desc || 0 = by ID, 1 = by name
	writeln( order, by ); // TODO, simply quicksort
{ sorting after removing non-existent elements }
{
    TODO in extended:
    introsort
}
End; { End of SortDatabase }

Begin

End.
{
    TODO in extended:
    error management unit,
    sort state,

    TODO in extended+:
    finishing additional database management such as saving db to file,

    TODO in VERY extended+:
    split type and functions/procs definitions to units
    split certain functions with algorithms to different units
}
