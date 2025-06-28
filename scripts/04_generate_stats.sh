#!/bin/bash

# Load required modules
module load samtools

# Script to generate comprehensive statistics report
# Set paths
STATS_FILE="../results/stats/ERR11572064.stats.txt"
FLAGSTAT_FILE="../results/stats/ERR11572064.flagstat.txt"
COVERAGE_FILE="../results/stats/ERR11572064.coverage.txt"
SORTED_BAM="../results/alignment/ERR11572064.sorted.bam"
REPORT="../results/stats/FINAL_REPORT.txt"
LOG="../results/logs/final_stats.log"

echo "Generating comprehensive statistics report..." | tee $LOG

# Create final report
cat > $REPORT << EOF
===============================================
E. COLI RNA-SEQ ANALYSIS REPORT
===============================================
Analysis Date: $(date)
Sample: ERR1157204
Pipeline: HISAT2 + SAMtools

===============================================
1. ALIGNMENT SUMMARY
===============================================
EOF

# Add flagstat results
echo "Flagstat Results:" >> $REPORT
cat $FLAGSTAT_FILE >> $REPORT

echo -e "\n===============================================" >> $REPORT
echo "2. DETAILED STATISTICS" >> $REPORT
echo "===============================================" >> $REPORT

# Extract key metrics from stats file
echo "Key Metrics:" >> $REPORT
grep "reads mapped:" $STATS_FILE >> $REPORT
grep "bases mapped:" $STATS_FILE >> $REPORT
grep "average length:" $STATS_FILE >> $REPORT
grep "average quality:" $STATS_FILE >> $REPORT

echo -e "\n===============================================" >> $REPORT
echo "3. COVERAGE ANALYSIS" >> $REPORT
echo "===============================================" >> $REPORT
cat $COVERAGE_FILE >> $REPORT

# Calculate additional metrics
echo -e "\n===============================================" >> $REPORT
echo "4. ADDITIONAL ANALYSIS" >> $REPORT
echo "===============================================" >> $REPORT

# BAM file size
BAM_SIZE=$(ls -lh $SORTED_BAM | awk '{print $5}')
echo "Sorted BAM file size: $BAM_SIZE" >> $REPORT

# Total mapped bases
MAPPED_BASES=$(samtools stats $SORTED_BAM | grep "bases mapped:" | awk '{print $4}')
echo "Total mapped bases: $MAPPED_BASES" >> $REPORT

# Genome coverage percentage
echo "Calculating genome coverage..." >> $REPORT
samtools depth $SORTED_BAM | awk '{if($3>0) covered++; total++} END {print "Genome positions covered:", covered, "out of", total, "("100*covered/total"%)"}' >> $REPORT


