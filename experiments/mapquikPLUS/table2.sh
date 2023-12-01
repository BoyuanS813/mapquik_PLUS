
REF=chm13.fa

for ERROR in 0.97 0.95 0.93 0.91
do 
    READS=simulated-chm13.10X.$ERROR.25kb
    pbsim $REF --model_qc ./model_qc-clr --accuracy-mean $ERROR --accuracy-sd 0 \
	--difference-ratio 20:40:40 --depth 10 --prefix $READS --length-mean 25000
    paftools.js pbsim2fq $REF.fai "$READS"_*.maf > $READS.fa
    rm -f "$READS"_*.maf "$READS"_*.ref "$READS"_*.fastq
done

for ERROR in 0.97 0.95 0.93 0.91
do 
    READS=simulated-chm13.10X.$ERROR.25kb
    mashmap -r $REF -q $READS.fa -o mashmap-$ERROR.paf -t 8
    minimap2 -x map-ont $REF $READS.fa -t 8 > minimap2-$ERROR.paf
    ./mapquikPLUS --reference $REF $READ.fa -p mapquikPLUS-$ERROR -t 8
    awk '$12 == 60' mapquikPLUS-$ERROR.paf | awk '{print $1}' > Q60.list
    cat $READS.fa | awk 'NR%2==1' | sed 's/>//' > reads.list
    grep -f Q60.list reads.list -v > retrived.list
    seqtk subseq $READ.fa retrived.list > $PAF.retrived.fastq
    rm Q60.list
    rm reads.list
    minimap2 -x map-ont $REF $PAF.retrived.fastq -t 8 > minimap2-retrived-$ERROR.paf
done
