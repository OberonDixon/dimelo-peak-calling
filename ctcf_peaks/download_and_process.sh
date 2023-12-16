#!/bin/bash
# Job name:
#SBATCH --job-name=prep_ChIP_peaks
#
# Account:
#SBATCH --account=fc_nilah
#
# Partition:
#SBATCH --partition=savio2
#
# Wall clock limit:
#SBATCH --time=00:20:00
#
# Nodes:
#SBATCH --nodes=1
#
## Command(s) to run:

module load ucsc_toolkit/v287

DOWNLOAD_TARGET=https://www.encodeproject.org/files/ENCFF797SDL/@@download/ENCFF797SDL.bed.gz
BED_FILE="$(basename $DOWNLOAD_TARGET .gz)"
# Apparently, this should be set to 6, even though there are 10 columns, because narrowPeak files are weird and liftOver is weird
N_COLS=6


## 0. download and unpack original file:
wget $DOWNLOAD_TARGET
gunzip $BED_FILE.gz

## 1. hg38 -> chm13v1.0
CHAIN_FILE_1=/global/scratch/projects/vector_streetslab/amaslan/dimelo_bams/20220414/beds/hg38.t2t-chm13-v1.0.over.chain
TARGET_REF_NAME_1=chm13v1.0
OUT_BED_FILE_1=${BED_FILE%.bed}.$TARGET_REF_NAME_1.bed
# Usage: liftOver oldFile map.chain newFile unMapped
# -bedPlus=N - File is bed N+ format (number of cols)
liftOver $BED_FILE $CHAIN_FILE_1 $OUT_BED_FILE_1 unmapped.$TARGET_REF_NAME_1.bed -bedPlus=$N_COLS

## 1. chm13v1.0 -> chm13v1.1
CHAIN_FILE_2=/global/scratch/projects/vector_streetslab/amaslan/dimelo_bams/20220414/beds/v1.0_to_v1.1_rdna_merged.chain
TARGET_REF_NAME_2=chm13v1.1
OUT_BED_FILE_2=${BED_FILE%.bed}.$TARGET_REF_NAME_2.bed
# Usage: liftOver oldFile map.chain newFile unMapped
# -bedPlus=N - File is bed N+ format (number of cols)
liftOver $OUT_BED_FILE_1 $CHAIN_FILE_2 $OUT_BED_FILE_2 unmapped.$TARGET_REF_NAME_2.bed -bedPlus=$N_COLS
