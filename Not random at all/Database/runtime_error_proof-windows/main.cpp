#include "class.h"

main()
{
	Klasa Obiekt;

	Obiekt.pushFront(4);
	Obiekt.pushFront(6);

	Obiekt.showElements();

	return 0;
}
/*
g++ main.cpp class.h class.cpp -o out.exe
*/
