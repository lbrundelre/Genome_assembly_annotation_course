#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=map_STAR
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/map_STAR_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/map_STAR_%j.e


# Path to directory
WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation
READ1=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_2/RNAseq/ERR754075_1.fastq.gz
READ2=/data/courses/assembly-annotation-course/raw_data/Cvi-0/participant_2/RNAseq/ERR754075_2.fastq.gz

# Paths for flye
GENOMEDIR=${WORKDIR}/trinity/trinity_flye

# Paths for canu
#GENOMEDIR=${WORKDIR}/trinity/trinity_canu

# Load module
module add UHTS/Aligner/STAR/2.7.9a

STAR --runThreadN 4 --genomeDir $GENOMEDIR --readFilesIn  <(zcat ${READ1}) <(zcat ${READ2}) --outFileNamePrefix ${GENOMEDIR}/RNA_map \
 --outSAMtype BAM SortedByCoordinate --outFilterMultimapNmax 10 \
 --outFilterMismatchNoverLmax 0.01 --alignIntronMax 60000 

