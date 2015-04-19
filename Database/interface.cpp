#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <string>

#include "database.h"
#include "interface.h"
#include "management.h"

std::string menuPos[8] = {
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


void Interface::showMenu()
{
	while( "" != menuPos[loopCounter] )
	{
		std::cout << menuPos[loopCounter] << "\n";
/* I had to use std::cout because printf() doesn't working with structures */

		loopCounter++;
	}
}
