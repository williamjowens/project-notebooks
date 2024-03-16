/* Reading in the Data */
libname sasdata '/home/u63442611/my_courses/ANA625' inencoding='latin1';
data yrbs; set sasdata.yrbs2021; run;


/* View the data */
proc print data=yrbs (obs=100); run;
proc contents data=yrbs; run;



/*Create SUICIDE_ATTEMPT variable */
data yrbs;
    set yrbs;
    
    /* Initialize the variable */
    SUICIDE_ATTEMPT = .;

    /* Check for missing values first */
    if QN26 = . or QN27 = . or QN28 = . or QN29 = . then SUICIDE_ATTEMPT = .;
    else if QN26 = 2 and QN27 = 2 and QN28 = 2 and QN29 = 2 then SUICIDE_ATTEMPT = 0;
    else if QN28 = 1 or QN29 = 1 then SUICIDE_ATTEMPT = 1;
    else if QN26 = 1 or QN27 = 1 then SUICIDE_ATTEMPT = 0;
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var QN26 QN27 QN28 QN29 SUICIDE_ATTEMPT;
run;


/* Frequencies */
proc freq data=yrbs;
	tables SUICIDE_ATTEMPT / missing nocum nopercent;
run;



/* Create BULLIED variable */
data yrbs;
    set yrbs;
    
    /* Initialize the variable */
    BULLIED = .;

    /* Check for "yes" responses first */
    if QN23 = 1 or QN24 = 1 then BULLIED = 1;
    else if QN23 = 2 and QN24 = 2 then BULLIED = 0;
    else if (QN23 = 2 and QN24 = .) or (QN23 = . and QN24 = 2) then BULLIED = .;
    else if QN23 = . and QN24 = . then BULLIED = .; /* set as missing if both are missing */
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var QN23 QN24 BULLIED;
run;


/* Frequencies */
proc freq data=yrbs;
	tables BULLIED / missing nocum nopercent;
run;



/* BD_FREQ variable creation was not working, so let's view its format */
proc contents data=yrbs; run;


/* What are the underlying values being reformatted for BD_FREQ? */
proc print data=yrbs (obs=200);
    var Q42;
    format Q42 $1.;  /* Temporarily remove the format */
run;


/* Create BD_FREQ (Binge Drinking Frequency) variable */
data yrbs;
    set yrbs;
    
    /* Create the variable based on QN42 */
    if Q42 in('1', '2', '3') then BD_FREQ = 1;
    else if Q42 in('4') then BD_FREQ = 2;
    else if Q42 in('5', '6', '7') then BD_FREQ = 3;
    else BD_FREQ = .;
run;
	
	
/* View variables */
proc print data=yrbs (firstobs=1 obs=300);
	var Q42 BD_FREQ;
run;


/* Frequencies */
proc freq data=yrbs;
	tables BD_FREQ / missing nocum nopercent;
run;



/* Create HARD_DRUG variable */
data yrbs;
    set yrbs;
    
    /* Initialize the variable */
    HARD_DRUG = .;

    /* Check for "yes" responses first */
    if QN50 = 1 or QN52 = 1 or QN53 = 1 then 
        HARD_DRUG = 1;
    else if QN50 = 2 and QN52 = 2 and QN53 = 2 then 
        HARD_DRUG = 0;
    else if (QN50 = 2 or QN50 = .) and (QN52 = 2 or QN52 = .) and (QN53 = 2 or QN53 = .) then 
        HARD_DRUG = .; /* set as missing if there's a mix of "no" and missing responses without a "yes" in any variable */
run;

	
/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var QN50 QN52 QN53 HARD_DRUG;
run;


/* Frequencies */
proc freq data=yrbs;
	tables HARD_DRUG / missing nocum nopercent;
run;



/* GRADE variable creation was not working, so let's view its format */
proc contents data=yrbs; run;


/* What are the underlying values being reformatted for GRADE? */
proc print data=yrbs (obs=200);
    var Q3;
    format Q3 $1.;  /* Temporarily remove the format */
run;



/* Create GRADE variable */
data yrbs;
	set yrbs;

    /* Adjust conditions based on character numbers */
    if Q3 = '1' then GRADE = 1;
    else if Q3 = '2' then GRADE = 2;
    else if Q3 = '3' then GRADE = 3;
    else if Q3 = '4' then GRADE = 4;
    else GRADE = .;  /* Default to missing for other or empty values */
run;

	
/* View variables */
proc print data=yrbs (firstobs=1 obs=200);
	var Q3 GRADE;
run;


/* Frequencies */
proc freq data=yrbs;
	tables GRADE / missing nocum nopercent;
run;



/* SEX variable creation was not working, so let's view its format */
proc contents data=yrbs; run;


/* What are the underlying values being reformatted for SEX? */
proc print data=yrbs (obs=200);
    var Q2;
    format Q2 $1.;  /* Temporarily remove the format */
run;



/* Create SEX variable */
data yrbs;
	set yrbs;
	
	if Q2 = 1 then SEX = 1;
	else if Q2 = 2 then SEX = 0;
	else SEX = .;
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var Q2 SEX;
run;


/* Frequencies */
proc freq data=yrbs;
	tables SEX / missing nocum nopercent;
run;



/* Create SEXUAL_VIOLENCE variable */
data yrbs;
    set yrbs;
    
    /* Initialize the variable */
    SEXUAL_VIOLENCE = .;

    /* Check for "yes" responses first */
    if QN19 = 1 or QN20 = 1 or QN21 = 1 then 
        SEXUAL_VIOLENCE = 1;
    else if (QN19 = 2 or QN19 = .) and (QN20 = 2 or QN20 = .) and (QN21 = 2 or QN21 = .) then 
        SEXUAL_VIOLENCE = 0;
    else 
        SEXUAL_VIOLENCE = .; /* set as missing if uncertain */
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var QN19 QN20 QN21 SEXUAL_VIOLENCE;
run;


/* Frequencies */
proc freq data=yrbs;
	tables QN19 QN20 QN21 SEXUAL_VIOLENCE / missing nocum nopercent;
run;



/* WEIGHT_PERCEPTION variable creation was not working, so let's view its format */
proc contents data=yrbs; run;


/* What are the underlying values being reformatted for WEIGHT_PERCEPTION? */
proc print data=yrbs (obs=200);
    var Q66;
    format Q66 $1.;  /* Temporarily remove the format */
run;


/* Unique Values */
data yrbs; set yrbs;
	proc freq data=yrbs;
	tables Q66 / nocum nopercent;
run;


/* Create WEIGHT_PERCEPTION variable */
data yrbs; set yrbs;

    /* Adjust conditions based on the numeric values of Q66 */
    if Q66 = '1' then WEIGHT_PERCEPTION = 1;      /* 'Very underweight' */
    else if Q66 = '2' then WEIGHT_PERCEPTION = 1; /* 'Slightly underweight' */
    else if Q66 = '3' then WEIGHT_PERCEPTION = 2; /* 'About the right weight' */
    else if Q66 = '4' then WEIGHT_PERCEPTION = 3; /* 'Slightly overweight' */
    else if Q66 = '5' then WEIGHT_PERCEPTION = 3; /* 'Very overweight' */
    else WEIGHT_PERCEPTION = .;
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=100);
	var Q66 WEIGHT_PERCEPTION;
run;


/* Frequencies */
proc freq data=yrbs;
	tables Q66 WEIGHT_PERCEPTION / missing nocum nopercent;
run;



/* Data Filtering */
data yrbs;
	set yrbs;
	
	where SEX in(0,1) and SUICIDE_ATTEMPT in(0,1) and BULLIED in(0,1) and BD_FREQ in(1,2,3) 
		and HARD_DRUG in(0,1) and SEXUAL_VIOLENCE in(0,1);
run;


/* Data Structure */
proc contents data=yrbs; run;


/* Data Distributions */
proc freq data=yrbs;
    tables SEX SUICIDE_ATTEMPT BULLIED BD_FREQ
    	HARD_DRUG SEXUAL_VIOLENCE / missing nocum nopercent;
run;



/* Save prepared dataset */
data sasdata.yrbs_final; set yrbs; run;


/**-----------------------------------------------------------------------------**/


/* Read in saved data */
libname sasdata '/home/u63442611/my_courses/ANA625' inencoding='latin1';
data yrbs; set sasdata.yrbs_final; run;



/* View data */
proc print data=yrbs (obs=100); run;
proc contents data=yrbs; run;


/* Data Distributions */
proc freq data=yrbs;
    tables SEX SUICIDE_ATTEMPT BULLIED BD_FREQ
    	HARD_DRUG SEXUAL_VIOLENCE / missing nocum nopercent;
run;


/* View variables */
proc print data=yrbs (firstobs=1 obs=1000);
	var SUICIDE_ATTEMPT BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE;
run;


/* Frequencies */
proc freq data=yrbs;
	tables SUICIDE_ATTEMPT BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / missing nocum nopercent;
run;


/**-----------------------------------------------------------------------------**/


/* SUICIDE_ATTEMPT by BULLIED */
proc freq data=yrbs;
	tables BULLIED*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk
	plots=mosaicplot cmh;
run;


/* SUICIDE_ATTEMPT by BULLIED stratified by SEX */
proc freq data=yrbs;
	tables SEX*BULLIED*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk
	plots=mosaicplot cmh;
run;


/* SUICIDE_ATTEMPT by BULLIED stratified by BD_FREQ */
proc freq data=yrbs;
	tables BD_FREQ*BULLIED*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk
	plots=mosaicplot cmh;
run;


/* SUICIDE_ATTEMPT by BULLIED stratified by HARD_DRUG */
proc freq data=yrbs;
	tables HARD_DRUG*BULLIED*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk
	plots=mosaicplot cmh;
run;


/* SUICIDE_ATTEMPT by BULLIED stratified by SEXUAL_VIOLENCE */
proc freq data=yrbs;
	tables SEXUAL_VIOLENCE*BULLIED*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk
	plots=mosaicplot cmh;
run;


/**-----------------------------------------------------------------------------**/


/* Table 1: Control Variables by Exposure */
proc freq data=yrbs;
	tables (SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE)*BULLIED / nopercent norow nocol chisq relrisk;
run;



/* Table 2: Unadjusted Control and Exposure by Outcome */
proc freq data=yrbs;
	tables (BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE)*SUICIDE_ATTEMPT / nopercent norow nocol chisq relrisk;
run;


/* Table 3: Maximum Likelihood and Odds Ratio Estimates */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;


/**-----------------------------------------------------------------------------**/


/* Unsaturated (Main Effects) Model */
proc logistic data=yrbs plots(only)=roc;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;


/* Fully Saturated Model */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED | SEX | BD_FREQ | HARD_DRUG | SEXUAL_VIOLENCE / aggregate scale=none lackfit;
run;


/* Complex Model with Two-Way Interactions */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED | SEX | BD_FREQ | HARD_DRUG | SEXUAL_VIOLENCE @2/ aggregate scale=none lackfit;
run;


/* Complex Model with Two-Way Interactions */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*HARD_DRUG BULLIED*SEXUAL_VIOLENCE
                            SEX*BD_FREQ SEX*HARD_DRUG SEX*SEXUAL_VIOLENCE
                            BD_FREQ*HARD_DRUG BD_FREQ*SEXUAL_VIOLENCE
                            HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit;
run;


/**-----------------------------------------------------------------------------**/


/* Parameter Summary Macro */
%macro param_summary(data, dependent, independents);
	
	/* Run logistic regression and capture parameter estimates */
	ods output ParameterEstimates=param_estimates;
	proc logistic data=&data;
		class &dependent(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
		model &dependent = &independents / aggregate scale=none lackfit;
	run;
	ods output close;
	
	/* Process the captured parameter estimates */
	data _pe (keep=variable estimate probchisq);
		set param_estimates;
	run;
	
	/* Sort by p-values */
	proc sort data=_pe;
		by descending probchisq;
	run;
	
	/* Print the sorted dataset */
	proc print data=_pe; run;
	
%mend param_summary;


/**-----------------------------------------------------------------------------**/


/* Run 1 */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*HARD_DRUG BULLIED*SEXUAL_VIOLENCE
                            SEX*BD_FREQ SEX*HARD_DRUG SEX*SEXUAL_VIOLENCE
                            BD_FREQ*HARD_DRUG BD_FREQ*SEXUAL_VIOLENCE
                            HARD_DRUG*SEXUAL_VIOLENCE);
                            
                            
/* Run 2 - Omit BULLIED*HARD_DRUG */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*SEXUAL_VIOLENCE
                            SEX*BD_FREQ SEX*HARD_DRUG SEX*SEXUAL_VIOLENCE
                            BD_FREQ*HARD_DRUG BD_FREQ*SEXUAL_VIOLENCE
                            HARD_DRUG*SEXUAL_VIOLENCE);
                            
                            
/* Run 3 - Omit BD_FREQ*SEXUAL_VIOLENCE */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*SEXUAL_VIOLENCE
                            SEX*BD_FREQ SEX*HARD_DRUG SEX*SEXUAL_VIOLENCE
                            BD_FREQ*HARD_DRUG
                            HARD_DRUG*SEXUAL_VIOLENCE);
         
                                       
/* Run 4 - Omit SEX*SEXUAL_VIOLENCE */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*SEXUAL_VIOLENCE
                            SEX*BD_FREQ SEX*HARD_DRUG
                            BD_FREQ*HARD_DRUG
                            HARD_DRUG*SEXUAL_VIOLENCE);

                           
/* Run 5 - Omit SEX*BD_FREQ */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*BD_FREQ BULLIED*SEXUAL_VIOLENCE
                            SEX*HARD_DRUG
                            BD_FREQ*HARD_DRUG
                            HARD_DRUG*SEXUAL_VIOLENCE);
                            
                            
/* Run 6 - Omit BULLIED*BD_FREQ */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*SEXUAL_VIOLENCE
                            SEX*HARD_DRUG
                            BD_FREQ*HARD_DRUG
                            HARD_DRUG*SEXUAL_VIOLENCE);
                            
                            
/* Run 7 - Omit BD_FREQ*HARD_DRUG */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*SEXUAL_VIOLENCE
                            SEX*HARD_DRUG
                            HARD_DRUG*SEXUAL_VIOLENCE);
                            
                            
/* Run 8 - Omit SEX*HARD_DRUG */
%param_summary(data=yrbs, dependent=SUICIDE_ATTEMPT, independents=BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE 
                            BULLIED*SEX BULLIED*SEXUAL_VIOLENCE
                            HARD_DRUG*SEXUAL_VIOLENCE);


/**-----------------------------------------------------------------------------**/


/* Unsaturated (Main Effects) Model */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;


/* Final Model - Insignificant Interactions Removed */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;


/**-----------------------------------------------------------------------------**/


/* Odds Ratios for all possible combinations of the profiles */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=glm;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	lsmeans BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / oddsratio diff;
run;


/* Odds Ratios for exposure-control interactions */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	oddsratio BULLIED / at(SEX='0' '1');
	oddsratio BULLIED / at(SEXUAL_VIOLENCE='0' '1');
run;


/* Odds Ratios for exposure-focused interactions */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	oddsratio BULLIED / at(SEX='0' '1' SEXUAL_VIOLENCE='0' '1');
run;


/* Odds Ratios for control-focused interactions */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	oddsratio HARD_DRUG / at(SEXUAL_VIOLENCE='0' '1');
run;


proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	oddsratio SEXUAL_VIOLENCE / at(BULLIED='0' '1' HARD_DRUG='0' '1');
run;


proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
	oddsratio SEX / at(BULLIED='0' '1');
run;


/**-----------------------------------------------------------------------------**/


/* ROC Comparison */
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE
		BULLIED*SEX BULLIED*SEXUAL_VIOLENCE HARD_DRUG*SEXUAL_VIOLENCE;
	roc 'Main Effects' BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE;
	roccontrast / estimate = allpairs;
run;


/**-----------------------------------------------------------------------------**/


/* Unsaturated (Main Effects) Model */
ods output OddsRatios=Main_Effects_OR;
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;
ods output close;


data BULLIED_OR_Base;
	set Main_Effects_OR (obs=1);
run;

proc print data=BULLIED_OR_Base; run;


/* Test for SEX Confounding */
ods output OddsRatios=SEX_Removed_OR;
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED BD_FREQ HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;
ods output close;


data BULLIED_OR_SEX_Removed;
	set SEX_Removed_OR (obs=1);
run;

proc print data=BULLIED_OR_SEX_Removed; run;


/* Test for BD_FREQ Confounding */
ods output OddsRatios=BD_FREQ_Removed_OR;
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') HARD_DRUG(ref='0') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX HARD_DRUG SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;
ods output close;


data BULLIED_OR_BD_FREQ_Removed;
	set BD_FREQ_Removed_OR (obs=1);
run;

proc print data=BULLIED_OR_BD_FREQ_Removed; run;


/* Test for HARD_DRUG Confounding */
ods output OddsRatios=HARD_DRUG_Removed_OR;
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') SEXUAL_VIOLENCE(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ SEXUAL_VIOLENCE / aggregate scale=none lackfit rsq;
run;
ods output close;


data BULLIED_OR_HARD_DRUG_Removed;
	set HARD_DRUG_Removed_OR (obs=1);
run;

proc print data=BULLIED_OR_HARD_DRUG_Removed; run;


/* Test for SEXUAL_VIOLENCE Confounding */
ods output OddsRatios=SEXUAL_VIOLENCE_Removed_OR;
proc logistic data=yrbs;
	class SUICIDE_ATTEMPT(ref='0') BULLIED(ref='0') SEX(ref='0') BD_FREQ(ref='1') HARD_DRUG(ref='0') / param=ref;
	model SUICIDE_ATTEMPT = BULLIED SEX BD_FREQ HARD_DRUG / aggregate scale=none lackfit rsq;
run;
ods output close;


data BULLIED_OR_SV_Removed;
	set SEXUAL_VIOLENCE_Removed_OR (obs=1);
run;

proc print data=BULLIED_OR_SV_Removed; run;



/* Extract OR for BULLIED from Main Effects Model */
data OR_Values;
    set BULLIED_OR_Base;
    Base_OR = OddsRatioEst;
    output;

    /* Extract OR for BULLIED from SEX removed model */
    set BULLIED_OR_SEX_Removed;
    SEX_Rem_OR = OddsRatioEst;
    output;

    /* Extract OR for BULLIED from BD_FREQ removed model */
    set BULLIED_OR_BD_FREQ_Removed;
    BD_FREQ_Rem_OR = OddsRatioEst;
    output;

    /* Extract OR for BULLIED from HARD_DRUG removed model */
    set BULLIED_OR_HARD_DRUG_Removed;
    HARD_DRUG_Rem_OR = OddsRatioEst;
    output;

    /* Extract OR for BULLIED from SEXUAL_VIOLENCE removed model */
    set BULLIED_OR_SV_Removed;
    SV_Rem_OR = OddsRatioEst;
    output;
run;

/* Calculate Percentage Differences */
data percent_diff;
    set OR_Values;

    percent_diff_SEX = ((SEX_Rem_OR - Base_OR) / Base_OR) * 100;
    percent_diff_BD_FREQ = ((BD_FREQ_Rem_OR - Base_OR) / Base_OR) * 100;
    percent_diff_HARD_DRUG = ((HARD_DRUG_Rem_OR - Base_OR) / Base_OR) * 100;
    percent_diff_SV = ((SV_Rem_OR - Base_OR) / Base_OR) * 100;
    
    keep percent_diff_SEX percent_diff_BD_FREQ percent_diff_HARD_DRUG percent_diff_SV;
run;

/* Print the results */
proc print data=percent_diff (firstobs=5 obs=5); run;



/* Nicer formatting */
proc format;
    /* Create a custom format for percentage differences */
    picture percentfmt (round)
        low-<0='0009.999%-'
        0='0.000%'
        0-high='0009.999%';
run;

%macro printReport;
proc report data=percent_diff (firstobs=5 obs=5) nowd;
    /* Column definitions and formatting */
    column percent_diff_SEX percent_diff_BD_FREQ percent_diff_HARD_DRUG percent_diff_SV;

    /* Define header names and format */
    define percent_diff_SEX / 'Difference (SEX)' format=percentfmt. center;
    define percent_diff_BD_FREQ / 'Difference (BD FREQ)' format=percentfmt. center;
    define percent_diff_HARD_DRUG / 'Difference (HARD DRUG)' format=percentfmt. center;
    define percent_diff_SV / 'Difference (SEXUAL VIOLENCE)' format=percentfmt. center;

    /* Title for the report */
    title "Percentage Differences for OR Estimates";
run;
%mend printReport;


/* Call Macro to print report */
%printReport;


/**-----------------------------------------------------------------------------**/


/* Export original file to CSV */
proc export data=sasdata.yrbs2021
	outfile='/Users/williamjowens/Desktop/ANA 625/yrbs2021.csv'
	dbms=csv replace;
run;