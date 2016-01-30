Program OPascal;

type
	int = integer;

	TClassPtr = ^TClass;

	voidMethodARG4Ptr = ^voidMethodARG4;

	intMethodARG1 = function( var x:int ):int;
	intMethodARG2 = function( var x:int; var y:int ):int;
	voidMethodARG4 = function( var x:int; var y:int; method1:intMethodARG1; method2:intMethodARG2; var this:TClassPtr ):TClassPtr;

	TClass = record
		x:int;
		y:int;
		Method_1:intMethodARG1;
		Method_2:intMethodARG2;
	TClassConstructor:voidMethodARG4Ptr;
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


function TClassConstructor( var x:int; var y:int; method1:intMethodARG1; method2:intMethodARG2; var this:TClassPtr ):TClassPtr;
begin
	this^.x := x;
	this^.y := y;
	this^.Method_1 := method1;
	this^.Method_2 := method2;
	this^.TClassConstructor := @TClassConstructor;
	TClassConstructor := this;
end;

function TClassDef( x:int; y:int ):TClassPtr;
begin
new( TClassDef );
TClassDef := TClassConstructor(
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

write( tempClass.x );

writeln( ' ', tempClass.y );

tempClass.x := tempClass.Method_1( tempClass.x );

tempClass.y := tempClass.Method_2( tempClass.x, tempClass.y );

write( tempClass.x );

writeln( ' ', tempClass.y );

readln;
end.
