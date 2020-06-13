****Replication paper Hansen(AER, 2015)

clear
cd "/Users/andreaotero/Documents/GitHub/prueba/RDD/"

use "Data/hansen_dwi.dta", clear
gen dui= (bac1>=0.08)
gen bac1_c=bac1 - 0.08
gen interaction= dui*bac1_c


***TABLE 2: parte 1
	
				cap n tempvar tempsample
				cap n local specname=`specname'+1

				* Column 1: Male
				cap n reg male dui bac1_c interaction if (bac1>0.075 & bac1<0.085), robust
				cap n estimates store y1
				cap n estadd ysumm


				* Column 2: white
				cap n reg white dui bac1_c interaction if (bac1>0.075 & bac1<0.085), robust
				cap n estimates store y2
				cap n estadd ysumm
				
				* Column 3: Age
				cap n reg aged dui bac1_c interaction if (bac1>0.075 & bac1<0.085), robust
				cap n estimates store y3
				cap n estadd ysumm


				* Column 2: Accident
				cap n reg acc dui  bac1_c interaction if (bac1>0.075 & bac1<0.085), robust
				cap n estimates store y4
				cap n estadd ysumm
				
				
				


#delimit ;
	cap n estout * using ./Q5_hw4.tex,
		style(tex) label notype
		cells((b(star fmt(%9.3f))) (se(fmt(%9.3f)par))) 		
		stats(N ymean,
			labels("N" "Mean of dependent variable")
			fmt(%9.0fc %9.2fc 2))
			drop(_cons) 
			replace noabbrev starlevels(* 0.10 ** 0.05 *** 0.01) 
			title(Regression Discontinuity Estimates for the Effect of Exceeding BAC Thresholds on Predetermined Driver Characteristics)   
			collabels(none) eqlabels(none) mlabels(none) mgroups(none) substitute(_ \_)
			prehead("\begin{table}[htbp]\centering" "\small" "\caption{@title}" "\begin{center}" "\begin{threeparttable}" "\begin{tabular}{l*{@E}{c}}"
	"\toprule"
	"\multicolumn{1}{l}{\textit{Dependent var: }}&"
	"\multicolumn{1}{c}{\textit{Male}}&"
	"\multicolumn{1}{c}{\textit{White}}&"
	"\multicolumn{1}{c}{\textit{Age}}&"
	"\multicolumn{1}{c}{\textit{Accident}}\\")
		posthead("\midrule")
		prefoot("\midrule")  
		postfoot("\bottomrule" "\end{tabular}" "\begin{tablenotes}" "\tiny" "\item This table contains regression discontinuity based estimates of the effect of having BAC above the legal thresholds on predetermined  drivers characteristics based on Hansen (2015).  Heteroskedastic standard errors shown in parenthesis.  * p$<$0.10, ** p$<$0.05, *** p$<$0.01" "\end{tablenotes}" "\end{threeparttable}" "\end{center}" "\end{table}");
#delimit cr
	cap n estimates clear

	
	
	***TABLE 2: parte 2
	
				cap n tempvar tempsample
				cap n local specname=`specname'+1

				* Column 1: Male
				cap n reg male dui bac1_c interaction, robust
				cap n estimates store y1
				cap n estadd ysumm


				* Column 2: white
				cap n reg white dui bac1_c interaction, robust
				cap n estimates store y2
				cap n estadd ysumm
				
				* Column 3: Age
				cap n reg aged dui bac1_c interaction, robust
				cap n estimates store y3
				cap n estadd ysumm


				* Column 2: Accident
				cap n reg acc dui  bac1_c interaction, robust
				cap n estimates store y4
				cap n estadd ysumm
				
				
				


#delimit ;
	cap n estout * using ./Q5_hw4_B.tex,
		style(tex) label notype
		cells((b(star fmt(%9.3f))) (se(fmt(%9.3f)par))) 		
		stats(N ymean,
			labels("N" "Mean of dependent variable")
			fmt(%9.0fc %9.2fc 2))
			drop(_cons) 
			replace noabbrev starlevels(* 0.10 ** 0.05 *** 0.01) 
			title(Regression Discontinuity Estimates for the Effect of Exceeding BAC Thresholds on Predetermined Driver Characteristics)   
			collabels(none) eqlabels(none) mlabels(none) mgroups(none) substitute(_ \_)
			prehead("\begin{table}[htbp]\centering" "\small" "\caption{@title}" "\begin{center}" "\begin{threeparttable}" "\begin{tabular}{l*{@E}{c}}"
	"\toprule"
	"\multicolumn{1}{l}{\textit{Dependent var: }}&"
	"\multicolumn{1}{c}{\textit{Male}}&"
	"\multicolumn{1}{c}{\textit{White}}&"
	"\multicolumn{1}{c}{\textit{Age}}&"
	"\multicolumn{1}{c}{\textit{Accident}}\\")
		posthead("\midrule")
		prefoot("\midrule")  
		postfoot("\bottomrule" "\end{tabular}" "\begin{tablenotes}" "\tiny" "\item This table contains regression discontinuity based estimates of the effect of having BAC above the legal thresholds on predetermined  drivers characteristics based on Hansen (2015).  Heteroskedastic standard errors shown in parenthesis.  * p$<$0.10, ** p$<$0.05, *** p$<$0.01" "\end{tablenotes}" "\end{threeparttable}" "\end{center}" "\end{table}");
#delimit cr
	cap n estimates clear
