# Project S.pne
## Down data
Accession: DRR189357
- Bước 1: Tải dữ liệu về máy cá nhân
- Bước 2: Upload lên codespaces
Mở thư mục: project_s.pne/data
Kéo thả file data từ máy vào
- Bước 3: Kiểm tra dữ liệu
cd ../data
ls
## Fastp
Bước 1. Kích hoạt môi trường QC (chứa fastp)
```conda activate QC```
Bước 2. Lệnh chạy fastp (Dành cho file Interleaved đã upload lên)
- Ghi chú: --in1 là file đầu vào, --interleaved_in để báo file chứa cả R1 và R2 -o và -O là 2 file đầu ra đã được tách và lọc sạch
``` fastp --in1 data/DRR189357.fastq.gz \
      --interleaved_in \
      -o data/cleaned_R1.fastq.gz \
      -O data/cleaned_R2.fastq.gz \
      -h results/fastp_report.html \
      -j results/fastp.json
```
## Fastqc
Bước 1. Kích hoạt môi trường QC (nơi có cài tool fastqc)
``` conda activate QC ```

Bước 2. Chạy FastQC cho 2 file đã được lọc sạch (cleaned)
```
fastqc data/cleaned_R1.fastq.gz data/cleaned_R2.fastq.gz -o results/
``` 
-o results/: Yêu cầu xuất kết quả vào thư mục results
## Spades
Bước 1. Kích hoạt môi trường Assembly
conda activate Assembly

Bước 2. Chạy SPAdes lắp ghép bộ gene
``` spades.py -1 data/cleaned_R1.fastq.gz \
-2 data/cleaned_R2.fastq.gz \
-o results/spades_output \
--only-assembler \
-t 2 -m 7
```
-1, -2: Dữ liệu sạch đã lọc qua fastp

-o: Thư mục xuất kết quả

-t 2 -m 7: Giới hạn tài nguyên để máy không bị treo
## Quast
Bước 1. Kích hoạt môi trường Assembly
```conda activate Assembly```
Bước 2. Chạy QUAST để đánh giá file scaffolds.fasta
```quast.py results/spades_output/scaffolds.fasta -o results/quast_results ```
scaffolds.fasta là kết quả từ SPAdes ```
## Busco
Bước 1. Kích hoạt môi trường Assembly
```conda activate Assembly```
Bước 2. Chạy BUSCO đánh giá độ đầy đủ của bộ gene

Sử dụng bộ dữ liệu bacteria_odb10 làm chuẩn
```
busco -i results/spades_output/scaffolds.fasta \
      -o results/busco_results \
      -m genome \
      -l bacteria_odb10 \
      --cpu 2
```
## Prokka
Bước 1. Kích hoạt môi trường env_prokka
conda activate env_prokka

Bước 2. Chạy prokka chú giải bộ gene 
```
prokka --outdir results/prokka_results \
       --prefix bacterial_genome \
       --kingdom Bacteria \
       --cpus 2 \
       --force \
       results/spades_output/scaffolds.fasta
```
--outdir: Thư mục chứa kết quả chú giải.

--prefix: Tên tiền tố cho các file (ví dụ: bacterial_genome.gff, bacterial_genome.faa).

--kingdom Bacteria: Báo cho Prokka biết đây là vi khuẩn để nó dùng đúng bộ lọc.
## RGI
``` coda activate env_rgi```
Bước 1. Tải dữ liệu CARD trực tiếp (không cần qua lệnh database pull hay bị lỗi)
``` 
wget https://card.mcmaster.ca/latest/data -O card.tar.bz2
tar -jxvf card.tar.bz2
```
Bước 2. Nạp dữ liệu vào hệ thống
```rgi load --card_json card.json --local```
Bước 3. Chạy RGI tìm gene kháng thuốc
```
rgi main --input_sequence results/prokka_results/bacterial_genome.faa \
         --output_file results/rgi_results \
         --input_type protein \
         --clean
```
## Viruslence
Bước 1. Kích hoạt môi trường riêng cho Abricate
```conda activate env_abricate```
Bước 2. Chạy lệnh
```
abricate --db vfdb results/spades_output/scaffolds.fasta > results/virulence_results.txt
```
