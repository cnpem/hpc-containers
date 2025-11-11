# Installation

This document provides step-by-step instructions for building and running the Scipion container on HPC systems using Apptainer. It includes information about the base container, additional packages, and how to configure and launch Scipion in HPC environments.

## Apptainer

Apptainer is a container platform that allows users to create and run containers on HPC systems. To install Apptainer, run the following commands:

```bash
wget https://github.com/apptainer/apptainer/releases/download/v1.4.1/apptainer_1.4.1_amd64.deb
sudo apt install -y ./apptainer_1.4.1_amd64.deb
```

## RStudio Server container

This section describes how to build the RStudio Server container on HPC systems using Apptainer.

To build the `singularity-rstudio/` container, run the following command:

```bash
./build.sh
```

This command creates a sandbox container named `singularity-rstudio/` in the current directory.

After building the sandbox, you can convert it into a single-file Apptainer image with:

```bash
./symlink.sh
```

This will create a file named `singularity-rstudio.simg` in the current directory.

Finally, to make the new container version available through the RStudio Server app in Open OnDemand, update the configuration file `/etc/ood/config/apps/bc_osc_rstudio_server/form.yml`.

```yaml
    value: "4.5.2"
    help: |
      Choose the R version that you want to load.
      Available:

        - `3.6.2`
        - `4.2.0`
        - `4.5.2`
    options:
      - ["3.6.2", "rstudio_singularity/3.6.2"]
      - ["4.2.0", "rstudio_singularity/4.2.0"]
      - ["4.5.2", "rstudio_singularity/4.5.2"]
```

The `config.sh` file provides an interface to access the singularity-rstudio container and adjust environment variables as required.

### Extras

The `extras/` directory contains optional packages for authentication (local and LDAP) in the RStudio Server container during the build process.
