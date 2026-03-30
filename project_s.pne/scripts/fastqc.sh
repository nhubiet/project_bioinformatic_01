#!/bin/bash
# Bước 1. Kích hoạt môi trường QC (nơi có cài tool fastqc)
conda activate QC
# Bước 2. Chạy FastQC cho 2 file đã được lọc sạch (cleaned)
fastqc data/cleaned_R1.fastq.gz data/cleaned_R2.fastq.gz -o results/
# -o results/: Yêu cầu xuất kết quả vào thư mục results