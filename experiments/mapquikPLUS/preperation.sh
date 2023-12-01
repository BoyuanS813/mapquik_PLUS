#!/bin/bash

# Download necessary tools
# Construct a new conda environment
conda create -n mapquikPLUS
conda activate mapquikPLUS

# Use mamba to accelerate downloading for necessary packages 
# Basic tools
mamba install -c bioconda samtools
mamba install seqtk
mamba install -c bioconda sra-tools
# Simulators
mamba install -c bioconda pbsim
mamba install -c bioconda nanosim
# Mappers
mamba install -c bioconda minimap2
mamba install -c bioconda meryl
mamba install -c bioconda winnowmap
mamba install -c blend-bio
mamba install -c "bioconda/label/cf201901" mashmap
git clone --recursive https://github.com/bwa-mem2/mm2-fast.git mm2-fast
./mm2-fast/make 
mv ./mm2-fast/minimap2 ./mm2-fast/mm2-fast
export PATH=$PATH:


# Download reference human genome of T2T-CHM13v2.0
wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/assemblies/analysis_set/chm13v2.0.fa.gz
gzip -d chm13v2.0.fa.gz
mv chm13v2.0.fa.gz chm13.fa

# Convert reference genome into single line version for mapquik(PLUS)
seqtk seq chm13.fa > chm13-oneline.fa

# Generate indexes for reference
samtools faidx chm13.fa

# Generate k-mer table for winnowmap
meryl count k=15 output merylDB chm13.fa
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
