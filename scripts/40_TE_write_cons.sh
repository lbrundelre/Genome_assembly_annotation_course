#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=write_cons
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/write_cons_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/write_cons_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Emboss/EMBOSS/6.6.0

#go to working directory
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

cons -sequence TE_family_polished.txt -outseq TE_family_polished.cons -name TE_cons
