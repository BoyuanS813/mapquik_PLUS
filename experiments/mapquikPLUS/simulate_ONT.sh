
REF=chm13.fa
READS=simulated-ONT.chm13.10X

python simulator.py genome -rg $REF -c ./pre-traine_models/human_NA12878_DNA_FAB49712_guppy_flipflop/training \
       -o $READS -n 1400000 -t 8 -seed $RANDOM -med 50000 -sd 0.5 -min 20000

rm "$READS"_unaligned_reads.fasta
