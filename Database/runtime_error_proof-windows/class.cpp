#include <iostream>
#include "class.h"

Klasa::Klasa()
{
	head = NULL;
	tail = NULL;

	count = 0;
}

struct Klasa::element
{
	element *next;
	element *prev;

	int pole;
};

void Klasa::showElements()
{
	element *tempElement = head;
	
	while( tempElement )
	{
		std::cout << tempElement->pole << ",";

		tempElement = tempElement->next;
	}
}

void Klasa::pushFront( int x )
{
	element *tempElement;

	tempElement = new element;	

	tempElement->pole = x;

	head = tempElement;

	if( tempElement->next )
		tempElement->next->prev = tempElement;
	else
		tail = tempElement;
}

void Klasa::pushBack( int x )
{
	element *tempElement;

	tempElement = new element;	

	tempElement->pole = x;

	tail = tempElement;

	if( tempElement->prev )
		tempElement->prev->next = tempElement;
	else
		head = tempElement;
}
