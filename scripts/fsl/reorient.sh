#!/bin/bash

DATA_DIR="/home/ijarni/diplomski/data/subjects"
OUTPUT_DIR="/home/ijarni/diplomski/data/reorient_outputs"

for GROUP in ad cn; do
  for SUBJECT_DIR in "$DATA_DIR/$GROUP"/*; do
    SUBJECT_ID=$(basename "$SUBJECT_DIR")
    INPUT_IMAGE="$SUBJECT_DIR/${SUBJECT_ID}.nii.gz"
    OUTPUT_SUBDIR="$OUTPUT_DIR/$GROUP/$SUBJECT_ID"
    OUTPUT_IMAGE="$OUTPUT_SUBDIR/${SUBJECT_ID}_reoriented.nii.gz"

    mkdir -p "$OUTPUT_SUBDIR"

    echo "Reorient za $SUBJECT_ID"

    fslreorient2std "$INPUT_IMAGE" "$OUTPUT_IMAGE"
  done
done
