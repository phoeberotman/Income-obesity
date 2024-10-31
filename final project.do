use "/Users/phoeberotman/Desktop/statehealth2023.dta"
log using "/Users/phoeberotman/Desktop/statehealth2023extract.log", replace

tab1 food_insecure
tabstat food_insecure obeseadults2 mincome, s(mean, med, sd, range)

browse statename mincome

codebook mincome
gen incomelvl=0
replace incomelvl=1 if mincome <60000
replace incomelvl=2 if mincome >=60000
replace incomelvl=3 if mincome >70000
replace incomelvl=. if mincome==. 

browse statename mincome incomelvl

tab1 incomelvl

browse statename obeseadults2
gen obesitylvl=0
replace obesitylvl=1 if obeseadults2 <31.5
replace obesitylvl=2 if obeseadults2 >=31.5
replace obesitylvl=3 if obeseadults2 >35.5
replace obesitylvl=. if obeseadults2==.

tab1 obesitylvl

browse statename food_insecure
gen foodinsecure=0
replace foodinsecure=1 if food_insecure <9.5
replace foodinsecure=2 if food_insecure >=9.5
replace foodinsecure=3 if food_insecure >11

hist mincome
hist obeseadults2
hist food_insecure

tab1 foodinsecure

tab2 obesitylvl foodinsecure, col

tab2 obesitylvl incomelvl, col

tab2 foodinsecure incomelvl, col


scatter obeseadults2 food_insecure

drop if obeseadults2==.

gen hhinc2=mincome/1000

pwcorr hhinc2 obeseadults2, sig
pwcorr obeseadults2 food_insecure, sig
pwcorr hhinc2 food_insecure, sig


pwcorr hhinc2 obeseadults2 food_insecure, sig

browse statename mincome hhinc2

graph twoway (lfit food_insecure obeseadults2) (scatter food_insecure obeseadults2)

graph twoway (lfit hhinc2 obeseadults2) (scatter hhinc2 obeseadults2)

graph twoway (lfit mincome food_insecure) (scatter mincome food_insecure) 

regress obeseadults2 hhinc2
regress obeseadults2 hhinc2 food_insecure

log off
log close
clear 
