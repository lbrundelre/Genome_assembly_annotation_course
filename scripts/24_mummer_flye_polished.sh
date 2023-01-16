#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=mummer_flye_polished
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_mummer_flye_poli_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_mummer_flye_poli_%j.e
#SBATCH --partition=pcourseassembly

#load module
module add UHTS/Analysis/mummer/4.0.0beta1 
export PATH=/software/bin:$PATH

#define paths
ref_file=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
input_dir=/data/users/lbrun/assembly_annotation_course
output_dir=/data/users/lbrun/assembly_annotation_course/evaluation/flye/mummer/

#go to directory
cd ${output_dir}

#performe nucmer
nucmer --prefix flye_polished --breaklen 1000 --mincluster 1000 \
$ref_file ${input_dir}/polishing/flye/pilon.fasta

#performe mummerplot
mummerplot --prefix flye_polished -R $ref_file \
-Q ${input_dir}/polishing/flye/pilon.fasta \
--filter -t png --large --layout flye_polished.delta
