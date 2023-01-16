#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=30G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Blast_MAKER
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/Blast_MAKER_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/Blast_MAKER_%j.e

# Define paths to directories
WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation

# Load Module
module load Blast/ncbi-blast/2.9.0+

# Go to working directory
cd $WORKDIR

# Create blast db
#makeblastdb -in /data/courses/assembly-annotation-course/CDS_annotation/uniprot-plant_reviewed.fasta -dbtype prot -out uniprot-plant_reviewed

# Run blastp once for flye and once for canu --> comment out creation of database when doing it the second time!
#blastp -query ${WORKDIR}/flye/pilon.maker.output/pilon.all.maker.proteins.fasta -db uniprot-plant_reviewed \
# -num_threads 10 -outfmt 6 -evalue 1e-10 > ${WORKDIR}/flye/pilon.maker.output/pilon_blastprotein_output

blastp -query ${WORKDIR}/canu/pilon.maker.output/pilon.all.maker.proteins.fasta -db uniprot-plant_reviewed \
 -num_threads 10 -outfmt 6 -evalue 1e-10 > ${WORKDIR}/canu/pilon.maker.output/pilon_blastprotein_output


