#!/bin/bash
# $1=file $2=query expression, use this program to prepare voting machine logs for digital analysis of time stamps.
cat $1 | grep $2 | grep -o [0-2][0-9]:[0-5][0-9]:[0-5][0-9] | sed s/[:]//g > _$1 
