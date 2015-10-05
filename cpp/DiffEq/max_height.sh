#!/bin/sh

i=0
while [ $i -lt 10 ]
do
   `./a.out expr $1`
   i=`expr $i + 1`
done
