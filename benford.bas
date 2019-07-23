dim x as long
dim y as long
dim ch as long
dim a$(255)
dim aaa as long
dim bar$(100)
dim errs as long
errs=0
for xy = 1 to 78:spacer$=spacer$ + " ":next xy
shell "ls *.dat > f.lst"
open "f.lst" for input as #4
do
if not(eof(4)) then input #4,fils$

print fils$;", ";
loop until eof(4)
print
close #4
shell "rm f.lst"
print "File (ie ";fils$;")>";
input fil$
if fil$ = "" then fil$=fils$
input "(1) or (A)ll>",yorn$
if yorn$="" then yorn$="a"
input "SCOPE (ie 10000 or 0=none)>",scope$
if scope$="" then scope$="10000"
input "Diviation Threshold (1-100 or 0=off)>",divi
if divi=0 then divi=1
divi$=right$((str$(divi)),len(str$(divi))-1)
scp=val(scope$)
fullog$="logb_"+fil$+scope$+"div"+divi$+".ben"
errlog$="logb-"+fil$+scope$+"div"+divi$+".err"

open fil$ for input as #5
tq=0
do
if not (eof(5)) then input #5, tq$
tq=tq+1
loop until (eof(5))

close #5

open fil$ for input as #1
shell "echo. > "+fullog$
shell "echo. > "+errlog$
open fullog$ for output as #2
open errlog$ for output as #3
c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0:c0=0
x=0
cls
bar$(0)=""
for cbt=1 to 100
bar$(cbt)=bar$(cbt-1)+"*"
next cbt
locate 1,1
color 0,10
print "BenfordBenchX V1.0 by Page Telegram 2019"
color 7,0
do
do
 if not(eof(1)) then input #1, lin$
loop until val(lin$)<>0
ch=len(lin$)
locate 2,1: print "LINE LNG:";ch; " - FILE: ";fil$; " - LOG FILE: ";fullog$;
color 14
print " - Div:";divi;
color 7
print using "########";int(tq*ch)
if ch>254 then print "Err: Each line more than 255 chars. Sorry exiting.": system
if ucase$(yorn$) <> "1" then   ' ALL
for i = 0 to ch-1
a$(i) = mid$(lin$,i,1) 
aaa=val(a$(i))
if val(a$(i)) > 0 then
ab=val(a$(i))
a=int(ab)
end if
select case a
case 1:c1=c1+1: if x > cc1 then cc1=cc1+1
case 2:c2=c2+1: if x > cc2 then cc2=cc2+1
case 3:c3=c3+1: if x > cc3 then cc3=cc3+1
case 4:c4=c4+1: if x > cc4 then cc4=cc4+1
case 5:c5=c5+1: if x > cc5 then cc5=cc5+1
case 6:c6=c6+1: if x > cc6 then cc6=cc6+1
case 7:c7=c7+1: if x > cc7 then cc7=cc7+1
case 8:c8=c8+1: if x > cc8 then cc8=cc8+1
case 9:c9=c9+1: if x > cc9 then cc9=cc9+1
'case 0:if a$(i)<>"" then c0=c0+1:
end select
x=x+1
y=y+1
locate 3,1
print "                                                                                               "
locate 3,1
print "SCOPE, LINES, TOTAL COUNT:";
print using "########-";x;
print using "############-";y;
print using "################";y*ch;
color 4,14
print " * ERRORS ";errs; " TOTAL *"
color 7,0
total=c1+c2+c3+c4+c5+c6+c7+c8+c9+c0
'                 tq=total lines, y=line position
'              ll:   tq-y=lines left
'               tq/ll
' ch = total in line, total count y*ch
tc=y*ch   'total count position
ta=tq*ch  'total all count
prog=int(100*( tc/ta) )
color 4,14
locate 1,41:print using "###";prog;
? "%"
 for ii=1 to int(prog/1.555) 
  locate 1,ii+44
  color 14,12
  print "#";
 next ii
color 7,0
if prog=100 then locate 25,1: system
if x>= scp then c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0:x=0
'end if

if x+1 >= scp then
for cl=4 to 13:locate cl,1:print "                                                                                                                           ":next cl

locate 4,1
? "1:"+bar$(int(p1))
locate 5,1
? "2:"+bar$(int(p2))
locate 6,1
? "3:"+bar$(int(p3))
locate 7,1
? "4:"+bar$(int(p4))
locate 8,1
? "5:"+bar$(int(p5))
locate 9,1
? "6:"+bar$(int(p6))
locate 10,1
? "7:"+bar$(int(p7))
locate 11,1
? "8:"+bar$(int(p8))
locate 12,1
? "9:"+bar$(int(p9))
locate 13,1
? "0:"+bar$(int(p0))
end if


p1= int(100*((c1)/total))
p2= int(100*((c2)/total))
p3= int(100*((c3)/total))
p4= int(100*((c4)/total))
p5= int(100*((c5)/total))
p6= int(100*(c6/total))
p7= int(100*(c7/total))
p8= int(100*(c8/total))
p9= int(100*(c9/total))
p0= int(100*(c0/total))
locate 15,1
print spacer$

locate 15,1:
print using "##-";p1;p2;p3;p4;p5;p6;p7;p8;p9;p0

							'Errors

if x+1 >= scp and divi<>1 then
  pt$=str$(p1)+","+str$(p2)+","+str$(p3)+","+str$(p4)+","+str$(p5)+","+str$(p6)+","+str$(p7)+","+str$(p8)+","+str$(p9)+","+str$(p0):pt$=pt$+","+str$(y)+","+str$(aaa)+", err"
  if divi < int(q1-p1) then
  print #3, pt$:beep:sleep 1
  errs=errs+1
  end if
  if divi < int(q2-p2) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q3-p3) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q4-p4) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q5-p5) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q6-p6) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q7-p7) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q8-p8) then
  errs=errs+1
  print #3, pt$:beep:sleep 1
  end if
  if divi < int(q9-p9) then
  errs=errs+1
  print #3, pt$
  beep:
  sleep 1
  end if
  pt$=""

p1= int(100*((c1)/total)):p2= int(100*((c2)/total)):p3= int(100*((c3)/total)):p4= int(100*((c4)/total)):p5= int(100*((c5)/total)):p6= int(100*(c6/total)):p7= int(100*(c7/total)):p8= int(100*(c8/total)):p9= int(100*(c9/total)):p0= int(100*(c0/total))
count=count+1
if count >= 8 then 
 count = 0
 for i = 0 to 9
 locate i+16,1: 
 print spacer$
next i
end if
locate count+16,1:
print using "##-";p1;p2;p3;p4;p5;p6;p7;p8;p9;p0
pt$=str$(p1)+","+str$(p2)+","+str$(p3)+","+str$(p4)+","+str$(p5)+","+str$(p6)+","+str$(p7)+","+str$(p8)+","+str$(p9)+","+str$(p0):pt$=pt$+","+str$(y+1)+","+str$(ch)+", ok":print #2, pt$:pt$=""
' store recent to prior values
q1= int(100*((c1)/total)):q2= int(100*((c2)/total)):q3= int(100*((c3)/total)):q4= int(100*((c4)/total)):q5= int(100*((c5)/total)):q6= int(100*(c6/total)):q7= int(100*(c7/total)):q8= int(100*(c8/total)):q9= int(100*(c9/total)):q0= int(100*(c0/total))




end if


' if scp <> x then print #2, pt$



next i

else                           ' FIRST

a$(0)=mid$(lin$,1,1)

a=val(a$(v))
select case a
case 1:c1=c1+1:
case 2:c2=c2+1:
case 3:c3=c3+1:
case 4:c4=c4+1:
case 5:c5=c5+1:
case 6:c6=c6+1:
case 7:c7=c7+1:
case 8:c8=c8+1:
case 9:c9=c9+1:
'case 0:if a$(0)<>"" then c0=c0+1:
end select
x=x+1
y=y+1
locate 2,1: print "LINE LNG:";ch; " - FILE: ";fil$; " - LOG FILE: ";fil$+scope$+".ben"
locate 3,1: print "                                                        "
locate 3,1
'print "LINE#:";x;" TOTAL COUNT#:";x*ch
print "SCOPE#:";x;" LINES#:";y;" TOTAL COUNT#:";y*ch

total=c1+c2+c3+c4+c5+c6+c7+c8+c9+c0

if x>= scp then c1=0:c2=0:c3=0:c4=0:c5=0:c6=0:c7=0:c8=0:c9=0:x=0

if x+1 >= scp then

for cl=4 to 13:locate cl,1:print "                                                                                                                           ":next cl

locate 4,1
? "1:"+bar$(int(p1))
locate 5,1
? "2:"+bar$(int(p2))
locate 6,1
? "3:"+bar$(int(p3))
locate 7,1
? "4:"+bar$(int(p4))
locate 8,1
? "5:"+bar$(int(p5))
locate 9,1
? "6:"+bar$(int(p6))
locate 10,1
? "7:"+bar$(int(p7))
locate 11,1
? "8:"+bar$(int(p8))
locate 12,1
? "9:"+bar$(int(p9))
locate 13,1
? "0:"+bar$(int(p0))
end if


locate 20,1: print "                                                                                                    "

locate 20,1
p1= int(100*((c1)/total))
? p1
locate 20,6
p2= int(100*((c2)/total))
? p2
locate 20,11
p3= int(100*((c3)/total))
? p3
locate 20,16
p4= int(100*((c4)/total))
? p4
locate 20,21
p5= int(100*((c5)/total))
? p5
locate 20,26
p6= int(100*(c6/total))
? p6
locate 20,31
p7= int(100*(c7/total))
? p7
locate 20,36
p8= int(100*(c8/total))
? p8
locate 20,41  
p9= int(100*(c9/total))
? p9
locate 20,46
p0= int(100*(c0/total))
? p0
pt$=str$(p1)+","+str$(p2)+","+str$(p3)+","+str$(p4)+","+str$(p5)+","+str$(p6)+","+str$(p7)+","+str$(p8)+","+str$(p9)+","+str$(p0):
if scp=x then print #2, pt$
end if

loop until eof(1) or inkey$=chr$(27)
close #1
close #2
close #3
shell "rm ben.lst"
