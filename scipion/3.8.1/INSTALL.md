# Installation

This document provides instructions for building and running the Scipion container on HPC systems using Apptainer. It includes details on the base container, additional packages, and how to run Scipion with specific configurations.

This repository is based on this I2PC repository: <https://github.com/I2PC/scipion-containers>.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. To install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## Scipion container

This section describes how to build the Scipion container on HPC systems using Apptainer.

To build the `scipion-base` and `scipion-full` container, run the following command:

```bash
./build.sh
```

To run the `scipion-full` container, use the following command:

```bash
export CONTAINER=/opt/images/scipion/3.8.1/scipion.sif
apptainer exec --nv --containall --env DISPLAY=$DISPLAY --env SCIPION_USER_DATA=$HOME/ScipionUserData --bind /run --bind /tmp/.X11-unix --bind /etc/resolv.conf --bind $HOME/ScipionUserData/data:/data --bind $HOME/ScipionUserData/logs:/logs --bind $HOME/ScipionUserData --bind /usr/bin/sbatch --bind /usr/bin/srun --bind /usr/bin/scancel --bind /usr/bin/salloc --bind /usr/bin/squeue --bind /usr/bin/sinfo --bind /usr/bin/scontrol --bind /usr/bin/sstat --bind /usr/bin/sacct --bind /etc/slurm --bind /usr/lib64/slurm --bind /usr/lib64/slurm --bind /usr/lib/x86_64-linux-gnu/openmpi --bind /tmp $CONTAINER /scipion/scipion3
```

or,

```bash
./launcher.sh
```
