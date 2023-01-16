#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=QUAST_no_reference_all_four
#SBATCH --mail-user=livbrundel@gmail
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_QUAST_all_without_ref%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_QUAST_all_without_ref%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course

# Go to working directory
cd /data/users/lbrun/assembly_annotation_course/evaluation/QUAST_all/

# Run QUAST without reference
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py ${WORKDIR}/assemblies/flye/assembly.fasta \
${WORKDIR}/polishing/flye/pilon.fasta \
${WORKDIR}/assemblies/canu/canu.contigs.fasta \
${WORKDIR}/polishing/canu/pilon.fasta \
--eukaryote --large --est-ref-size 135000000 --threads 4 \
--labels "flye initial","flye polished","canu initial","canu polished" \
-o /data/users/lbrun/assembly_annotation_course/evaluation/QUAST_all/
