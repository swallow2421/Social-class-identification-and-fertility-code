global root "D:/jieceng"  
global d    $root/Data  
global r    $root/Results  
global date 251230
use "$d\jieceng.dta",clear

global control gender age age2 health dang married nation gya guanli worktime parents only_child size ferboy faincome 
global xlist upbias consistent

*Table 2
reg child jie i.sm i.year if inrange(age,18,45), cluster(sm)
est store m1
reg child jie $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store m2

reg child diwei i.sm i.year if inrange(age,18,45), cluster(sm)
est store m3
reg child diwei $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store m4

gen jiaohu=jie*diwei
reg child jie diwei i.sm i.year if inrange(age,18,45), cluster(sm)
est store m5
reg child jie diwei jiaohu $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store m6

esttab m* using "$r\table2_$date.rtf", mtitle(Model1 Model2 Model3 Model4  Model5 Model6) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear
*Table 3
reg child upbias consistent if inrange(age,18,45),cluster(sm)
est store a1
reg child $xlist $control if inrange(age,18,45),cluster(sm)
est store a2
reg child $xlist $control i.sm if inrange(age,18,45), cluster(sm)
est store a3
reg child $xlist $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store a4
esttab a* using "$r\table3_$date.rtf", mtitle(Model1 Model2 Model3 Model4) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear
*Table 4
reg tfertility upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b1
reg twochild upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b2
reg erhai upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b3
reg happiness upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b4
reg trust upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b5
reg fair upbias consistent $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store b6
esttab b* using "$r\table4_$date.rtf", mtitle(m1 m2 m3 m4 m5 m6) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear

*Appendix 1
tobit child upbias consistent $control i.sm i.year if inrange(age,18,45),ll(0) vce(cluster sm) 
margins,dydx(*) post
est store c1
reg child updis consistenta $control i.sm i.year if inrange(age,18,45), cluster(sm)
est store c2
reg child $xlist $control i.sm i.year if inrange(age,18,50), cluster(sm)
est store c3
reg child $xlist $control i.sm i.year if inrange(age,18,45) & year<2021, cluster(sm)
est store c4
esttab c* using "$r\appendix1_$date.rtf", mtitle(Model1 Model2 Model3 Model4) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear
*Table 5
gen upcons=upbias+consistent
reg upcons oldjie $control i.sm i.year if inrange(age,18,45),cluster(sm)
est store d1
reg child upcons oldjie $control i.sm i.year if inrange(age,18,45),cluster(sm)    
est store d2
ivreg2 child (upcons=oldjie) $control i.sm i.year if inrange(age,18,45), first cluster(sm)
est store d3   

esttab d* using "$r\table5_$date.rtf", mtitle(m1 m2 m3 ) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear
*Table 6
reg child upbias consistent $control i.sm i.year if gender==0 & inrange(age,18,45),cluster(sm)
est store e1
reg child upbias consistent $control  i.sm i.year if gender==1 & inrange(age,18,45),cluster(sm)
est store e2

gen agegroup=1 if age<30
replace agegroup=2 if age>=30 & age<40
replace agegroup=3 if age>=40 
reg child upbias consistent $control i.sm i.year if agegroup==1 & inrange(age,18,45),cluster(sm)
est store e3
reg child upbias consistent $control  i.sm i.year if agegroup==2 & inrange(age,18,45),cluster(sm)
est store e4
reg child upbias consistent $control  i.sm i.year if agegroup==3 & inrange(age,18,45),cluster(sm)
est store e5
esttab e* using "$r\table6_1_$date.rtf", mtitle(e1 e2 e3 e4 e5) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear

reg child upbias consistent $control i.year i.sm if hukou==0 & inrange(age,18,45), cluster(sm)
est store f1
reg child upbias consistent $control i.year i.sm if hukou==1 & inrange(age,18,45), cluster(sm)   
est store f2

reg child upbias consistent $control i.year i.sm if qishi==0 & inrange(age,18,45), cluster(sm)
est store f3
reg child upbias consistent $control i.year i.sm if qishi==1 & inrange(age,18,45), cluster(sm)
est store f4

gen shuidao=1 if inlist(sm,9, 15, 1, 19, 24, 16, 21, 22, 12, 13, 20, 28, 6)
replace shuidao=0 if missing(shuidao)
reg child upbias consistent $control i.year i.sm if shuidao==0 & inrange(age,18,45), cluster(sm)
est store f5
reg child upbias consistent $control i.year i.sm if shuidao==1 & inrange(age,18,45), cluster(sm)
est store f6

esttab f* using "$r\table6_2_$date.rtf", mtitle(f1 f2 f3 f4 f5 f6) b(%6.2f) se(%6.2f) nogap compress star(* 0.1 ** 0.05 *** 0.01) r2(%6.2f) scalar(N) replace indicate("Year fixed effect=*.year" "Province fixed effect=*.sm")
eststo clear
