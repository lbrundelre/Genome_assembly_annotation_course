#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_sorter
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/TE_sorter_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/TE_sorter_%j.e
#SBATCH --partition=pcourseassembly


# Define paths to directories
CONTAINER=/data/courses/assembly-annotation-course
#WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/flye
WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/canu
#WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element

# Go to working directory
cd $WORKDIR/

# Run TEsorter for polished flye and canu assembly
singularity exec \
--bind $CONTAINER \
--bind $WORKDIR \
${CONTAINER}/containers2/TEsorter_1.3.0.sif \
TEsorter all_gff_simplified.fasta -db rexdb-plant
