#include <stdlib.h>
#include <iostream>
#include <string>
#include <conio.h> /* Only for getch() \_(' - ' )^\ */

#include "database.h"
#include "interface.h"
#include "management.h"

void doSomething() {
	std::cout << "This is special function that doing important something\n";
};

std::string mainMenu[8] = {
	"[1] Open database",
	"[2] Edit database",
	"[3] Show database",
	"[4] Find record",
	"[0] Exit"
};

Interface::Interface()
{

	ovr = 0;
	loopCounter = 0;
	
}

Interface::~Interface() {};


void Interface::showMenu( unsigned char menuVar)
{
	switch( menuVar )
	{
		case 1:
			{
				doSomething();
			} break;
		case 2:
			{
				doSomething();
			} break;
		default:
			{
				while( "" != mainMenu[loopCounter] )
				{
					std::cout << mainMenu[loopCounter] << "\n";
/* I had to use std::cout because printf() doesn't working with structures */
					loopCounter++;
				}
				switch( getch() )
				{
					case 1:
					{
						Database Database;
						readDatabaseFromFile(Database, "databaza"); // Ya, rly
					} break;
					default:
					{
						showMenu(0);
					}
				}
			}
	} /* Well, I got panicked after 1:30 AM... */
} /* I think, this is the worst menu switch-case I ever made. */
