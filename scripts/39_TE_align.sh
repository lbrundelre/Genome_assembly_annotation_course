#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=align_TE
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/align_TE_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/align_TE_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load SequenceAnalysis/MultipleSequenceAlignment/clustalw2/2.1

#go to working directory
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu


clustalw2 TE_candidate_window.bed.fa
