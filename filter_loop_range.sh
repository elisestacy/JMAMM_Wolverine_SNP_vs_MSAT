#!/bin/bash

#load vcftools
module load vcftools

# Set variables
VCF_FILE="out.recode.vcf"
#VCF_File Filtered produce from stacks (gstack and populations), no locus or individual filtering applied, justs remove PCR duplicates in gstacks and single population and preliminary depth filtering in vcftools >=3 <=60  
#Number of increments based on size of increments and range between individual and locus need to match
LOCUS_THRESH_RANGE=(0.7 0.85)  # range of locus missingness (shared, where 1 is no missing and 0 is missing across all) thresholds to use
LOCUS_THRESH_INCREMENT=0.015  # increment for locus missingness thresholds
INDIVIDUAL_THRESH_RANGE=(0.99 0.6)  # range of individual missingness thresholds to use
INDIVIDUAL_THRESH_DECREMENT=0.039  # decrement for individual missingness thresholds

# Create a set of locus missingness thresholds
LOCUS_THRESHOLDS=($(seq ${LOCUS_THRESH_RANGE[0]} $LOCUS_THRESH_INCREMENT ${LOCUS_THRESH_RANGE[1]}))

# Create a set of individual missingness thresholds
INDIVIDUAL_THRESHOLDS=($(seq ${INDIVIDUAL_THRESH_RANGE[0]} -$INDIVIDUAL_THRESH_DECREMENT ${INDIVIDUAL_THRESH_RANGE[1]}))

# Create log files for individual filtering and locus filtering
INDIVIDUAL_LOG="individual_filtering.log"
LOCUS_LOG="locus_filtering.log"
echo -n "" > $INDIVIDUAL_LOG
echo -n "" > $LOCUS_LOG

# Loop over locus and individual missingness thresholds
for ((ITER=0; ITER<${#LOCUS_THRESHOLDS[@]}*2; ITER++)); do

  if (( ITER%2 == 0 )); then
    # Individual filtering
    i=$(($ITER/2))
    i_thresh=${LOCUS_THRESHOLDS[$i]}
    
  # Remove loci with too much missing data
    vcftools --vcf $VCF_FILE --max-missing $i_thresh --recode --out filtered &>> $LOCUS_LOG

    # Update VCF file for next iteration
    VCF_FILE="filtered.recode.vcf"

  else
    # Individual filtering
    j=$(($ITER/2))
    j_thresh=${INDIVIDUAL_THRESHOLDS[$j]}

    # Calculate proportion of missing data per individual
    vcftools --vcf $VCF_FILE --missing-indv --out missing

    # Get list of individuals with too much missing data
    awk -v thresh=$j_thresh 'NR>1 && $5 > thresh {print $1}' missing.imiss > individuals_to_remove.txt
    echo "Individuals to remove at threshold ${j_thresh}: $(cat individuals_to_remove.txt)" >> individuals_removed.log

    # Remove individuals with too much missing data
    vcftools --vcf $VCF_FILE --remove individuals_to_remove.txt --recode --out final &>> $INDIVIDUAL_LOG
    

    # Update VCF file for next iteration
    VCF_FILE="final.recode.vcf"
  fi
done
