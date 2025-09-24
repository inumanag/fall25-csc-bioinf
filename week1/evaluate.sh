#!/bin/bash

# Add "-x" for debugging purposes; however, do not submit stuff with -x
set -euo pipefail

# The script starts at the repository root; move to week1
cd week1

# Step 1: clone the original repository (so that you do not have to commit large data files into your repo!)
git clone https://github.com/zhongyuchen/genome-assembly

# Step 2: Extract data files
(cd genome-assembly; for i in *.zip; do unzip $i; done)

# Step 3: Run experiments
echo -e "Dataset\tLanguage \tRuntime \tN50"
echo "-------------------------------------------"
for i in data1 data2 ; do
    # Run Codon
    start=$(date +%s)
    # Direct all output to out.txt to avoid cluttering the table
    codon run -release codon/main.py genome-assembly/$i >out.txt
    time=$(($(date +%s) - $start))
    # Calculate N50
    n50=$(python n50.py genome-assembly/$i/contig.fasta)
    echo -e "$i\tcodon\t$time\t$n50"

    # Run Python
    start=$(date +%s)
    python python/main.py genome-assembly/$i >out.txt
    time=$(($(date +%s) - $start))
    n50=$(python n50.py genome-assembly/$i/contig.fasta)
    echo -e "$i\tpython\t$time\t$n50"
done
