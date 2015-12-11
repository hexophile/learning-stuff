unit zadanie5_error_mgmt;

interface

const
	ERROR_REM_SIZE = 255;
	ERROR_REM_LIST_SIZE = 7;

	ERROR_REM:array[0..ERROR_REM_LIST_SIZE] of array[0..ERROR_REM_SIZE] of char = (
	'0x00: Successful result.',
	'0x01: Database is empty.',
	'0x02: Unknown error.',
	'0x03: Element does not exist.',
	'0x04: Not enough memory.',
	'0x05: Element not found.',
	'0x06: ',
	'0x07: ' );
{ End of error codes comments }

type
	int = integer;
	uint = cardinal;
	bool = boolean;

	TError = record
		success:bool;
		errorCode:longword;
		rem:array[0..ERROR_REM_SIZE] of char;
	end;

	operator := ( rArg:byte ) lArg:char;
	operator := ( rArg:char ) lArg:byte;
	
	operator := ( rArg:word ) lArg:TError;
	operator := ( rArg:uint ) lArg:TError;
	operator := ( rArg:int ) lArg:TError;
{ End of assign operator overload }

	operator = ( boolArg:bool; errArg:TError ) opRes:bool;
	operator = ( wordArg:word; errArg:TError ) opRes:bool;
	operator = ( uIntArg:uint; errArg:TError ) opRes:bool;
	operator = ( intArg:int; errArg:TError ) opRes:bool;
{ End of equal operator overload }


implementation
	operator := ( rArg:byte ) lArg:char;
	begin
		rArg := ord( lArg );
	end;

	operator := ( rArg:char ) lArg:byte;
	begin
		rArg := char( lArg );
	end;

	operator := ( rArg:word ) lArg:TError;
	begin
		if( rArg > 0 ) then
			lArg.success := false
		else
			lArg.success := true;

		lArg.errorCode := rArg;
		lArg.rem := ERROR_REM[rArg];
	end;

	operator := ( rArg:uint ) lArg:TError;
	begin
		if( rArg > 0 ) then
			lArg.success := false
		else
			lArg.success := true;

		lArg.errorCode := rArg;
		lArg.rem := ERROR_REM[rArg];
	end;

	operator := ( rArg:int ) lArg:TError;
	begin
		if( rArg > 0 ) then
			lArg.success := false
		else
			lArg.success := true;

		lArg.errorCode := rArg;
		lArg.rem := ERROR_REM[rArg];
	end;
{ End of assign operator overload }

	operator = ( boolArg:bool; errArg:TError ) opRes:bool;
	begin
		if ( boolArg = errArg.success ) then
			opRes := true
		else
			opRes := false;
	end;

	operator = ( wordArg:word; errArg:TError ) opRes:bool;
	begin
		if ( wordArg = errArg.errorCode ) then
			opRes := true
		else
			opRes := false;
	end;

	operator = ( uIntArg:uint; errArg:TError ) opRes:bool;
	begin
		if ( uIntArg = errArg.errorCode ) then
			opRes := true
		else
			opRes := false;
	end;

	operator = ( intArg:int; errArg:TError ) opRes:bool;
	begin
		if ( intArg = errArg.errorCode ) then
			opRes := true
		else
			opRes := false;
	end;
{ End of equal operator overload }

Begin
End.
