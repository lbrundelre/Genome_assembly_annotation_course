#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00
#SBATCH --job-name=split_contig
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/split_contig_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/split_contig_%j.e
#SBATCH --partition=pshort

#load module
module load UHTS/Analysis/SeqKit/0.13.2

# path to directory
DIR=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation

# split flye
seqkit sliding -s 500 -W 500 -g ${DIR}/flye/big_contig.fasta > ${DIR}/flye/contig_windows.fasta

# split canu
seqkit sliding -s 500 -W 500 -g ${DIR}/canu/big_contig.fasta > ${DIR}/canu/contig_windows.fasta
