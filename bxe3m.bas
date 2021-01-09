' This program for Benford Analysis was created to cater towards Election Machine Ward log files
' This program can run from any batch program designed to process all files
' by the batch specifing bxe [filename]
' This version of bxe does not batch by itself. Only accepts one file at a time.
' Benford BXE will output total counts for 1-9 total as well as first and last digits
' And will also output those three types as percentages in a [filename]+.CSV file
' The array while processed is not used yet in this version of the program.
' The array is established for later development in some Benford curve intelligence
' identification as the file is being processed.
' This program is developed by Jason Page of Page Telegram for BenfordBench.org in Dec of 2020

' count of all digits in each value up to 255 digits
'dim fa1(255)
'dim fa2(255)
'dim fa3(255)
'dim fa4(255)
'dim fa5(255)
'dim fa6(255)
'dim fa7(255)
'dim fa8(255)
'dim fa9(255)
print "Benford Bench Engine v0.4.a by Page Telegram 2020. Compiled for Linux or OS/2"
flag$=COMMAND$
do
if len(flag$) < 2 then shell "ls *.dat": input "Study File:>",flag$
print "Studying Data File "+flag$
shell "ls > files.tx"
open "files.tx" for input as #1
ok=0												
 do
 if not (eof(1)) then input #1, scan$
 if ucase$(scan$)=ucase$(flag$) then ok=1
 loop until eof(1)
close #1
loop until ok=1
shell "rm files.tx"
open flag$ for input as #2
do
 if not(eof(2)) then line input #2,ot$
 t$=(rtrim$(ltrim$(ot$)))
 size=len(t$)
 if size>255 then size =255: beep: print "Warning....data cropped at 255..."
  for i=1 to size   
   char$=mid$(t$,i,1)
   char=val(char$)
   if len(t$) > 3 then
 select case char		'count all digits
  case 1: 'fa1(i)=fa1(i)+1:
   ft1=ft1+1  
  case 2: 'fa2(i)=fa2(i)+1:
   ft2=ft2+1
  case 3: 'fa3(i)=fa3(i)+1:
   ft3=ft3+1
  case 4: 'fa4(i)=fa4(i)+1:
   ft4=ft4+1
  case 5: 'fa5(i)=fa5(i)+1:
   ft5=ft5+1
  case 6: 'fa6(i)=fa6(i)+1:
   ft6=ft6+1
  case 7: 'fa7(i)=fa7(i)+1:
   ft7=ft7+1
  case 8: 'fa8(i)=fa8(i)+1:
   ft8=ft8+1
  case 9: 'fa9(i)=fa9(i)+1:
   ft9=ft9+1
 end select
end if
if val(t$)<>0 and len(t$)>3 then 
 if t$<>":" then totalall=totalall+1
end if
  next i
  
  first=val(mid$(t$,1,1))			'capture first digit for count
  last=val(mid$(t$,size,1))        'capture last digit for count
rem  totalall=totalall+i				'count total digits
if val(t$)<>0 then  totalnum=totalnum+1				'count total values
 select case first                  'count 1-9 first digit
  case 1: fc1=fc1+1
  case 2: fc2=fc2+1
  case 3: fc3=fc3+1
  case 4: fc4=fc4+1
  case 5: fc5=fc5+1
  case 6: fc6=fc6+1
  case 7: fc7=fc7+1
  case 8: fc8=fc8+1
  case 9: fc9=fc9+1
 end select
 select case last					'count 1-9 last digit
  case 1: fl1=fl1+1					
  case 2: fl2=fl2+1
  case 3: fl3=fl3+1
  case 4: fl4=fl4+1
  case 5: fl5=fl5+1
  case 6: fl6=fl6+1
  case 7: fl7=fl7+1
  case 8: fl8=fl8+1
  case 9: fl9=fl9+1
 end select
loop until eof(2)
close #2

perchfirst$="Percent 1st,"+str$(100-((1-(fc1/totalnum))*100))+","+str$(100-((1-(fc2/totalnum))*100))+","+str$(100-((1-(fc3/totalnum))*100))+","+str$(100-((1-(fc4/totalnum))*100))+","+str$(100-((1-(fc5/totalnum))*100))+","+str$(100-((1-(fc6/totalnum))*100))+","+str$(100-((1-(fc7/totalnum))*100))+","+str$(100-((1-(fc8/totalnum))*100))+","+str$(100-((1-(fc9/totalnum))*100))
perchlast$="Percent Last,"+str$(100-((1-(fl1/totalnum))*100))+","+str$(100-((1-(fl2/totalnum))*100))+","+str$(100-((1-(fl3/totalnum))*100))+","+str$(100-((1-(fl4/totalnum))*100))+","+str$(100-((1-(fl5/totalnum))*100))+","+str$(100-((1-(fl6/totalnum))*100))+","+str$(100-((1-(fl7/totalnum))*100))+","+str$(100-((1-(fl8/totalnum))*100))+","+str$(100-((1-(fl9/totalnum))*100))
perchall$="Percent All,"+str$(100-((1-(ft1/totalall))*100))+","+str$(100-((1-(ft2/totalall))*100))+","+str$(100-((1-(ft3/totalall))*100))+","+str$(100-((1-(ft4/totalall))*100))+","+str$(100-((1-(ft5/totalall))*100))+","+str$(100-((1-(ft6/totalall))*100))+","+str$(100-((1-(ft7/totalall))*100))+","+str$(100-((1-(ft8/totalall))*100))+","+str$(100-((1-(ft9/totalall))*100))
iperchall$=str$(100-((1-(ft1/totalall))*100))+","+str$(100-((1-(ft2/totalall))*100))+","+str$(100-((1-(ft3/totalall))*100))+","+str$(100-((1-(ft4/totalall))*100))+","+str$(100-((1-(ft5/totalall))*100))+","+str$(100-((1-(ft6/totalall))*100))+","+str$(100-((1-(ft7/totalall))*100))+","+str$(100-((1-(ft8/totalall))*100))+","+str$(100-((1-(ft9/totalall))*100))

last$=str$(totalnum)+","+str$(fl1)+","+str$(fl2)+","+str$(fl3)+","+str$(fl4)+","+str$(fl5)+","+str$(fl6)+","+str$(fl7)+","+str$(fl8)+","+str$(fl9)
first$=str$(totalnum)+","+str$(fc1)+","+str$(fc2)+","+str$(fc3)+","+str$(fc4)+","+str$(fc5)+","+str$(fc6)+","+str$(fc7)+","+str$(fc8)+","+str$(fc9)
all$=str$(totalall)+","+str$(ft1)+","+str$(ft2)+","+str$(ft3)+","+str$(ft4)+","+str$(ft5)+","+str$(ft6)+","+str$(ft7)+","+str$(ft8)+","+str$(ft9)

outfile$=flag$+".csv"
shell "echo. > "+outfile$
shell "echo. > _"+outfile$
open outfile$ for append as #3
 print #3, "total count, 1, 2, 3, 4, 5, 6, 7, 8, 9"
 print #3, first$
 print #3, last$
 print #3, all$
 print #3, perchfirst$
 print #3, perchlast$
 print #3, perchall$
close #3
ben$="30.1,17.6,12.5,9.7,7.9,6.7,5.8,5.1,4.6"
i1$=str$(100-((1-(ft1/totalall))*100)) :b1$="30.1"
i2$=str$(100-((1-(ft2/totalall))*100)):b2$="17.6"
i3$=str$(100-((1-(ft3/totalall))*100)):b3$="12.5"
i4$=str$(100-((1-(ft4/totalall))*100)):b4$="9.7"
i5$=str$(100-((1-(ft5/totalall))*100)):b5$="7.9"
i6$=str$(100-((1-(ft6/totalall))*100)):b6$="6.7"
i7$=str$(100-((1-(ft7/totalall))*100)):b7$="5.8"
i8$=str$(100-((1-(ft8/totalall))*100)):b8$="5.1"
i9$=str$(100-((1-(ft9/totalall))*100)):b9$="4.6"
open "_"+outfile$ for append as #4

print #4, "0,0"
print #4, i1$+","+b1$+","+str$(ft1)
print #4, i2$+","+b2$+","+str$(ft2)
print #4, i3$+","+b3$+","+str$(ft3)
print #4, i4$+","+b4$+","+str$(ft4)
print #4, i5$+","+b5$+","+str$(ft5)
print #4, i6$+","+b6$+","+str$(ft6)
print #4, i7$+","+b7$+","+str$(ft7)
print #4, i8$+","+b8$+","+str$(ft8)
print #4, i9$+","+b9$+","+str$(ft9)

close #4

shell "cat _"+outfile$
