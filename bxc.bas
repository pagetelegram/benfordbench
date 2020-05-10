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

if tat<>4 then                                  ' if not enough arguments
 print "Total flags=";tat
 print "Arguments ";tif$;",";tid$;",";til$;",";tic$
 print "Press any key to continue to prompts, or use -h as a flag in command for command line help."
 goto 1:
end if

'print "htt or ftp?";left$(tif$,3):sleep

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
  sleep 3
  
  ' -f = load1$, -d = a12$ [all or 1], -l = prog$, -c = col$
  load1$=ltrim$(rtrim$(tif$)):a12$=ltrim$(rtrim$(tid$)):prog$=ltrim$(rtrim$(til$)): col$=ltrim$(rtrim$(tic$))
  print load1$, a12$,prog$,col$
  print "Press any key to continue"
  sleep 4
goto 2: 'skip interactive inputs
end if

1:
shell "ls *.dat"													' List all dat files
input "Load>",load1$												' Ask for data file for analysis 
input "[A]ll Digits [1]st Digit?>",a12$     						' Ask whether to count all digits or first
input "Capture Average Every (default: 10000) Points?>",prog$ 		' Specify count / data plot segments
input "Which Column Number (0=default: single column data only)",col$

if len(prog$)=0 then prog$="10000"									' If no input specified then default vale = 10000
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"-.log"					' Empty data log file of values
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"_.log"  				' Empty data log file of percentages
2:
if val(col$)<>0 and val(col$)<>1 then 
 shell "cut -f"+ltrim$(rtrim$((col$)))+" -d',' "+load1$+" > "+"c"+col$+"_"+load1$
 print "Command Using:"+" cut -f"+ltrim$(rtrim$((col$)))+" -d',' "+load1$+" > "+"c"+col$+"_"+load1$
 'sleep
 loaf$="c"+col$+"_"+load1$
 load1$=loaf$ 
 print "File Using:";load1$
 'sleep
end if

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
do
 if not eof(1) then input #1,toot$ 									' Load value from data file
ot$=toot$
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
 cc1$=ot$+","+c1$+","+c2$+","+c3$+","+c4$+","+c5$+","+c6$+","+c7$+","+c8$+","+c9$  ' Set values for storage
 cc2$=ot$+","+p1$+","+p2$+","+p3$+","+p4$+","+p5$+","+p6$+","+p7$+","+p8$+","+p9$  ' Set percentages for storage
 color 14,12
 'locate 4,1:
  print "#:";cc1$
  color 12,14
  print "%:";cc2$ 
 color 7,0
  shell "echo "+cc1$+" >> "+load1$+"_"+a12$+"-"+prog$+"-.log"					  ' Store values
  shell "echo "+cc2$+" >> "+load1$+"_"+a12$+"-"+prog$+"_.log"					  ' Store percentages
  c=0:c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0  				' Reset counters
'sleep 1
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
 'ends = (int((n(i)*100)/(c*100)))*33    						'Percent/Position of end of each line
  'for p=1 to ends
   'xss$=xss$+str$(n(i))
'  next p
  'locate (n(i))+6, ends
   'for e=1 to 80-ends
    ' eas$=eas$+" "
   'next e
    'locate 6+(n(i)),1
    'print xss$+eas$ 
 next i 
'sleep 1
 eas$="":xss$=""
loop until (eof(1))
close #1
