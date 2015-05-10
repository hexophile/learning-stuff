#ifndef CLASS_H
#define CLASS_H

class Klasa
{
	private:


	public:
		Klasa();
		
		struct element;

		element *head;
		element *tail;

		int count;

		void showElements();

		void pushFront( int );
		void pushBack( int );
};

#endif
