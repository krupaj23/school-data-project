LIBNAME project7 '/home/u63751945/myfolders/week7';
/*Problem1*/
DATA s2f;
	INFILE "/home/u63751945/myfolders/week7/school 2 final.csv" DSD FIRSTOBS=2;
	INPUT ClassID ChildID Gender $ ClassAge $ f1 f2 f3 f4;
RUN;
PROC PRINT DATA=s2f;
	TITLE "School 2 final";
RUN;
/*Q1:Use PROC UNIVARIATE to analyze the variables f1, f2, f3, f4. Which variable is 
normal? Which variable is right-skewed? Which variable is left-skewed?*/
PROC UNIVARIATE DATA=s2f normal;
	VAR f1 f2 f3 f4;
RUN;
/*Since the skewness value in the moments table is -0.404, this means this is not a 
normal distribution and it is left-skewed. They are all left-skewed but most is f2. 

/*Q2:Use PROC UNIVARIATE with option plot to graph the histogram,box-plot, and Normal 
Probability Plot for the variable f3. And only print the graphs.*/
ODS SELECT PLOTS;
PROC UNIVARIATE DATA=s2f PLOT;
	VAR f3;
RUN;

/*Q3:Add a new variable difference defined as difference=f4-f2. Analyze the variable 
difference and graph its histogram, Boxplot, qqplot. Print only the TestsNormality 
and TestsForLocation. Does the mean of the variable difference equal to 0 
statistically?*/
DATA q3;
SET S2f;
difference=f4-f2;
RUN;
ODS SELECT TestsForNormality TestsForLocation;
PROC UNIVARIATE DATA=q3 PLOT NORMAL;
	VAR difference;
RUN;
/*The mean of the variable difference is not statistically equal to 0*/
/*Q4:Use PROC UNIVARIATE to analyze the variable difference by Gender.*/
PROC SORT DATA=q3;
	BY Gender;
RUN;
PROC UNIVARIATE DATA=q3 PLOT NORMAL;
	BY Gender;
	VAR difference;
RUN;
/*Q5:For the variable difference, calculate custom percentiles from 5 to 100 by 5 and 
export these percentiles to an xlsx file named percentiles.xlsx.*/
proc univariate data=q3 noprint;
	var difference;
  output pctlpre=P_ pctlpts=5 to 100 by 5;
run;
PROC PRINT DATA = q3;
	TITLE "percentiles";
RUN;
/*Problem 2*/
/*Q1*/
DATA problem2;
	INPUT Section $ Test;
	DATALINES;
	A 65
	B 50
	A 68
	B 59
	A 75
	B 71
	A 78
	B 80
	A 70
	B 65
	;
RUN;
PROC TTEST DATA = problem2 SIDE=U;
CLASS Section;
VAR test;
RUN;
/*Since the p-value is greater than 0.05, you can reject the claim that section A is
 better than Section B. However, from comparing the statistics it seems that section A
 is better.*/
/*Q2*/
DATA p2q2;
	INPUT Before After;
	DATALINES;
	136.9 130.2
	201.4 180.7
	166.8 149.6
	150.0 153.2
	173.2 162.6
	169.3 160.1
	;
RUN;
PROC TTEST DATA= p2q2 SIDE=U;
PAIRED Before * After;
RUN;
/*There was a decrease because the p value is less than 0.05 being 0.0155 which means
you can fail to reject the null hypothesis of mean blood pressure decreasing after
training*/

/*Q3*/
DATA p3;
	INPUT Gender $ Series $ Count;
	DATALINES;
	Boys LoneR 50 
	Boys Sesam 30
	Boys Simps 20
	Girls LoneR 50
	Girls Sesam 80
	Girls Simps 70
	;
RUN;
PROC FREQ DATA= P3;
TABLES Gender * Series/chisq;
WEIGHT Count;
RUN;
/*Since the p value is less than 0.05 there is great difference in the preferences for
both boys and girls*/