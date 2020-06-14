clear
capture log close

* This do file will estimate a simple regression and produce a simple table with covariates

cd "/Users/andreaotero/Documents/GitHub/prueba/RDD/"

use "Data/hansen_dwi.dta", clear


*Q3
gen dui= (bac1>=0.08)

*Q4
rddensity bac1, all c(0.08) plot graph_options(graphregion(color(white)) xtitle("BAC") ytitle("Density") legend(off)) 

graph save "Graph" "/Users/andreaotero/Documents/GitHub/prueba/RDD/Figures/figure1.png"


DCdensity bac1, breakpoint(0.08) generate(Xj Yj r0 fhat se_fhat)
graph export"/Users/andreaotero/Documents/GitHub/prueba/RDD/Figures/figure1_oldmccrary.png", as(png) name("Graph")


*Q5
gen bac1_c=bac1 - 0.08
gen interaction= dui*bac1_c


foreach x in male white age acc if (bac1>0.07 & bac1<0.09) {
reg `x' dui bac1_c interaction , robust
}


*Q6
cmogram acc bac1, cut(0.08) scatter line(0.08) qfitci
cmogram acc bac1, cut(0.08) scatter line(0.08) lfitci


cmogram male bac1, cut(0.08) scatter line(0.08) qfitci
cmogram male bac1, cut(0.08) scatter line(0.08) lfitci


cmogram white bac1, cut(0.08) scatter line(0.08) qfitci
cmogram white bac1, cut(0.08) scatter line(0.08) lfitci


cmogram aged bac1, cut(0.08) scatter line(0.08) qfitci
cmogram aged bac1, cut(0.08) scatter line(0.08) lfitci

gr combine

gr combine "Figures/figure2_male_lfit.gph"  "Figures/figure2_white_lfit.gph"  "Figures/figure2_age_lfit.gph"  "Figures/figure2_acc_lfit.gph" 

gr combine "Figures/figure2_male_qfit.gph"  "Figures/figure2_white_qfit.gph"  "Figures/figure2_age_qfit.gph"  "Figures/figure2_acc_qfit.gph"


*Q7
gen bac1_sq= bac1_c*bac1_c
gen interaction_sq= dui*bac1_sq

* Panel A
reg recidivism dui bac1_c  if (bac1>0.03 & bac1<0.13), robust
reg recidivism dui bac1_c interaction  if (bac1>0.03 & bac1<0.13), robust
reg recidivism dui bac1_c bac1_sq interaction interaction_sq  if (bac1>0.03 & bac1<0.13), robust
reg recidivism dui bac1_c  male white aged if (bac1>0.03 & bac1<0.13), robust
reg recidivism dui bac1_c interaction male white aged if (bac1>0.03 & bac1<0.13), robust
reg recidivism dui bac1_c interaction interaction_sq male white aged if (bac1>0.03 & bac1<0.13), robust


* Panel B
reg recidivism dui bac1_c if (bac1>0.055 & bac1<0.105), robust
reg recidivism dui bac1_c interaction if (bac1>0.055 & bac1<0.105), robust
reg recidivism dui bac1_c bac1_sq interaction interaction_sq if (bac1>0.055 & bac1<0.105), robust
reg recidivism dui bac1_c  male  white aged if (bac1>0.055 & bac1<0.105), robust
reg recidivism dui bac1_c interaction male  white aged if (bac1>0.055 & bac1<0.105), robust
reg recidivism dui bac1_c interaction interaction_sq male  white aged if (bac1>0.055 & bac1<0.105), robust


*Q8
cmogram recidivism bac1 if bac1<0.15, cut(0.08) scatter line(0.08) qfitci
cmogram recidivism bac1 if bac1<0.15, cut(0.08) scatter line(0.08) lfitci


