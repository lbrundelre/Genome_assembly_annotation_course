#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00
#SBATCH --job-name=get_length
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/length_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/annotation/transposable_element/manual_annotation/length_%j.e
#SBATCH --partition=pcourseassembly

#load module
module load UHTS/Analysis/SeqKit/0.13.2

#path to genome
in_dir=/data/users/lbrun/assembly_annotation_course/polishing

#get the length of all contigs
seqkit fx2tab -l -n ${in_dir}/flye/pilon.fasta
echo -n "flye done, starting canu"
seqkit fx2tab -l -n ${in_dir}/canu/pilon.fasta

#copy the output into excel and sort it by size. Store the ID of the biggest one in a file (big_contig.txt)
