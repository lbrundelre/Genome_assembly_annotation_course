#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=00:30:00
#SBATCH --job-name=Quast_canu_ini_with_ref
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_QUAST_canu_ini_with_ref%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_QUAST_canu_ini_with_ref%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course
DATADIR=/data/courses/assembly-annotation-course

# Use QUAST with container once without and once with reference
# Without reference:
#singularity exec \
#--bind $WORKDIR \
#/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
#quast.py ${WORKDIR}/assemblies/canu/canu.contigs.fasta --eukaryote --large \
#--est-ref-size 135000000 --threads 4 --labels canu_assembly_initial \
#-o ${WORKDIR}/evaluation/canu/QUAST/initial

# Go to working directory for merqury
cd ${WORKDIR}/evaluation/canu/merqury/initial_assembly/

# With reference:
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/data/courses/assembly-annotation-course/containers/quast_5.1.0rc1.sif \
quast.py ${WORKDIR}/assemblies/canu/canu.contigs.fasta --eukaryote --large \
--est-ref-size 135000000 --threads 4 --labels canu_assembly_initial \
-r ${DATADIR}/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz \
-g ${DATADIR}/references/TAIR10_GFF3_genes.gff \
-o ${WORKDIR}/evaluation/canu/QUAST/initial_ref/
