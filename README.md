# E.coli-sequencing 

This is a very simple Bioinformatics project I have build to get some hands on experience in using Hisat 2 and Samtools. I have taken the E.coli RNA sequencing data ERR11572064.fastq which I downloaded from NCBI's database, to be particular, it is from an experiment where RNA-Seq of Escherichia Coli Nissle 1917 strain modified to produce amounts of the bacteriocin microcin C (Bacteriocin C. is known as the Trojan horse antibiotic because it enters the bacterial cells and disrupts their protein synthesis). This Particular data was from the run ERR11572064, and was generated by Illumina. Due to the size of the data I could not put it here, but if anyone wants to download it to run the pipeline, here is the link - https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=ERR11572064&display=metadata. You will need the reference genome as well, the link for that is - https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000005845.2/.

For my first step, I use HISAT 2 to create an alignment index from the E.Coli reference genome which help in faster read mapping. It generated a couple of index files which were then processed to generate a SAM file which had all the details about the alignment. In step 2, Samtools is used to convert this SAM output to compressed BAM file, for faster processing. Then in the third script I process the data in the BAM file using samtols again. It performs, sorting, indexing ( stored in .bai file ), calculating coverage and stats. Step 4 was just creating a comprehensive report of all the statistics calculated in step 3.


## Key Statistics Calculated:

### Total reads: 11,106,948 (our input FASTQ had ~11M reads)
### Mapped reads: 3,431,846 (30.90% mapping rate)
### Secondary alignments: 260,778 (reads mapping to multiple locations)
### No duplicates: 0 (good!)

## Why the paired-end stats are all 0?
## Our data is single-end RNA-seq, so all the "paired" statistics are irrelevant:

#### 0 paired in sequencing  (correct - single-end)
#### 0 properly paired (correct - single-end)
#### 0 mate mapped  (correct - single-end)

## Is 30.90% mapping rate good? For RNA-seq, this could be normal depending on:

### rRNA contamination (ribosomal RNA doesn't map well)
### Low quality reads
### Strain differences between your sample and reference
### Experimental conditions
