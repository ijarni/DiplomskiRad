#!/bin/bash

DATA_DIR="/home/ijarni/diplomski/data/reorient_outputs"
OUTPUT_DIR="/home/ijarni/diplomski/data/bet_outputs"

for GROUP in ad cn; do
  for SUBJECT_DIR in "$DATA_DIR/$GROUP"/*; do
    SUBJECT_ID=$(basename "$SUBJECT_DIR")
    INPUT_IMAGE="$SUBJECT_DIR/${SUBJECT_ID}_reoriented.nii.gz"
    OUTPUT_SUBDIR="$OUTPUT_DIR/$GROUP/$SUBJECT_ID"
    OUTPUT_IMAGE="$OUTPUT_SUBDIR/${SUBJECT_ID}_brain"

    mkdir -p "$OUTPUT_SUBDIR"

    CENTER=$(fslstats "$INPUT_IMAGE" -C)

    echo "BET za $SUBJECT_ID, centar: $CENTER"

    bet "$INPUT_IMAGE" "$OUTPUT_IMAGE" -f 0.3 -B -c $CENTER -m
  done
done
