#!/usr/bin/env bash

#SBATCH --time=03:00:00
#SBATCH --mem=30G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=Blast_outgroup
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/Blast_outgroup_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/Blast_outgroup_%j.e

# Define paths to directories once for flye and once for canu
WORKDIR=/data/users/lbrun/assembly_annotation_course/annotation/protein_coding_seq/automatic_annotation/gene_duplication

# Load Module
module load Blast/ncbi-blast/2.9.0+

# Go to working directory
cd $WORKDIR

# Create blast db 1x for outgroup, 1x for flye and 1x for canu --> comment out creation of outgroup database when doing it the second time!
makeblastdb -in NNU.pep.fa.ref.single_model -dbtype prot -out blast_db/NNU

makeblastdb -in flye/pilon.all.maker.annotated.proteins-RA.fasta -dbtype prot -out flye/blast_db/Cvi
makeblastdb -in canu/pilon.all.maker.annotated.proteins-RA.fasta -dbtype prot -out canu/blast_db/Cvi

# Run blastp for flye and canu -> once against NNU and once against itself
blastp -query flye/pilon.all.maker.annotated.proteins-RA.fasta -db blast_db/NNU -num_threads 10 -evalue 1e-10 -max_target_seqs 5 -outfmt 6 > flye/Cvi_NNU.blast
blastp -query flye/pilon.all.maker.annotated.proteins-RA.fasta -db flye/blast_db/Cvi -num_threads 10 -evalue 1e-10 -max_target_seqs 5 -outfmt 6 > flye/Cvi.blast

blastp -query canu/pilon.all.maker.annotated.proteins-RA.fasta -db blast_db/NNU -num_threads 10 -evalue 1e-10 -max_target_seqs 5 -outfmt 6 > canu/Cvi_NNU.blast
blastp -query canu/pilon.all.maker.annotated.proteins-RA.fasta -db canu/blast_db/Cvi -num_threads 10 -evalue 1e-10 -max_target_seqs 5 -outfmt 6 > canu/Cvi.blast
