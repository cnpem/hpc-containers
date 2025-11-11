#!/bin/bash

[ ! -d "singularity-rstudio/" ] && singularity build --sandbox singularity-rstudio/ singularity-rstudio.simg

singularity shell --writable singularity-rstudio/
