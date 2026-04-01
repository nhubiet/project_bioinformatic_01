# Project Staphylococcus aureus
Accession: SRR37768792
# Down data
Bước 1: Tải dữ liệu về máy cá nhân
Bước 2: Upload lên codespaces
Mở thư mục: project_sta
Kéo thả file data từ máy vào
Bước 3: Kiểm tra dữ liệu
``` 
cd ../data
ls
```
# Fastqc dữ liệu thô
Trở về thư mục gốc /workspaces/project_bioinformatic_01
```
cd ../
```
```
conda activate QC
```
Chạy fastqc cho dữ liệu thô vừa up lên
```
fastqc project_sta/data/SRR37768792.fastq.gz -o project_sta/results/
```
Fastp trả kết quả file .html
# Fastp tách R1, R2
Vì data chứa cả trình tự R1 và R2 nên cần interleaved để tách ra
```
fastp --in1 project_sta/data/SRR37768792.fastq.gz \
      --interleaved_in \
      --out1 project_sta/data/SRR37768792_R1_clean.fastq.gz \
      --out2 project_sta/data/SRR37768792_R2_clean.fastq.gz \
      -h project_sta/results/SRR37768792_fastp_report.html \
      -j project_sta/results/SRR37768792_fastp.json \
   
      -w 4
```
# Fastqc kiểm tra lại chất lượng R1, R2
Bước 1. tạo thư mục kết quả cho fastqc
```
mkdir -p project_sta/results/fastqc_clean/
```
Bước 2. Chạy fastqc cho R1, R2
```
fastqc project_sta/data/SRR37768792_R1_clean.fastq.gz \
       project_sta/data/SRR37768792_R2_clean.fastq.gz \
       -o project_sta/results/fastqc_clean/ \
       -t 2
```
# Spades để lắp ráp 
Bước 1: Di chuyển sang môi trường Assembly
```
conda activate Assembly
```
Bước 2. Tạo thư mục chứa kết quả spades
``` mkdir -p project_sta/results/spades_output ```
Bước 3. Chạy SPAdes với dữ liệu đã lọc sạch
```
spades.py -1 project_sta/data/SRR37768792_R1_clean.fastq.gz \
          -2 project_sta/data/SRR37768792_R2_clean.fastq.gz \
          -o project_sta/results/spades_output \
          --isolate \
          -t 4 \
          --tmp-dir /tmp
```
-1: Read 1 sạch

-2: Read 2 sạch

-o: Thư mục lưu kết quả

--isolate: Chế độ tối ưu cho vi khuẩn thuần chủng (rất quan trọng)

-t 4: Dùng 4 luồng xử lý

Lấy 4 triệu dòng đầu tiên (~1 triệu reads) từ file sạch
```
zcat project_sta/data/SRR37768792_R1_clean.fastq.gz | head -n 4000000 | gzip > project_sta/data/R1_sub.fastq.gz
zcat project_sta/data/SRR37768792_R2_clean.fastq.gz | head -n 4000000 | gzip > project_sta/data/R2_sub.fastq.gz 
```
 2. Chạy với dữ liệu đã cắt giảm (R1_sub và R2_sub)
Mình vẫn giữ giới hạn RAM để chắc chắn không bị văng
```spades.py -1 project_sta/data/R1_sub.fastq.gz \
          -2 project_sta/data/R2_sub.fastq.gz \
          -o project_sta/results/spades_output \
          --isolate \
          -t 2 \
          -m 4 \
          --tmp-dir /tmp
```
# Quast
1. Tạo thư mục chứa kết quả đánh giá
``` mkdir -p project_sta/results/quast_results```

2. Chạy QUAST để đánh giá file scaffolds
```quast.py project_sta/results/spades_output/scaffolds.fasta \
         -o project_sta/results/quast_results
```
# Busco
1. Tạo thư mục chứa kết quả BUSCO
```mkdir -p project_sta/results/busco_results```

2. Chạy BUSCO
 -i: File đầu vào (scaffolds bạn vừa lắp xong)

 -o: Tên thư mục kết quả (nó sẽ tạo trong folder hiện hành)

 -m: Chế độ (genome)

 -l: Bộ dữ liệu lineage (bacteria_odb10)

 -f: Ghi đè nếu đã có kết quả cũ
```
busco -i project_sta/results/spades_output/scaffolds.fasta \
      -o busco_output \
      -m genome \
      -l bacteria_odb10 \
      -f \
      --cpu 4
```
3. Di chuyển kết quả vào đúng cấu trúc folder của project
```mv busco_output project_sta/results/busco_results/```
# Prokka
``` conda activate env_prokka ```
1. Tạo thư mục chứa kết quả chú giải
``` mkdir -p project_sta/results/prokka_results ```
2. Chạy Prokka
--outdir: Thư mục đầu ra
--prefix: Tên tiền tố cho các file kết quả (ví dụ: MyBacteria)
--kingdom: Chỉ định là Vi khuẩn (Bacteria)
--cpus 4: Dùng 4 nhân để chạy cho lẹ
```
prokka --outdir project_sta/results/prokka_results/annotation \
       --prefix MyBacteria \
       --kingdom Bacteria \
       --force \
       --cpus 4 \
       project_sta/results/spades_output/scaffolds.fasta
```
# RGI
```conda activate env_rgi
mkdir -p project_sta/results/rgi_results```
 1. Tạo thư mục chứa database
```mkdir -p /workspaces/project_bioinformatic_01/localDB
cd /workspaces/project_bioinformatic_01/localDB
```
 2. Tải file database mới nhất từ CARD
```wget https://card.mcmaster.ca/latest/data -O card_data.tar.bz2
```
3. Giải nén file vừa tải (Lưu ý: dùng tar -jxvf cho file .bz2)
```tar -jxvf card_data.tar.gz 2>/dev/null || tar -jxvf card_data.tar.bz2
```
4. Kiểm tra xem file card.json đã xuất hiện chưa
```ls -l card.json
```
nạp database vào rgi
```
rgi load --card_json /workspaces/project_bioinformatic_01/localDB/card.json --local
```
```
rgi main --input_sequence /workspaces/project_bioinformatic_01/project_sta/results/prokka_results/annotation/MyBacteria.faa \
         --output_file /workspaces/project_bioinformatic_01/project_sta/results/rgi_results/rgi_output \
         --input_type protein \
         --local \
         --num_threads 2 \
         --clean
```
# Virulence
Tải Database
Tạo thư mục chứa database
```
mkdir -p project_sta/data/virulencefinder_db
cd project_sta/data/virulencefinder_db
```
Tải database từ bitbucket của CGE
```git clone https://bitbucket.org/genomicepidemiology/virulencefinder_db.git .```

Cài đặt kma (bộ máy tìm kiếm của VirulenceFinder)
```conda install -c bioconda kma -y```

Lập chỉ mục cho database
```
python3 install.py kma_index
cd /workspaces/project_bioinformatic_01
```

Chạy tool

1. Tạo thư mục kết quả
```mkdir -p project_sta/results/virulence_finder_results```

2. Chạy VirulenceFinder
```
python3 -m virulencefinder \
    -ifa project_sta/results/spades_output/scaffolds.fasta \
    -o project_sta/results/virulence_finder_results \
    -p project_sta/data/virulencefinder_db \
    -k /opt/conda/envs/env_virulence/bin/kma \
    -x
```