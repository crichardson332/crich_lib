#!/bin/sh

if [ -f "height.txt" ]
then
    `rm height.txt`
fi

i=0
result=0.01
while [ $i -lt 1200 ]
do
    result=$(echo "0.01 + $result" | bc -l )
   `./modelRocketSim $result >> height.csv`
   i=`expr $i + 1`
done
