#!/bin/bash

# Scipion Containers launcher script for end users and system administrators
# MAINTAINERS:
# Bruno Focassio @ LNNano/CNPEM - bruno.focassio@lnnano.cnpem.br
# João Victor Guerra @ LNBio/CNPEM - joao.guerra@lnbio.cnpem.br
# José Geraldo Pereira @ LNBio/CNPEM - jose.pereira@lnbio.cnpem.br

#### USER CONFIGURABLE VARIABLES
CONTAINER=scipion-base.sif

### CLUSTER SPECIFIC
# You can add your cluster-specific commands here
#PREPARE_ENV="module load XXX"
PREPARE_SCREEN="xhost +"
CLUSTER_PREP="$PREPARE_ENV $PREPARE_SCREEN"
$CLUSTER_PREP
# CLUSTER END
### END #######################################################################

### CRYOASSESS
# Point to your CryoAssess models folder 
# $SCIPCRYOASSESS_MODELS="/route/to/your/cryoassess_models_folder"

# UNCOMMENT THIS LINE WHEN USING CRYOASSESS
#$SCIPCRYOASSESS_CMD=" --bind $SCIPCRYOASSESS_MODELS:/scipion/software/em/cryoassess_models "
### CRYOASSESS END
### END #######################################################################


### STORAGE DIRECTORIES
# The projdir will house Scipion's project and all of its intermediate data
SCIPION_PROJDIR=$HOME/ScipionUserData
# The datadir will be used to input the RAW data used for processing, ie movies/tiltseries
SCIPION_DATADIR=$HOME/ScipionUserData/data
# Logs will be stored in the logs folder
SCIPION_LOGDIR=$HOME/ScipionUserData/logs
# Create the directories if they do not exist
mkdir -p $SCIPION_PROJDIR
mkdir -p $SCIPION_DATADIR
mkdir -p $SCIPION_LOGDIR
### END STORAGE
### END #######################################################################

### SLURM
# Modify the variables to point to your actual SLURM installation 
# Or just ignore if not using SLURM
# SCIPSLURM_HOSTSCONF=/path/to/your/hosts.conf
SCIPSLURM_BIN="/usr/bin"
SCIPSLURM_BASE=/etc/slurm
SCIPSLURM_LIB=/usr/lib64/slurm
SCIPSLURM_PLUGINS=/usr/lib64/slurm
# Usual locations (check your specific case)
# BIN -> /usr/bin, /opt/slurm/bin, /bin
# BASE -> /etc/slurm-llnl, /etc/slurm
# LIB -> /var/lib/slurm-llnl (ubuntu apt), /var/lib/slurm (ubuntu sources), /usr/lib64/slurm
# PLUGINS -> /usr/lib/x86_64-linux-gnu/slurm-wlm/ (ubuntu apt), /usr/lib64/slurm (CentOS)
###
# DONT TOUCH THESE
SCIPSLURM_JOBS=" --bind $SCIPSLURM_BIN/sbatch --bind $SCIPSLURM_BIN/srun --bind $SCIPSLURM_BIN/scancel --bind $SCIPSLURM_BIN/salloc "
SCIPSLURM_CTRL=" --bind $SCIPSLURM_BIN/squeue --bind $SCIPSLURM_BIN/sinfo \
                 --bind $SCIPSLURM_BIN/scontrol --bind $SCIPSLURM_BIN/sstat --bind $SCIPSLURM_BIN/sacct "
# SCIPSLURM_CONF=" --bind $SCIPSLURM_BASE --bind $SCIPSLURM_HOSTSCONF:/scipion/config/hosts.conf "
SCIPSLURM_CONF=" --bind $SCIPSLURM_BASE "
SCIPSLURM_LIBS=" --bind $SCIPSLURM_LIB"
# SCIPSLURM_LIBS=" --bind $SCIPSLURM_LIB --bind $SCIPSLURM_PLUGINS "
# UNCOMMENT THIS LINE WHEN USING SLURM
SCIPSLURM_CMD=" $SCIPSLURM_JOBS $SCIPSLURM_CTRL $SCIPSLURM_CONF $SCIPSLURM_LIBS "
# END OF SLURM CONFIGURATION VARIABLES
### END #######################################################################

### Message Passing Interface (MPI)
# Many programs (such as Relion & Xmipp) require MPI
# Simple tasks such as extract particles will fail if this is not configured
# LIB is usually /usr/lib/x86_64-linux-gnu/openmpi (Ubuntu-APT) or /usr/lib64/openmpi/ (CentOS-YUM)
# Depending on your system, it might also be in /opt or even be mpich instead of openmpi
# If in doubt, check with your nearest IT manager
SCIPMPI_LIB=" /opt/images/openmpi/4.1.4"
SCIPMPI_CMD=" --bind $SCIPMPI_LIB --bind /tmp "
# END OF MPI CONFIGURATION VARIABLES
### END #######################################################################

### Apptainer download location
# You might be interested in downloading the container in a different location
# Or maybe you just don't have enough space in your ~/.apptainer to download the image
# Uncomment these variables to change the location of the container
#export APPTAINER_CACHEDIR=/route/to/FOLDER
#export CONTAINER_LOCATION=/route/to/FOLDER

###
###
#### END OF USER CONFIGURABLE VARIABLES

# Check if apptainer or singularity is available
if command -v apptainer &> /dev/null; then
    CONTAINER_CMD="apptainer"
elif command -v singularity &> /dev/null; then
    CONTAINER_CMD="singularity"
else
    echo "Error: Neither apptainer nor singularity is installed."
    exit 1
fi

# Do not touch below here unless you know what you are doing!
echo "Preparing to launch Scipion Container"
LAUNCH_CMD="$CONTAINER_CMD exec --nv --containall \
            --env DISPLAY=$DISPLAY --env SCIPION_USER_DATA=$SCIPION_PROJDIR \
            --bind /run --bind /etc/resolv.conf \
            --bind $SCIPION_DATADIR:/data --bind $SCIPION_LOGDIR:/logs --bind $SCIPION_PROJDIR \
            $SCIPCRYOASSESS_CMD $SCIPSLURM_CMD $SCIPMPI_CMD \
            $CONTAINER"

if [ "$#" -gt 0 ]; then
    echo "Launching $CONTAINER with parameters..."
    $LAUNCH_CMD /scipion/scipion3 run $@
else
    echo "Launching $CONTAINER in standalone mode..."
    echo "Launching Scipion container for $CONTAINER"
    $LAUNCH_CMD /scipion/scipion3
fi
