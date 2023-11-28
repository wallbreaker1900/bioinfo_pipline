#!/bin/bash

# Description: BWA alignment and sorting of paired-end reads using SAMtools.
# Usage: $ ./bwa.sh -r <reference_genome_file> -q <query_directory> -o <output_directory>

# Initialize variables
reference_genome_file=""
query_dir=""
output_dir=""
output_script="bwa_commands_qb3.sh"

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--reference) reference_genome_file="$2"; shift ;;
        -q|--query) query_dir="$2"; shift ;;
        -o|--output) output_dir="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Change to the query directory
cd "$query_dir" || { echo "Unable to change to the query directory: $query_dir"; exit 1; }

output_script_path="${output_dir}/${output_script}"
echo "#!/bin/bash" > "$output_script_path"

# Iterate through the files in the input directory
for filename in *_1.fq.gz; do
    # Check if the file is a paired-end read file
    if [[ -f "${filename/_1/_2}" ]]; then
        # Extract the sample name
        sample_name=$(basename "$filename" | sed -E 's/_1.fq.gz//')

        # Construct the full paths to input FASTQ files and output BAM file
        input_fq1="$query_dir""$filename"
        input_fq2="$query_dir""${filename/_1/_2}"
        output_bam="${output_dir}${sample_name}_PE.bam"

        echo "bwa mem -t 4 -R '@RG\\tID:${sample_name}\\tSM:${sample_name}\\tPL:ILLUMINA' ${reference_genome_file} ${input_fq1} ${input_fq2} | samtools sort -@ 8 -o ${output_bam}" >> "$output_script_path"
    fi
done

chmod +x "$output_script_path"


