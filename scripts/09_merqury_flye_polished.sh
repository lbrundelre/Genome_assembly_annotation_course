#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=03:00:00
#SBATCH --job-name=merqury_flye_polished
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_merqury_flye_pol%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_merqury_flye_pol%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course
meryl_dir=${WORKDIR}/evaluation/meryl

# Go to working directory for merqury
cd ${WORKDIR}/evaluation/flye/merqury/polished_assembly/

# Run container with merqury
singularity exec \
--bind $WORKDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${meryl_dir}/union.meryl \
${WORKDIR}/polishing/flye/pilon.fasta \
flye_polished
