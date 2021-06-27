/* Read data */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/iitauma0/my_shared_file_links/iitauma0/data/Real_Estate_Sample.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.myrealestate;
	GETNAMES=YES;
RUN;


%web_open_table(WORK.IMPORT);


/* Summarize data */

ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.MYREALESTATE chartype mean std min max vardef=df q1 q3 
		qmethod=os;
	var Price 'Living area'n bedrooms bathrooms year garage;
run;


ods noproctitle;
ods graphics / imagemap=on;

proc corr data=WORK.MYREALESTATE pearson nosimple noprob plots=matrix(histogram 
		nvar=4);
	var Price bathrooms year garage;
run;


/* Pairwise scatter plot */
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=WORK.MYREALESTATE pearson nosimple noprob plots=matrix(histogram 
		nvar=6 nwith=6);
	var 'Living area'n bedrooms bathrooms year garage;
	with Price;
run;


/* Run multiple regression */

ods noproctitle;
ods graphics / imagemap=on;

proc reg data=WORK.MYREALESTATE alpha=0.05 plots=none;
	model Price='Living area'n bedrooms bathrooms year garage /;
	run;
quit;