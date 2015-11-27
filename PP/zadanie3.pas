// Baza danych oparta na strukturach i tablicach
uses crt, sysutils, zadanie3_unit;

var
	Database:TDatabase;

procedure MainMenu(); // Main menu loop
var
	choice:int;
	orderBool:bool;
	tempCont:TContent;
	tempObj:TObject;
	tempObjPtr:TObjectPtr;
Begin
	while( true ) do { Need better menu management }
	begin
		choice := 0;

		clrscr;
		writeln( 'Main menu:' );
		writeln( '[1] Add element' );
		writeln( '[2] Find element' );
		writeln( '[3] Show database' );
		writeln( '[4] Sort database' );
		writeln( '[5] Re-ID database' );
		writeln( '[6] Show free space' );
		writeln( '[8] fill with numberz' );
		writeln( '[0] Exit' );
		readln( choice );

		case choice of
		0:
			exit;
		1:
		begin
			clrscr;
			write( 'New ID: ':DEFAULT_TEXT_POSITION );
			readln( choice );
			write( 'New content: ':DEFAULT_TEXT_POSITION );
			readln( tempCont.strVal );
			{ Need better adding :S }
			AddObject( Database, choice, tempCont );
			readln;
		end;
		2:
		begin
			clrscr;
			write( 'Content you want to search for: ' );
			readln( tempCont.strVal );

			tempObjPtr := FindObject( Database, tempCont );
			tempObj := tempObjPtr^;

			if tempObjPtr = nil then
				writeln( 'Object with content = "', tempCont.strVal, '" not found.' )
			else
			begin
				while ( true ) do
				begin
					clrscr;
					ShowObject( tempObj );

					writeln( 'What do you want to do with it?' );
					writeln( '[1] Modify' );
					writeln( '[2] Remove' );
					writeln( '[0] Nothing' );
					readln( choice );

					case choice of
					1:
						tempObj := ModifyObject( tempObj );
					2:
						tempObj.state := false;
					0:
						break;
					end; { End of internal case }
				end; { End of internal loop }
			end; { End of if tempObjPtr }
			readln;
		end;
		3:
		begin
			clrscr;
			ShowDatabase( Database );
			readln;
		end;
		4:
		begin
			repeat
				clrscr;
				write( 'Please, enter order(asc/desc/exit): ' );
				readln( tempCont.strVal );

				if ( tempCont.strVal = 'exit' ) then
					exit { dunno about this }
				else if ( tempCont.strVal = 'asc' ) then
					orderBool := true
				else if ( tempCont.strVal = 'desc' ) then
					orderBool := false
				else
					orderBool := true;

			until ( ( tempCont.strVal = 'asc' ) or ( tempCont.strVal = 'desc' ) );

			SortDatabase( Database, orderBool, 0 );
			writeln( 'Done.' );
			readln;
		end;
		5:
		begin
			clrscr;
			writeln( 'Are you sure?(To confirm type "yes") ' );
			read( tempCont.strVal );
			if ( tempCont.strVal = 'yes' ) then
				ReIDDatabase( Database );
		end;
		6:
		begin
			clrscr;
			writeln( 'Free space in database = ', FreeSpace( Database ) );
			readln;
		end;
        8:
        begin                    
            tempCont.strVal := '';
            for choice := 1 to 10 do
                AddObject( Database, random(1000), tempCont );
        end;
		end; { End of main case }
	end; { End of main loop }
End; { End of MainMenu }

{ Main body }
Begin
	InitializeDatabase( Database );
	MainMenu();
End.
