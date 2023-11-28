#!/bin/bash

# Description: Supplement to bwa.sh, bwa0.sh run commands file using Parallel
# Usage: $ ./bwa0.sh -c <bwa_commands_file> -j <num_parallel_jobs>

# Default values
bwa_commands_file=""
num_parallel_jobs=""

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--commands) bwa_commands_file="$2"; shift ;;
        -j|--jobs) num_parallel_jobs="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

log_dir=$(mktemp -d)

cat "$bwa_commands_file" | parallel --jobs "$num_parallel_jobs" \
                                   --halt 2 \
                                   --joblog "$log_dir/parallel.log" \
                                   '{} || echo "Job failed: {}" >> "$log_dir/failed_jobs.log"'

if [ -s "$log_dir/failed_jobs.log" ]; then
    echo "Some jobs failed. Check the failed_jobs.log file for details."
    exit 1
else
    echo "All jobs completed successfully."
fi

# Clean up temporary directory
rm -r "$log_dir"

