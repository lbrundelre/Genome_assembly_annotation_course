#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=genome_index_STAR
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/genome_index_STAR_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/genome_index_STAR_%j.e

# Path to directory
WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation

# Paths for flye
GENOMEDIR=${WORKDIR}/trinity/trinity_flye
GENOMEFASTAFILE=/data/users/lbrun/assembly_annotation_course/polishing/flye/pilon.fasta
GTFFILE=${WORKDIR}/flye/pilon.maker.output/pilon.all.gtf

# Paths for canu
#GENOMEDIR=${WORKDIR}/trinity/trinity_canu
#GENOMEFASTAFILE=/data/users/lbrun/assembly_annotation_course/polishing/canu/pilon.fasta
#GTFFILE=${WORKDIR}/canu/pilon.maker.output/pilon.all.gtf


# Load module
module add UHTS/Aligner/STAR/2.7.9a

# Run for flye and canu
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $GENOMEDIR --genomeFastaFiles $GENOMEFASTAFILE --sjdbGTFfile $GTFFILE
