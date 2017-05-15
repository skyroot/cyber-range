#!/bin/sh

if [ $# -ne 1 ]; then
	echo "need VM num"
	echo "example:"
	echo "./add_serialconsole.sh 500"
	exit 1
fi

qm set $1 -serial0 socket