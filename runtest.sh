#!/bin/bash
# script to run loadtest with different parameters
# every time this script is run it will override the previous results 

# -e used with echo to enable interpretation of backslash escapes as tabs
echo -e "Co\tN\tidle" > results.dat

# inform user the script has started
echo "============================="
echo "    LOAD TESTING STARTED     "
echo "============================="
# n being the number of cocurrent users (also being used as the indexer)
for n in {1..50} # loop 1 to 50 
do
	# running loadtest script in background using & 
	./loadtest $n &
	
	# getting one average output from 10 seconds and pipping into awk to get just the average idle time
	# result is stored in variable idle
	idle=`mpstat 10 1 | awk 'END{print $12}'`
	
	# count the number of completed processes - storing number in variable Co
	Co=`wc -l < synthetic.dat`	

	# killing the loadtest which is running in the background
	pkill loadtest
	
	echo -e "$Co\t$n\t$idle" >> results.dat # appending results from tests ran to data file
	
	# update user step by step
	echo "Load testing for $n cocurrent user complete"
done

# inform user the script has finished
echo "============================"
echo "   LOAD TESTING FINISHED    "
echo "============================"

