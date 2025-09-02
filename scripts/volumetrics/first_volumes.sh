#!/bin/bash

ROOT_DIR="/home/ijarni/diplomski/data/first_outputs"
OUTPUT_CSV="/home/ijarni/diplomski/results/first_volumes.csv"

echo "Subject_ID,Group,L_Hipp,R_Hipp,L_Thal,R_Thal,L_Amyg,R_Amyg" > first_volumes.csv

for group in ad cn; do
  for subject_dir in "$ROOT_DIR/$group"/*; do
    subj_id=$(basename "$subject_dir")

    #hipokampus
    lh="$subject_dir/${subj_id}_first-L_Hipp_first.nii.gz" 
    rh="$subject_dir/${subj_id}_first-R_Hipp_first.nii.gz"
    #talamus
    lt="$subject_dir/${subj_id}_first-L_Thal_first.nii.gz" 
    rt="$subject_dir/${subj_id}_first-R_Thal_first.nii.gz"
    #amigdala
    la="$subject_dir/${subj_id}_first-L_Amyg_first.nii.gz"
    ra="$subject_dir/${subj_id}_first-R_Amyg_first.nii.gz"

    if [[ -f "$lh" && -f "$rh" && -f "$lt" && -f "$rt" && -f "$la" && -f "$ra" ]]; then
      #broj voxela * veličina voxela 
      vol_lh=$(fslstats "$lh" -V | awk '{print $1 * $2}')
      vol_rh=$(fslstats "$rh" -V | awk '{print $1 * $2}')
      vol_lt=$(fslstats "$lt" -V | awk '{print $1 * $2}')
      vol_rt=$(fslstats "$rt" -V | awk '{print $1 * $2}')
      vol_la=$(fslstats "$la" -V | awk '{print $1 * $2}')
      vol_ra=$(fslstats "$ra" -V | awk '{print $1 * $2}')

      echo "$subj_id,$group,$vol_lh,$vol_rh,$vol_lt,$vol_rt,$vol_la,$vol_ra" >> first_volumes.csv
    else
      echo "Nije moguce obraditi $subj_id."
    fi
  done
done

echo "Rezultat spremljen u first_volumes.csv"
