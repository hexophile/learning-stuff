//#include "interface.h"
#include "db_class.h"

main()
{
	char *test = "test!";
	
	Database Baza;

	Baza.pushElFront( test, 3, test );

//	Baza.printElement(Baza.head);

	Baza.printAllElements();


//	*test = getchar();

	return 0;
}
