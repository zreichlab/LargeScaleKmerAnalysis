# LargeScaleKmerAnalysis
Scripts for the paper: "Large-scale k-mer-based analysis of the informational properties of genomes, comparative genomics and taxonomy"

The package [KMC](http://sun.aei.polsl.pl/kmc) \[K-Mer Counter (KMC) ver. 3.1.0\] was used for this project - it contains tools for efficient k-mer counting and k-mer comparisons. 

# Installing KMC

Using the [Bioconda channel](https://bioconda.github.io/) from [Conda](https://conda.io/docs/install/quick.html):

```
conda install -c bioconda kmc
```

# Disclaimers
1. Counting all k-mers for all genomes for many lengths of k is computationally expensive. We were specifically interested in the informational properties of genomes and how it relates to k-mer length for educational purposes. For almost all other applications at these scales, it is advisable to use minHash based approximations, like [Mash](https://mash.readthedocs.io/en/latest/), [fastANI](https://github.com/ParBLiSS/FastANI), [k-mer-db](https://github.com/refresh-bio/kmer-db), etc.
2. Most of the scripts for this project were specifically written for use on our institute's cluster - we have rewritten them so that others could easily reproduce the commands used, but we make no guarantees on efficiency. 
