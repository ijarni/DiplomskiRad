import os

root_dir = "/home/ijarni/diplomski/data_new/subjects"
groups = ["ad", "cn"]

for group in groups:
    group_path = os.path.join(root_dir, group)

    for subject_id in os.listdir(group_path):
        subject_path = os.path.join(group_path, subject_id)

        if os.path.isdir(subject_path):
            
            for filename in os.listdir(subject_path):
                if filename.endswith(".nii") or filename.endswith(".nii.gz"):
                    old_path = os.path.join(subject_path, filename)
                    
                    ext = ".nii" 
                    new_filename = f"{subject_id}{ext}"
                    new_path = os.path.join(subject_path, new_filename)

                    os.rename(old_path, new_path)
                    print(f"Preimenovano: {old_path} -> {new_path}")
