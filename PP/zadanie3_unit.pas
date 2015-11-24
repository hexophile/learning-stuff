unit zadanie3_unit;

interface
 
{ Constants }
const
    LOW = 1;        // Starting number in database
	HIGH = 100000;  // Ending number
                    // LOW and HIGH are numbers that define primary key of database
{ Structures }
type
	TPerson = record
		id:integer;     // ID number
		name:string;    // Main information
		state:boolean;  // Information whether record exists
	End; // Main database object structure   
	TPersonPtr = ^TPerson;

	TDatabase = array[LOW..HIGH] of TPerson;

{ Functions }
function ObjectExists( var Database:array of TPerson; dbObject:TPerson ):boolean;
function FindObject( var Database:array of TPerson; name:string ):TPersonPtr;
function ModifyObject( obj:TPerson ):TPerson;

{ Procedures }
procedure InitializeDatabase( var Database:array of TPerson );
procedure AddObject( var Database:array of TPerson );
procedure RemoveObject( var Database:array of TPerson; tabID:integer );
procedure ShowDatabase( var Database:array of TPerson );
procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte );

implementation        

uses crt, sysutils;

{ Internal functions and procedures }
procedure Swap( var element:TPerson; var element2:TPerson ); // Swaps two elements in database
var
    swapVar:TPerson;
Begin
    swapVar := element;
    element := element2;
    element2 := swapVar;
End; { End of Swap }

function FindNextExistent( var Database:array of TPerson; id:integer ):integer; // Finds next element that isn't empty after certain ID
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
   i,next:integer;
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

function FindRealHighValue( var Database:array of TPerson ):integer; // Finds max ID of data in database.
var
	i:integer;
Begin
	ClearEmptyRecords( Database );

	for i := LOW to HIGH do
	begin
		if( Database[i].state ) then FindRealHighValue := i;
	end;
End; { End of FindRealHighValue }
{ End of internal functions and procedures }

{ Export functions }
function ObjectExists( var Database:array of TPerson; dbObject:TPerson ):boolean; // Function returns if object exists
Begin
	ObjectExists := dbObject.state;
End; { End of ObjectExists }

function FindObject( var Database:array of TPerson; name:string ):TPersonPtr; // Function has to find record and return pointer to it
var
	i:integer;
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

	if ObjectExists( Database, Database[i] ) then // Yeah, no comment, poor as hell
		FindObject := @Database[i]
	else
		FindObject := nil;

End; { End of FindObject }

function ModifyObject( obj:TPerson ):TPerson; // Function returns modified object
Begin
	ModifyObject := obj;
End; { End of ModifyObject }

{ Export procedures }
procedure InitializeDatabase( var Database:array of TPerson ); // Before you start working on database, it has to be empty
var
	i,id:integer;
Begin
	id := 1;
	for i := LOW to HIGH do
	begin
		Database[i].id := id;
		Database[i].state := false;
		id := id + 1;
	end;
	Database[LOW].name := #0'Control record';
	Database[LOW].state := True;
End; { End of InitializeDatabase }

procedure AddObject( var Database:array of TPerson ); // Procedure adds new record to database
Begin
End; { End of AddObject }

procedure RemoveObject( var Database:array of TPerson; tabID:integer ); // Procedure removes object from database
Begin
	Database[tabID].state := false;
End; { End of RemoveObject }

procedure ShowDatabase( var Database:array of TPerson ); // Procedure shows all existent records
var
	i:integer;
Begin
	i := LOW;
	while( (i <> HIGH) and Database[i].state ) do
	begin
		writeln('':1, Database[i].id, ' ', Database[i].name );
		i := i - 1;
	end;
End; { End of ShowDatabase }

procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte ); // Procedure has to sort database
Begin // true = asc, false = desc || 0 = by ID, 1 = by name
	writeln(order, by); // TODO, simply quicksort
End; { End of SortDatabase }

Begin

End.
