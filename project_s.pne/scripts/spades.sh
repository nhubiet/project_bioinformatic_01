#!/bin/bash
# Bước 1. Kích hoạt môi trường Assembly
conda activate Assembly
# Bước 2. Chạy SPAdes lắp ghép bộ gene
spades.py -1 data/cleaned_R1.fastq.gz \
          -2 data/cleaned_R2.fastq.gz \
          -o results/spades_output \
          --only-assembler \
          -t 2 -m 7
# -1, -2: Dữ liệu sạch đã lọc qua fastp
# -o: Thư mục xuất kết quả
# -t 2 -m 7: Giới hạn tài nguyên để máy không bị treo