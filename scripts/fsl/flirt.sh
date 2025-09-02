#!/bin/bash

ROOT_DIR="/home/ijarni/diplomski/data/bet_outputs"
OUTPUT_DIR="/home/ijarni/diplomski/data/flirt_outputs"
TEMPLATE=~/diplomski/template/MNI152_T1_1mm_brain.nii.gz

for GROUP in ad cn; do
  for SUBJECT_DIR in "$ROOT_DIR/$GROUP"/*; do
    SUBJECT_ID=$(basename "$SUBJECT_DIR")
    INPUT_IMAGE="$SUBJECT_DIR/${SUBJECT_ID}_brain.nii"
    OUTPUT_SUBDIR="$OUTPUT_DIR/$GROUP/$SUBJECT_ID"
    OUTPUT_IMAGE="$OUTPUT_SUBDIR/${SUBJECT_ID}_flirt.nii.gz"
    MATRIX_FILE="$OUTPUT_SUBDIR/${SUBJECT_ID}_flirt.mat"

    mkdir -p "$OUTPUT_SUBDIR"

    echo "FLIRT za $SUBJECT_ID"

    flirt -in "$INPUT_IMAGE" \
        -ref "$TEMPLATE" \
        -out "$OUTPUT_IMAGE" \
        -omat "$MATRIX_FILE" \
        -dof 6 \
        -interp trilinear
  done
done

