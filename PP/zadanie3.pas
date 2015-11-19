// Baza danych oparta na strukturach i tablicach
uses crt, sysutils;

// Constants
const
     N = 100; // Size of database

// Structures
type
    TPerson = record
            id:integer;
            name:string;
            state:boolean;
    End; // Main database object structure

// Variables
var
   globalID:integer;
   Database:array[0..N-1] of TPerson; // Database array

{ Functions }
function FindObject( tabID:integer ):TPerson; // Function has to find record and return it
Begin
     FindObject := Database[tabID];
End;

function ObjectExists( tabID:integer ):boolean; // Function returns if object exists
Begin
     ObjectExists := Database[tabID].state;
End;

function ModifyObject( obj:TPerson ):TPerson; // Function returns modified object
Begin
     ModifyObject := obj;
End;

{ Procedures }
procedure AddObject(); // Procedure adds new record to database
Begin
End;

procedure RemoveObject( var obj:TPerson ); // Procedure removes object from database
Begin
     obj.state := false;
End;

procedure ShowDatabase(); // Procedure shows all existent records
var
   i:integer;
Begin
     i := 0;
     while( (i <> N-1) and Database[i].state ) do
     begin
          writeln('':1, Database[i].id, ' ', Database[i].name );
          i := i - 1;
     end;
End;

procedure SortDatabase( order:boolean; by:byte ); // Procedure has to sort database
Begin // true = asc, false = desc || 0 = by ID, 1 = by name
      writeln(order,by);
End;

procedure MainMenu(); // Procedure contains main menu loop
var
   choice:integer;
Begin
     while( true ) do
     begin
          writeln('Main menu:');
          writeln('not_yet.png');
          break;
     end;
End;

{ Main body }
Begin
     MainMenu();
End.

