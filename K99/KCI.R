library(CondIndTests)
library(dplyr)


cells_genes <- read.csv("100_clones_highly_expressed_genes.tsv", sep='\t')

clone1 = 3628



pvalues <- tibble(
    clone1 = numeric(),
    clone2 = numeric(),
    target = numeric(),
    myc_target_p_value = numeric(), 
    target_myc_p_value = numeric()
)


for (clone2 in unique(cells_genes$clone_idx)){
  cells_genes %>% filter(clone_idx == clone1 | clone_idx == clone2) -> df
  for (gene_id in names(df)[2:length(names(df)) - 1]){
    df[[gene_id]]
  }
}

df
names(df)


MYC <- "X15353"

df[[MYC]]

gene_id
df[[gene_id]]
