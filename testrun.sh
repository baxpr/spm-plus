#!/usr/bin/env bash

# Start the docker
docker run -it \
    --mount type=bind,src="`pwd -P`/INPUTS",dst=/INPUTS \
    --mount type=bind,src="`pwd -P`/OUTPUTS",dst=/OUTPUTS \
    --entrypoint 'bash' \
    baxterprogers/spm-segment:v1.0.0


# Inside the docker to run processing
t1_niigz=/INPUTS/mrt1.nii.gz

cp "${t1_niigz}" -f /OUTPUTS/t1.nii.gz
gunzip -f /OUTPUTS/t1.nii.gz

/opt/spm12/spm12 batch /opt/matlabbatch/matlabbatch_segment.mat
/opt/spm12/spm12 batch /opt/matlabbatch/matlabbatch_brainmask.mat
