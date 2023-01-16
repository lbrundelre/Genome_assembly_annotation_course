#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=most_abundant
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/most_abundant_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/most_abundant_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#go to working directory of flye
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/flye

#before the next step, save the 50-most abundant files in a new fasta file
cut -f1 contig_windows.blastn | sort | uniq -c | sort -k1,1 -n | tail -n 50 | cut -f6 -d ' ' > top_contig_windows.txt

#save 50 most abundant 500bp-windows into new fasta file
seqkit grep -n -f top_contig_windows.txt contig_windows.fasta -o contig_windows_TOP50.fasta

#go to working directory of canu
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

#before the next step, save the 50-most abundant files in a new fasta file
cut -f1 contig_windows.blastn | sort | uniq -c | sort -k1,1 -n | tail -n 50 | cut -f8 -d ' ' > top_contig_windows.txt

#save 50 most abundant 500bp-windows into new fasta file
seqkit grep -n -f top_contig_windows.txt contig_windows.fasta -o contig_windows_TOP50.fasta
