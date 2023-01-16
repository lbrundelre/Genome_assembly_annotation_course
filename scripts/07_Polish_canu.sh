#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=12G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=canu_polish
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/polishing/canu/output_canu_%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/polishing/canu/error_canu_%j.e
#SBATCH --partition=pcourseassembly

#load module
module add UHTS/Aligner/bowtie2/2.3.4.1;
module load UHTS/Analysis/samtools/1.10;
module add Development/java/11.0.6;

##Use bowtie to first make index file and then aligne in second step

#define absolut path to directory of fastq files and directory of output
input_fastafile=/data/users/lbrun/assembly_annotation_course/assemblies/canu/canu.contigs.fasta  
output_directory=/data/users/lbrun/assembly_annotation_course/polishing/canu
input_rawfile=/data/users/lbrun/assembly_annotation_course/participant_2/Illumina

#performe bowtie-build to get index file
bowtie2-build --threads 4 -f ${input_fastafile} ${output_directory}/canu_index

#performe alignment using created index file
bowtie2 -p 4 -x ${output_directory}/canu_index -1 ${input_rawfile}/ERR3624578_1.fastq.gz -2 ${input_rawfile}/ERR3624578_2.fastq.gz \
#-q --sensitive-local -S ${output_directory}/canu_polish.sam

cd ${output_directory}
#convert output SAM files to BAM files
samtools sort -T $SCRATCH -@ $SLURM_CPUS_PER_TASK canu_polish.sam -o canu_sorted.sam
samtools view -bS canu_sorted.sam -o canu.bam
samtools index canu.bam


##Use Pilon to polish the assembly$
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome ${input_fastafile} \
--bam ${output_directory}/canu.bam --outdir ${output_directory} --output pilon
