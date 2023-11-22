#!/bin/bash

# Description: preprocess query files with SE8617
# parent_query_dir
# |-- FT-SA204313-FT-SPN04499_H3T33DSX7
# |   |-- 1001A_R1.fastq.gz
# |   |-- 1001A_R2.fastq.gz
# |-- ...
# Usage: $ ./fastp0.sh -q <parent_query_dir> -o <output_dir>

# Parse command-line options
while getopts ":q:o:" opt; do
  case ${opt} in
    q ) parent_query_dir=${OPTARG} ;;
    o ) output_dir=${OPTARG} ;;
    \? ) echo "Usage: $0 -q <parent_query_dir> -o <output_dir>" >&2
         exit 1 ;;
    : ) echo "Usage: $0 -q <parent_query_dir> -o <output_dir>" >&2
        exit 1 ;;
  esac
done

# Run fastp on the experiment
cd "$output_dir" || { echo "Unable to change to the output directory"; exit 1; }

# Loop over R1 files using find
find "${parent_query_dir}" -type f -name "*R1.fastq.gz" | while read -r path_r1; do
  experiment_name=$(basename "${path_r1}" "_R1.fastq.gz")
  dir_name=$(dirname "${path_r1}")
  cmd="/home/jill/fastp --thread 30 -i ${path_r1} -I ${dir_name}/${experiment_name}_R2.fastq.gz -o ${experiment_name}_1.fq.gz -O ${experiment_name}_2.fq.gz --detect_adapter_for_pe --unpaired1 ${experiment_name}.fq.gz --unpaired2 ${experiment_name}.fq.gz"
  eval "$cmd"
done

