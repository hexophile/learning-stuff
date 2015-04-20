//#include "interface.h"
#include "database.h"

main()
{
/*
	Interface Interface;

	Interface.showMenu(0);
	
*/

	Database DatabaseObj;

	/*
	short hVar = 255;
	while( hVar )
	{
		DatabaseObj.pushElFront( "test", hVar, "test" );

		hVar--;
	}*/

	DatabaseObj.pushElFront( "test", 2, "descr" );
	DatabaseObj.pushElFront( "test2", 2, "descr2" );
//	I don't know why it doesn't work ^\(' - ' )/^

	DatabaseObj.printAllElements();

	return 0;
}
/*
 * Deadline uœwiêca œrodki.
 */
