#ifndef DB_CLASS_H
#define DB_CLASS_H

class Database
{
	private:

	public:
		Database();

		Database( Database& );

		~Database();
// End of The Big Three

		struct element;		// Main structure, contains data of current row of database and pointers to prev/next row.
		unsigned int count;	// Count number of elements.

		element *head;		// The beggining of list
		element *tail;		// The ending of list	

		
		void printElement( element* );	// Prints element
		void printAllElements();		// Prints all database
		
		void pushElFront( char*, short, char* );	// Push element on head of list
		void pushElBack( char*, short, char* );		// Push element on tail of list

		void popElFront();	// Pop(remove) element on head of list
		void popElBack();	// Pop(remove) element on head of list

		void insertElBefore( char*, short, char*, element* );	// Insert before/
		void insertElAfter( char*, short, char*, element* );		// after pointed element
		
		void insertElBefore( char*, short, char*, unsigned int );// Insert before/
		void insertElAfter( char*, short, char*, unsigned int );// after pointed ID in list

		void removeElement( element* );				// Removing pointed element
	//	void removeElement( unsigned int );			// by ID

		element findElement( element* );	// Find by all
		element findElement( unsigned int );// Find by ID
	//	element findElement( char* );		// Find by name
		element findElement( short );		// Find by value
//		element findElement( char* );		// Find by description

// End of declarations
};


#endif // DB_CLASS_H
