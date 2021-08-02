#Hierarchical Clustering and Tree Comparisons Script
library("dendextend")
library("seriation")
library("ape")
library("treeio")


R_TEST_DATA_PATH = "Documents/MATLAB/Genome_Entropy/R_test_data/"

# Pairwise distance matrix (1 - jaccard similarity):
# need to unzip file first
dist_mat_file = paste0(R_TEST_DATA_PATH, "PairwiseMatrices/genera_js_dist_k21.csv")
dist_mat = read.csv(dist_mat_file, header=FALSE)

# genus ID tip (leaf) labels
genus_labels = read.csv(paste0(R_TEST_DATA_PATH, "PairwiseMatrices/genus_id_labels.csv"), stringsAsFactors = FALSE)

# distance matrix as dist
dt = as.dist(dist_mat, diag=TRUE, upper=TRUE)

# hierarchical clustering with optimal ordering, as phylo
hc_reord = reorder(hclust(dt, "ward.D2"), dt)
hc_reord$labels = genus_labels$gen
hc_reord_p = as.phylo(hc_reord)

# mammalian subtree - indices = [180:223], reverse order
hc_reord_p_sub = tree_subset(hc_reord_p, "Homo", 6)
hc_rev_reord_sub = rotateConstr(hc_reord_p_sub, rev(hc_reord$labels[hc_reord$order[180:223]]))

#read reference dendrograms
#full_ref_dend = readRDS(paste0(R_TEST_DATA_PATH, "ReferenceTree/full_ref_dend.rds"))
mammalian_ref_dend = readRDS(paste0(R_TEST_DATA_PATH, "ReferenceTree/mammalian_ref_dend.rds"))

#tanglegram tree comparison
tanglegram(hc_rev_reord_sub, mammalian_ref_dend, lab.cex=1.3, common_subtrees_color_branches=TRUE, columns_width = c(1,0.6,1), margin_inner=9, margin_outer=0.5, highlight_branches_lwd = FALSE, highlight_distinct_edges=FALSE, edge.lwd=2.5, font=4)


