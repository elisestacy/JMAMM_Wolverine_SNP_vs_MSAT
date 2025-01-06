# Comparing microsatellites and single nucleotide polymorphisms to evaluate genetic structure and diversity in wolverines (*Gulo gulo*) across Alaska and western Canada: Journal of Mammalogy manuscript

### Code repository describing bioinformatics and R code for comparing population structure and genetic diversity analysis of wolverines across Alaska and the Yukon with a single nucleotide polymorphism (SNP) dataset generated via restriction-site associated DNA sequencing and microsatellite dataset
Authors: Elise M. Stacy, Martin D. Robards, Thomas S. Jung, Piia M. Kukka, Jack Sullivan, Paul A. Hohenlohe, and Lisette P. Waits

#### Primary Contact: Elise Stacy, email: stacy.elise.m@gmail.com

## Description of CSVs
all_samples: All sample IDs, region, and sex - exact location data sensitive and available with error added upon request
snp_sample_data: SNP genotyped sample IDs, region, and sex
msat_structure_order, msat_r_structure_order, and snp_structure_order: Labels to order samples for display in structure barplots, including for microsatellite results, microsatellites with related individuals kept in the dataset, and the SNP dataset. 

## Description of scripts
### RAD Seq data processing - RAD seq following "BestRAD" protocol excluding the targeted bait capture with modification to use biotinylated adapters (Ali et al. 2016) using SbfI enzyme
flip_trim: Custom Hohenlohe lab script for recognizing cutsites, barcodes, and trimming
filter_loop_range: Custom script to automate iterative filtering of individual and locus level missingness similar to approach in O’Leary et al. (2018) 

## R code
### SNP outlier detection and high observed heterozygosity removed
snp_outliers_Ho_removed.RMD
### Microsatellite loci linkage disequilibrium and Hardy-weinberg equilibrium
LD_HWE.RMD
### PCA calculation and STRUCTURE results visualization
PCA_Structure_visualization.RMD, to produce structure plots, structure results files available upon request
### Genetic Diversity and Fst
GD_Fst.RMD
### Isolation by distance mantel tests
IBD.RMD
## Genotype Data Availability
Dryad - DOI: 10.5061/dryad.crjdfn3dz
