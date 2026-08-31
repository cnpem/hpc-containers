#!/bin/bash

IMAGE="/opt/images/tcrmodel/tcrmodel_pipeline_cuda112_tfgpu.sif"
DBDIR="/public/alphafold_db_20231114"
WORKDIR="/opt/tcrmodel2"

singularity run --nv \
  -B "${DBDIR}:/database" \
  --pwd "${WORKDIR}" \
  "${IMAGE}" \
  python /opt/tcrmodel2/run_tcrmodel2_ub_tcr.py "$@"

  