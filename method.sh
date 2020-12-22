#!/bin/bash


echo Benford Bench: Time Stamps of Election Logs Chicago Board of Elections...
echo method 'keyword' 'electionday'

echo Method:

echo 1. Combine all precinct files to one Ward file.

cat *.txt > all.tx

echo 2. Extract all lines with key expression 'Ballot saved'

cat all.tx | grep $1 > keyword.tx

echo 3. Extract all lines of Election day Nov 3

cat keyword.tx | grep $2 > electionday.tx

echo 4. Extract only time stamps to file

cat electionday.tx | grep -o [0-2][0-9]:[0-5][0-9]:[0-5][0-9] > timestamps.tx

echo 5. Convert time stamps to total seconds

cat timestamps.tx | nawk -F: '{ seconds=($1*60)*60; seconds=seconds+($2*60); seconds=seconds+$3; print seconds}' > seconds.tx

echo 6. Sort seconds ascending

sort -n seconds.tx > all.dat

echo 7. Count total number of ballots saved

cat -n all.dat > counted.tx
tail counted.tx

mv timestamps.tx allts.dat

echo 8. Run BenfordXe per Ward. Source code for bxe.bas available at https://github.com/pagetelegram/benfordbench

echo ie

echo bxe all.dat   [for total seconds]
echo bxe allts.dat [for actual time stamps]
