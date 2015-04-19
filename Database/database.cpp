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

/* End of The Big Three */

struct Database::element
{
	element *next;
	element *prev;
	
	unsigned int ID;
	char *name;//[20];
	short value;
	char *desc;//[30];

	bool operator==( const element *&rEl )
	{
		if ( (rEl->ID == this->ID) && (rEl->name == this->name) && (rEl->value == this->value) )
			return true;
		else
			return false;
	}
}; /* End of two-way list definition */

const Database::element NULL_ELEMENT = { NULL, NULL, 0, 0, 0, 0 }; // NULL for element type return in function

/* End of database stuff */

/* Start of database management stuff */

void Database::printElement( element *tempElement )
{
	printf( "[ID] %d\n[Name] %s\n[Value] %d\n[Description] %s\n", tempElement->ID, tempElement->name, tempElement->value, tempElement->desc );
} // End of element printing procedure

void Database::printAllElements()
{
	element *tempElement = head;

	while(tempElement)
	{
		printf( "[ID] %d\n[Name] %s\n[Value] %d\n[Description] %s\n\n", tempElement->ID, tempElement->name, tempElement->value, tempElement->desc );
		tempElement = tempElement->next;
	}
} // End of database printing procedure

void Database::pushElFront( char *name, short value, char *desc )
{
	element *tempElement = new element;

//	tempElement = new element;

	tempElement->ID = count++;
	tempElement->name = name;
	tempElement->value = value;
	tempElement->desc = desc;

	head = tempElement;

	if( tempElement->next ) tempElement->next->prev = tempElement;
	else tail = tempElement;
} // End of element front pushing procedure

void Database::pushElBack( char *name, short value, char *desc )
{
	element *tempElement = new element;

	tempElement->ID = count++;
	tempElement->name = name;
	tempElement->value = value;
	tempElement->desc = desc;

	tail = tempElement;

	if( tempElement->prev) tempElement->prev->next = tempElement;
	else head = tempElement;
} // End of element back pushing procedure

void Database::popElFront()
{
	if( count ) removeElement(head);
}

void Database::popElBack()
{
	if( count ) removeElement(tail);
}

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
} // End of insert before element

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
} // End of insert after element

void Database::insertElBefore( char*, short, char*, unsigned int )
{
}

void Database::insertElAfter( char*, short, char*, unsigned int )
{
}

void Database::removeElement( element *tempElement )
{
	count--;
	if( tempElement->prev ) tempElement->prev->next = tempElement->next;
	else head = tempElement->next;

	if( tempElement->next ) tempElement->next->prev = tempElement->prev;
	else tail = tempElement->prev;

	delete tempElement;
}
/*
void Database::removeElement( unsigned int ID )
{
}
*/
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
}

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
}
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
}
