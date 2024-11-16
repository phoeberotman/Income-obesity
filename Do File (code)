use "/Users/phoeberotman/Desktop/statehealth23_foodinsecurity.dta"
log using "/Users/phoeberotman/Desktop/statehealth23_foodinsecurity.log", replace
cd "/Users/phoeberotman/Desktop/"

drop if obeseadults2==.
drop if mincome==.
drop if food_insecure==.

tabstat food_insecure obeseadults2 mincome, s(mean, med, sd, range)

centile mincome, centile(33.33, 66.66)
gen incomelvl=0
replace incomelvl=1 if mincome <59461.75
replace incomelvl=2 if mincome >=59461.75
replace incomelvl=3 if mincome >68714.11

centile obeseadults2, centile (33.33, 66.66)
gen obesitylvl=0
replace obesitylvl=1 if obeseadults2 <31.59949 
replace obesitylvl=2 if obeseadults2 >=31.59949 
replace obesitylvl=3 if obeseadults2 >35.19932

centile food_insecure, centile (33.33, 66.66)
gen foodinsecure=0
replace foodinsecure=1 if food_insecure <9.49983
replace foodinsecure=2 if food_insecure >=9.49983
replace foodinsecure=3 if food_insecure >11.39762

tab mincome
hist mincome, xtitle("Median Household Income") width(7000) frequency ytitle("Frequency") start(40000) ylabel(0(5)15)

tab obeseadults2
hist obeseadults2, xtitle("Obese Adults (% of total adult pop.)") width(3) frequency ytitle("Frequency") start(24.5) ylabel(0(5)15)

tab food_insecure
hist food_insecure, xtitle("Food Insecure People (% of total pop.)") width(3) frequency ytitle("Frequency") start(5) ylabel(0(5)30)

tabulate obesitylvl foodinsecure, chi2 row 
tabulate obesitylvl incomelvl, chi2 row
tabulate foodinsecure incomelvl, chi2 row

gen hhinc2=mincome/1000
pwcorr hhinc2 obeseadults2 food_insecure, sig

graph twoway (scatter food_insecure obeseadults2) (lfit food_insecure obeseadults2), xtitle("Food Insecure People (% of total pop.)") ytitle("Obese Adults (% of total adult pop.)")
graph twoway (lfit hhinc2 obeseadults2)(scatter hhinc2 obeseadults2), xtitle("Median Household Income") ytitle("Obese Adults (% of total adult pop.)")
graph twoway (lfit mincome food_insecure) (scatter mincome food_insecure), xtitle("Median Household Income") ytitle("Food Insecure People (% of total pop.)")

regress obeseadults2 hhinc2
esttab, style(fixed) 

regress obeseadults2 hhinc2 food_insecure
esttab, style(fixed) 

log close
clear 
