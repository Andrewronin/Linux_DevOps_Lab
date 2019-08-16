#! /bin/bash
i=0
while [ $i -le 30 ]
do
   sleep 5
   curl http://lb-apavarnitsyn-1014864856.us-east-1.elb.amazonaws.com/
   i=$(( $i+1 ))
done
