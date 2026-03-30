#!/bin/bash
# Bước 1. Kích hoạt môi trường riêng cho Abricate
conda activate env_abricate
# Bước 2. Chạy lệnh
abricate --db vfdb results/spades_output/scaffolds.fasta > results/virulence_results.txt