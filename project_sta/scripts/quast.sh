#!/bin/bash
mkdir -p project_sta/results/quast_results
quast.py project_sta/results/spades_output/scaffolds.fasta \
         -o project_sta/results/quast_results
         