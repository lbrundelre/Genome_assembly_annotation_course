#!/usr/bin/env bash
#SBATCH --job-name=fastqc
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/read_QC/fastqc/error_fastqc_%j.e
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/read_QC/fastqc/output_fastqc_%j.o
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4000M
#SBATCH --partition=pcourseassembly


##perform fast quality control on fasta files 

#add fastqc module
module add UHTS/Quality_control/fastqc/0.11.9;

#define absolut path to directory of fastq files and directory of output
input_directory=/data/users/lbrun/assembly_annotation_course/participant_2
output_directory=/data/users/lbrun/assembly_annotation_course/read_QC/fastqc

#perform quality control on every fastq file
fastqc -o ${output_directory}/Illumina ${input_directory}/Illumina/*.fastq.gz  
fastqc -o ${output_directory}/pacbio ${input_directory}/pacbio/*.fastq.gz
fastqc -o ${output_directory}/RNAseq ${input_directory}/RNAseq/*.fastq.gz 
