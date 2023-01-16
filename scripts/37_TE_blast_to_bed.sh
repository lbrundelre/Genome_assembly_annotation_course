#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=blast_to_bed
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_to_bed_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_to_blast_%j.e
#SBATCH --partition=pcourseassembly

#go to working directory
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

#make bed
awk '$10 < $9 {print($2"\t"$10-1"\t"$9)}' candidate_TE.blastn > candidate_TE.bed
awk '$10 > $9 {print($2"\t"$9-1"\t"$10)}' candidate_TE.blastn >> candidate_TE.bed
