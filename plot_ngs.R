# Description: Generates a barplot representing admixture proportions for a given experiment (K=4) using pcangsd output.

# Usage:
# 1. Set the working directory to the directory containing necessary input files.
# 2. Ensure the required input files (e.g., qopt, bam.filelist) are available in the working directory.
# 3. Run the R script to produce a barplot displaying admixture proportions for the experiment.

# Change
WORD_D <- "/more_storage/jill/qb3_pcangsd_columbianus"
INPUT <- "columbianus_K4"

# To create bam.filelist: 
# col1: the name of the experiment name in order
# col2: need to extract the first column of pcangsd_out.cov

setwd(WORD_D)  # Set working directory

# Create a PDF for the plot
pdf(paste(INPUT, "pdf", sep = "."))

# Read estimated admixture proportions
q <- read.table(paste(INPUT, "qopt", sep = "."))
pop <- read.table("bam.filelist")

# Order according to population
ord <- order(pop$V2)

# Create a barplot
barplot(t(q)[, ord],
        col = 1:4,
        names = pop$V1[ord],
        las = 2,
        space = 0,
        border = NA,
        xlab = "Individuals",
        ylab = "Admixture proportions for K=4")
