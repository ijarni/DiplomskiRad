#!/bin/bash

INPUT_ROOT="/home/ijarni/diplomski/data/flirt_outputs"
OUTPUT_ROOT="/home/ijarni/diplomski/data/first_outputs"

for group in ad cn; do
    input_group_dir="$INPUT_ROOT/$group"
    output_group_dir="$OUTPUT_ROOT/$group"

    mkdir -p "$output_group_dir"

    for subj_dir in "$input_group_dir"/*; do
        subj_id=$(basename "$subj_dir")
        input_file="$subj_dir/${subj_id}_flirt.nii.gz"
        subj_output_dir="$output_group_dir/$subj_id"
        output_prefix="$subj_output_dir/${subj_id}_first"

        echo "FIRST za $subj_id"
        mkdir -p "$subj_output_dir"

        run_first_all \
            -i "$input_file" \
            -o "$output_prefix" \
            -s L_Hipp,R_Hipp,L_Thal,R_Thal,L_Amyg,R_Amyg \
            -b

    done
done
