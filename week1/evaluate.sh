#!/bin/bash

set -euo pipefail
cd week1

# Step 1: clone the original repository
git clone https://github.com/zhongyuchen/genome-assembly

# Step 2: Extract data files
(cd genome-assembly; for i in *.zip; do unzip $i; done)

# Step 3: Run experiments
echo -e "Dataset\tLanguage \tRuntime \tN50"
echo "-------------------------------------------"
for i in data1 ; do
    start=$(date +%s)
    codon run -release codon/main.py genome-assembly/$i >out.txt
    time=$(($(date +%s) - $start))
    n50=$(python n50.py genome-assembly/$i/contig.fasta)
    echo -e "$i\tcodon\t$time\t$n50"

    start=$(date +%s)
    python python/main.py genome-assembly/$i >out.txt
    time=$(($(date +%s) - $start))
    n50=$(python n50.py genome-assembly/$i/contig.fasta)
    echo -e "$i\tpython\t$time\t$n50"
done
