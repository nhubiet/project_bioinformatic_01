#!/bin/bash
conda activate env_prokka
mkdir -p project_sta/results/prokka_results
prokka --outdir project_sta/results/prokka_results/annotation \
       --prefix MyBacteria \
       --kingdom Bacteria \
       --force \
       --cpus 4 \
       project_sta/results/spades_output/scaffolds.fasta
