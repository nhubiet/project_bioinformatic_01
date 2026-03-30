#!/bin/bash
# Bước 1. Kích hoạt môi trường env_prokka
conda activate env_prokka
# Bước 2. Chạy prokka chú giải bộ gene 
prokka --outdir results/prokka_results \
       --prefix bacterial_genome \
       --kingdom Bacteria \
       --cpus 2 \
       --force \
       results/spades_output/scaffolds.fasta
# --outdir: Thư mục chứa kết quả chú giải.
# --prefix: Tên tiền tố cho các file (ví dụ: bacterial_genome.gff, bacterial_genome.faa).
# --kingdom Bacteria: Báo cho Prokka biết đây là vi khuẩn để nó dùng đúng bộ lọc.
