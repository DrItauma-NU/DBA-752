/* Fitting Least-Squares Regression in SAS, Example Case Study */
/* Read in Icecream data */
data icecream;
	infile "/home/iitauma0/my_shared_file_links/iitauma0/data/icecream.csv" DSD 
		MISSOVER FIRSTOBS=2;
	input cons income price temp;
run;

/* Summarize data */
/* Use the Summary Statistics Task to generate the code */
ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.ICECREAM chartype mean std min max n vardef=df;
	var cons income price temp;
run;

proc univariate data=WORK.ICECREAM vardef=df noprint;
	var cons income price temp;
	histogram cons income price temp / normal(noprint) kernel;
	inset mean std min max n / position=nw;
run;

/* Plot consumption versus temperature */
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ICECREAM;
	title height=14pt "Ice Cream Consumption and Outside Temperature";
	scatter x=temp y=cons /;
	xaxis grid label="Temperature (deg F)";
	yaxis grid label="Consumption of Ice Cream per head (in pints)";
run;

ods graphics / reset;
title;

/* Plot consumption versus temperature with a line of best fit */
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.ICECREAM;
	title height=14pt "Ice Cream Consumption and Outside Temperature";
	reg x=temp y=cons / nomarkers;
	scatter x=temp y=cons /;
	xaxis grid label="Temperature (deg F)";
	yaxis grid label="Consumption of Ice Cream per head (in pints)";
run;

ods graphics / reset;
title;

/* Run regression */
ods noproctitle;
ods graphics / imagemap=on;

proc genmod data=WORK.ICECREAM plots=none;
	model cons=temp / dist=normal;
run;

/* General linear model */
proc GLM;
	model cons=temp;
	
	
	
	
ods rtf file="/home/iitauma0/my_shared_file_links/iitauma0/result/LinearRegressionReport.rtf" style=Journal;

ods noproctitle;
ods graphics / imagemap=on;

proc genmod data=WORK.ICECREAM plots=none;
	model cons=temp / dist=normal;
run;


ods proctitle;
ods rtf close;