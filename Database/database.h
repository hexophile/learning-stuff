#ifndef DATABASE_H
#define DATABASE_H

class Database
{
	private:

	public:
		Database();

		Database( Database& );

		~Database();

/* Main structure, contains all data of row in database */
		struct element;

/* Amout of rows in database */
		unsigned int count;

/* head and tail of list */
		element *head;
		element *tail;

/* Printing */
		void printElement( element* );	// Prints arg element
		void printAllElements();	// Prints all rows

/* Push element on head/tail of list */
		void pushElFront( char*, short, char* );
		void pushElBack( char*, short, char* );

/* Pop element on head/tail of list */
		void popElFront();
		void popElBack();

/* Insert before/after pointed element */
		void insertElBefore( char*, short, char*, element* );
		void insertElAfter( char*, short, char*, element* );

/* Remove element */
		void removeElement( element* );

/* Searching */
		element findElement( element* );	// Find by all
		element findElement( unsigned int );// Find by ID
	//	element findElement( char* );		// Find by name
		element findElement( short );		// Find by value
//		element findElement( char* );		// Find by description

/* End of declarations */
}; /* End of class declaration(?) */


#endif /* DATABASE_H */
