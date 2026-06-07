#!/bin/bash

a=$1
b=$2

while [ "$b" -ne 0 ]; do
	rem=$((a % b))
	a=$b
	b=$rem
done

echo "$a"
