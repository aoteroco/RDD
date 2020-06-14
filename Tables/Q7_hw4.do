****Replication paper Hansen(AER, 2015)

clear
cd "/Users/andreaotero/Documents/GitHub/prueba/RDD/"

use "Data/hansen_dwi.dta", clear
gen dui= (bac1>=0.08)
gen bac1_c=bac1 - 0.08
gen interaction= dui*bac1_c


***TABLE 3: parte a
	
				cap n tempvar tempsample
				cap n local specname=`specname'+1

				* Column 1: BAC1
				cap n reg recidivism dui bac1_c  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y1
				cap n estadd ysumm


				* Column 2: BAC1+interaction
				cap n reg recidivism dui bac1_c interaction  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y2
				cap n estadd ysumm
				
				* Column 3: BAC1+interaction+interactionsq
				cap n reg recidivism dui bac1_c bac1_sq interaction interaction_sq  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y3
				cap n estadd ysumm

				* Column 4: BAC1 controls
				cap n reg recidivism dui bac1_c  male  white aged  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y4
				cap n estadd ysumm


				* Column 5: BAC1+interaction controls
				cap n reg recidivism dui bac1_c interaction  male  white aged  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y5
				cap n estadd ysumm
				
				* Column 6: BAC1+interaction+interactionsq controls
				cap n reg recidivism dui bac1_c bac1_sq interaction interaction_sq  male  white aged  if (bac1>0.03 & bac1<0.13), robust
				cap n estimates store y6
				cap n estadd ysumm
				
				
#delimit ;
	cap n estout * using ./Q7_hw4_a.tex,
		style(tex) label notype
		cells((b(star fmt(%9.3f))) (se(fmt(%9.3f)par))) 		
		stats(N ymean,
			labels("N" "Mean of dependent variable")
			fmt(%9.0fc %9.2fc 2))
			drop(_cons white male aged) 
			replace noabbrev starlevels(* 0.10 ** 0.05 *** 0.01) 
			title(Regression Discontinuity Estimates for the Effect of Exceeding BAC Thresholds on Recidivism)   
			collabels(none) eqlabels(none) mlabels(none) mgroups(none) substitute(_ \_)
			prehead("\begin{table}[htbp]\centering" "\small" "\caption{@title}" "\begin{center}" "\begin{threeparttable}" "\begin{tabular}{l*{@E}{c}}"
	"\toprule"
	"\multicolumn{1}{l}{\textit{Dependent var: Recidivism }}&"
	"\multicolumn{1}{c}{\textit{(1)}}&"
	"\multicolumn{1}{c}{\textit{(2)}}&"
	"\multicolumn{1}{c}{\textit{(3)}}&"
	"\multicolumn{1}{c}{\textit{(4)}}&"
	"\multicolumn{1}{c}{\textit{(5)}}&"
	"\multicolumn{1}{c}{\textit{(6)}}\\")
		posthead("\midrule")
		prefoot("\midrule")  
		postfoot("\bottomrule" "\end{tabular}" "\begin{tablenotes}" "\tiny" "\item This table contains regression discontinuity based estimates of the effect of having BAC above the legal thresholds on predetermined  drivers characteristics based on Hansen (2015). Panel A contains observations with BAC +/-0.5 around the cutoff. Panel B contains observations with BAC +/-0.25 around the cutoff.   Heteroskedastic standard errors shown in parenthesis.  * p$<$0.10, ** p$<$0.05, *** p$<$0.01" "\end{tablenotes}" "\end{threeparttable}" "\end{center}" "\end{table}");
#delimit cr
	cap n estimates clear

	
	
	***TABLE 2: parte b
	
				cap n tempvar tempsample
				cap n local specname=`specname'+1

				* Column 1: BAC1
				cap n reg recidivism dui bac1_c  if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y1
				cap n estadd ysumm


				* Column 2: BAC1+interaction
				cap n reg recidivism dui bac1_c interaction  if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y2
				cap n estadd ysumm
				
				* Column 3: BAC1+interaction+interactionsq
				cap n reg recidivism dui bac1_c bac1_sq interaction interaction_sq  if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y3
				cap n estadd ysumm
				
				* Column 4: BAC1 controls
				cap n reg recidivism dui bac1_c  male  white aged if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y4
				cap n estadd ysumm

 
				* Column 5: BAC1+interaction controls
				cap n reg recidivism dui bac1_c interaction  male  white aged if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y5
				cap n estadd ysumm
				
				* Column 6: BAC1+interaction+interactionsq controls
				cap n reg recidivism dui bac1_c bac1_sq interaction interaction_sq  male  white aged  if (bac1>0.055 & bac1<0.105), robust
				cap n estimates store y6
				cap n estadd ysumm		

#delimit ;
	cap n estout * using ./Q7_hw4_b.tex,
		style(tex) label notype
		cells((b(star fmt(%9.3f))) (se(fmt(%9.3f)par))) 		
		stats(N ymean,
			labels("N" "Mean of dependent variable")
			fmt(%9.0fc %9.2fc 2))
			drop(_cons male white aged) 
			replace noabbrev starlevels(* 0.10 ** 0.05 *** 0.01) 
			title(Regression Discontinuity Estimates for the Effect of Exceeding BAC Thresholds on Recidivism)   
			collabels(none) eqlabels(none) mlabels(none) mgroups(none) substitute(_ \_)
			prehead("\begin{table}[htbp]\centering" "\small" "\caption{@title}" "\begin{center}" "\begin{threeparttable}" "\begin{tabular}{l*{@E}{c}}"
	"\toprule"
	"\multicolumn{1}{l}{\textit{Dependent var: }}&"
	"\multicolumn{1}{c}{\textit{(1)}}&"
	"\multicolumn{1}{c}{\textit{(2)}}&"
	"\multicolumn{1}{c}{\textit{(3)}}&"
	"\multicolumn{1}{c}{\textit{(4)}}&"
	"\multicolumn{1}{c}{\textit{(5)}}&"
	"\multicolumn{1}{c}{\textit{(6)}}\\")
		posthead("\midrule")
		prefoot("\midrule")  
		postfoot("\bottomrule" "\end{tabular}" "\begin{tablenotes}" "\tiny" "\item This table contains regression discontinuity based estimates of the effect of having BAC above the legal thresholds on recidivism based on Hansen (2015). Panel A contains observations with BAC +/-0.5 around the cutoff. Panel B contains observations with BAC +/-0.25 around the cutoff. Heteroskedastic standard errors shown in parenthesis.  * p$<$0.10, ** p$<$0.05, *** p$<$0.01" "\end{tablenotes}" "\end{threeparttable}" "\end{center}" "\end{table}");
#delimit cr
	cap n estimates clear
