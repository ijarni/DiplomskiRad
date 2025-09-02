import pyvista as pv
import nibabel as nib
import numpy as np
import os
import csv

ROOT_DIR = "/home/ijarni/diplomski/data/first_outputs"
GROUPS = ["ad", "cn"]
STRUCTURES = ["L_Hipp", "R_Hipp", "L_Thal", "R_Thal", "L_Amyg", "R_Amyg"]
SPACING = [1.0, 1.0, 1.0]  # voxel size in mm
VOXEL_VOLUME = np.prod(SPACING)

output_csv = "first_volumes.csv"

with open(output_csv, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["Subject_ID", "Group"] + STRUCTURES)

    for group in GROUPS:
        group_path = os.path.join(ROOT_DIR, group)
        for subject_id in os.listdir(group_path):
            subject_dir = os.path.join(group_path, subject_id)
            if not os.path.isdir(subject_dir):
                continue

            row = [subject_id, group]
            for structure in STRUCTURES:
                vtk_file = f"{subject_id}_first-{structure}_first.vtk"
                vtk_path = os.path.join(subject_dir, vtk_file)

                if not os.path.exists(vtk_path):
                    print(f"Ne postoji file {vtk_path}")
                    row.append("")
                    continue

                try:
                    mesh = pv.read(vtk_path)
                    volume = mesh.volume
                    volume_mm3 = volume if volume is not None else 0
                    row.append(int(volume_mm3))
                except Exception as e:
                    print(f"Greska za {subject_id}, {vtk_file}: {e}")
                    row.append("")

            writer.writerow(row)

print(f"\nRezultati spremljeni u: {output_csv}")
