#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=quant_Salmon
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/quant_Salmon_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/quant_Salmon_%j.e

# Define paths to directories
DATADIR=/data/users/lbrun/assembly_annotation_course
CONTAINER=/software/singularity/containers

# Define path to reads
READ1=${DATADIR}/participant_2/RNAseq/ERR754075_1.fastq.gz 
READ2=${DATADIR}/participant_2/RNAseq/ERR754075_2.fastq.gz 


# Go to working directory of flye or canu
#cd ${DATADIR}/annotation/protein_coding_seq/automatic_annotation/annotation_QC/Salmon/flye
cd ${DATADIR}/annotation/protein_coding_seq/automatic_annotation/annotation_QC/Salmon/canu


singularity exec \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon quant -i transcript_index -l A -1 <(zcat $READ1) -2 <(zcat $READ2) --validateMappings -o transcript_quant
