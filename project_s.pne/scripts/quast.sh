#!/bin/bash
# Bước 1. Kích hoạt môi trường Assembly
conda activate Assembly
# Bước 2. Chạy QUAST để đánh giá file scaffolds.fasta
quast.py results/spades_output/scaffolds.fasta -o results/quast_results
# scaffolds.fasta là kết quả từ SPAdes