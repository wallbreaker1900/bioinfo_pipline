#!/bin/bash

# Description: Performs genomic analysis using ANGSD and pcangsd for population genetics.

# Usage:
#   Run the 'pca_angsd.sh' Bash script, providing the necessary parameters:
#   $ ./pca_angsd.sh -w /path/to/working_directory -i input_file -b bam_list -o output_prefix
#   * -w /path/to/working_directory: Specifies the working directory containing input files.
#   * -i input_file: Specifies the input file (genolike.beagle.gz).
#   * -b bam_list: Specifies the list of BAM files.
#   * -o output_prefix: Indicates the prefix for the output files.

# Default paths
ANGSD_PATH="/home/jill/angsd/angsd"
PCANGSD_PATH="/home/jill/bin/pcangsd/pcangsd/pcangsd.py"

# Initialize variables
WORK_D=""
INPUT=""
BAMLIST=""
OUTPUT_PREFIX=""

# Loop through the arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--working-directory) WORK_D="$2"; shift ;;
        -i|--input) INPUT="$2"; shift ;;
        -b|--bam-list) BAMLIST="$2"; shift ;;
        -o|--output) OUTPUT_PREFIX="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Change directory to the working directory
cd "$WORK_D" || { echo "Unable to change to the working directory"; exit 1; }

# Perform genomic analysis using ANGSD
${ANGSD_PATH} -GL 2 -out genolike -nThreads 18 -doGlf 2 -doMajorMinor 1 -doMaf 2 \
              -SNP_pval 1e-6 -minMaf 0.05 -minInd 20 \
              -bam "${BAMLIST}" \
              2> angsd.err

# Perform PCA analysis using pcangsd
${PCANGSD_PATH} -b "${WORK_D}/${INPUT}" -o "${WORK_D}/${OUTPUT_PREFIX}" -t 10 2> pcangsd.err
