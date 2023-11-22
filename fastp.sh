#!/bin/bash

# Description: preprocess of query files
# Usage: $ ./fastp.sh -q <query_dir> -o <output_dir>

# Parse command-line options
while getopts ":q:o:" opt; do
  case ${opt} in
    q ) query_dir=${OPTARG} ;;
    o ) output_dir=${OPTARG} ;;
    \? ) echo "Usage: $0 -q <query_dir> -o <output_dir>" >&2
         exit 1 ;;
    : ) echo "Usage: $0 -q <query_dir> -o <output_dir>" >&2
        exit 1 ;;
  esac
done

# Run fastp on the experiment
cd "$output_dir" || { echo "Unable to change to the output directory"; exit 1; }

# Loop over files in the query directory using find
find "$query_dir" -name '*_L001_R1_001.fastq.gz' | while read -r filename; do
    # Extract experiment name
    experiment_name=$(basename "${filename}" "_L001_R1_001.fastq.gz")
    cmd="/home/jill/fastp --thread 8 -i ${query_dir}${experiment_name}_L001_R1_001.fastq.gz -I ${query_dir}${experiment_name}_L001_R2_001.fastq.gz -o ${experiment_name}_1.fq.gz -O ${experiment_name}_2.fq.gz --detect_adapter_for_pe --unpaired1 ${experiment_name}.fq.gz --unpaired2 ${experiment_name}.fq.gz"
    eval "$cmd" 
done
