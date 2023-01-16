#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=06:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,start,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/assemblies/flye/output_flye_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/assemblies/flye/error_flye_%j.e
#SBATCH --partition=pcourseassembly

#performe assembly with flye

#define absolut path to directory of fastq files and directory of output
input_directory=/data/users/lbrun/assembly_annotation_course/participant_2/pacbio
output_directory=/data/users/lbrun/assembly_annotation_course/assemblies/flye

#load module
module load UHTS/Assembler/flye/2.8.3;

# performe assembly on pacbio fastq files
flye --pacbio-raw ${input_directory}/* --out-dir ${output_directory} --threads 16

