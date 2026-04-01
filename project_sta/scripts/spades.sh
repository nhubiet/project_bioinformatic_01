#!/bin/bash
conda activate Assembly
mkdir -p project_sta/results/spades_output
zcat project_sta/data/SRR37768792_R1_clean.fastq.gz | head -n 4000000 | gzip > project_sta/data/R1_sub.fastq.gz
zcat project_sta/data/SRR37768792_R2_clean.fastq.gz | head -n 4000000 | gzip > project_sta/data/R2_sub.fastq.gz 
spades.py -1 project_sta/data/R1_sub.fastq.gz \
          -2 project_sta/data/R2_sub.fastq.gz \
          -o project_sta/results/spades_output \
          --isolate \
          -t 2 \
          -m 4 \
          --tmp-dir /tmp 