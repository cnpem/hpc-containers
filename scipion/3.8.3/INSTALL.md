# Installation

This document provides instructions for building and running the Scipion container on HPC systems using Apptainer. It includes details on the base container, additional packages, and how to run Scipion with specific configurations.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. To install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## Scipion container

This section describes how to build the Scipion container on HPC systems using Apptainer.

To build the `scipion-${VERSION}` container, run the following command:

```bash
./build.sh
```

This will create a file named `scipion-${VERSION}.sif` in the current directory.

### Extras

The `extras` directory contains additional packages that can be included in the Scipion container. To include these packages, copy them to the `extras` directory before building the container.

The following packages are included in the `extras` directory for this build:

- [ ] cisTEM (`default_run_profiles.txt)
- [x] [ChimeraX](https://www.rbvi.ucsf.edu/chimerax/cgi-bin/secure/chimerax-get.py?file=1.6/linux/ChimeraX-1.6.1.tar.gz) (`ChimeraX-1.6.1.tar.gz`)
- [x] [CryoAssess models](https://cosmic-cryoem.org/software/cryo-assess/) (`cryoassess-models`)
- [x] [Phenix](https://phenix-online.org/) (`phenix-installer-1.21.2-5419-intel-linux-2.6-x86_64-centos6.tar.gz`)
- [ ] Relion (`relion_torch_models`, [`relion-5.0-slurm_template.sh`](https://github.com/ucdavis/spack-ucdavis/tree/main/templates/hpccf/franklin))

**Note**: These files are not included in the repository and must be obtained separately.