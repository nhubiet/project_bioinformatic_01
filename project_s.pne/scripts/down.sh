#!/bin/bash
# Accession: DRR189357
# Trong trường hợp không thể tải trực tiếp từ NCBI(do lỗi SSL hoặc giới hạn môi trường), dữ liệu được tải về từ máy cá nhân và upload lên hệ thống.
# CÁCH UPLOAD DỮ LIỆU LÊN CODESPACES
# Bước 1: Tải dữ liệu về máy cá nhân
# Bước 2: Upload lên codespaces
#- Mở thư mục: project_s.pne/data
#- Kéo thả file data từ máy vào
# Bước 3: Kiểm tra dữ liệu
cd ../data
ls
# Link tải dự phòng từ EBI:
# ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR189/007/DRR189357/DRR189357_1.fastq.gz
# ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR189/007/DRR189357/DRR189357_2.fastq.gz