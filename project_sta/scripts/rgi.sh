#!/bin/bash
conda activate env_rgi
mkdir -p project_sta/results/rgi_results
mkdir -p /workspaces/project_bioinformatic_01/localDB
cd /workspaces/project_bioinformatic_01/localDB
wget https://card.mcmaster.ca/latest/data -O card_data.tar.bz2
tar -jxvf card_data.tar.gz 2>/dev/null || tar -jxvf card_data.tar.bz2
ls -l card.json
rgi load --card_json /workspaces/project_bioinformatic_01/localDB/card.json --local
rgi main --input_sequence /workspaces/project_bioinformatic_01/project_sta/results/prokka_results/annotation/MyBacteria.faa \
         --output_file /workspaces/project_bioinformatic_01/project_sta/results/rgi_results/rgi_output \
         --input_type protein \
         --local \
         --num_threads 2 \
         --clean
