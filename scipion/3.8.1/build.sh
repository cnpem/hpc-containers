#!/bin/bash

# Scipion Containers builder script for end users and system administrators

# AUTHORS
# Bruno Focassio bruno.focassio@lnnano.cnpem.br
# João V S Guerra joao.guerra@lnbio.cnpem.br
# Jose G C Pereira jose.pereira@lnbio.cnpem.br

#### USER CONFIGURABLE VARIABLES
###
###

# Available flavours are: base, spa
# You can build multiple containers by adding them separated by a space
# For example, CONTAINER_FLAVOURS="base spa"
# Remember that you will need base for any container
# CONTAINER_FLAVOURS="base"
CONTAINER_FLAVOURS="full"

### CLUSTER SPECIFIC
# You can add your cluster-specific commands here
#PREPARE_ENV="module load XXX"
PREPARE_SCREEN="xhost +"
CLUSTER_PREP="$PREPARE_ENV $PREPARE_SCREEN"
$CLUSTER_PREP

###
###
#### END OF USER CONFIGURABLE VARIABLES

echo "Preparing to build Scipion Apptainer image locally..."
echo "System will build $CONTAINER_FLAVOURS"

# Check if apptainer or singularity is available
if command -v apptainer &> /dev/null; then
    CONTAINER_CMD="apptainer"
elif command -v singularity &> /dev/null; then
    CONTAINER_CMD="singularity"
else
    echo "Error: Neither apptainer nor singularity is installed."
    exit 1
fi

for F in $CONTAINER_FLAVOURS; do
    TARGET="scipion-$F"
    echo "Compiling $TARGET image..."
    echo "Result will be in ./$TARGET.sif"
    APPTAINERENV_DISPLAY=$DISPLAY $CONTAINER_CMD build --nv --force ./$TARGET.sif ./apptainer/$TARGET.def
done
done

echo "Finished."