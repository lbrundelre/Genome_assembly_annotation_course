#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=index_Salmon
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/index_Salmon_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/index_Salmon_%j.e

# Define paths to directories
DATADIR=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation
CONTAINER=/software/singularity/containers

# Input flye or canu
#INPUTFILE=${DATADIR}/flye/pilon.maker.output/pilon.all.maker.transcripts.fasta
INPUTFILE=${DATADIR}/canu/pilon.maker.output/pilon.all.maker.transcripts.fasta


# Go to working directory of flye or canu
#cd ${DATADIR}/annotation_QC/Salmon/flye
cd ${DATADIR}/annotation_QC/Salmon/canu

singularity exec \
--bind $DATADIR \
--bind $CONTAINER \
$CONTAINER/salmon-1.7.0-1.ubuntu18.sif \
salmon index -t $INPUTFILE -i transcript_index -k 31
