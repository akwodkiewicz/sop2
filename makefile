all: klient serwer

serwer: serwer.c soplib.c
	gcc serwer.c soplib.c -Wall -o serwer -g -O0

klient: klient.c soplib.c
	gcc klient.c soplib.c -Wall -o klient -g -O0


