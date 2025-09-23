#!/bin/bash

# Scipion Containers builder script for end users and system administrators

# AUTHORS
# Bruno Focassio bruno.focassio@lnnano.cnpem.br
# João V S Guerra joao.guerra@lnbio.cnpem.br
# Jose G C Pereira jose.pereira@lnbio.cnpem.br

VERSION=$(basename "$(pwd)")
TARGET="scipion-${VERSION}"

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
$CONTAINER_CMD build --nv --force ./$TARGET.sif ./apptainer/$TARGET.def

echo "Finished."