*****************************************************************************************************************************
*   Project: NFHS-5 Analysis, Anuvaad 										 									  		    *
*   Task: Macros for NFHS-4 Child Health																					*
*   Tip: Run first, then clean up, then survey weights																		*
*	Authors: Niharika Pandya (Anuvaad) and Dr. Lindsay Jaacks (University of Edinburgh)										*
*   Date: 5 Jan 2022																										*
*	Last updated: 6 Jan 2022			   						             	    										*
*****************************************************************************************************************************
cls 
clear all 
/* Indicate to the Stata compiler where the igrowup_restricted.ado file is stored*/
adopath + "C:\Users\v1npandy\Documents\WHO_igrowup_STATA"

set maxvar 10000

/* Load the data file (BIRTH RECODE) */
use "C:\Users\v1npandy\OneDrive - University of Edinburgh\NFHS5\NFHS4_Data\BirthRecode\IABR74FL.DTA"

*Keeping only macro and survey weight related vars
keep caseid v001 v005 v022 v024 v025 v190 bord hw1 hw2 hw3 hw15 b4 hw57 v106 m34 m19 v414a-v414w v404 v409 v410 v411 v411a v412a v412c v413

*Fixing decimal vars 
replace v005 = v005*0.000001
replace hw2 = hw2*0.1
replace hw3 = hw3*0.1
replace m19 = m19*0.001

*Re-labelling headers and vars 
rename caseid id
rename v001 cluster_no
rename v005 surveyweight
rename v022 sample_strata
rename v024 state 
rename v025 urban_rural 
rename v190 wealth_index
rename bord birth_order
rename hw1 age
rename hw2 weight 
rename hw3 lenhei
rename hw15 temp_measure
rename b4 sex 
rename hw57 anemia 
rename v106 mom_edu
rename m34 time_breastfed
rename m19 birth_weight
rename v404 breastfeeding

label var id "case identification number"
label var surveyweight "household weight"
label var cluster_no "cluster number"
label var sample_strata "Sample strata"
label var state "state"
label var urban_rural "urban or rural residence"
label var age "child's age in months"
label var weight "child's weight in kg"
label var lenhei "child's height in cm"
label var sex "sex of child"
label var mom_edu "highest level of mothers education"
label var time_breastfed "when child put to breast"


*Adding vars for macro 

gen ageunit="months"
replace ageunit = " " if age==. 	
lab var ageunit "age unit: months"

gen measure = " "
replace measure = "L" if temp_measure == 1
replace measure = "S" if temp_measure == 2
replace measure = " " if temp_measure == 0 
label var measure "height: lying or standard"

gen oedema = . 


/* generate the first three parameters reflib, datalib & datalab	(CAN DROP THIS BIT)	*/
gen str60 reflib="C:\Users\v1npandy\Documents\WHO_igrowup_STATA"
lab var reflib "Directory of reference tables"

gen str60 datalib="C:\Users\v1npandy\Documents\WHO_igrowup_workdata" 
lab var datalib "Directory for datafiles"

gen str30 datalab="mysurvey" 
lab var datalab "Working file"

/*	check the variable for "sex"	1 = male, 2=female */
desc sex
tab sex

/*	check the variable for "age"	*/
desc age
summ age

/*	check the variable for body "weight" which must be in kilograms*/
desc weight 
summ weight

/* 	check the variable for "height" which must be in centimeters	*/ 
desc lenhei
summ lenhei

/*	check the variable for "measure"*/
desc measure
tab measure

/* 	check the variable for "oedema"*/
desc oedema
tab oedema

/*	check the variable for "sw" for the sampling weight*/
desc surveyweight
summ surveyweight

/* 	Fill in the macro parameters to run the command */
igrowup_restricted reflib datalib datalab sex age ageunit weight lenhei measure oedema surveyweight
