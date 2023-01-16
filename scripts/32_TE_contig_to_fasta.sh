#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00
#SBATCH --job-name=big_contig_to_fasta
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/big_contig_to_fasta_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/big_contig_to_fasta_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
in_dir=/data/users/lbrun/assembly_annotation_course/polishing
out_dir=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation

# extract sequence of flye
seqkit grep -n -f ${out_dir}/flye/big_contig.txt ${in_dir}/flye/pilon.fasta -o ${out_dir}/flye/big_contig.fasta

# extract sequence of canu
seqkit grep -n -f ${out_dir}/canu/big_contig.txt ${in_dir}/canu/pilon.fasta -o ${out_dir}/canu/big_contig.fasta

