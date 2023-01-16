#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:10:00
#SBATCH --job-name=blast_against_EDTA
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_against_EDTA_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/blast_against_EDTA_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load Blast/ncbi-blast/2.9.0+

#go to working directory of canu
cd /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/canu

#make database with genome 
makeblastdb -in /data/users/lbrun/assembly_annotation_course/annotation/transposable_element/canu/pilon.fasta.mod.EDTA.TElib.fa \
 -dbtype nucl -out blast_db/EDTA_canu

#blast against EDTA file containing TE (double checking)
blastn -query TE_family_polished.cons -db blast_db/EDTA_canu -outfmt 6 -num_threads 10  > TE_family_polished_EDTA.blastn
