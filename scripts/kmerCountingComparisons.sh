#!/bin/bash

#Counting K-mers and Comparing K-mer databases

# commands to count k-mers and compare k-mer databases (union) 
# using KMC3 (http://sun.aei.polsl.pl/kmc)

# for large scale analysis - send commands in batches to your HPC cluster 
# recommended to speak with your cluster administrator as this can be computationally 
# expensive in memory and time
# for most practical applications/analysis use approximation approaches (see README)

#COUNTING K-MERS
# k = k-mer length
# fasta = input fasta of genome (gzipped ok)
# KMERDIR = directory of k-mer databases (output of counting k-mers)
# ID1 = ID of Genome (will be prefix of KMC Database)
# WORK_DIR = working directory for temporary files created by KMC

kmc -k$k -ci1 -cs1000000000 -fm $fasta $KMERDIR/$ID $WORK_DIR;

# Should create a separate working directory for each ID if running in parallel
# for each ID, mkdir $WORK_DIR/$ID
# replace $WORK_DIR with $WORK_DIR/$ID
#kmc -k$k -ci1 -cs1000000000 -fm $fasta $KMERDIR/$ID $WORK_DIR/$ID;

#Read metadata (unique/total k-mers) with 
kmc_tools info $KMERDIR/$ID  


#PAIRWISE COMPARISONS

#PAIRWISEDIR = Output Directory
#ID1 = ID of Genome 1 (prefix of KMC Database)
#ID2 = ID of Genome 2 (prefix of KMC Database)

kmc_tools simple $KMERDIR/$ID1 -ci1 $KMERDIR/$ID2 -ci1 union $PAIRWISEDIR/"$ID1"-"ID2" -ci1 -cs100000000000;

#Read metadata (unique k-mers) from 
kmc_tools info $PAIRWISEDIR/"$ID1"-"ID2" > $PAIRWISEDIR/"$ID1"-"ID2".txt; 

# warning writing metadata to text per file can have high IOPS, can use stdout for batches
# writing IDs first
# i.e. 'echo "$ID1"-"ID2"; kmc_tools info $PAIRWISEDIR/"$ID1"-"ID2;' 
# then read this metadata post process to a table of unique k-mers per comparison
# jaccard similarity = intersection(A,B) / union(A,B) = (cardinality(A) + cardinality(B) - union(A, B)) / union(A,B)

#To save space can remove k-mer databases after metadata is written
rm $PAIRWISEDIR/"$ID1"-"ID2".kmc*;

