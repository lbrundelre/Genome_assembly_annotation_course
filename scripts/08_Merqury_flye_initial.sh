#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury_flye_initial
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_meryl_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_meryl_%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course
DATADIR=/data/courses/assembly-annotation-course
read_dir=${WORKDIR}/participant_2/Illumina
meryl_dir=${WORKDIR}/evaluation/meryl

# Go to working directory for meryl
cd ${meryl_dir}/

# Count and combine the kmers from the forward and backward reads
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl union-sum \
output union.meryl \
[count k=21 ${read_dir}/ERR3624578_1.fastq.gz output read1.meryl] \
[count k=21 ${read_dir}/ERR3624578_2.fastq.gz output read2.meryl]

# Go to working directory for merqury
cd ${WORKDIR}/evaluation/flye/merqury/initial_assembly/

# Run container with merqury
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
${meryl_dir}/union.meryl \
${WORKDIR}/assemblies/flye/assembly.fasta \
flye_initial
