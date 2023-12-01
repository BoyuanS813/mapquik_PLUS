#!/bin/bash

# Simulated CLR

REF1=chm13-one.fa
REF=chm13.fa

for ERROR in 0.95 0.90
do
    READS=simulated-chm13.10X.$ERROR.20kb 
    time ./mapquikPLUS -t 10 --reference $REF1 $READS -p mapquikPLUS.$ERROR.CLR
    paftools.js mapeval mapquikPLUS.$ERROR.CLR.paf

    time minimap2 --secondary no -t 10 -x map-pb $REF $READS > minimap2.$ERROR.CLR.paf
    paftools.js mapeval minimap2.$ERROR.CLR.paf

    time ./mm2-fast --secondary no -t 10 -x map-pb $REF $READS > mm2-fast.$ERROR.CLR.paf
    paftools.js mapeval mm2-fast.$ERROR.CLR.paf

    time blend --secondary no -t 10 -x map-pb $REF $READS > blend.$ERROR.CLR.paf
    paftools.js mapeval blend.$ERROR.CLR.paf

    time winnowmap -W repetitive_k15.txt --secondary no -t 10 -x map-pb $REF $READS > winnowmap.$ERROR.CLR.paf
    paftools.js mapeval winnowmap.$ERROR.CLR.paf
done 

# Simulated ONT

READS=simulated-ONT-chm13.10X_aligned_reads.fasta

time ./mapquikPLUS -t 10 --reference $REF1 $READS -p mapquikPLUS.simulated.ONT
awk '$12 == 60 {print}' mapquikPLUS.simulated.ONT.paf | wc -l
time minimap2 --sencondary no -t 10 -x map-pb $REF $READS> minimap2.simulated.ONT.paf 
awk '$12 == 60 {print}' minimap2.simulated.ONT.paf | wc -l
time mm2-fast --secondary no -t 10 -x map-pb $REF $READS> mm2-fast.simulated.ONT.paf
awk '$12 == 60 {print}' mm2-fast.simulated.ONT.paf | wc -l
time blend --secondary no -t 10 -x map-pb $REF $READS> blend.simulated.ONT.paf
awk '$12 == 60 {print}' blend.simulated.ONT.paf | wc -l
time winnowmap -W repetitive_k15.txt --secondary no -t 10 -x map-pb $REF $READS> winnowmap.simulated.ONT.paf
awk '$12 == 60 {print}' winnowmap.simulated.ONT.paf | wc -l

# Real CLR

READS=CLR.fastq

time ./mapquikPLUS -t 10 --reference $REF1 $READS -p mapquikPLUS.real.CLR
awk '$12 == 60 {print}' mapquikPLUS.real.CLR.paf | wc -l
time minimap2 --secondary no -t 10 -x map-pb $REF $READS > minimap2.real.CLR.paf
awk '$12 == 60 {print}' minimap2.real.CLR.paf | wc -l
time ./mm2-fast --secondary no -t 10 -x map-pb $REF > mm2-fast.real.CLR.paf
awk '$12 == 60 {print}' mm2-fast.real.CLR.paf | wc -l
time blend --secondary no -t 10 -x map-pb $REF > blend.real.CLR.paf
awk '$12 == 60 {print}' blend.real.CLR.paf | wc -l
time winnowmap -W repetitive_k15.txt --secondary no -t 10 -x map-pb $REF $REF> winnowmap.real.CLR.paf
awk '$12 == 60 {print}' winnowmap.real.CLR.paf | wc -l

# Real ONT

READS=ONT.fastq

time ./mapquikPLUS -t 10 --reference $REF1 $READS -p mapquikPLUS.real.ONT
awk '$12 == 60 {print}' mapquikPLUS.real.ONT.paf | wc -l
time minimap2 --sencondary no -t 10 -x map-pb $REF $READS > minimap2.real.ONT.paf
awk '$12 == 60 {print}' minimap2.real.ONT.paf | wc -l
time mm2-fast --secondary no -t 10 -x map-pb $REF $READS > mm2-fast.real.ONT.paf
awk '$12 == 60 {print}' mm2-fast.real.ONT.paf | wc -l
time blend --secondary no -t 10 -x map-pb $REF $READS > blend.real.ONT.paf
awk '$12 == 60 {print}' blend.real.ONT.paf | wc -l
time winnowmap -W repetitive_k15.txt --secondary no -t 10 -x map-pb $REF $READS > winnowmap.real.ONT.paf
awk '$12 == 60 {print}' winnowmap.real.ONT.paf | wc -l
