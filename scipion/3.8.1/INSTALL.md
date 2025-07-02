# Installation

This document provides instructions for building and running the Scipion container on HPC systems using Apptainer. It includes details on the base container, additional packages, and how to run Scipion with specific configurations.

This repository is based on this I2PC repository: <https://github.com/I2PC/scipion-containers>.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. To install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## Base Container

This section describes how to build the base container for Scipion on HPC systems using Apptainer.

To build the `scipion-base` container, run the following command:

```bash
APPTAINER_DISPLAY=$DISPLAY apptainer build --nv --force ./build/scipion-base.sif ./apptainer/scipion-base.def
```

To run the `base` container, use the following command:

```bash
apptainer exec --nv --containall --env DISPLAY=$DISPLAY --bind /run --bind /tmp/.X11-unix --bind /etc/resolv.conf --bind  /usr/lib/x86_64-linux-gnu/openmpi  --bind /tmp --bind $(pwd)/logs:/logs scipion-base.sif  /scipion/scipion3
```

## Full Container

This section describes how to build the Scipion container with the Tomography packages.

To build the `scipion-full` container, run the following command:

```bash
APPTAINER_DISPLAY=$DISPLAY apptainer build --nv --force ./build/scipion-full.sif ./apptainer/scipion-full.def
```

To run the `scipion-full` container, use the following command:

```bash
apptainer exec --nv --containall --env DISPLAY=$DISPLAY --bind /run --bind /tmp/.X11-unix --bind /etc/resolv.conf --bind  /usr/lib/x86_64-linux-gnu/openmpi  --bind /tmp --bind $(pwd)/logs:/logs build/scipion-full.sif  /scipion/scipion3
```
