    'This file is part of bxc/benford.

    'bxc/benford aka Benford Bench is free software: you can redistribute
    'it and/or modify it under the terms of the GNU General Public License
    'as published by the Free Software Foundation, either version 3 of the
    'License, or (at your option) any later version.

    'bxc/benford is distributed in the hope that it will be useful,
    'but WITHOUT ANY WARRANTY; without even the implied warranty of
    'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    'GNU General Public License for more details.

    'You should have received a copy of the GNU General Public License
    'along with bxc/benford.  If not, see <https://www.gnu.org/licenses/>.
    
    'bxc/benford is written by Jason S. Page as part of the Benford Bench
    'project, benfordbench.org in operation since 2016.
    
    'This program uses OS specific operations and will only work in
    'Unix/Linux. There are no plans to make this available for DOS/Windows
    'however may work and compile with GNU DOS command line tools in OS/2.
    '
    'The Benford Bench Project as of this writing consist of the following
    'volunteers:
    '
    'Jason Page
    'Morris Chukhman
    'Padraig O'Hara
    'Kevin Perez
    'Michael Fiedler

dim n(255)															' Set array to handle data lines up to 255 chars
express$=command$(-1)
' -f = load1$, -d = a12$ [all or 1], -l = prog$, -c = column$
print express$
tat=0
dc=0
do
i=0
select case mid$(express$,dc,3)
 case " -h"
  print "bxc -f [data file] -d [all] or [1] -l [length of sample pools (ie 10000)] -c [column number] - {terminal}":print "Use 0 for columns if only one column of data in input file":system

 case "-f "   ' load file
   tat=tat+1
    do
    
     tif$=tif$+tit$
    i=i+1
    tit$=mid$(express$,dc+2+i,1)
    tits$=mid$(express$,dc+i+2,2)
      
    loop until tits$=" -" or i > len(express$)
print " -f ";tif$

 i=0

  case " -d"    ' all or 1st digit
	tat=tat+1
	do
    
    if i>0 then tid$=tid$+tit$
    
    i=i+1
    tit$=mid$(express$,dc+2+i,1)
    loop until tit$="-" or i > len(express$)
    print " -d"; tid$  

i=0  

  case " -l"    ' total count per sample
	tat=tat+1
	do
    
    if i>0 then til$=til$+tit$
    i=i+1
    tit$=mid$(express$,dc+i+2,1)
      
    loop until tit$="-" or i > len(express$)
    print " -l"; til$  

i=0  

case " -c"    ' column number with comma deliminated
	tat=tat+1
	do
    
   if i>0 then tic$=tic$+tit$
    i=i+1
    tit$=mid$(express$,dc+i+2,1)

       loop until tit$="-" or i > len(express$)
i=0   
          print " -c ";tic$  

end select
dc=dc+1

loop until dc=len(express$)

if tat=4 then                                  ' if not enough arguments
 print "Total flags=";tat
 print "Arguments ";tif$;",";tid$;",";til$;",";tic$
 print "Press any key to continue to prompts, or use -h as a flag in command for command line help."
 sleep 3
  load1$=ltrim$(rtrim$(tif$)):a12$=ltrim$(rtrim$(tid$)):prog$=ltrim$(rtrim$(til$)): col$=ltrim$(rtrim$(tic$))
  print load1$, a12$,prog$,col$
if col$="0" then col$="1" 

if left$(tif$,3)="ftp" or left$(tif$,3)="htt" then ' check for web link; if true then download the data file
 shell "wget -N "+tif$ 				   'get data file
'shell "find . -type f -exec stat -c '%Y %n' {} \; | sort -nr | awk 'NR==1,NR==1 {print $2}' > file.nam"
'shell "awk 'END{ var=FILENAME; split (var,a,/\//); print a[5]}' "+ tif$ + " > file.nam"
shell "ls -w1 -t > file.nam" 			' get the latest downloaded file to read from the file list newest first
 open "file.nam" for input as #11
  if not (eof(11)) then input #11,filenam$
  if not (eof(11)) then input #11,filenam$
  print "Downloaded file>";filenam$ 
 close #11
  tif$=filenam$
  print tif$
  ' 3
  
  ' -f = load1$, -d = a12$ [all or 1], -l = prog$, -c = col$
  load1$=ltrim$(rtrim$(tif$)):a12$=ltrim$(rtrim$(tid$)):prog$=ltrim$(rtrim$(til$)): col$=ltrim$(rtrim$(tic$))
  print load1$, a12$,prog$,col$
  'print "Press any key to continue"
   '4
end if


goto 2:
 else
 print "Total flags=";tat;". Must be a total of 4 to qualify headless operation."
 goto 1:
end if
1:
shell "ls *.dat"													' List all dat files
input "Load>",load1$												' Ask for data file for analysis 
input "[A]ll Digits [1]st Digit?>",a12$     						' Ask whether to count all digits or first
input "Capture Average Every (default: 10000) Points?>",prog$ 		' Specify count / data plot segments
input "Which Column Number (0=default: single column data only)",col$
2:
if len(prog$)=0 then prog$="10000"									' If no input specified then default vale = 10000
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"-.log"					' Empty data log file of values
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"_.log"  				' Empty data log file of percentages

if val(col$)<>0 and val(col$)<>1 then 
 shell "cut -f"+ltrim$(rtrim$((col$)))+" -d',' "+load1$+" > "+"c"+col$+"_"+load1$
 print "Command Using:"+" cut -f"+ltrim$(rtrim$((col$)))+" -d',' "+load1$+" > "+"c"+col$+"_"+load1$
 '
 '
 toad$="c"+col$+"_"+load1$
 load1$=toad$
end if

'print "File Using:";load1$
 
c=0:c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0					' Reset counters on start
'locate 1,1 :
print
'locate 2,1: 
print "Benford X-C Forensics Digital Analysis Tool by Jason Page 5-10-2020"
'locate 3,1: 
print "-------------------------------------------------------------------"
'locate 4,1: 
color 12,14
print "    Time,  1,  2,  3,  4,  5, 6, 7, 8, 9"
color 7,0
'view print 6 to 24													' Set preview window for results
'color 15,11
'print load1$
color 7,0
open load1$ for input as #1											' Load data file for analysis
tc=0
if not (eof(1)) then input #1,line1$
do
 												' record count to total record count
 if not eof(1) then
   input #1,ot$:
   tc=tc+1 									' Load value from data file
 end if
 
if c >= val(prog$) then												' If segment within range then do the analysis
 c$=str$(c)    : c6$=str$(c6)										' Perform value format to strings
 c1$=str$(c1)  : c7$=str$(c7)
 c2$=str$(c2)  : c8$=str$(c8) 
 c3$=str$(c3)  : c9$=str$(c9)
 c4$=str$(c4)
 c5$=str$(c5)
 p6$=str$(int(((c6*100)/(c*100))*100))								' Perform percent calculation to strings
 p1$=str$(int(((c1*100)/(c*100))*100))
 p7$=str$(int(((c7*100)/(c*100))*100))
 p2$=str$(int(((c2*100)/(c*100))*100))
 p8$=str$(int(((c8*100)/(c*100))*100))
 p3$=str$(int(((c3*100)/(c*100))*100))
 p9$=str$(int(((c9*100)/(c*100))*100))
 p4$=str$(int(((c4*100)/(c*100))*100))
 p5$=str$(int(((c5*100)/(c*100))*100))
 cc1$=ot$+","+str$(tc)+","+c1$+","+c2$+","+c3$+","+c4$+","+c5$+","+c6$+","+c7$+","+c8$+","+c9$  ' Set values for storage
 cc2$=ot$+","+str$(tc)+","+p1$+","+p2$+","+p3$+","+p4$+","+p5$+","+p6$+","+p7$+","+p8$+","+p9$  ' Set percentages for storage
 color 14,12
 'locate 4,1:
  print "#:";cc1$
  color 12,14
  print "%:";cc2$ 
 color 7,0
  shell "echo "+cc1$+" >> "+load1$+"_"+a12$+"-"+prog$+"-.log"					  ' Store values
  shell "echo "+cc2$+" >> "+load1$+"_"+a12$+"-"+prog$+"_.log"					  ' Store percentages
  c=0:c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0  				' Reset counters
' 1
end if
if left$((ucase$(a12$)),1)="A" then position=len(ot$) 							' Count all digits
if ucase$(a12$)="1" then position=1 								' Count only first digit
for i=1 to position  												' count to position
  n(i)=val(mid$(ot$,i,1))
 select case n(i)  											' count individual digits specified in array of opened file
  case 1
   c=c+1
   c1=c1+1  
  case 2
   c=c+1
   c2=c2+1  
  case 3
   c=c+1
   c3=c3+1  
  case 4
   c=c+1
   c4=c4+1  
  case 5
   c=c+1
   c5=c5+1  
  case 6
   c=c+1
   c6=c6+1  
  case 7
   c=c+1
   c7=c7+1
  case 8
   c=c+1
   c8=c8+1
  case 9
   c=c+1
   c9=c9+1
end select
 next i 
' 1
 eas$="":xss$=""
loop until (eof(1))
close #1
print "Generating the ASCII Chart..."   'create the charts
print load1$,a12$,prog$
filenam$=load1$+"_"+a12$+"-"+prog$+"_.log"
print filenam$
open filenam$ for input as #12
if not(eof(12)) then line input #12,empty$
shell "rm chart_"+filenam$+".txt"
ccc=0
do

if not(eof(12)) then input #12, toss$, recd$, throw1$, throw2$, throw3$, throw4$, throw5$, throw6$, throw7$, throw8$, throw9$

for i=1 to val(throw1$)
as1$=as1$+"1"
next i

for i=1 to val(throw2$)
as2$=as2$+"2"
next i

for i=1 to val(throw3$)
as3$=as3$+"3"
next i

for i=1 to val(throw4$)
as4$=as4$+"4"
next i

for i=1 to val(throw5$)
as5$=as5$+"5"
next i

for i=1 to val(throw6$)
as6$=as6$+"6"
next i

for i=1 to val(throw7$)
as7$=as7$+"7"
next i

for i=1 to val(throw8$)
as8$=as8$+"8"
next i

for i=1 to val(throw9$)
as9$=as9$+"9"
next i
ccc=ccc+1
fnam$="chart_"+filenam$
shell "echo record number " + recd$ + " at value " + toss$ + " >> " + fnam$
shell "echo "+as1$ + " " + " at "+throw1$+ "% >> " + fnam$
shell "echo "+as2$ + " " + " at "+throw2$+ "% >> " + fnam$
shell "echo "+as3$ + " " + " at "+throw3$+ "% >> " + fnam$
shell "echo "+as4$ + " " + " at "+throw4$+ "% >> " + fnam$
shell "echo "+as5$ + " " + " at "+throw5$+ "% >> " + fnam$
shell "echo "+as6$ + " " + " at "+throw6$+ "% >> " + fnam$
shell "echo "+as7$ + " " + " at "+throw7$+ "% >> " + fnam$
shell "echo "+as8$ + " " + " at "+throw8$+ "% >> " + fnam$
shell "echo "+as9$ + " " + " at "+throw9$+ "% >> " + fnam$
as1$="":as2$="":as3$="":as4$="":as5$="":as6$="":as7$="":as8$="":as9$=""
'shell "echo Chart #"+str$(ccc)+" >> "+fnam$
loop until(eof(12))
close #12
shell "mv "+fnam$+" "+fnam$+".txt"
print "head:"
shell "head -n10 "+fnam$+".txt"
print "tail:"
shell "tail -n10 "+fnam$+".txt"
system
