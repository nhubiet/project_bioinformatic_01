#!/bin/bash
conda activate env_rgi
# Bước 1. Tải dữ liệu CARD trực tiếp (không cần qua lệnh database pull hay bị lỗi)
wget https://card.mcmaster.ca/latest/data -O card.tar.bz2
tar -jxvf card.tar.bz2
# Bước 2. Nạp dữ liệu vào hệ thống
rgi load --card_json card.json --local
# Bước 3. Chạy RGI tìm gene kháng thuốc
rgi main --input_sequence results/prokka_results/bacterial_genome.faa \
         --output_file results/rgi_results \
         --input_type protein \
         --clean
