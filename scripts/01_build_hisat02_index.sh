#!/bin/bash
# Script to build HISAT2 index for E. coli genome

# Set paths (updated with your actual file names)
GENOME="../data/reference/reference_ecoli"
INDEX_DIR="../results/alignment"
INDEX_NAME="ecoli_hisat2_index"

# Create output directory if it doesn't exist
mkdir -p $INDEX_DIR

# Build HISAT2 index
echo "Building HISAT2 index..."
hisat2-build $GENOME $INDEX_DIR/$INDEX_NAME

echo "HISAT2 index building complete!"
echo "Index files created in: $INDEX_DIR"
