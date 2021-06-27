/* Read in icecream data */
%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/iitauma0/my_shared_file_links/iitauma0/data/icecream.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.myicecream;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.myicecream; RUN;


%web_open_table(WORK.IMPORT);


/* Summarize data */

ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.MYICECREAM chartype mean std min max vardef=df skewness 
		kurtosis q1 q3 qmethod=os;
	var cons income price temp;
run;

proc univariate data=WORK.MYICECREAM vardef=df noprint;
	var cons income price temp;
	histogram cons income price temp;
run;


/* Run simple linear regression */

ods noproctitle;
ods graphics / imagemap=on;

proc reg data=WORK.MYICECREAM alpha=0.05 plots(only)=(diagnostics residuals 
		fitplot observedbypredicted);
	model cons=temp /;
	run;
quit;



ods noproctitle;
ods graphics / imagemap=on;

proc reg data=WORK.MYICECREAM alpha=0.05 plots=none;
	model cons=temp / cli;
	run;
quit;