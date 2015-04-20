#include "database.h"
#include "stdio.h"

Database::Database()
{
	head = NULL;
	tail = NULL;
	count = 0;
}

Database::~Database()
{
	while( count ) popElFront();
}

struct Database::element
{
	element *next;
	element *prev;
	
	unsigned int ID;
	char *name;
	short value;
	char *desc;

	bool operator==( const element *&rEl )
	{
		if ( (rEl->ID == this->ID) && (rEl->name == this->name) && (rEl->value == this->value) )
			return true;
		else
			return false;
	}
}; /* End of two-way linked list definition */

/* NULL element for errors in searching functions */
const Database::element NULL_ELEMENT = { NULL, NULL, 0, 0, 0, 0 };

/* End of database stuff */

/* Start of database 1st grade management stuff */

void Database::printElement( element *tempElement )
{
	printf( "[ID] %d\n[Name] %s\n[Value] %d\n[Description] %s\n", tempElement->ID, tempElement->name, tempElement->value, tempElement->desc );
} /* End of element printing procedure */

void Database::printAllElements()
{
	element *tempElement = head;

	if( tempElement )
	{
		while( tempElement ) // or wothout ->next, dunno
		{
			printf( "[ID] %d\n[Name] %s\n[Value] %d\n[Description] %s\n\n", tempElement->ID, tempElement->name, tempElement->value, tempElement->desc );
			if( tempElement->next )
				tempElement = tempElement->next;
			else
				break;
		}
	}
	else
	{
		printf( "No elements in database." );
	}
} /* End of database printing procedure */

void Database::pushElFront( char *name, short value, char *desc )
{
	element *tempElement;// = new element;
	tempElement = new element;

	tempElement->ID = ++count;
	tempElement->name = name;
	tempElement->value = value;
	tempElement->desc = desc;

	head = tempElement;

	if( tempElement->next ) tempElement->next->prev = tempElement;
	else tail = tempElement;
} /* End of element front pushing procedure */

void Database::pushElBack( char *name, short value, char *desc )
{
	element *tempElement;
	tempElement = new element;

	tempElement->ID = ++count;
	tempElement->name = name;
	tempElement->value = value;
	tempElement->desc = desc;

	tail = tempElement;

	if( tempElement->prev ) tempElement->prev->next = tempElement;
	else head = tempElement;
} /* End of element back pushing procedure */



void Database::pushByFile( unsigned int ID, char *name, short value, char *desc )
{
	element *tempElement = new element;

//	tempElement = new element;

	tempElement->ID = ID;
	tempElement->name = name;
	tempElement->value = value;
	tempElement->desc = desc;

	head = tempElement;

	if( tempElement->next ) tempElement->next->prev = tempElement;
	else tail = tempElement;
} /* End of pushing from file procedure */



void Database::popElFront()
{
	if( count ) removeElement( head );
} /* End of element front pop procedure */

void Database::popElBack()
{
	if( count ) removeElement( tail );
} /* End of element back pop procedure */

void Database::insertElBefore( char *name, short value, char *desc, element *tempElement )
{
	if( tempElement == head ) pushElFront( name, value, desc );
	else
	{
		element *buffElement = new element;

		buffElement->ID = count++;
		buffElement->name = name;
		buffElement->value = value;
		buffElement->desc = desc;

		buffElement->next = tempElement;
		buffElement->prev = tempElement->prev;

		tempElement->prev->next = buffElement;
		tempElement->prev = buffElement;
	}	
} /* End of insert before element procedure */

void Database::insertElAfter( char *name, short value, char *desc, element *tempElement )
{
	if( tempElement == tail ) pushElBack( name, value, desc );
	else
	{
		element *buffElement = new element;

		buffElement->ID = count++;
		buffElement->name = name;
		buffElement->value = value;
		buffElement->desc = desc;

		buffElement->prev = tempElement;
		buffElement->next = tempElement->next;

		tempElement->next->prev = buffElement;
		tempElement->next = buffElement;
	}
} /* End of insert after element procedure */

void Database::removeElement( element *tempElement )
{
	count--;
	if( tempElement->prev ) tempElement->prev->next = tempElement->next;
	else head = tempElement->next;

	if( tempElement->next ) tempElement->next->prev = tempElement->prev;
	else tail = tempElement->prev;

	delete tempElement;
} /* End of remove procedure */

Database::element Database::findElement( element *buffElement )
{
	element *tempElement = head;

	while(tempElement)
	{
		if( tempElement == buffElement )
			return *tempElement;

		tempElement = tempElement->next;
	}
	return NULL_ELEMENT;
} /* End of search by element function */

Database::element Database::findElement( unsigned int sID )
{
	element *tempElement = head;

	while( tempElement )
	{
		if( tempElement->ID == sID )
			return *tempElement;

		tempElement = tempElement->next;
	}
	return NULL_ELEMENT;
} /* End of search by ID function */
/*
element Database::findElement( char *sName )
{
	return 0;
} 
*/
Database::element Database::findElement( short sValue )
{
	element *tempElement = head;

	while( tempElement )
	{
		if( tempElement->value == sValue )
			return *tempElement;

		tempElement = tempElement->next;
	}
	return NULL_ELEMENT;
} /* End of search by value function */
