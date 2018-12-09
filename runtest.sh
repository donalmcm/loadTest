#!/bin/bash
#script to run loadtest with different parameters

# -e used with echo to enable interpretation of backslash escapes
echo -e "Co\tN\tidle" > results.dat

# n being the number of cocurrent users (also being used as the indexer)
for n in {1..50} # loop 1 to 50 
do
	./loadtest $n &  # running loadtest script in background using & 
	idle=`mpstat 10 1 | awk 'END{print $12}'`
	Co=`wc -l < synthetic.dat` # count the number of completed processes
	pkill loadtest
	echo -e "$Co\t$n\t$idle" >> results.dat # appending results from tests ran to data file
	echo "Load testing for $n cocurrent user complete"
done
