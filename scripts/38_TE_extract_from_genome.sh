#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=extract_TE
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/extract_TE_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/extract_TE_%j.e
#SBATCH --partition=pcourseassembly


module load UHTS/Analysis/SeqKit/0.13.2

#go to working directory
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

seqkit subseq --bed candidate_TE.bed /data/users/lbrun/assembly_annotation_course/polishing/canu/pilon.fasta \
 -u 2000 -d 2000 > TE_candidate_window.bed.fa
