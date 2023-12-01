# mapquik_PLUS: An ultra-fast approximate mapper for long reads with modest error rates.

A modified version of `mapquik` for long read with sequencing error larger than 1%.

## Motivation

The mapping performance of ultra-fast mapper [`mapquik`](https://github.com/ekimb/mapquik) degrades markly when identity between reads and the reference is lower than $97$\%, , and less than $1$\% of the reads are mapped at $Q60$ for identities below $93$\%. 

To further make the mapper available to other third generation long reads like PacBio CLR reads or Oxford Nanopore reads, `mapquik_PLUS` can be used as an assistant for cases other than PacBio HiFi reads.

## Installation

Pre-requisites: [A working Rust environment](https://rustup.rs/).

Clone the repository, and run 

```
rustup install nightly
cargo +nightly build --release
```

## Usage 

`target/release/mapquikPLUS <reads.fq> --reference <reference.fa>`

## Performance

`mapquik_PLUS` can correctly map most simulated reads from human genome (over $90$\% of reads at $Q60$ with divergence no more than $10$\%) while maintain the ultra fast mapping speed of `mapquik`.

For real ONT and CLR reads from T2T-CHM13 Project, `mapquik_PLUS` achieves high consistency with `minimap2` mapping results and obtains an over $30\times$ speed-up over `mm2-fast`. 

The ONT read data set from the most recent version for T2T-CHM13 used in the test:

https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/nanopore/rel8-guppy-5.0.7/reads.fastq.gz

The CLR read data set from raw CCS mode of Sequal II used in the test:

https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/pacbio/hifi_20kb/m64062_190803_042216.subreads.bam

https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/pacbio/hifi_20kb/m64062_190804_172951.subreads.bam

https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/pacbio/hifi_20kb/m64062_190806_063919.subreads.bam

Experimental materials can be found in experiments/mapquikPLUS/
