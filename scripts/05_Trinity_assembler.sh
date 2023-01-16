#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=Trinity_assembly
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,start,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/assemblies/Trinity/output_Trinity_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/assemblies/Trinity/error_Trinity_%j.e
#SBATCH --partition=pcourseassembly

#performe assembly with Trinity

#define absolut path to directory of fastq files and directory of output
input_directory=/data/users/lbrun/assembly_annotation_course/participant_2/RNAseq
output_directory=/data/users/lbrun/assembly_annotation_course/assemblies/Trinity

#load module
module load UHTS/Assembler/trinityrnaseq/2.5.1;

# performe assembly on pacbio fastq files
Trinity --seqType fq --left ${input_directory}/ERR754075_1.fastq.gz --right ${input_directory}/ERR754075_2.fastq.gz \
--CPU 12 --max_memory 48G --output ${output_directory}
