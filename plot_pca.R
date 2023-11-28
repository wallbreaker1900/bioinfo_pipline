# Description: Generates principal component analysis (PCA) plots for selected PC combinations using pcangsd output data.

# Usage:
# 1. Set the working directory to the directory containing necessary input files.
# 2. Ensure the required input files (e.g., columbianus_pcangsd_out.cov, poplabel.info) are available in the working directory.
# 3. Run the R script to produce PCA plots for various PC combinations.

# Change
WORD_D <- "/more_storage/jill/qb3_pcangsd_columbianus"
INPUT <- "columbianus_pcangsd_out.cov"
OUTPUT <- "columbianus"

# Change to Working directory
setwd(WORD_D)
file_path <- file.path(WORD_D, INPUT)

pop <- read.table("poplabel.info") # with colors
cov <- as.matrix(read.table(file_path))
e <- eigen(cov)

# Generate PCA plots for selected PC combinations and save them as PDF files
result_file <- paste(OUTPUT, "pc1_pc2.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 1:2], col = pop[, 1], xlab = "PC1", ylab = "PC2") # with colors
# plot(e$vectors[, 1:2], xlab = "PC1", ylab = "PC2") # without color
print(e$values / sum(e$values))

result_file <- paste(OUTPUT, "pc1_pc3.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 1:3], col = pop[, 1], xlab = "PC1", ylab = "PC3")

result_file <- paste(OUTPUT, "pc1_pc4.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 1:4], col = pop[, 1], xlab = "PC1", ylab = "PC4")

result_file <- paste(OUTPUT, "pc2_pc3.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 2:3], col = pop[, 1], xlab = "PC2", ylab = "PC3")

result_file <- paste(OUTPUT, "pc2_pc4.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 2:4], col = pop[, 1], xlab = "PC2", ylab = "PC4")

result_file <- paste(OUTPUT, "pc3_pc4.pdf", sep = "_")
pdf(file = result_file)
plot(e$vectors[, 3:4], col = pop[, 1], xlab = "PC3", ylab = "PC4")
