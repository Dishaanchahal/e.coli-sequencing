#!/bin/bash

# Load required modules
module load hisat2
module load samtools

# Script to align reads using HISAT2
# Set paths (matching your file structure)
FASTQ="../data/raw/ERR11572064.fastq"
INDEX="../results/alignment/ecoli_hisat2_index"
OUTPUT="../results/alignment/ERR11572064.bam"
LOG="../results/logs/alignment.log"

# Rest of your script...
# Create log directory if it doesn't exist
mkdir -p ../results/logs

# Run HISAT2 alignment
echo "Starting alignment with HISAT2..."
echo "Input: $FASTQ" | tee $LOG
echo "Index: $INDEX" | tee -a $LOG
echo "Output: $OUTPUT" | tee -a $LOG

hisat2 -x $INDEX \
       -U $FASTQ \
       --threads 4 \
       | samtools view -bS - > $OUTPUT

echo "Alignment completed!" | tee -a $LOG
echo "BAM file created: $OUTPUT" | tee -a $LOG

# Check output file
ls -lh $OUTPUT
