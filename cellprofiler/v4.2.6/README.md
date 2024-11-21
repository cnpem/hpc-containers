# singularity-cellprofiler

A [singularity container](https://github.com/sylabs/singularity) definition file to run [cellpose](https://github.com/cellprofiler/cellprofiler) with Cellpose (binary), ilastik and ImageJ/FIJI plugins.

Build:

`sudo singularity build --nv cellprofiler.sif cellpose.def`

Run [GUI]:

`singularity run --nv -B /etc/machine-id -B /run/user/$UID/ cellprofiler.sif`

or

`singularity run --nv -B /etc/machine-id -B /run/user/$UID/ cellprofiler.sif -h`

