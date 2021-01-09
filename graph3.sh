#!/bin/bash

mv _dall3.dat.csv $1.csv

gnuplot -persist <<-EOFMarker
set xrange [0:10]
set yrange [0:45]
datafile = "$1.csv"
set output "$1.png"
set xlabel "Digit"
set ylabel "Percent"
set terminal png size 600,400
set datafile separator ','
set title 'BenfordBench.org Analysis of Election Log Time-Stamps in Delta Total Seconds' font ",10" textcolor rgbcolor "black"
    set pointsize 3

plot for [col=1:1] datafile using 0:col title "$1" lt rgb "#000000", \
   for [col=2:2] datafile using 0:col with lines title "Benford" lt rgb "#000000"


EOFMarker

