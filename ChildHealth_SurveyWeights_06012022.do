*****************************************************************************************************************************
*   Project: NFHS-5 Analysis (CHILD HEALTH), Anuvaad						 									  		    *
*   Task: Survey Weights for NFHS-4 Child Health																			*
*	Authors: Niharika Pandya (Anuvaad) and Dr. Lindsay Jaacks (University of Edinburgh)										*
*   Date: 6 Jan 2022																										*
*	Last updated: 6 Jan 2022			   						             	    										*
*****************************************************************************************************************************

clear all
cls
use "C:\Users\v1npandy\Documents\WHO_igrowup_workdata\mysurvey_z_rc_ChildCleaned_06012022.dta", clear

*Set survey weights 
svyset [pweight=surveyweight], psu(cluster_no) strata(sample_strata) singleunit(centered)

/*cls
global catvartable1 stunting wasting overweight underweight anemia sam  
foreach var in $catvartable1 {
	svy, subpop(nfhssurvey): tab `var' sex, col pearson
	svy, subpop(nfhssurvey): tab `var' educat, col pearson  
}

cls
tab stunting
tab wasting
tab overweight
tab underweight 
tab anemia
tab sam
translate @Results NFHS4_Header.pdf, replace*/

/*cls
svy, subpop(nfhssurvey): proportion state
svy, subpop(nfhssurvey): proportion sex
svy, subpop(nfhssurvey): proportion educat
svy, subpop(nfhssurvey): proportion urban_rural
svy, subpop(nfhssurvey): proportion anemia
svy, subpop(nfhssurvey): proportion stunting
svy, subpop(nfhssurvey): proportion wasting
svy, subpop(nfhssurvey): proportion overweight
svy, subpop(nfhssurvey): proportion underweight
svy, subpop(nfhssurvey): proportion anemia
svy, subpop(nfhssurvey): proportion sam
translate @Results NFHS4_Adjusted_Weights.pdf, replace*/

putexcel set "NFHS4_Tabs_ChildHealth", sheet("NFHS4_ChildHealth_Tabs") replace

*Name table column headers
	putexcel B1=("Total"), bottom left bold font(timesnewroman, 11, black)
	putexcel B2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel C2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel D2=("UB"), bottom left	font(timesnewroman, 11, black)
	putexcel E1=("Sex Male"), bottom left bold font(timesnewroman, 11, black)
	putexcel E2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel F2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel G2=("UB"), bottom left font(timesnewroman, 11, black)
	putexcel H1=("Sex Female"), bottom left bold font(timesnewroman, 11, black)
	putexcel H2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel I2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel J2=("UB"), bottom left font(timesnewroman, 11, black)
	putexcel K1=("Education level 1"), bottom left bold font(timesnewroman, 11, black)
	putexcel K2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel L2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel M2=("UB"), bottom left	font(timesnewroman, 11, black)
	putexcel N1=("Education level 2"), bottom left bold font(timesnewroman, 11, black)
	putexcel N2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel O2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel P2=("UB"), bottom left	font(timesnewroman, 11, black)
	putexcel Q1=("Education level 3"), bottom left bold font(timesnewroman, 11, black)
	putexcel Q2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel R2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel S2=("UB"), bottom left font(timesnewroman, 11, black)
	putexcel T1=("Education level 4"), bottom left bold font(timesnewroman, 11, black)
	putexcel T2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel U2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel V2=("UB"), bottom left	font(timesnewroman, 11, black)
	putexcel W1=("Education level 8"), bottom left bold font(timesnewroman, 11, black)
	putexcel W2=("Weighted %"), bottom left font(timesnewroman, 11, black)
	putexcel X2=("LB"), bottom left font(timesnewroman, 11, black)
	putexcel Y2=("UB"), bottom left	font(timesnewroman, 11, black)

putexcel A4=("Anemia"), bottom left bold font(timesnewroman, 11, black)
local row=5	
	
foreach val in 1 2 3 4 { 
		foreach var in anemia {	
			
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
						
putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A10=("Stunting"), bottom left bold font(timesnewroman, 11, black)
local row=11

foreach val in 1 2 { 
		foreach var in stunting {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100


putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A14=("Wasting"), bottom left bold font(timesnewroman, 11, black)
local row=15

foreach val in 1 2 { 
		foreach var in wasting {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
			

putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A18=("Underweight"), bottom left bold font(timesnewroman, 11, black)
local row=19

foreach val in 1 2 { 
		foreach var in underweight {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100


putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A22=("SAM"), bottom left bold font(timesnewroman, 11, black)
local row=23

foreach val in 1 2 { 
		foreach var in sam {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
								

putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A26=("Overweight/Obese"), bottom left bold font(timesnewroman, 11, black)
local row=27

foreach val in 1 2 3 { 
		foreach var in overweight {	
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
						

putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A31=("Breasted within 1 hour"), bottom left bold font(timesnewroman, 11, black)
local row=32

foreach val in 1 2 { 
		foreach var in breastfed_1hr {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
			

putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"

putexcel A35=("Low birth weight"), bottom left bold font(timesnewroman, 11, black)
local row=36

foreach val in 1 2 { 
		foreach var in low_birthweight {	
			
		
			svy, subpop(nfhssurvey): prop `var'
		mat rtable = r(table) 
			mat `var'_tprop = rtable[1,`val']*100
			mat `var'_tlb = rtable[3,`val']*100
			mat `var'_tub = rtable[4,`val']*100
			
/*Sex*/
*male  = 1
svy, subpop(nfhssurvey if sex==1): prop `var'
		mat rtable = r(table) 
			mat `var'_0prop = rtable[1,`val']*100
			mat `var'_0lb = rtable[3,`val']*100
			mat `var'_0ub = rtable[4,`val']*100
		
*female = 2
svy, subpop(nfhssurvey if sex == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_1prop = rtable[1,`val']*100
			mat `var'_1lb = rtable[3,`val']*100
			mat `var'_1ub = rtable[4,`val']*100
		
*Mothers education status

svy, subpop(nfhssurvey if educat == 1): prop `var'
		mat rtable = r(table) 
			mat `var'_2prop = rtable[1,`val']*100
			mat `var'_2lb = rtable[3,`val']*100
			mat `var'_2ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 2): prop `var'
		mat rtable = r(table) 
			mat `var'_3prop = rtable[1,`val']*100
			mat `var'_3lb = rtable[3,`val']*100
			mat `var'_3ub = rtable[5,`val']*100
			
svy, subpop(nfhssurvey if educat == 3): prop `var'
		mat rtable = r(table) 
			mat `var'_4prop = rtable[1,`val']*100
			mat `var'_4lb = rtable[3,`val']*100
			mat `var'_4ub = rtable[4,`val']*100
		

svy, subpop(nfhssurvey if educat == 4): prop `var'
		mat rtable = r(table) 
			mat `var'_5prop = rtable[1,`val']*100
			mat `var'_5lb = rtable[3,`val']*100
			mat `var'_5ub = rtable[5,`val']*100
								

putexcel B`row'=matrix(`var'_tprop), nformat(#.0) font(timesnewroman, 11, black)
putexcel C`row'=matrix(`var'_tlb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black) 
putexcel D`row'=matrix(`var'_tub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel E`row'=matrix(`var'_0prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel F`row'=matrix(`var'_0lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)
putexcel G`row'=matrix(`var'_0ub), nformat(", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel H`row'=matrix(`var'_1prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel I`row'=matrix(`var'_1lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel J`row'=matrix(`var'_1ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel K`row'=matrix(`var'_2prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel L`row'=matrix(`var'_2lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel M`row'=matrix(`var'_2ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel N`row'=matrix(`var'_3prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel O`row'=matrix(`var'_3lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel P`row'=matrix(`var'_3ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel Q`row'=matrix(`var'_4prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel R`row'=matrix(`var'_4lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel S`row'=matrix(`var'_4ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
putexcel T`row'=matrix(`var'_5prop), nformat(#.0) font(timesnewroman, 11, black)
putexcel U`row'=matrix(`var'_5lb), nformat("(0.0;(-#.0") font(timesnewroman, 11, black)  
putexcel V`row'=matrix(`var'_5ub), nformat (", 0.0);, -0.0) ") font(timesnewroman, 11, black)
		}
		local ++row
	}
di "row is `row'"