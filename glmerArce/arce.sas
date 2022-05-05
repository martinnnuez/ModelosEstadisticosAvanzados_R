/*
---------------------------------------------------------------------------
Short description
---------------------------------------------------------------------------
Data on tree growth used in the Case Study published in the September, 1995
issue of the Canadian Journal of Statistics

---------------------------------------------------------------------------
Permission
---------------------------------------------------------------------------
This data set was been provided by Dr. Fernando Camacho, 
Ontario Hydro Technologies, 800 Kipling Ave, Toronto Canada M3Z 5S4. 
It forms the basis of the Case Study in Data Analysis published in
the Canadian Journal of Statistics, September 1995.
It can be freely used for non-commercial purposes, as long as proper
acknowledgement to the source and to the Canadian Journal of Statistics
is made.


*/

PROC GENMOD;
CLASS TRATAM TREE;
MODEL NUM_INT=TRATAM /DIST=POI LINK=LOG TYPE3 ; 
REPEATED SUBJECT=TREE /TYPE=EXCH ;
LSMEANS TRATAM / PDIFF;
RUN;
PROC GENMOD;
CLASS TRATAM TREE;
MODEL NUM_INT=TRATAM /DIST=NEGBIN LINK=LOG TYPE3 ; 
REPEATED SUBJECT=TREE /TYPE=EXCH ;
LSMEANS TRATAM / PDIFF;
RUN;


proc sort;
by tree;
proc nlmixed data=trees qpoints=100;
parms b0=1.7  bc=0  bcm=0.25   bp2=-0.17   be2=-0.36   be4=-0.3     logsu=2;
media=exp(b0+u+bc*treatc+bcm*treatcm+bp2*treatp2+be2*treate2+be4*treate4);
model num_int ~ Poisson(media);
random u ~ N(0,exp(2*logsu)) subject=tree;
contrast 'bc vs. bcm' bc-bcm;
contrast 'bc vs. p 20' bc-bp2;
contrast 'bc vs. p4' bc;
contrast 'bc vs. e2' bc-be2;
contrast 'bc vs. e4' bc-be4;
contrast 'bcm vs. p 20' bcm-bp2;
contrast 'bcm vs. p4' bcm;
contrast 'bcm vs. e2' bcm-be2;
contrast 'bcm vs. e4' bcm-be4;
contrast 'p20 vs. p4' bp2;
contrast 'p20 vs. e2' bp2-be2;
contrast 'p20 vs. e4' bp2-be4;
contrast 'p4 vs. e2' be2;
contrast 'p4 vs. e4' be4;
contrast 'e2 vs. e4' be2-be4;
run;

ods rtf close;