Program FortyNine;
type
	uint = cardinal;

	NodePtrPtrPtrPtr = ^NodePtrPtrPtr;
	NodePtrPtrPtr = ^NodePtrPtr;
	NodePtrPtr = ^NodePtr;
	NodePtr = ^Node;

	NodeRecordPtr = ^NodeRecord;

	Node = record
		data:uint;
		next:NodePtr;  
		NodeItem:NodeRecordPtr;
	end;

	NodeRecord = record
		data:NodePtrPtr;
	end;

var
	head:NodePtrPtrPtrPtr;
	temp:NodePtr;
	element:NodeRecordPtr;
	newNode:NodePtrPtr;

begin
	head := new( NodePtrPtrPtrPtr );
	head^ := new( NodePtrPtrPtr );  
	head^^ := new( NodePtrPtr );
	head^^^ := new( NodePtr );

	temp := new( NodePtr );
	head^^^^.next := temp;
	element := new( NodeRecordPtr );
	head^^^^.next^.data := uint( element );

	newNode := new( NodePtrPtr );
	newNode^ := new( NodePtr );
	NodeRecordPtr( head^^^^.next^.data)^.data := newNode;
	NodeRecordPtr( head^^^^.next^.data )^.data^^.data := 3;
	{ Oczywiście w tym /\ miejscu można to jakoś zamaskować. }

	writeln( NodeRecordPtr( head^^^^.next^.data )^.data^^.data );
	
	readln;
end.
