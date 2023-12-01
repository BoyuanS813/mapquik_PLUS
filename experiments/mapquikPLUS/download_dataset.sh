#!/bin/bash 

# Real CLR reads for test
for SRR in SRR11292121 SRR11292123 SRR11292120
do 
    fasterq-dump -P -M 10000 $SRR
done 
cat SRR* >> SRR.fastq
seqtk sample -s $RANDOM SRR.fastq 0.8 > CLR.fastq
rm SRR*

#Real ONT reads for test
wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/nanopore/rel8-guppy-5.0.7/reads.fastq.gz
gunzip -c reads.fastq.gz 
seqkit seq -m 25000 -g reads.fastq > reads_25000.fastq 
seqtk sample -s $RANDOM reads_25000.fastq 3000000 > ONT.fastq
rm reads*
