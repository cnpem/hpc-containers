#!/bin/bash

# Rstudio Containers builder script for end users and system administrators

# AUTHORS
# João V S Guerra joao.guerra@lnbio.cnpem.br

VERSION=$(basename "$(pwd)")
TARGET="singularity-rstudio-${VERSION}"

echo "Preparing to build Scipion Apptainer image locally..."
echo "Building $TARGET.sif"

# Check if apptainer or singularity is available
if command -v apptainer &> /dev/null; then
    CONTAINER_CMD="apptainer"
elif command -v singularity &> /dev/null; then
    CONTAINER_CMD="singularity"
else
    echo "Error: Neither apptainer nor singularity is installed."
    exit 1
fi

# APPTAINERENV_DISPLAY=$DISPLAY 
$CONTAINER_CMD build --sandbox ./$TARGET/ ./apptainer/$TARGET.def

echo "Finished."