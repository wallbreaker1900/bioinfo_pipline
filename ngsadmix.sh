#!/bin/bash

# Description: Performs population structure analysis using NGSadmix tool for different values of K.

# Usage:
#   Run the 'ngsadmix.sh' Bash script, providing the necessary parameters:
#   $ ./ngsadmix.sh -w /path/to/working_directory -o output_prefix
#   * -w /path/to/working_directory: Specifies the working directory containing the input file.
#   * -o output_prefix: Indicates the prefix for the output files.

NGSADMIX_PATH="/home/jill/bin/NGSadmix"
INPUT="genolike.beagle.gz"

# Initialize variables
WORK_D=""
OUTPUT_PREFIX=""

# Loop through the arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--working-directory) WORK_D="$2"; shift ;;
        -o|--output) OUTPUT_PREFIX="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Change directory to the working directory
cd "$WORK_D" || { echo "Unable to change to the working directory"; exit 1; }

# Perform population structure analysis for different K values
for K in {2..4}; do
    ${NGSADMIX_PATH} -likes "${WORK_D}/${INPUT}" -K "$K" -o "${OUTPUT_PREFIX}_K${K}" -P 8 2>k${K}.err
done
