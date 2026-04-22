# Installation

This document provides step-by-step instructions for building and running the sda container on HPC systems using Apptainer. It includes information about the base container, additional packages, and how to configure and launch sda in HPC environments.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. TO install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## SDA container

This section describes how to build the SDA container on HPC systems using Apptainer.


to build the `sda_7.4.0` container, run the following command:

```bash
export GITHUB_TOKEN=your_github_token_here
sudo singularity build --build-arg GITHUB_TOKEN=${GITHUB_TOKEN} sda_7.4.0.sif sda_7.4.0.def
```


## Usage

This section provides instructions on how to run the sda container on HPC systems using Apptainer.

To run the sda container, use the following command:

- Running sda command:
```bash
singularity exec sda_7.4.0.sif sda_flex sda.in > sda.out
```