#!/bin/bash
# tạo thư mục kết quả cho fastqc
mkdir -p project_sta/results/fastqc_clean/
# chạy fastqc cho tất cả các file đã được làm sạch
fastqc project_sta/data/SRR37768792_R1_clean.fastq.gz \
       project_sta/data/SRR37768792_R2_clean.fastq.gz \
       -o project_sta/results/fastqc_clean/ \
       -t 2