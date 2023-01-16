#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time=01:00:00
#SBATCH --job-name=blast_window
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_window_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_window_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#go to working directory of flye
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/flye

# performe blasting for flye
makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 -max_hsps 1 > contig_windows.blastn


#go to working directory of canu
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

# performe blasting for flye
makeblastdb -in contig_windows.fasta -dbtype nucl -out blast_db/contig_windows

blastn -query contig_windows.fasta -db blast_db/contig_windows -num_threads 10 -outfmt 6 -perc_identity 80 -max_hsps 1 > contig_windows.blastn
