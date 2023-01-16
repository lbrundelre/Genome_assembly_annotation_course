#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=blast_candidate
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_candidate_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_candidate_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#go to working directory of canu
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

#make database with genome
makeblastdb -in /data/users/lbrun/assembly_annotation_course/polishing/canu/pilon.fasta \ 
 -perc_identity 80 -qcov_hsp_perc 80 -dbtype nucl -out blast_db/genome

#blast against candidate family 18 
blastn -query candidate_TE.fasta -db blast_db/genome -outfmt 6 -num_threads 10  > candidate_TE.blastn
