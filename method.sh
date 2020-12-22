#!/bin/bash


echo Benford Bench: Delta Time Stamps of Election Logs Board of Elections
echo For rendering with bxe [benfordbenchXe]
echo method [ballot keyword] [electionday keyword]
echo press a key to continue or ctrl+"C" to escape

read p

echo Processing Steps Commence:

echo 1. Combine all precinct files to one Ward file.

cat *.txt > all.tx

echo 2. Extract all lines with key expression [ballot keyword]

cat all.tx | grep $1 > keyword.tx

echo 3. Extract all lines of Election day Nov 3

cat keyword.tx | grep $2 > electionday.tx

echo 4. Extract only time stamps to file

cat electionday.tx | grep -o [0-2][0-9]:[0-5][0-9]:[0-5][0-9] > timestamps.tx

echo 5. Convert time stamps to total seconds

cat timestamps.tx | nawk -F: '{ seconds=($1*60)*60; seconds=seconds+($2*60); seconds=seconds+$3; print seconds}' > seconds.tx

echo Skipping 6. Sort seconds ascending

mv seconds.tx all.dat

echo 7. Count total number of ballots saved

cat -n all.dat > counted.tx
tail counted.tx

mv timestamps.tx allts.dat

echo 8. Making delta seconds file...

awk 'p{print $0-p}{p=$0}' all.dat > dall.dat

tail dall.dat

echo 9. Run BenfordXe per Ward. Source code for bxe.bas available at https://github.com/pagetelegram/benfordbench
echo ie
echo bxe all.dat   [for total seconds]
echo bxe allts.dat [for actual time stamps]
echo bxe dall.dat [for delta seconds]
