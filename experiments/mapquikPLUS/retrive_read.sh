PAF=$1
READS=$2

awk '$12 == 60' $PAF | awk '{print $1}' > Q60.list
cat $READS | awk 'NR%4==1' | sed 's/@//' > reads.list
grep -f Q60.list reads.list -v > retrived.list
seqtk subseq $READS retrived.list > $PAF.retrived.fastq
rm Q60.list
rm reads.list
