
# Use mamba to accelerate downloading for necessary packages 
# Basic tools
mamba install -c bioconda samtools
mamba install seqtk
mamba install -c bioconda sra-tools
mamba install -c bioconda seqkit
# Simulators
mamba install -c bioconda pbsim
mamba install -c bioconda nanosim
# Mappers
mamba install -c bioconda minimap2
mamba install -c bioconda meryl
mamba install -c bioconda winnowmap
mamba install -c blend-bio
mamba install -c bioconda mashmap
git clone --recursive https://github.com/bwa-mem2/mm2-fast.git mm2-fast-project
cd ./mm2-fast-project 
make
cd ..
cp ./mm2-fast-project/minimap2 ./mm2-fast
cp ../../target/release/mapquikPLUS .

# Download reference human genome of T2T-CHM13v2.0
wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/assemblies/analysis_set/chm13v2.0.fa.gz
gzip -d chm13v2.0.fa.gz
mv chm13v2.0.fa chm13.fa

# Convert reference genome into single line version for mapquik(PLUS)
seqtk seq chm13.fa > chm13-oneline.fa

# Generate indexes for reference
samtools faidx chm13.fa

# Generate k-mer table for winnowmap
meryl count k=15 output merylDB chm13.fa
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
