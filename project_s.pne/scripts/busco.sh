#!/bin/bash
# Bước 1. Kích hoạt môi trường Assembly
conda activate Assembly
# Bước 2. Chạy BUSCO đánh giá độ đầy đủ của bộ gene
# Sử dụng bộ dữ liệu bacteria_odb10 làm chuẩn
busco -i results/spades_output/scaffolds.fasta \
      -o results/busco_results \
      -m genome \
      -l bacteria_odb10 \
      --cpu 2