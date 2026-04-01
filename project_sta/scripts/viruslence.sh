#!/bin/bash
mkdir -p project_sta/data/virulencefinder_db
cd project_sta/data/virulencefinder_db
git clone https://bitbucket.org/genomicepidemiology/virulencefinder_db.git .
conda install -c bioconda kma -y
python3 install.py kma_index
cd /workspaces/project_bioinformatic_01
mkdir -p project_sta/results/virulence_finder_results
python3 -m virulencefinder \
    -ifa project_sta/results/spades_output/scaffolds.fasta \
    -o project_sta/results/virulence_finder_results \
    -p project_sta/data/virulencefinder_db \
    -k /opt/conda/envs/env_virulence/bin/kma \
    -x