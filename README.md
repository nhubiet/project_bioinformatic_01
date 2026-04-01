# project_bioinformatic_01
```
conda init bash
source ~/.bashrc
```
## Initial Conda Configuration
Run these commands once to set up the necessary channels for bioinformatics tools:
```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict
```
## Step 1: Quality Control (QC) Environment
This environment is used for raw data trimming and quality assessment.
Tools: fastp, fastqc
### Installation:
```
conda create -n QC fastp fastqc -y
```
### Verification:
Activate the environment and check the versions:
```
conda activate QC
fastp --version
fastqc --version
```
```
conda deactivate
```
## Step 2: Genome Assembly
Contains tools for de novo assembly and evaluating the completeness of your results.
Tools: Spades, Busco, Quast
### Installation:
```
conda create -n Assembly spades busco quast -y
```
Verification:
```
conda activate Assembly
spades.py --version
busco --version
quast.py --version
```
## Step 3: Functional Annotation (RGI & Virulence)
These tools identify antibiotic resistance and virulence factors. It is recommended to handle their databases carefully.
### Resistance Gene Identifier (RGI)
#### Installation:
```
conda create -n env_rgi rgi -y
```
```
conda activate env_rgi
rgi main --version
```
### Prokka (Rapid Prokaryotic Genome Annotation)
#### Installation
```
conda create -n env_prokka prokka -y
```
#### Verification:
```
conda activate env_prokka
prokka --version
```
### VirulenceFinder
#### Installation:
```
conda create -n env_virulence virulencefinder -y
```
#### Verification:
```
conda activate env_virulence
conda list virulencefinder
virulencefinder.py -h
```
### Tạo môi trường mới với Python 3.8
```conda create -n env_abricate python=3.8 -y```
### Kích hoạt
``` conda activate env_abricate ```
### Cài đặt Abricate từ kênh Bioconda
``` conda install -c bioconda -c conda-forge abricate -y ```
## Save
```
git add README.md
git commit -m "Complete installation and storage management guide"
git push origin main
```
# Project_s.pne
[scripts](project_s.pne/scripts)
[results](project_s.pne/results)

# Project_staphylococcus
[script](project_sta/scpripts)
[results](project_sta/results)