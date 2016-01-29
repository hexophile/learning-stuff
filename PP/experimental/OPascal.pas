Program OPascal;

type
	int = integer;
	uint = cardinal;

	TClassPtr = ^TClass;

	intMethodARG1Ptr = ^intMethodARG1;
	intMethodARG2Ptr = ^intMethodARG2;
	voidMethodARG4Ptr = ^voidMethodARG4;

	intMethodARG1 = function( var x:int ):int;
	intMethodARG2 = function( var x:int; var y:int ):int;
//  voidMethodARG4 = procedure( var x:int; var y:int; var method1:intMethodARG1; var method1:intMethodARG1 );
	voidMethodARG4 = function( var x:int; var y:int; method1:intMethodARG1; method2:intMethodARG2; var this:TClassPtr ):voidMethodARG4Ptr;

	TClass = record
		x:int;
		y:int;
		Method_1:intMethodARG1;
		Method_2:intMethodARG2;
		TClassConstructor:voidMethodARG4;
	end;

var
	tempTClass:TClassPtr;
	tempClass:TClass;


function Method_1( var x:int ):int;
begin
	Method_1 := x + 1;
end;

function Method_2( var x:int; var y:int ):int;
begin
	Method_2 := x + y;
end;


function TClassConstructor( var x:int; var y:int; method1:intMethodARG1; method2:intMethodARG2; var this:TClassPtr ):voidMethodARG4;
begin
	this^.x := x;
	this^.y := y;
	this^.Method_1 := method1;
	this^.Method_2 := method2;
	this^.TClassConstructor := @TClassConstructor;
end;

function TClassDef( x:int; y:int ):TClassPtr;
begin
	new( TClassDef );
	TClassDef^.TClassConstructor(
		x,
		y,
		@Method_1,
		@Method_2,
		TClassDef
	);
end;

begin
	tempTClass := TClassDef( 4, 7 );

	tempClass := tempTClass^;

	writeln( tempClass.x );

	writeln( tempClass.y );

	readln;
end.
