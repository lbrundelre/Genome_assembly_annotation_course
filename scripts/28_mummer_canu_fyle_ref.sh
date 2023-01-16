#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=mummer_canu_flye_ref
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_mummer_canu_flye_ref_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_mummer_canu_flye_ref_%j.e
#SBATCH --partition=pcourseassembly

#load module
module add UHTS/Analysis/mummer/4.0.0beta1
export PATH=/software/bin:$PATH

#define paths
ref_file=/data/users/lbrun/assembly_annotation_course/polishing/flye/pilon.fasta
input_dir=/data/users/lbrun/assembly_annotation_course
output_dir=/data/users/lbrun/assembly_annotation_course/evaluation/canu/mummer/

#go to directory
cd ${output_dir}

#performe nucmer
nucmer --prefix canu_flye_ref --breaklen 1000 --mincluster 1000 \
$ref_file ${input_dir}/polishing/canu/pilon.fasta

#performe mummerplot
mummerplot --prefix canu_flye_ref -R $ref_file \
-Q ${input_dir}/polishing/canu/pilon.fasta \
--filter -t png --large --layout canu_flye_ref.delta

