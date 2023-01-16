#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=QUAST_with_reference_all_four
#SBATCH --mail-user=livbrundel@gmail
#SBATCH --mail-type=begin,fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_QUAST_all_with_ref%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_QUAST_all_with_ref%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course
DATADIR=/data/courses/assembly-annotation-course

# Go to working directory
cd /data/users/lbrun/assembly_annotation_course/evaluation/QUAST_all_ref/

# Run QUAST without reference
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py ${WORKDIR}/assemblies/flye/assembly.fasta \
${WORKDIR}/polishing/flye/pilon.fasta \
${WORKDIR}/assemblies/canu/canu.contigs.fasta \
${WORKDIR}/polishing/canu/pilon.fasta \
--eukaryote --large --est-ref-size 135000000 --threads 4 \
--labels "flye initial","flye polished","canu initial","canu polished" \
-r $DATADIR/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz \
-g $DATADIR/references/TAIR10_GFF3_genes.gff \
-o /data/users/lbrun/assembly_annotation_course/evaluation/QUAST_all_ref/
