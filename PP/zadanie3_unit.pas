unit zadanie3_unit;

interface

uses crt, sysutils, zadanie3_err_mgmt;

{ Constants }
const
	TRUE_LOW = 0;		{ This is for table name record, its true starting number }
	LOW = TRUE_LOW+1;	{ Starting number in database }
	HIGH = 100000;		{ Ending number }
				{ LOW and HIGH are numbers that define primary key of database }
	TSTATE_FALSE = false;
	TSTATE_TRUE = true;

	STRING_SIZE = 32;

	DEFAULT_TEXT_POSITION = 10;

{ Structures }
type
	int = longint;
	uint = cardinal;

	bool = boolean;
	TState = bool;

	TContentUnion = ( strVal, intVal, statVal );

	TContent = record
	case content:TContentUnion of
		strVal: ( strVal:string[STRING_SIZE] );
		intVal: ( intVal:int );
		statVal: ( statVal:TState );
	end;
	
	TObject = record
		id:uint;
        content:TContent;
		state:TState;
	End; { Main database object structure }	

	TObjectPtr = ^TObject;

	TDatabase = array[TRUE_LOW..HIGH] of TObject;
	TDatabasePtr = ^TDatabase;


{ Functions }
function ObjectState( var Database:array of TObject; id:int ):TState;
function FindObject( var Database:array of TObject; content:TContent ):TObjectPtr;
function ModifyObject( obj:TObject ):TObject;
function FreeSpace( var Database:array of TObject ):int;

{function CreateDatabase():TDatabasePtr; For extended }
{function DeleteDatabase():TError; For extended }
{function MergeDatabases( var ParentDatabase:TDatabasePtr, var ChildDatabase:TDatabasePtr ):TDatabasePtr; For extended }

{ Procedures, most of them will turn into functions after adding error management }
	{ Object }
procedure AddObject( var Database:array of TObject );
procedure RemoveObject( var Database:array of TObject; tabID:int );
procedure ShowObject( obj:TObject );
	{ Database }
procedure InitializeDatabase( var Database:array of TObject );
procedure ShowDatabase( var Database:array of TObject );
procedure ReIDDatabase( var Database:array of TObject );
procedure SortDatabase( var Database:array of TObject; order:bool; column:int );

{procedure LoadDatabase( var Database:TDatabasePtr ); For extended }
{procedure SaveDatabase( var Database:array of TObject ); For extended }


implementation
{
	List of internal functions:
	function FindNextExistent( var array of TObject, int ):int;
	function FindRealHighValue( var array of TObject ):int;

	procedure Swap( var TObject, var TObject );
	procedure ClearEmptyRecords( var array of TObject );
}


{ ######################################## Internal functions ######################################## }

procedure Swap( var element:TObject; var element2:TObject ); { Swaps two elements in database }
var
	swapVar:TObject;
Begin
	swapVar := element;
	element := element2;
	element2 := swapVar;
End; { End of Swap }

function FindNextExistent( var Database:array of TObject; id:int ):int; { Finds next element that isnt empty after certain ID }
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

procedure ClearEmptyRecords( var Database:array of TObject ); { Its supposed to remove 'empty' records in database. }
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

function FindRealHighValue( var Database:array of TObject ):int; { Finds max ID of data in the database. }
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

{ ######################################## End of internal functions ######################################## }


{ ######################################## Export functions ######################################## }

function ObjectState( var Database:array of TObject; id:int ):TState; { Function returns if object exists or something else }
Begin
	ObjectState := Database[id].state;
End; { End of ObjectExists }

function FindObject( var Database:array of TObject; content:TContent ):TObjectPtr; { Function has to find record and return pointer to it }
var
	i:int;
Begin
	i := LOW;

	while( not ( Database[i].content.strVal = content.strVal ) ) do { Pretty primitive, but working. TODO for extended }
	begin
		if( HIGH = i ) then
		begin
			FindObject := nil;
			exit;
		end;

		i := i + 1;
	end;

	if( ObjectState( Database, i ) = TSTATE_FALSE ) then { Yeah, no comment, poor as hell }
		FindObject := nil
	else
		FindObject := @Database[i];
{
    TODO in extended:
    binary tree of searching with DSW algorithm(?)
}
End; { End of FindObject }

function ModifyObject( obj:TObject ):TObject; { Function returns modified object }
Begin
	writeln( 'Old ID = ':DEFAULT_TEXT_POSITION, obj.id );
	write( 'New ID = ':DEFAULT_TEXT_POSITION );
	readln( obj.id );
	writeln( 'Old name: ':DEFAULT_TEXT_POSITION, obj.content.strVal );
	write( 'New name: ':DEFAULT_TEXT_POSITION );
	readln( obj.content.strVal );

	ModifyObject := obj;
{
	TODO in extended:
	multiple modification, independence from definition of object,
	secure forms
}
End; { End of ModifyObject }

function FreeSpace( var Database:array of TObject ):int; { Function returns amount of free space in the database }
Begin
	FreeSpace := HIGH - FindRealHighValue( Database );
End;

{ ######################################## Export procedures ######################################## }

procedure AddObject( var Database:array of TObject ); { Procedure adds new record to the database }
var
	i:int;
Begin
	i := FindRealHighValue( Database );

	if( i > 0 ) then
	begin
		write( 'New ID: ':DEFAULT_TEXT_POSITION );
		readln( Database[i+1].id );
		write( 'New name: ':DEFAULT_TEXT_POSITION );
		readln( Database[i+1].content.strVal );
	end
	else if( i = -1 ) then
	begin
		writeln('Database is full.');
		readln;
	end;
End; { End of AddObject }

procedure RemoveObject( var Database:array of TObject; tabID:int ); { Procedure removes object from the database }
Begin
	Database[tabID].state := false;
End; { End of RemoveObject }

procedure ShowObject( obj:TObject );
Begin
	writeln( 'ID = ':DEFAULT_TEXT_POSITION, obj.ID );
	writeln( 'Name: ':DEFAULT_TEXT_POSITION, obj.content.strVal );
End; { End of ShowObject }

procedure InitializeDatabase( var Database:array of TObject ); { Before you start working on the database, it has to be empty }
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
	Database[TRUE_LOW].content.strVal := 'Table name';
	Database[TRUE_LOW].state := TSTATE_TRUE;
End; { End of InitializeDatabase }

procedure ShowDatabase( var Database:array of TObject ); { Procedure shows all existent records }
var
	i:int;
Begin
	for i := LOW to FindRealHighValue( Database ) do
	begin
		ShowObject( Database[i] );
	end;
End; { End of ShowDatabase }

procedure ReIDDatabase( var Database:array of TObject ); { Procedure has to re-ID whole database }
var { It is recommended to re-ID database after sorting and removing empties }
	i,id:int;
Begin
	id := 1;

	for i := LOW to HIGH do
	begin
		Database[i].id := id;
		id := id + 1;
	end;
End; { End of ReIDDatabase }

{ ######################################## Sorting internal functions ######################################## }

{ ######################################## Sorting ######################################## }
function Split( var Database:array of TObject; localLOW, localHIGH:int; var order:bool; var column:int ):int;
var { order - true is asc, false is desc }
	i, actualPosition:int;
Begin
	i := ( localLOW + localHIGH ) div 2;
	Swap( Database[localHIGH], Database[i] );
	
	actualPosition := localLOW;

	for i := localLOW to localHIGH - 1 do
	begin
		if( order ) then
		begin
			if( ( Database[i].id > Database[localHIGH].id ) and ( column = 0 ) ) then
			begin
				Swap( Database[i], Database[actualPosition] );
				actualPosition := actualPosition + 1;
			end;
			{ else if ( ( Database[i].content.strVal > Database[localHIGH] ) and ( column = 1 ) ) then
			I need there an algorithm for the strings. }
		end
		else
		begin
			if( ( Database[i].id < Database[localHIGH].id ) and ( column = 0 ) ) then
			begin
				Swap( Database[i], Database[actualPosition] );
				actualPosition := actualPosition + 1;
			end;

		end;
	end;

	Swap( Database[actualPosition], Database[localHIGH] );

	Split := actualPosition;
End;

procedure SortDatabase( var Database:array of TObject; order:bool; column:int ); { Procedure has to sort the database }
var
	localLOW, localHIGH, i:int;
	temp:array[LOW..HIGH] of int;
Begin

{	localLOW := LOW;
	localHIGH := HIGH;

	while( i >= 0 ) do
	begin

		localLOW := Split( Database, localLOW, localHIGH, order, column );
		localLOW := localLOW + 1;
	end;
}

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

