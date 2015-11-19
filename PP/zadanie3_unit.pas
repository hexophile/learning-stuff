unit zadanie3_unit;

interface

uses crt, sysutils;
 
// Constants
const
     LOW = 0;      // Starting number in database
     HIGH = 100;   // Size of database

// Structures
type
    TPerson = record
            id:integer;     // ID number
            name:string;    // Main information
            state:boolean;  // Infomraiton whether record exists
    End; // Main database object structure
    
    TDatabase = array[LOW..HIGH-1] of TPerson;
// Functions
function FindObject( var Database:array of TPerson; tabID:integer ):TPerson;
function ObjectExists( var Database:array of TPerson; tabID:integer ):boolean;
function ModifyObject( obj:TPerson ):TPerson;

// Procedures
procedure InitializeDatabase( var Database:array of TPerson );
procedure AddObject( var Database:array of TPerson );
procedure RemoveObject( var Database:array of TPerson; tabID:integer );
procedure ShowDatabase( Database:array of TPerson );
procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte );

implementation
{ Functions }
function FindObject( var Database:array of TPerson; tabID:integer ):TPerson; // Function has to find record and return it
Begin
     FindObject := Database[tabID];
End; { End of FindObject }

function ObjectExists( var Database:array of TPerson; tabID:integer ):boolean; // Function returns if object exists
Begin
     ObjectExists := Database[tabID].state;
End; { End of ObjectExists }

function ModifyObject( obj:TPerson ):TPerson; // Function returns modified object
Begin
     ModifyObject := obj;
End; { End of ModifyObject }

{ Procedures }
procedure InitializeDatabase( var Database:array of TPerson ); // Before you start working on database, it has to be empty
var
   i:integer;
Begin
     for i := LOW to HIGH-1 do
         Database[i].state := false;
End; { End of InitializeDatabase }

procedure AddObject( var Database:array of TPerson ); // Procedure adds new record to database
Begin
End; { End of AddObject }

procedure RemoveObject( var Database:array of TPerson; tabID:integer ); // Procedure removes object from database
Begin
     Database[tabID].state := false;
End; { End of RemoveObject }

procedure ShowDatabase( Database:array of TPerson ); // Procedure shows all existent records
var
   i:integer;
Begin
     i := LOW;
     while( (i <> HIGH-1) and Database[i].state ) do
     begin
          writeln('':1, Database[i].id, ' ', Database[i].name );
          i := i - 1;
     end;
End; { End of ShowDatabase }

procedure SortDatabase( var Database:array of TPerson; order:boolean; by:byte ); // Procedure has to sort database
Begin // true = asc, false = desc || 0 = by ID, 1 = by name
      writeln(order,by);
End; { End of SortDatabase }


Begin

End.
