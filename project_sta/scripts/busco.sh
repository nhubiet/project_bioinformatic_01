#!/bin/bash
mkdir -p project_sta/results/busco_results
busco -i project_sta/results/spades_output/scaffolds.fasta \
      -o busco_output \
      -m genome \
      -l bacteria_odb10 \
      -f \
      --cpu 4
mv busco_output project_sta/results/busco_results/