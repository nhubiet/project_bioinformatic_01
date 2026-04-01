#!/bin/bash
fastp --in1 project_sta/data/SRR37768792.fastq.gz \
      --interleaved_in \
      --out1 project_sta/data/SRR37768792_R1_clean.fastq.gz \
      --out2 project_sta/data/SRR37768792_R2_clean.fastq.gz \
      -h project_sta/results/SRR37768792_fastp_report.html \
      -j project_sta/results/SRR37768792_fastp.json \
   
      -w 4