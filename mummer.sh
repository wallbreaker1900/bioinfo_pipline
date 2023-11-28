#!/bin/bash

# Description: MUMmer is a suffix tree algorithm designed to find maximal exact matches of some minimum length between two input sequences.
# Usage: Usage: $ ./mummer.sh -p <parent_dir> -r <ref_file> -q <query_file> -o <output_dir> > mummer0.err

# Default Variables
MUMMER_PATH="/home/jill/mummer-4.0.0rc1"
PLOT_INPUT="mummer.mums"

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

# Run MUMmer
${MUMMER_PATH}/mummer -mum -b -c "${PARENT_DIR}/${REF_FILE}" "${PARENT_DIR}/${QUERY_FILE}" > "${OUTPUT_DIR}/${PLOT_INPUT}" 2>mummer.err
