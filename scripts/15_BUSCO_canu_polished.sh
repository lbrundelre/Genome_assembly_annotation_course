#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G
#SBATCH --time=02:00:00
#SBATCH --job-name=BUSCO_canu_polished
#SBATCH --mail-user=livbrundel@gmail.com
#SBATCH --mail-type=fail,begin,end
#SBATCH --output=/data/users/lbrun/assembly_annotation_course/evaluation/output_BUSCO_canu_polished%j.o
#SBATCH --error=/data/users/lbrun/assembly_annotation_course/evaluation/error_BUSCO_canu_polished%j.e
#SBATCH --partition=pcourseassembly

# Define paths
WORKDIR=/data/users/lbrun/assembly_annotation_course

# Use BUSCO with container
singularity exec \
--bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/busco_v5.1.2_cv1.sif \
busco -i ${WORKDIR}/polishing/canu/pilon.fasta -l brassicales_odb10 -o polished_assembly --out_path ${WORKDIR}/evaluation/canu/BUSCO \
-m genome --cpu 4
