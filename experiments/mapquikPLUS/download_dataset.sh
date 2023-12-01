#!/bin/bash 

# Real CLR reads for test
for SRR in SRR11292121 SRR11292123 SRR11292120
do 
    fasterq-dump -P -M 10000 SRR
done 
cat SRR1129212* | seqtk sample -s $RANDOM 0.8 > CLR.fastq

#Real ONT reads for test

wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/nanopore/rel8-guppy-5.0.7/reads.fastq.gz
gunzip -c reads.fastq.gz |seqkit seq -m 25000 |seqtk sample -s $RANDOM 3000000 > ONT.fastq
