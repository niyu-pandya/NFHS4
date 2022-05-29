*****************************************************************************************************************************
*   Project: NFHS-5 Analysis CHILD NUTRITION, Anuvaad 						 									  		    *
*   Task: Cleaning up file, adding variables for stunting, wasting, sam, overweight, underweight							*
*   Tip: Run after Macro, and before survey weights																			*
*   Authors: Niharika Pandya (Anuvaad) and Dr. Lindsay Jaacks (University of Edinburgh)										*
*   Date: 29 May 2022																										*
*   Last updated: 29 May 2022			   						             	    										*
*****************************************************************************************************************************
cls
clear all 

set maxvar 15000

/*Use the WHO survey files after running the macro*/
use "C:\Users\v1npandy\Documents\WHO_igrowup_workdata\mysurvey_z_rc.dta"
 
gen stunting = . 
	replace stunting = 2 if _zlen <= -2 
	replace stunting = 1 if _zlen >= -2 
	replace stunting = . if _zlen == . 
		label define yesno 2 "Yes" 1 "No"
		label value stunting "yesno"
		label var stunting "Stunting yes no"
tab stunting 

gen wasting = . 
	replace wasting = 2 if _zwfl <= -2 
	replace wasting = 1 if _zwfl >= -2 
	replace wasting = . if _zwfl == .
		label value wasting "yesno"
		label var wasting "Wasting yes no"
tab wasting 

gen underweight = . 
	replace underweight = 2 if _zwei <= -2 
	replace underweight = 1 if _zwei >= -2 
	replace underweight = . if _zwei == . 
		label value underweight "yesno"
		label var underweight "Underweight yes no"
tab underweight 

gen overweight = . 
	replace overweight = 2 if _zwfl >= 2 & _zwfl <= 3
	replace overweight = 3 if _zwfl >= 3 
	replace overweight = 1 if _zwfl <= 2
	replace overweight = . if _zwfl == . 
		label define overweight_cat 2 "Overweight" 3 "Obese" 1 "None"
		label value overweight "overweight_cat"
		label var overweight "Overweight or obese yes no"
tab overweight 

gen sam = . /*check with Lindsay if this is right, the numbers seem too high*/
	replace sam = 2 if _zlen <= -3 | _zwfl <= -3 | _zwei <= -3 
	replace sam = 1 if _zlen >= -3 & _zwfl >= -3 & _zwei >= -3
	replace sam = . if _zlen == . & _zwfl == . & _zwei == .
		label value sam "yesno"
		label var sam "SAM yes no"
tab sam 
		
/*Doing this for the survey set*/
gen educat = . 
	replace educat = 1 if mom_edu == 0
	replace educat = 2 if mom_edu == 1
	replace educat = 3 if mom_edu == 2
	replace educat = 4 if mom_edu == 3
		label define educat 1 "no education" 2 "primary" 3 "secondary" 4 "higher" 
		label values educat "educat"
		label variable educat "Highest educational level"

gen nfhssurvey = 1
		
/*Dropping vars not needed in the survey files*/		
drop reflib datalib reflib temp_measure 

save "C:\Users\v1npandy\Documents\WHO_igrowup_workdata\mysurvey_z_rc_ChildCleaned_29052022.dta", replace
