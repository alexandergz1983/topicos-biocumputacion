#!/bin/bash
for archivo in $(find . -name "seqs1-2.fasta")
do
    grep -E --color ">|HD" "$archivo"
done

