#!/bin/bash

data_dir="/home/ijarni/diplomski/data/fast_outputs"

#zaglavlje
echo "Group,Subject,CSF_Volume,GM_Volume,WM_Volume" > fast_volumes.csv

calculate_volume() {
    subject_dir=$1
    subject_name=$2

    # csf, pve0
    csf_volume=$(fslstats ${subject_dir}/${subject_name}_fast_pve_0.nii.gz -V | awk '{print $1}')
    # gm, pve1
    gm_volume=$(fslstats ${subject_dir}/${subject_name}_fast_pve_1.nii.gz -V | awk '{print $1}')
    # wm, pve2
    wm_volume=$(fslstats ${subject_dir}/${subject_name}_fast_pve_2.nii.gz -V | awk '{print $1}')

    echo "${group},${subject_name},${csf_volume},${gm_volume},${wm_volume}" >> fast_volumes.csv
}

for subject_dir in ${data_dir}/ad/*; do
    subject_name=$(basename ${subject_dir})
    group="AD"
    calculate_volume ${subject_dir} ${subject_name}
done

for subject_dir in ${data_dir}/cn/*; do
    subject_name=$(basename ${subject_dir})
    group="CN"
    calculate_volume ${subject_dir} ${subject_name}
done

echo "Rezultati spremljeni u fast_volumes.csv"

