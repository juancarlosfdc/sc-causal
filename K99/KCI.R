library(CondIndTests)
library(dplyr)


cells_genes <- read.csv("100_clones_highly_expressed_genes.tsv", sep='\t')
likely_tuples <- read.csv("potential_targets.tsv", sep='\t')
likely_tuples[1, ]$clone1

clone1 = 3628
MYC <- "X15353"

pvalues <- tibble(
    clone1 = numeric(),
    clone2 = numeric(),
    target = character(),
    myc_target_p_value = numeric(), 
    target_myc_p_value = numeric()
)

for (i in 1:length(likely_tuples)){
  cells_genes %>% filter(clone_idx == likely_tuples[i, ]$clone1 | clone_idx == likely_tuples[i, ]$clone2) %>% 
    select(MYC, clone_idx, likely_tuples[i, ]$gene_number) -> df
  myc_target <- KCI(df[[MYC]], df$clone_idx, df[[gene_id]])$pvalue
  target_myc <- KCI(df[[gene_id]], df$clone_idx, df[[MYC]])$pvalue
  pvalues %>% add_row(clone1=clone1, clone2=clone2, target=gene_id, myc_target_p_value=myc_target, target_myc_p_value=target_myc) -> pvalues
  }


for (clone2 in unique(cells_genes$clone_idx)){
  cells_genes %>% filter(clone_idx == clone1 | clone_idx == clone2) -> df
  print(clone2)
  for (i in 2:length(names(df)) - 1){
    gene_id = names(df)[i]
    print(gene_id)
    myc_target <- KCI(df[[MYC]], df$clone_idx, df[[gene_id]])$pvalue
    target_myc <- KCI(df[[gene_id]], df$clone_idx, df[[MYC]])$pvalue
    pvalues %>% add_row(clone1=clone1, clone2=clone2, target=gene_id, myc_target_p_value=myc_target, target_myc_p_value=target_myc) -> pvalues
  }
}


KCI(df[[MYC]], df$clone_idx, df[[gene_id]])
KCI(df[[gene_id]], df$clone_idx, df[[gene_id]])$pvalue
