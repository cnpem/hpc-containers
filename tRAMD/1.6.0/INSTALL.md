# Installation

This document provides step-by-step instructions for building and running the tRAMD container on HPC systems using Apptainer. It includes information about the base container, additional packages, and how to configure and launch tRAMD in HPC environments.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. TO install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## tRAMD container

This section describers how to build the tRAMD container on HPC systems using Apptainer.


to build the `tRAMD_1.6.0` container, run the following command:

```bash
sudo singularity build tRAMD_1.6.0.sif tRAMD_1.6.0.def
```


## Usage

This section provides instructions on how to run the tRAMD container on HPC systems using Apptainer.

To run the tRAMD container, use the following command:

- Running gromacs gmx command:
```bash
singularity exec --nv --bind ./path/to/output:/data tRAMD_1.6.0.sif gmx 
```

- Running gromacs gmx_mpi with MPI support:
```bash
singularity exec --nv --bind ./path/to/output:/data tRAMD_1.6.0.sif gmx_mpi grompp -f gromacs_ramd.mdp -c gromacs.tpr -o gromacs_ramd.tpr -t state.cpt -n index.ndx -maxwarn 2

singularity exec --nv --bind ./path/to/output:/data tRAMD_1.6.0.sif gmx_mpi mdrun -s gromacs_ramd.tpr -ntmpi 1 -ntomp 16 -maxh 24 > gromac.output
```