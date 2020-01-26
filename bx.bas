dim n(255)															' Set array to handle data lines up to 255 chars
shell "ls *.dat"													' List all dat files
input "Load>",load1$												' Ask for data file for analysis 
input "[A]ll Digits [1]st Digit?>",a12$     						' Ask whether to count all digits or first
input "Capture Average Every (default: 10000) Points?>",prog$ 		' Specify count / data plot segments
if len(prog$)=0 then prog$="10000"									' If no input specified then default vale = 10000
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"-.log"					' Empty data log file of values
 shell "echo > "+load1$+"_"+a12$+"-"+prog$+"_.log"  				' Empty data log file of percentages
cls
c=0:c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0					' Reset counters on start
locate 1,1 :print
locate 2,1: print "Benford X Forensics Digital Analysis Tool by Jason Page Jan. 2020"
locate 3,1: print "-----------------------------------------------------------------"
locate 4,1: 
color 12,14
print "    Time,  1,  2,  3,  4,  5, 6, 7, 8, 9"
color 7,0
'view print 6 to 24													' Set preview window for results
open load1$ for input as #1											' Load data file for analysis
do
 if not eof(1) then input #1,ot$ 									' Load value from data file
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
if ucase$(a12$)="A" then position=len(ot$) 							' Count all digits
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
