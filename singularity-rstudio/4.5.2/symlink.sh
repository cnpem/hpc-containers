#!/bin/bash

DT=`date '+%Y%m%d%H%M'`

singularity build singularity-rstudio-${DT}.simg singularity-rstudio/

unlink singularity-rstudio.simg

ln -s singularity-rstudio-${DT}.simg singularity-rstudio.simg
