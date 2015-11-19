// Baza danych oparta na strukturach i tablicach
uses zadanie3_unit;

// Variables
var
   globalID:integer;
   Database:array[LOW..HIGH-1] of TPerson;

{ End of declarations }

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
End; { End of MainMenu }

{ Main body }
Begin
     MainMenu();
     InitializeDatabase( Database );
End.
