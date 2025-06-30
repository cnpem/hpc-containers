# Installation

This document provides instructions for building and running the Scipion container on HPC systems using Apptainer. It includes details on the base container, additional packages, and how to run Scipion with specific configurations.

This repository is based on this I2PC repository: <https://github.com/I2PC/scipion-containers>.

## Base Container

This section describes how to build the base container for Scipion on HPC systems using Apptainer.

To build the `base` container, run the following command:

```bash
APPTAINER_DISPLAY=:1 apptainer build --nv --force ./build/base.sif ./apptainer/apptainer-base.def
```

To run the `base` container, use the following command:

```bash
apptainer exec --nv --containall --env DISPLAY=$DISPLAY --bind /run --bind /tmp/.X11-unix --bind /etc/resolv.conf --bind  /usr/lib/x86_64-linux-gnu/openmpi  --bind /tmp build/apptainer-base.sif  /scipion/scipion3
```

## Tomography Container

This section describes how to build the Scipion container with the Tomography packages.

To build the `tomography` container, run the following command:

```bash
APPTAINER_DISPLAY=:1 apptainer build --nv --force ./build/tomography.sif ./apptainer/apptainer-tomography.def
```

To run the `tomography` container, use the following command:

```bash
apptainer exec --nv --containall --env DISPLAY=$DISPLAY --bind /run --bind /tmp/.X11-unix --bind /etc/resolv.conf --bind  /usr/lib/x86_64-linux-gnu/openmpi  --bind /tmp build/apptainer-tomography.sif  /scipion/scipion3
```