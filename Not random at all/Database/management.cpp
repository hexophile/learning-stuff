#include "management.h"
#include "database.h"
#include <fstream>

void readDatabaseFromFile( Database &Database, char *fileName )
{		
	std::ifstream dbFile;

	dbFile.open( fileName );

	if( !dbFile.is_open() )
		return;


	unsigned int fID;
	short fValue;
	char *fName;
	char *fDesc;

// Beginning of the poverty
	while( true )
	{
		if( !getline( dbFile, fID ) )
		{
			printf( "End of file." );
			break;
		};
		if( !getline( dbFile, fName ) )
		{
			printf( "Error reading name" );
			break;
		};
		if( !getline( dbFile, fValue ) )
		{
			printf( "Error reading value" );
			break;
		};
		if( !getline( dbFile, fDesc ) )
		{
			printf( "Error reading description" );
			break;
		}
		Database.pushByFile( fID, fName, fValue, fDesc );
		
	} /* To mo¿na zrobiæ ³adniej, ale ju¿ pierwsza i mam deadline za 6h */
// End of the poverty

	dbFile.close();
}

/*
 * TODO: File reading... plz make it prettier (_/; - ;)/ (x _ x )
 */
