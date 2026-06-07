#!/bin/bash

if [ $# -ne 2 ]; then
	echo "ERR: 引数が2つではない" >&2
	exit 1
fi

expr "$1" + "$2" > /dev/null 2>&1
if [ $? -ge 2 ]; then
	echo "ERR: 引数が数値ではない" >&2
	exit 1
fi

if [ "$1" -le 0 ] || [ "$2" -le 0 ]; then
       echo "ERR: 引数の数値が1以上ではない" >&2
       exit 1
fi


a=$1
b=$2

while [ "$b" -ne 0 ]; do
	rem=$((a % b))
	a=$b
	b=$rem
done

echo "$a"
