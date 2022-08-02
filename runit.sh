#!/bin/bash

dump(){
	if [ -z "$1" -o -z "$2" -o -z "$3" ] ; then
		echo "usage: $0 dump offset len filename" >&2
		exit 1
	fi

	echo "dumping offset $1 len $2 to $3"
	rm -f bootrom*.bin
	sudo env DUMP_OFFSET=$1 DUMP_LENGTH=$2 $PWD/main.py -c $PWD/exploits_collection/default_config.json5 -t
	cp bootrom_8167.bin "$3"
}

boot(){
	sudo $PWD/main.py -c $PWD/exploits_collection/default_config.json5 -p ../../usboot.bin
}

normal(){
	sudo ./main.py -c exploits_collection/default_config.json5
}

dump_x(){
	normal
	sleep 1
	dump 0x100000 0x10000 100000a.bin
}

if [ "$(type -t "$1")" = "function" ] ; then
	"$@"
else
	normal
fi
