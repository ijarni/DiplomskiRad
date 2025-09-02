#!/bin/bash

INPUT_ROOT="/home/ijarni/diplomski/data/flirt_outputs"
OUTPUT_ROOT="/home/ijarni/diplomski/data/fast_outputs"

for group in ad cn; do

    input_group_dir="$INPUT_ROOT/$group"
    output_group_dir="$OUTPUT_ROOT/$group"

    mkdir -p "$output_group_dir"

    for subj_dir in "$input_group_dir"/*; do
        subj_id=$(basename "$subj_dir")
        input_file="$subj_dir/${subj_id}_flirt.nii.gz"
        subj_output_dir="$output_group_dir/$subj_id"
        output_prefix="$subj_output_dir/${subj_id}_fast"

        echo "FAST za $subj_id"
        mkdir -p "$subj_output_dir"
        fast -t 1 -n 3 -g -b -o "$output_prefix" "$input_file"

    done
done

