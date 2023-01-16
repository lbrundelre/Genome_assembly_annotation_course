#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=start,fail,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/assemblies/canu/output_canu_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/assemblies/canu/error_canu_%j.e
#SBATCH --partition=pcourseassembly

#performe assembly with flye

#define absolut path to directory of fastq files and directory of output
input_directory=/data/users/lbrun/assembly_annotation_course/participant_2/pacbio
output_directory=/data/users/lbrun/assembly_annotation_course/assemblies/canu

#load module
module load UHTS/Assembler/canu/2.1.1;

# performe assembly on pacbio fastq files
canu \
-p canu -d ${output_directory} \
genomeSize=130m \
-pacbio ${input_directory}/* \
maxThreads=16 \
maxMemory=64 \
gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
gridOptions="--partition=pcourseassembly --mail-user=livbrundel@gmail.com \
--mail-type=start,fail,end --output=/data/users/lbrun/assembly_annotation_course/assemblies/canu/output_canu_%j.o \
--error=/data/users/lbrun/assembly_annotation_course/assemblies/canu/error_canu_%j.e"
