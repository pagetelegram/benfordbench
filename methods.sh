#!/bin/bash
echo Benford Bench: Delta Time Stamps of Election Logs Board of Elections
echo For rendering with bxe [benfordbenchXe]
echo press a key to continue or ctrl+"C" to escape
read a
echo Processing Steps Commence:
echo 1. Combine all precinct files to one Ward file in proper order.
#cat < ls | grep .txt > all.tx
ls *.txt | xargs cat > all.tx
#cat w??p??.txt > all.tx

echo 2. Extract all lines with key expression ´Ballot saved´
#cp all.tx keyword.tx
cat all.tx | grep 'Ballot drop' > keyword.tx

echo 3. Extract all lines of Election day Nov 3
cat keyword.tx | grep '03 Nov' > electionday.tx

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
awk 'p{print $0-p}{p=$0}' all.dat > dall.csv

echo 9. Making file containing only digits more than 3

cat dall.csv | awk 'length($0) > 3' > dall3.csv

# echo Skipping 9. Removing all that is delta equal zero
# cat dall.csv | grep -vx 0 > dall0.csv

echo 10. Removing all negative numbers in file
cat dall.csv | grep -v '-' > dall.dat
cat dall3.csv | grep -v '-' > dall3.dat

echo 11. Run BenfordXe per Ward. Source code for bxe.bas available at https://github.com/pagetelegram/benfordbench
echo ie
echo bxe all.dat   [for total seconds]
echo bxe allts.dat [for actual time stamps]
echo bxe dall.dat  [for delta seconds]
echo bxem3 dall3.dat [for delta seconds more than 3 digits long]
bxe dall.dat
bxe3m dall3.dat
echo graphing...
graph $1
graph3 3_$1
mkdir ../graphs/
echo storing... ../graphs/
cp $1.png ../graphs/
cp 3_$1.png ../graphs/
