clear
capture log close

* This do file will estimate a simple regression and produce a simple table with covariates

cd "/Users/andreaotero/Documents/GitHub/prueba/RDD/"

use "Data/hansen_dwi.dta", clear


*Q3
gen above_cutoff= (bac1>=0.08)

*Q4
rddensity bac1, c(0.08) plot
graph save "Graph" "/Users/andreaotero/Documents/GitHub/prueba/RDD/Figures/figure1.gph"


DCdensity bac1, breakpoint(0.08) generate(Xj Yj r0 fhat se_fhat)
graph export"/Users/andreaotero/Documents/GitHub/prueba/RDD/Figures/figure1_oldmccrary.png", as(png) name("Graph")



