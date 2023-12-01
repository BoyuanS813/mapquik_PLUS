# Simulate ranging-error-rate CLR reads

REF=chm13.fa

for ERROR in 0.98 0.97 0.96 0.95 0.94 0.93 0.92 0.91 0.90
do 
    READS=simulated-chm13.10X.$ERROR.20kb
    pbsim $REF --model_qc ./model_qc-clr --accuracy-mean $ERROR --accuracy-sd 0 \
	--depth 10 --prefix $READS --length-mean 20000
    paftools.js pbsim2fq $REF.fai "$READS"_*.maf > $READS.fa
    rm -f "$READS"_*.maf "$READS"_*.ref "$READS"_*.fastq
done
