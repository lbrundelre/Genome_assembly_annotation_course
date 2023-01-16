#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=mummer_flye_initial
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_mummer_flye_ini_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_mummer_flye_ini_%j.e

#load module
module add UHTS/Analysis/mummer/4.0.0beta1 
export PATH=/software/bin:$PATH

#define paths
ref_file=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
input_dir=/data/users/lbrun/assembly_annotation_course
output_dir=/data/users/lbrun/assembly_annotation_course/evaluation/flye/mummer

cd ${output_dir}
#performe nucmer
nucmer --prefix flye_initial --breaklen 1000 --mincluster 1000 \
$ref_file ${input_dir}/assemblies/flye/assembly.fasta

#performe mummerplot
mummerplot --prefix flye_initial -R $ref_file \
-Q ${input_dir}/assemblies/flye/assembly.fasta \
--filter -t png --large --layout flye_initial.delta
