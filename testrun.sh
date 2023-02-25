#!/usr/bin/env bash

docker run -it \
    --mount type=bind,src="`pwd -P`/INPUTS",dst=/INPUTS \
    --mount type=bind,src="`pwd -P`/OUTPUTS",dst=/OUTPUTS \
    --entrypoint 'bash' \
    baxterprogers/spm-plus:v1.0.0 \
    -c " \
    cp /INPUTS/mrt1.nii.gz /OUTPUTS/t1.nii.gz && \
    gunzip /OUTPUTS/t1.nii.gz && \
    /opt/spm12/spm12 batch /opt/matlabbatch/matlabbatch_segment_30fwhm.mat \
    "
