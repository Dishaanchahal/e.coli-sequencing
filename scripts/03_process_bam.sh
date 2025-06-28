#!/bin/bash

# Load required modules
module load samtools

# Script to process BAM file with SAMtools
# Set paths
INPUT_BAM="../results/alignment/ERR11572064.bam"
SORTED_BAM="../results/alignment/ERR11572064.sorted.bam"
STATS_FILE="../results/stats/ERR11572064.stats.txt"
FLAGSTAT_FILE="../results/stats/ERR11572064.flagstat.txt"
COVERAGE_FILE="../results/stats/ERR11572064.coverage.txt"
LOG="../results/logs/samtools.log"

# Create stats directory
mkdir -p ../results/stats

echo "Processing BAM file with SAMtools..." | tee $LOG

# Step 1: Sort BAM file
echo "1. Sorting BAM file..." | tee -a $LOG
samtools sort $INPUT_BAM -o $SORTED_BAM
echo "Sorted BAM created: $SORTED_BAM" | tee -a $LOG

# Step 2: Index sorted BAM
echo "2. Indexing sorted BAM..." | tee -a $LOG
samtools index $SORTED_BAM
echo "Index file created: ${SORTED_BAM}.bai" | tee -a $LOG

# Step 3: Generate alignment statistics
echo "3. Generating alignment statistics..." | tee -a $LOG
samtools stats $SORTED_BAM > $STATS_FILE
samtools flagstat $SORTED_BAM > $FLAGSTAT_FILE

# Step 4: Generate coverage information
echo "4. Calculating coverage..." | tee -a $LOG
samtools depth $SORTED_BAM | awk '{sum+=$3; count++} END {print "Average coverage:", sum/count}' > $COVERAGE_FILE

echo "SAMtools processing completed!" | tee -a $LOG
echo "Files created:" | tee -a $LOG
echo "  - Sorted BAM: $SORTED_BAM" | tee -a $LOG
echo "  - Statistics: $STATS_FILE" | tee -a $LOG
echo "  - Flagstat: $FLAGSTAT_FILE" | tee -a $LOG
echo "  - Coverage: $COVERAGE_FILE" | tee -a $LOG

# Show summary
echo -e "\n=== ALIGNMENT SUMMARY ===" | tee -a $LOG
cat $FLAGSTAT_FILE | tee -a $LOG


 
