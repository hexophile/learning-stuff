unit zadanie7_unit;

interface

const
	TITLE_SIZE = 31;
	NULL = nil;

type
	int = integer;
	uint = cardinal;
	bool = boolean;
	charArray = array[0..TITLE_SIZE] of char;

	TNodePtr = ^TNode;
	TRootNodePtr = ^TRootNode;


	TNode = record
		title:charArray;
		amount:int;
		nextNodePtr:TNodePtr;
	end;

	TRootNode = record
		letter:char;
		item:TNodePtr;
		nextRootNodePtr:TRootNodePtr;
	end;

{ End of type definitions }
operator xor ( x1:pointer; x2:pointer ) res:pointer;

function AddLetter_s( prevRootNode:TRootNodePtr; headRootNodePtr:TRootNodePtr; newLetter:char ):TRootNodePtr;
function AddLetter( headRootNodePtr:TRootNodePtr; newLetter:char ):TRootNodePtr;
function FindLetter( headRootNodePtr:TRootNodePtr; letter:char ):TRootNodePtr;

function AddTitle_s( prevNodePtr:TNodePtr; headNodePtr:TNodePtr; var newTitle:charArray; i:int ):TNodePtr;
function AddTitle( headRootNodePtr:TRootNodePtr; var newTitle:charArray ):TNodePtr;
function FindTitle_root( headRootNodePtr:TRootNodePtr; var title:charArray ):TNodePtr;
function FindTitle( headNode:TNodePtr; var title:charArray ):TNodePtr;

{ End of function declarations }

implementation

operator xor ( x1:pointer; x2:pointer ) res:pointer;
begin
	uint(res) := uint(x1) xor uint(x2);
end;

function AddLetter_s( prevRootNode:TRootNodePtr; headRootNodePtr:TRootNodePtr; newLetter:char ):TRootNodePtr;
var
	newRootNode:TRootNodePtr;
begin
	if ( headRootNodePtr = NULL ) then
	begin
		new( headRootNodePtr );
		headRootNodePtr^.letter := newLetter;
		prevRootNode^.nextRootNodePtr := headRootNodePtr;
	end
	else
	begin
		if ( headRootNodePtr^.letter > newLetter ) then
		begin
			if ( prevRootNode = NULL ) then
			begin
				new( newRootNode );
				newRootNode^.letter := newLetter;
				newRootNode^.nextRootNodePtr := headRootNodePtr;

				headRootNodePtr := newRootNode xor headRootNodePtr;
				newRootNode := headRootNodePtr xor newRootNode;
				headRootNodePtr := newRootNode xor headRootNodePtr;
				{ We have to swap pointers - new node / current head pointer. }
			end
			else
			begin
				newRootNode := new( TRootNodePtr );
				newRootNode^.letter := newLetter;
				newRootNode^.nextRootNodePtr := headRootNodePtr;

				prevRootNode^.nextRootNodePtr := newRootNode;
			end;
		end
		else if ( headRootNodePtr^.letter < newLetter ) then
		begin
			newRootNode := AddLetter_s( headRootNodePtr, headRootNodePtr^.nextRootNodePtr, newLetter );
		end;
	end;
	AddLetter_s := newRootNode;
end; { End of AddLetter }

function AddLetter( headRootNodePtr:TRootNodePtr; newLetter:char ):TRootNodePtr;
var
	newRootNode:TRootNodePtr;
begin
	if not ( ( ( ord(newLetter) >= 65) and ( ord(newLetter) <= 90 ) ) or ( ( ord(newLetter) >= 97 ) and ( ord(newLetter) <= 122 ) ) ) then
	begin { Na chwilę obecną brak obsługi polskich znaków diakrytycznych. }
		AddLetter := NULL;
		exit;
	end;

	AddLetter := FindLetter( headRootNodePtr, newLetter );
	if ( AddLetter <> NULL ) then
	begin
		exit; {dunno?}
	end
	else
	begin
		if ( headRootNodePtr = NULL ) then
		begin
			newRootNode := new( TRootNodePtr );
			headRootNodePtr^.letter := newLetter;
			AddLetter := headRootNodePtr;
		end
		else
		begin
			if ( headRootNodePtr^.letter > newLetter ) then
			begin
				newRootNode := new( TRootNodePtr );
				newRootNode^.letter := newLetter;
				newRootNode^.nextRootNodePtr := headRootNodePtr;

				headRootNodePtr := newRootNode xor headRootNodePtr;
				newRootNode := headRootNodePtr xor newRootNode;
				headRootNodePtr := newRootNode xor headRootNodePtr;
				{ We have to swap pointers - new node / current head pointer. }
			end
			else if ( headRootNodePtr^.letter < newLetter ) then
			begin
				AddLetter := AddLetter_s( headRootNodePtr, headRootNodePtr^.nextRootNodePtr, newLetter );
			end;
		end;
	end;
end; { End of AddLetter }

function FindLetter( headRootNodePtr:TRootNodePtr; letter:char ):TRootNodePtr;
begin
	if ( headRootNodePtr^.letter = letter ) then
	begin
		FindLetter := headRootNodePtr;
	end
	else
	begin
		if ( headRootNodePtr^.nextRootNodePtr = NULL ) then
			FindLetter := NULL
		else
			FindLetter := FindLetter( headRootNodePtr^.nextRootNodePtr, letter );
	end;
end; { End of FindLetter } { proper pointer = found; NULL = not found; }

function AddTitle_s( prevNodePtr:TNodePtr; headNodePtr:TNodePtr; var newTitle:charArray; i:int ):TNodePtr;
var
	newNode:TNodePtr;
begin
	if ( headNodePtr^.title[i] < newTitle[i] ) then
	begin
		AddTitle_s( headNodePtr, headNodePtr^.nextNodePtr, newTitle, i );
	end
	else if ( headNodePtr^.title[i] > newTitle[i] ) then
	begin
		newNode := new( TNodePtr );
		newNode^.nextNodePtr := headNodePtr;
		prevNodePtr^.nextNodePtr := newNode;
		AddTitle_s := newNode;
	end
	else
	begin
		AddTitle_s( prevNodePtr, headNodePtr, newTitle, i+1 );
	end;
end; { End of AddTitle }

function AddTitle( headRootNodePtr:TRootNodePtr; var newTitle:charArray ):TNodePtr;
var
	newNode:TNodePtr;
	rootNodePtr:TRootNodePtr;
begin
	rootNodePtr := FindLetter( headRootNodePtr, newTitle[0] );

	if ( rootNodePtr <> NULL ) then
	begin
		if ( rootNodePtr^.item <> NULL ) then
		begin
			newNode := rootNodePtr^.item;

			newNode := AddTitle_s( rootNodePtr^.item, rootNodePtr^.item^.nextNodePtr, newTitle, 1 );
		end
		else
		begin
			newNode := new( TNodePtr );
			rootNodePtr^.item := newNode;
			newNode^.title := newTitle;
			newNode^.amount := 1;
			newNode^.nextNodePtr := NULL;
		end;
	end
	else
	begin
		rootNodePtr := AddLetter( headRootNodePtr, newTitle[0] );
		newNode := AddTitle( rootNodePtr, newTitle );
	end;
	AddTitle := newNode;
end; { End of AddTitle }

function FindTitle_root( headRootNodePtr:TRootNodePtr; var title:charArray ):TNodePtr;
begin
	if ( headRootNodePtr^.letter = title[0] ) then
	begin
		FindTitle_root := FindTitle( headRootNodePtr^.item, title );
	end
	else
	begin
		if ( headRootNodePtr^.nextRootNodePtr = NULL ) then
			FindTitle_root := NULL
		else
			FindTitle_root := FindTitle_root( headRootNodePtr^.nextRootNodePtr, title );
	end;
end; { End of FindTitle_root }

function FindTitle( headNode:TNodePtr; var title:charArray ):TNodePtr;
begin
	if ( headNode^.title = title ) then
	begin
		FindTitle := headNode;
	end
	else
	begin
		if ( headNode^.nextNodePtr = NULL ) then
			FindTitle := NULL
		else
			FindTitle := FindTitle( headNode^.nextNodePtr, title );
	end;
end; { End of FindTitle }

Begin
End.
