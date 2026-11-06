# Installation

This document provides step-by-step instructions for building and running the NWChem container on HPC systems using Apptainer. It includes information about the base container, additional packages, and how to configure and launch NWChem in HPC environments.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. To install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## NWChem container

This section describes how to build the NWChem container on HPC systems using Apptainer.

to build the `nwchem_1.0.0` container, run the following command:

```bash
sudo singularity build nwchem_1.0.0.sif nwchem_1.0.0.def
``` 

## Usage

this section provides instructions on how to run the NWChem container on HPC systems using Apptainer.

to get a help message for the NWChem container, use the following command:

```bash
singularity run --nv nwchem_1.0.0.sif --help
```

to get the version of the NWChem container and nwchem version, use the following command:

```bash
singularity run --nv nwchem_1.0.0.sif --version
```

to run the NWChem container, use the following command:

```bash
singularity exec --nv nwchem_1.0.0.sif -np <number_of_processes> nwchem <input_file> >
```
