#!/bin/bash

# Description: This script performs genome alignment using MUMmer tools, generating comparison outputs for further analysis.
#
# Usage:
#   Execute this script using nohup to allow the process to run in the background:
#   $ nohup ./nucmer.sh -p <parent_dir> -r <ref_file> -q <query_file> -o <output_dir> > nucmer0.err &

# Default Variables
MUMMER_PATH="/home/jill/mummer-4.0.0rc1"

# Initialize variables
PARENT_DIR=""
REF_FILE=""
QUERY_FILE=""
OUTPUT_DIR=""

# Loop through the arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--parent) PARENT_DIR="$2"; shift ;;
        -r|--ref) REF_FILE="$2"; shift ;;
        -q|--query) QUERY_FILE="$2"; shift ;;
        -o|--out) OUTPUT_DIR="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

cd "$OUTPUT_DIR" || { echo "Unable to change to the working directory"; exit 1; }

# Genome alignment using nucmer
${MUMMER_PATH}/nucmer -p nucmer "${PARENT_DIR}/${REF_FILE}" "${PARENT_DIR}/${QUERY_FILE}" 2>nucmer.err

# Post-processing commands for the generated delta file
# Generating various comparison outputs for analysis
${MUMMER_PATH}/show-coords -r -c -l nucmer.delta > "${OUTPUT_DIR}/nucmer.coords" 2>coords.err
${MUMMER_PATH}/show-snps -C nucmer.delta > "${OUTPUT_DIR}/nucmer.snps" 2>snps.err
${MUMMER_PATH}/show-tiling nucmer.delta > "${OUTPUT_DIR}/nucmer.tiling" 2>tiling.err
