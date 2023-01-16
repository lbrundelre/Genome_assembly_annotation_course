#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=BUSCO_MAKER
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/annotation_QC/BUSCO_MAKER_flye_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/annotation_QC/BUSCO_MAKER_flye_%j.e

# Define paths to directories
WORKDIR=/data/users/lbrun/assembly_annotation_course

# For flye
INPUTFILE=${WORKDIR}/annotation/protein_coding_seq/automatic_annotation/flye/pilon.maker.output/pilon.all.maker.annotated.proteins.fasta
OUTPATH=${WORKDIR}/annotation/protein_coding_seq/automatic_annotation/annotation_QC/BUSCO/flye

# For canu
#INPUTFILE=${WORKDIR}/annotation/protein_coding_seq/automatic_annotation/canu/pilon.maker.output/pilon.all.maker.annotated.proteins.fasta
#OUTPATH=${WORKDIR}/annotation/protein_coding_seq/automatic_annotation/annotation_QC/BUSCO/canu

# Go to working directory
cd $OUTPATH

# Run BUSCO
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i $INPUTFILE -l brassicales_odb10 -o gene_annotation -m proteins -c 4 --out_path $OUTPATH --download_path $OUTPATH

