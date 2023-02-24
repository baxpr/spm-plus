# Start with pre-built SPM12 docker container. Note we are going to get the latest
# with no control over versioning due to how this is released.
FROM ghcr.io/spm/spm-docker:docker-matlab

# Add our saved batch files, which assumes specific paths/filenames
# Need to hard code input file, TPM path, kernel size, etc
COPY matlabbatch /opt/matlabbatch
