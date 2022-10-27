/*downloading the stock data,characteristics and visualisation of distribution*/
clear
log using Fama_MacBeth, replace
set more off
clear
use "/Users/massimozharkovsky/Documents/returnstocks.dta"
list in 1/2	
summarize return_aapl,detail
histogram return_aapl

/* time-series regressions to get beta coefficients for each stock*/
tempname memhold 
tempfile beta_coef 
postfile `memhold' beta str20 company using `beta_coef'
foreach v of varlist return_aapl-return_qcom{
	  qui reg `v' return_gspc
	  post `memhold' (_b[return_gspc]) (e(depvar))
}
postclose `memhold'  
clear
use `beta_coef'
list in 1/5
qui outsheet using "/Users/massimozharkovsky/Documents/beta_coef.csv",replace

/* merging of two datasets in order to run regressions for each period*/
clear
use "/Users/massimozharkovsky/Documents/returnstocks.dta"
replace date=subinstr(date,"-","",.)
qui destring,replace
list in 1/2
xpose, clear varname
list in 1/2
local vv
foreach v of varlist v1-v121{
	 local vv ""y"+substr(string(`v'[1]),1,4)+"m"+substr(string(`v'[1]),5,.)"
	 rename `v' `=`vv''
}
rename _varname company
merge 1:1 company using `beta_coef',nogenerate
list in 1/2

/* getting gamma-coefficients and testing hypothesis*/
tempfile gamma_coef 
postfile `memhold' gamma str20 period using `gamma_coef'
foreach v of varlist y2012m6-y2022m6{
	  qui reg `v' beta
	  post `memhold' (_b[beta]) (e(depvar))
}
postclose `memhold'  
clear
use `gamma_coef'
list in 1/5
qui outsheet using "/Users/massimozharkovsky/Documents/gamma_coef.csv",replace
ttest gamma=0
log close              
