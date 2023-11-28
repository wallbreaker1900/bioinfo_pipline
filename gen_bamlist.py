# Description: This script generates a list of BAM file paths present in a specified directory and writes it to a designated output file.
#
# Usage:
# * python generate_bam_list.py -d /path/to/bam_files/ -o bam_list.txt

import os
import argparse

def gen_bam_list(dir_loc: str, output: str) -> None:
    """
    Generate a list of BAM file paths in the specified directory and write it to the output file.

    Args:
    - dir_loc (str): The directory location to search for BAM files.
    - output (str): The output filename to store the list of BAM file paths.
    """
    with open(output, "w") as f:
        for filename in os.listdir(dir_loc):
            if filename.endswith(".bam"):
                f.write(f"{dir_loc}/{filename}" + "\n")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--target_dir", help="Specify the target directory containing BAM files.")
    parser.add_argument("-o", "--output_filename", help="Specify the output filename for the list of BAM file paths.")
    args = parser.parse_args()

    # Generate the list of BAM file paths
    gen_bam_list(dir_loc=args.target_dir, output=args.output_filename)
