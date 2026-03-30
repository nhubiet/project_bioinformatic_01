#!/bin/bash
# Bước 1. Kích hoạt môi trường QC (chứa fastp)
conda activate QC
# Bước 2. Lệnh chạy fastp (Dành cho file Interleaved đã upload lên)
# Ghi chú: --in1 là file đầu vào, --interleaved_in để báo file chứa cả R1 và R2 -o và -O là 2 file đầu ra đã được tách và lọc sạch
fastp --in1 data/DRR189357.fastq.gz \
      --interleaved_in \
      -o data/cleaned_R1.fastq.gz \
      -O data/cleaned_R2.fastq.gz \
      -h results/fastp_report.html \
      -j results/fastp.json
      