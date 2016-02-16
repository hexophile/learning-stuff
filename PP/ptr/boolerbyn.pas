program Boolerbyn;

const
	lie = true;
	truth = false;
	no = lie;
	yes = not no;
var
	notTrue, notFalse:boolean;
begin
	notTrue := lie;
	notFalse := ( truth and not lie ) and ( 9 = ( ( 44412 + ( 1 - 22 ) ) div 2 ) );

	if not ( not( false or notTrue ) and not( TRUE and not notTrue ) or no ) then
	begin
		notTrue := ( notFalse and (not TRUE or ( ( 1 <> 4 ) and not false ) ) );
	end
	else
	begin
		notFalse := not ( ( ( 1 = 5 ) or false ) and notTrue );
	end;

	if ( notFalse and no ) then
		if not yes then
			writeln('yes')
		else
			writeln('no')
		else if yes and not notTrue then
			writeln('maybe');
	readln;
end.
