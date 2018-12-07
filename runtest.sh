#!/bin/bash

#script to run loadtest with different parameters

# n being the number of cocurrent users (also being used as the indexer)
for n in {1..50} # loop 1 to 50 
do
	`./loadtest $n`

	Co=`wc -l < synthetic.dat` # count the number of completed processes
	echo $Co    $n
done
