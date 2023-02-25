# spm-plus

Docker container from https://github.com/spm/spm-docker/pkgs/container/spm-docker with a few batch files added. The batch files hard-code a lot of filenames and paths and parameters, but allow custom processing with the standalone SPM in the otherwise stock container.

A typical run command for docker, using bash to perform some shell operations in addition to SPM batch jobs, operations, would be 

    docker run -it \
        --mount type=bind,src="`pwd -P`/INPUTS",dst=/INPUTS \
        --mount type=bind,src="`pwd -P`/OUTPUTS",dst=/OUTPUTS \
        --entrypoint 'bash' \
        baxterprogers/spm-plus:v1.0.0 \
        -c " \
        cp /INPUTS/mrt1.nii.gz /OUTPUTS/t1.nii.gz && \
        gunzip /OUTPUTS/t1.nii.gz && \
        /opt/spm12/spm12 batch /opt/matlabbatch/matlabbatch_segment_30fwhm.mat && \
        gzip /OUTPUTS/*.nii \
        "

## matlabbatch_segment_30fwhm.mat

Segment `/OUTPUTS/t1.nii` using a 30mm FWHM kernel for the bias field estimation. Full outputs are produced, and are stored in `/OUTPUTS`.

## matlabbatch_brainmask.mat

Sum the white matter, gray matter, and CSF output images from Segment and threshold at 0.01 to produce an approximate intracranial volume binary mask. Segment results are assumed to be `/OUTPUTS/c1t1.nii` etc, and the result is stored in `/OUTPUTS/brainmask.nii`.
