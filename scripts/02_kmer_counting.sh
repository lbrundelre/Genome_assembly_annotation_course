#!/usr/bin/env bash
#SBATCH --job-name=kmer_counting
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/read_QC/kmer_counting/error_kmer_counting_%j.e
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/read_QC/kmer_counting/output_kmer_counting_%j.o
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --mem-per-cpu=10GB
#SBATCH --partition=pcourseassembly


## Count k-mers using jellyfish

#add jellyfish  module
module load UHTS/Analysis/jellyfish/2.3.0

#define absolut path to directory of fastq files and directory of output
input_directory=/data/users/lbrun/assembly_annotation_course/participant_2
output_directory=/data/users/lbrun/assembly_annotation_course/read_QC/kmer_counting

#perform k-mer counting on Illumina data
jellyfish count -C -m 21 -s 5G -t 4 <(zcat ${input_directory}/Illumina/*.fastq.gz) -o ${output_directory}/illumina_reads.jf

jellyfish histo -t 10 ${output_directory}/illumina_reads.jf > ${output_directory}/illumina_reads.histo




