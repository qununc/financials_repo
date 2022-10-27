log using Fama_Macbeth_data, replace
clear
set more off
import delimited "/Users/massimozharkovsky/Documents/stocks.csv"
list in 1/5
mdesc
drop abbv
drop if missing(meta)
foreach v of varlist aapl-gspc{
	generate return_`v' = log(`v'[_n])-log(`v'[_n-1])
}
drop if _n==1
drop aapl-gspc	
save "/Users/massimozharkovsky/Documents/returnstocks.dta",replace
log close
