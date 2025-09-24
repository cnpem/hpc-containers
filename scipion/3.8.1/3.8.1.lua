-- Lmod module file for Scipion 3.8.1

-- whatis() is displayed when a user runs "module spider" or "module whatis"
whatis("Name: Scipion")
whatis("Version: 3.8.1")
whatis("Category: bio, cryo-em, cryo-tomo")
whatis("Description: Scipion is a software framework to integrate several software packages under a single interface.")
whatis("URL: https://scipion.i2pc.es/")

-- help() is displayed when a user runs "module help scipion"
help([[
Description
-----------
Scipion is a software framework to integrate several software packages under a single interface. It provides a workflow to manage, execute and monitor the image processing steps needed to obtain 3D cryo-EM maps from raw images.

This module provides Scipion version 3.8.1, executed via a Singularity container. It enables GPU support via the '--nv' flag.

Usage
-----
After loading this module, you can run Scipion using the 'scipion' alias

# To start the graphical user interface (GUI):
$ scipion3

# Run Relion, cisTEM, Phenix, and IsoNet from a GPU-enabled Apptainer/Singularity container.
$ relion
$ cistem
$ phenix
$ isonet

More Information
----------------
For more information, please visit the official Scipion website:
https://scipion.i2pc.es/
]])

-- Container location
local container_path = "/opt/images/apps/scipion/3.8.1/scipion-3.8.1.sif"
setenv("SCIPION3_CONTAINER", container_path)

-- User data directories
local home = os.getenv("HOME")
execute("mkdir -p " .. pathJoin(home, "ScipionUserData/data"))
execute("mkdir -p " .. pathJoin(home, "ScipionUserData/logs"))
setenv("SCIPION_PROJDIR", pathJoin(home, "ScipionUserData"))
setenv("SCIPION_DATADIR", pathJoin(home, "ScipionUserData/data"))
setenv("SCIPION_LOGDIR", pathJoin(home, "ScipionUserData/logs"))

-- SLURM
setenv("SCIPSLURM_BIN", "/usr/bin")
setenv("SCIPSLURM_BASE", "/etc/slurm")
setenv("SCIPSLURM_LIB", "/usr/lib64/slurm")
setenv("SCIPSLURM_PLUGINS", "/usr/lib64/slurm")

-- MUNGE and library binds for SLURM
setenv("SCIPSLURM_EXTRA_BINDS", table.concat({
    "--bind /etc/munge:/etc/munge:ro",
    "--bind /usr/lib64/libreadline.so.7:/usr/lib64/libreadline.so.7:ro",
    "--bind /usr/lib64/libhistory.so.7:/usr/lib64/libhistory.so.7:ro",
    "--bind /usr/lib64/libtinfo.so.6:/usr/lib64/libtinfo.so.6:ro",
    "--bind /var/run/munge:/var/run/munge:ro",
    "--bind /usr/lib64/libmunge.so.2.0.0:/usr/lib64/libmunge.so.2.0.0:ro",
    "--bind /run/munge:/run/munge:ro"
}, " "))

-- MPI
setenv("SCIPMPI_LIB", "/opt/images/openmpi/4.1.4")

-- Apptainer/Singularity launcher (Lmod does not decide, wrapper script does)
setenv("SCIPION_CONTAINER_CMD", "singularity")

-- Convenience aliases (with GUI binds)
local user = os.getenv("USER")
local bind_opts = table.concat({
    "--nv --containall",
    "--env DISPLAY=" .. os.getenv("DISPLAY"),
    "--env SCIPION_USER_DATA=" .. pathJoin(home, "ScipionUserData"),
    "--bind /run",
    "--bind /tmp",
    "--bind /tmp/.X11-unix",
    "--bind /etc/resolv.conf",
    "--bind " .. pathJoin(home, "ScipionUserData/data") .. ":/data",
    "--bind " .. pathJoin(home, "ScipionUserData/logs") .. ":/logs",
    "--bind " .. pathJoin(home, "ScipionUserData"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "sbatch"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "srun"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "scancel"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "salloc"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "squeue"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "sinfo"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "scontrol"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "sstat"),
    "--bind " .. pathJoin(os.getenv("SCIPSLURM_BIN"), "sacct"),
    "--bind " .. os.getenv("SCIPSLURM_BASE"),
    "--bind " .. os.getenv("SCIPSLURM_LIB"),
    "--bind " .. os.getenv("SCIPMPI_LIB"),
}, " ")

-- Build command using SCIPION_CONTAINER_CMD
local container_cmd = os.getenv("SCIPION_CONTAINER_CMD") .. " run " .. bind_opts .. " "

-- Aliases for applications
set_alias("scipion", container_cmd .. "--app scipion " .. container_path)
set_alias("relion",   container_cmd .. "--app relion "   .. container_path)
set_alias("cistem",   container_cmd .. "--app cistem "   .. container_path)
set_alias("phenix",   container_cmd .. "--app phenix "   .. container_path)
set_alias("isonet",   container_cmd .. "--app isonet "   .. container_path)
