#!/bin/bash

REF1=chm13-oneline.fa

for ERROR in 0.98 0.97 0.96 0.95 0.94 0.93 0.92 0.91 
do 
    echo "mapquikPLUS for simulated CLR reads with sequencing error rate $ERROR"
    time ./mapquikPLUS -p mapquikPLUS-$ERROR -t 11 --reference $REF1 simulated-chm13.10X.$ERROR.20kb.fa 
    ./k8 ./paftools.js mapeval mapquikPLUS-$ERROR.paf
done 
